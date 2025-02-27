% Compara el msqi orginal con el msqi corregido tanto para el acelremetro en
% el brazo y esternon

% Leer los nombres de los archivos desde los CSVs
archivos_mSQI_original = readmatrix('mSQI_FileName_Comercial.csv', 'Delimiter', ',', 'NumHeaderLines', 1, 'OutputType', 'string');
archivos_mSQI_corregido_arm = readmatrix('Corrections_msqi_power_FileName_Arm.csv', 'Delimiter', ',', 'NumHeaderLines', 1, 'OutputType', 'string');
archivos_mSQI_corregido_sternum = readmatrix('Corrections_msqi_power_FileName_Sternum.csv', 'Delimiter', ',', 'NumHeaderLines', 1, 'OutputType', 'string');

% Inicializar matrices para almacenar datos
num_archivos = length(archivos_mSQI_original); % todos tiene la misma length 
medias_msqi_original = zeros(1, num_archivos);
medias_msqi_corregido_arm = zeros(1, num_archivos);
medias_msqi_corregido_sternum = zeros(1, num_archivos);

% Leer los datos y calcular la media por archivo -> archivo orginal y
% coge mx y min
for i = 1:num_archivos
    medias_msqi_original(i) = calcularMedia(archivos_mSQI_original(i));
    medias_msqi_corregido_arm(i) = calcularMedia(archivos_mSQI_corregido_arm(i));
    medias_msqi_corregido_sternum(i) = calcularMedia(archivos_mSQI_corregido_sternum(i));
end

% Asegurar que los valores mínimos sean distintos de cero
medias_msqi_original_sin_cero = medias_msqi_original(medias_msqi_original ~= 0);
medias_msqi_corregido_arm_sin_cero = medias_msqi_corregido_arm(medias_msqi_corregido_arm ~= 0);
medias_msqi_corregido_sternum_sin_cero = medias_msqi_corregido_sternum(medias_msqi_corregido_sternum ~= 0);

% Ahora calculamos el mínimo sobre los valores que no son cero
min_original = min(medias_msqi_original_sin_cero);
min_corregido_arm = min(medias_msqi_corregido_arm_sin_cero);
min_corregido_sternum = min(medias_msqi_corregido_sternum_sin_cero);

% Calcular las comparaciones: 
max_original = max(medias_msqi_original_sin_cero);
resultado_original = (max_original - min_original) / min_original;

max_corregido_arm = max(medias_msqi_corregido_arm_sin_cero);
resultado_corregido_arm = (max_corregido_arm - min_corregido_arm) / min_corregido_arm;

max_corregido_sternum = max(medias_msqi_corregido_sternum_sin_cero);
resultado_corregido_sternum = (max_corregido_sternum - min_corregido_sternum) / min_corregido_sternum;

% Calcular la diferencia entre mSQI original y corregidos
diferencia_arm = resultado_original - resultado_corregido_arm;
diferencia_sternum = resultado_original - resultado_corregido_sternum;

% Crear la tabla de resultados reestructurada con diferencias al lado
resultados = {
    'mSQI Original', max_original, min_original, resultado_original, NaN;
    'mSQI Corregido (Arm)', max_corregido_arm, min_corregido_arm, resultado_corregido_arm, diferencia_arm;
    'mSQI Corregido (Sternum)', max_corregido_sternum, min_corregido_sternum, resultado_corregido_sternum, diferencia_sternum;
};

nombres_columnas = {'Type', 'Max', 'Min', 'Result', 'Differences'};
tabla_resultados = cell2table(resultados, 'VariableNames', nombres_columnas);

% Guardar los resultados en un CSV
writetable(tabla_resultados, 'Comparison_mSQI_mSQIcorrected.csv');
