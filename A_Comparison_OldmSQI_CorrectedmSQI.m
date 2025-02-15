
% Esta función compara los valores de mSQI originales con los valores 
% corregidos obtenidos de dos ubicaciones distintas (brazo y esternón). 
% Se calculan las medias de cada conjunto de archivos, eliminando ceros 
% para evitar distorsiones en los cálculos. Posteriormente, se determinan 
% los valores máximos y mínimos de cada conjunto y se calcula la diferencia 
% relativa entre ellos. Finalmente, se genera una tabla con los resultados 
% y se guarda en un archivo CSV.
%
% Parámetros de entrada:
%   - mSQI_files_top: Celda con los archivos de mSQI originales.
%   - corrected_files_esternon: Celda con los archivos de mSQI corregidos 
%     correspondientes al esternón.
%   - corrected_files_brazo: Celda con los archivos de mSQI corregidos 
%     correspondientes al brazo.
%
% Salida:
%   - Se genera un archivo 'Comparison_mSQI_mSQIcorrected.csv' con los 
%     resultados de la comparación, incluyendo valores máximos, mínimos, 
%     y diferencias relativas entre los datos originales y corregidos.


function A_Comparison_OldmSQI_CorrectedmSQI(mSQI_files_top, corrected_files_esternon, corrected_files_brazo)

    % Inicializar matrices para almacenar datos
    num_archivos = length(mSQI_files_top); % Asumiendo que todos los archivos tienen la misma longitud
    medias_msqi_original = zeros(1, num_archivos);
    medias_msqi_corregido_arm = zeros(1, num_archivos);
    medias_msqi_corregido_sternum = zeros(1, num_archivos);

    % Leer los datos y calcular la media por archivo
    for i = 1:num_archivos
        medias_msqi_original(i) = calcularMedia(mSQI_files_top(i));
        medias_msqi_corregido_arm(i) = calcularMedia(corrected_files_brazo(i));
        medias_msqi_corregido_sternum(i) = calcularMedia(corrected_files_esternon(i));
    end

    % Asegurar que los valores mínimos sean distintos de cero
    medias_msqi_original_sin_cero = medias_msqi_original(medias_msqi_original ~= 0);
    medias_msqi_corregido_arm_sin_cero = medias_msqi_corregido_arm(medias_msqi_corregido_arm ~= 0);
    medias_msqi_corregido_sternum_sin_cero = medias_msqi_corregido_sternum(medias_msqi_corregido_sternum ~= 0);

    % Cálculo de métricas adicionales
    min_original = min(medias_msqi_original_sin_cero);
    min_corregido_arm = min(medias_msqi_corregido_arm_sin_cero);
    min_corregido_sternum = min(medias_msqi_corregido_sternum_sin_cero);

    max_original = max(medias_msqi_original_sin_cero);
    max_corregido_arm = max(medias_msqi_corregido_arm_sin_cero);
    max_corregido_sternum = max(medias_msqi_corregido_sternum_sin_cero);

    % Calcular media, desviación estándar y percentiles
    promedio_original = mean(medias_msqi_original_sin_cero);
    promedio_corregido_arm = mean(medias_msqi_corregido_arm_sin_cero);
    promedio_corregido_sternum = mean(medias_msqi_corregido_sternum_sin_cero);

    desviacion_original = std(medias_msqi_original_sin_cero);
    desviacion_corregido_arm = std(medias_msqi_corregido_arm_sin_cero);
    desviacion_corregido_sternum = std(medias_msqi_corregido_sternum_sin_cero);

    p10_original = prctile(medias_msqi_original_sin_cero, 10);
    p90_original = prctile(medias_msqi_original_sin_cero, 90);
    p10_corregido_arm = prctile(medias_msqi_corregido_arm_sin_cero, 10);
    p90_corregido_arm = prctile(medias_msqi_corregido_arm_sin_cero, 90);
    p10_corregido_sternum = prctile(medias_msqi_corregido_sternum_sin_cero, 10);
    p90_corregido_sternum = prctile(medias_msqi_corregido_sternum_sin_cero, 90);

    % Calcular la métrica (mSQI_90% - mSQI_10%) / mSQI_10%
    metric_original = (p90_original - p10_original) / p10_original;
    metric_corregido_arm = (p90_corregido_arm - p10_corregido_arm) / p10_corregido_arm;
    metric_corregido_sternum = (p90_corregido_sternum - p10_corregido_sternum) / p10_corregido_sternum;

    % Calcular las diferencias 
    resultado_original = (max_original - min_original) / min_original;
    resultado_corregido_arm = (max_corregido_arm - min_corregido_arm) / min_corregido_arm;
    resultado_corregido_sternum = (max_corregido_sternum - min_corregido_sternum) / min_corregido_sternum;

    diferencia_arm = resultado_original - resultado_corregido_arm;
    diferencia_sternum = resultado_original - resultado_corregido_sternum;

    % Crear la tabla de resultados reestructurada con las nuevas métricas
    resultados = {
        mSQI_files_top(1).file_name, mSQI_files_top(2).file_name, 'mSQI Original', max_original, min_original, resultado_original, diferencia_arm, promedio_original, desviacion_original, metric_original;
        mSQI_files_top(1).file_name, mSQI_files_top(2).file_name, 'mSQI Corregido (Arm)', max_corregido_arm, min_corregido_arm, resultado_corregido_arm, diferencia_arm, promedio_corregido_arm, desviacion_corregido_arm, metric_corregido_arm;
        mSQI_files_top(1).file_name, mSQI_files_top(2).file_name, 'mSQI Corregido (Sternum)', max_corregido_sternum, min_corregido_sternum, resultado_corregido_sternum, diferencia_sternum, promedio_corregido_sternum, desviacion_corregido_sternum, metric_corregido_sternum;
    };

    % Nombres de las columnas para la tabla final
    nombres_columnas = {'File1', 'File2', 'Type', 'Max', 'Min', 'Result', 'Differences', 'Mean', 'StdDev', 'Metric (90%-10%)/10%'};
    tabla_resultados = cell2table(resultados, 'VariableNames', nombres_columnas);

    % Guardar los resultados en un archivo CSV
    writetable(tabla_resultados, 'Comparison_mSQI_mSQIcorrected.csv', 'WriteMode', 'append');
end
