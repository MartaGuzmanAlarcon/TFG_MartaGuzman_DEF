function [] = Compare_OldmSQI_CorrectedmSQI( ...
    archivos_mSQI_original, archivos_mSQI_corregido_arm, archivos_mSQI_corregido_sternum)

% Inicializar resultados
resultados = {}; % Variable para almacenar los resultados

% Leer todos los datos originales y corregidos con un bucle
datos_mSQI_original = cell(1, length(archivos_mSQI_original)); 
datos_mSQI_corregido_arm = cell(1, length(archivos_mSQI_corregido_arm)); 
datos_mSQI_corregido_sternum = cell(1, length(archivos_mSQI_corregido_sternum)); % Si tienes archivos sternum

for i = 1:length(archivos_mSQI_original)
    datos_mSQI_original{i} = readmatrix(archivos_mSQI_original{i}); % Leer cada archivo original
end

for i = 1:length(archivos_mSQI_corregido_arm)
    datos_mSQI_corregido_arm{i} = readmatrix(archivos_mSQI_corregido_arm{i}); % Leer archivos corregidos de tipo arm
end

for i = 1:length(archivos_mSQI_corregido_sternum)
    datos_mSQI_corregido_sternum{i} = readmatrix(archivos_mSQI_corregido_sternum{i}); % Leer archivos corregidos de tipo sternum
end

% Comparaciones originales
max_original_1 = max(datos_mSQI_original{1}); % Máximo del primer archivo original
min_original_2 = min(datos_mSQI_original{2}(datos_mSQI_original{2} ~= 0)); % Mínimo no cero del segundo archivo original
resultado_original = (max_original_1 - min_original_2) / min_original_2;

% Comparaciones corregidos tipo arm
max_corregido_arm_1 = max(datos_mSQI_corregido_arm{1}); % Máximo del primer archivo corregido (arm)
min_corregido_arm_2 = min(datos_mSQI_corregido_arm{2}(datos_mSQI_corregido_arm{2} ~= 0)); % Mínimo no cero del segundo archivo corregido (arm)
resultado_corregido_arm = (max_corregido_arm_1 - min_corregido_arm_2) / min_corregido_arm_2;

% Comparaciones corregidos tipo sternum (si tienes archivos sternum)
if ~isempty(archivos_mSQI_corregido_sternum)
    max_corregido_sternum_1 = max(datos_mSQI_corregido_sternum{1}); % Máximo del primer archivo corregido (sternum)
    min_corregido_sternum_2 = min(datos_mSQI_corregido_sternum{2}(datos_mSQI_corregido_sternum{2} ~= 0)); % Mínimo no cero del segundo archivo corregido (sternum)
    resultado_corregido_sternum = (max_corregido_sternum_1 - min_corregido_sternum_2) / min_corregido_sternum_2;
end

% Guardar resultados de comparaciones
resultados = [resultados; 
    {'mSQI Original', archivos_mSQI_original{1}, archivos_mSQI_original{2}, max_original_1, min_original_2, resultado_original};
    {'mSQI Corregido (Arm)', archivos_mSQI_corregido_arm{1}, archivos_mSQI_corregido_arm{2}, max_corregido_arm_1, min_corregido_arm_2, resultado_corregido_arm}];

% Si tienes archivos para sternum, agrega el bloque siguiente
if ~isempty(archivos_mSQI_corregido_sternum)
    resultados = [resultados;
        {'mSQI Corregido (Sternum)', archivos_mSQI_corregido_sternum{1}, archivos_mSQI_corregido_sternum{2}, max_corregido_sternum_1, min_corregido_sternum_2, resultado_corregido_sternum}];
end

% Guardar los resultados en un archivo CSV
nombres_columnas = {'Tipo', 'ArchivoMax', 'ArchivoMin', 'Máximo', 'Mínimo', 'Resultado'};
tabla_resultados = cell2table(resultados, 'VariableNames', nombres_columnas);
writetable(tabla_resultados, 'Comparacion_mSQI_Resultados.csv','WriteMode','Append');
end