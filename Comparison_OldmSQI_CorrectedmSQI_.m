% Definir los nombres de los archivos para mSQI original y corregido
% II:
archivos_mSQI_original = {'mSQI_Top_NewIII_Walking_2024-10-18.txt.csv', 'mSQI_Top_NewII_Stairs_2024-10-16.txt.csv'};
archivos_mSQI_corregido_arm = {'CorrectionmSQITopNewIIIWalking20241018_csvPowerArmNewIIIWalking.csv', 'CorrectionmSQITopNewIIStairs20241016_csvPowerArmNewIIStairs2024.csv'};
archivos_mSQI_corregido_sternum = {'CorrectionmSQITopNewIIIWalking20241018_csvPowerSternumNewIIIWal.csv', 'CorrectionmSQITopNewIIStairs20241016_csvPowerSternumNewIIStairs.csv'}; 

%III:
%archivos_mSQI_original = {'mSQI_Top_NewIII_Working_2024-10-18.txt.csv', 'mSQI_Top_NewIII_Stairs_2024-10-18.txt.csv'};
%archivos_mSQI_corregido_arm = {'CorrectionmSQITopNewIIIWorking20241018_csvPowerArmNewIIIWorking.csv', 'CorrectionmSQITopNewIIIStairs20241018_csvPowerArmNewIIIStairs20.csv'};
%archivos_mSQI_corregido_sternum = {'CorrectionmSQITopNewIIIWorking20241018_csvPowerSternumNewIIIWor.csv', 'CorrectionmSQITopNewIIIStairs20241018_csvPowerSternumNewIIIStai.csv'}; 

% Inicializar resultados
resultados = {}; % Variable para almacenar los resultados

% Leer todos los datos originales y corregidos con un bucle
datos_mSQI_original = cell(1, length(archivos_mSQI_original)); 
datos_mSQI_corregido_arm = cell(1, length(archivos_mSQI_corregido_arm)); 
datos_mSQI_corregido_sternum = cell(1, length(archivos_mSQI_corregido_sternum));

for i = 1:length(archivos_mSQI_original)
    datos_mSQI_original{i} = readmatrix(archivos_mSQI_original{i}); % Leer cada archivo original
end

for i = 1:length(archivos_mSQI_corregido_arm)
    datos_mSQI_corregido_arm{i} = readmatrix(archivos_mSQI_corregido_arm{i}); % Leer archivos corregidos de tipo arm
end

for i = 1:length(archivos_mSQI_corregido_sternum)
    datos_mSQI_corregido_sternum{i} = readmatrix(archivos_mSQI_corregido_sternum{i}); % Leer archivos corregidos de tipo sternum
end

% Calcular medias de las actividades
media_original_actividad1 = mean(datos_mSQI_original{1});
media_original_actividad2 = mean(datos_mSQI_original{2});

media_corregido_arm_actividad1 = mean(datos_mSQI_corregido_arm{1});
media_corregido_arm_actividad2 = mean(datos_mSQI_corregido_arm{2});

media_corregido_sternum_actividad1 = mean(datos_mSQI_corregido_sternum{1});
media_corregido_sternum_actividad2 = mean(datos_mSQI_corregido_sternum{2});

% Comparaciones originales
max_original = max([media_original_actividad1, media_original_actividad2]);
min_original = min([media_original_actividad1, media_original_actividad2]);
resultado_original = (max_original - min_original) / min_original;

% Comparaciones corregidos tipo arm
max_corregido_arm = max([media_corregido_arm_actividad1, media_corregido_arm_actividad2]);
min_corregido_arm = min([media_corregido_arm_actividad1, media_corregido_arm_actividad2]);
resultado_corregido_arm = (max_corregido_arm - min_corregido_arm) / min_corregido_arm;

% Comparaciones corregidos tipo sternum
max_corregido_sternum = max([media_corregido_sternum_actividad1, media_corregido_sternum_actividad2]);
min_corregido_sternum = min([media_corregido_sternum_actividad1, media_corregido_sternum_actividad2]);
resultado_corregido_sternum = (max_corregido_sternum - min_corregido_sternum) / min_corregido_sternum;

% Guardar resultados en la tabla
resultados = {
    'mSQI Original', archivos_mSQI_original{1}, archivos_mSQI_original{2}, media_original_actividad1, media_original_actividad2, resultado_original;
    'mSQI Corregido (Arm)', archivos_mSQI_corregido_arm{1}, archivos_mSQI_corregido_arm{2}, media_corregido_arm_actividad1, media_corregido_arm_actividad2, resultado_corregido_arm;
    'mSQI Corregido (Sternum)', archivos_mSQI_corregido_sternum{1}, archivos_mSQI_corregido_sternum{2}, media_corregido_sternum_actividad1, media_corregido_sternum_actividad2, resultado_corregido_sternum
};

% Crear la tabla final
nombres_columnas = {'Type', 'File1', 'File2', 'Mean_Activity1', 'Mean_Activity2', 'Result'};
tabla_resultados = cell2table(resultados, 'VariableNames', nombres_columnas);

% Guardar los resultados en un archivo CSV
writetable(tabla_resultados, 'Comparison_mSQI_mSQIcorrected.csv');