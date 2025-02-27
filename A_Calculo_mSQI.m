
% Calcula mSQI para un conjunto de archivos de datos ECG del top.
% Los resultados se guardan en archivos CSV y en una estructura para su uso posterior.
%
% Entradas:
%   - file_group: Celda de nombres de archivos con datos ECG del top.
%   - time_vector: Vector de tiempo (en segundos) para limitar los datos de entrada.
%
% Salidas:
%   - mSQI_files_top: Estructura con los resultados de mSQI y los nombres de archivos generados.


function [mSQI_files_top] = A_Calculo_mSQI(file_group, time_vector)

frecuencia_original = 1000; % Frecuencia de muestreo
% time_vector = time_vector*frecuencia_original;

% Inicializar estructuras
mSQI_files_top = struct();
archivos_generados = cell(length(file_group), 1); % Inicializar celda para archivos generados


for fileIndex = 1:length(file_group)
    file_name = file_group{fileIndex};

    % Importar datos del ECG
    data_ecg_top = ImportPluxData(file_name, 3);
    data_ecg_top = data_ecg_top(1:min(length(time_vector), length(data_ecg_top)));

    % Calcular mSQI para el top
    [top_kSQI_01_vector, top_sSQI_01_vector, top_pSQI_01_vector, top_rel_powerLine01_vector, top_cSQI_01_vector, top_basSQI_01_vector, top_dSQI_01_vector, geometricMean_vector_top, averageGeometricMean_top] = mSQI(data_ecg_top, frecuencia_original);

    % Guardar resultados en CSV por si hiciera falta analizar algo
    nombre_archivo_top = ['mSQI_Top_', file_name, '.csv'];
    guardarEnCSV(nombre_archivo_top, num2cell(geometricMean_vector_top'), {'geometricMean_vector'});


    % Guardar en struct para uso posterior
    mSQI_files_top(fileIndex).file_name = file_name;
    mSQI_files_top(fileIndex).geometricMean_vector = geometricMean_vector_top;
    mSQI_files_top(fileIndex).msqi_file = nombre_archivo_top;

  % Agregar a la lista de archivos generados
    archivos_generados{fileIndex} = nombre_archivo_top;

    fprintf("Processed and saved mSQI for %s\n", file_name);
end

writetable(table(unique((archivos_generados))), 'mSQI_FileNames.csv', ...
           'WriteVariableNames', false, 'WriteMode', 'append');
