% COMPARISON SCRIPT FOR mSQI ANALYSIS

%This script compares ECG signal quality (mSQI) across different groups 
% defined by electrode size or fabric type. It processes 4 recordings per 
% group, extracts mSQI values, and computes mean/median comparisons using 
% bootstrap confidence intervals.
%
% Outputs: CI results table and comparative histograms.
%
% Set parameters:
% - comparisonMode: 'ElectrodeSize' or 'Fabric'
% - testMode: 1 (5 min) or 0 (8 h)
%

% PARAMETERS
comparisonMode = 'ElectrodeSize'; % Options: 'ElectrodeSize' or 'Fabric'
testMode = 1; % 1:5mins; 0:8h;
alphaLevel = 0.01; % significance level
bootstrapIterations = 1000; % bootstrap iterations
fs=1000;

% FILE DEFINITIONS BASED ON COMPARISON MODE
if strcmp(comparisonMode, 'ElectrodeSize')
    if testMode
        ecgTimeVector = 1:((5*60*fs)); % 5mins ((7*60 + 59)*60)

    else
        ecgTimeVector = 1:(((7*60 + 59)*60)*fs - 360000); % 8h

    end
    %groupType:
    filesSizeXL = {'R1_Electr_XL_2025-02-24.txt', 'R2_Electr_XL_2025-03-20.txt', 'R3_Electr_XL_2025-03-26.txt', 'R4_Electr_XL_2025-05-07.txt'};
    filesSizeL = {'R1_Electr_L_2025-02-26.txt', 'R2_Electr_L_2025-03-24.txt', 'R3_Electr_L_2025-03-26.txt', 'R4_Electr_L_2025-05-05.txt'};
    filesSizeS = {'R1_Electr_S_2025-03-10.txt', 'R2_Electr_S_2025-04-24.txt', 'R3_Electr_S_2025-04-28.txt', 'R4_Electr_S_2025-04-30.txt'};
    groupsFileSets = {filesSizeXL, filesSizeL, filesSizeS};
    groupLabels = {'ElectrodeSizeXL', 'ElectrodeSizeSizeL', 'ElectrodeSizeSizeS'};

elseif strcmp(comparisonMode, 'Fabric')
    if testMode
        ecgTimeVector = 1:((5*60*fs));
    else
        ecgTimeVector = 1:(((7*60 + 59)*60)*fs - 360000);
    end
     %groupType:
    filesFabric1 = {'Top2_R1_2024-11-21.txt', 'Top2_R2_2024-11-22.txt', 'Top2_R3_2024-11-25.txt', 'Top2_R4_2024-12-09hr.txt'};
    filesFabric2 = {'TopS_R1_2024-04-04.txt', 'TopS_R2_2024-04-12.txt', 'TopS_R3_2024-04-16.txt', 'TopS_R4_2024-04-23.txt'};
    filesFabric3 = {'Top1_R1_Registro8h_2024-11-04.txt', 'Top1_R2_Registro8h_2024-11-05.txt', 'Top1_R3_2024-11-07.txt', 'Top1_R4_2024-11-18.txt'};
    groupsFileSets = {filesFabric1, filesFabric2, filesFabric3};
    groupLabels = {'Fabric1', 'Fabric2', 'Fabric3'};
end

% ECG DATA PROCESSING AND mSQI EXTRACTION
mSQIRecordingsByGroupType = cell(1, length(groupsFileSets));
for groupIdx = 1:length(groupsFileSets)
    groupFiles = groupsFileSets{groupIdx};
    mSQIRecordingsByGroupType{groupIdx} = cell(1, length(groupFiles));
    for fileIdx = 1:length(groupFiles)
        rawData = ImportPluxData(groupFiles{fileIdx}, 3);
        ecg = rawData(ecgTimeVector);
        [kSQI_01_vector, sSQI_01_vector, pSQI_01_vector, rel_powerLine01_vector, cSQI_01_vector, basSQI_01_vector, dSQI_01_vector, geometricMean_vector, averageGeometricMean] = mSQI(ecg, fs);
        mSQIRecordingsByGroupType{groupIdx}{fileIdx} = geometricMean_vector;% {fabric1,fabric2,fabric3}
    end
end

% AGGREGATE VECTORS FROM EACH GROUP -> grouped_mSQI_values{2} msqi del
% tamaño L msqi unificados para los 4 recordings
mSQIConcatPerGroup = cellfun(@cell2mat, mSQIRecordingsByGroupType, 'UniformOutput', false);

% CALCULATE SESSION MEANS AND VARIANCES PER GROUP
for groupIdx = 1:length(mSQIRecordingsByGroupType)
    meanValues = cellfun(@mean, mSQIRecordingsByGroupType{groupIdx});
    varValues = cellfun(@var, mSQIRecordingsByGroupType{groupIdx});
    fprintf('Comparison Mode: %s | Group: %s\n  Means per session: %s\n  Vars per session: %s\n\n', ...
        comparisonMode, groupLabels{groupIdx}, mat2str(meanValues, 4), mat2str(varValues, 4));
end

% COMPARISON AND CI RESULT STORAGE
CI = {};
comparisonCounter = 1;

for i = 1:length(mSQIConcatPerGroup)

    for j = i+1:length(mSQIConcatPerGroup)
        groupDataA = mSQIConcatPerGroup{i};
        groupDataB = mSQIConcatPerGroup{j};

        ciMedian = estimateCIMedian(groupDataA, groupDataB, alphaLevel, bootstrapIterations);
        ciMean = estimateCIMean(groupDataA, groupDataB, alphaLevel, bootstrapIterations);

        fprintf('%s vs %s:\n  Median CI: [%.4f, %.4f]\n  Mean CI: [%.4f, %.4f]\n', ...
            groupLabels{i}, groupLabels{j}, ciMedian(1), ciMedian(2), ciMean(1), ciMean(2));

        CI{comparisonCounter,1} = comparisonMode;
        CI{comparisonCounter,2} = sprintf('%s vs %s', groupLabels{i}, groupLabels{j});
        CI{comparisonCounter,3} = sprintf('[%.4f, %.4f]', ciMedian(1), ciMedian(2));
        CI{comparisonCounter,4} = sprintf('[%.4f, %.4f]', ciMean(1), ciMean(2));
        comparisonCounter = comparisonCounter + 1;

        % Comparative histogram between groups i and j
        figure;
        histogram(groupDataA, 20, 'FaceAlpha', 0.5, 'EdgeColor', 'none');
        hold on;
        histogram(groupDataB, 20, 'FaceAlpha', 0.5, 'EdgeColor', 'none');
        title(sprintf('Comparative Histogram - %s vs %s', groupLabels{i}, groupLabels{j}));
        xlabel('mSQI values'); ylabel('Count');
        legend(groupLabels{i}, groupLabels{j});
        hold off;
    end
end

% EXPORT RESULTS TO CSV FILE
ciResultsTable = cell2table(CI, 'VariableNames', {'ComparisonType', 'Comparison', 'Median_CI', 'Mean_CI'});
writetable(ciResultsTable, sprintf('CI_results_%s.csv', comparisonMode));
