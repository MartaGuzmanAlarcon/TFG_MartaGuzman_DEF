
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

function A_Comparison_OldmSQI_CorrectedmSQI(mSQI_files_top,corrected_files_esternon,corrected_files_brazo)
    
    % Inicializar matrices para almacenar datos
    num_archivos = length(mSQI_files_top); % Asumiendo que todos los archivos tienen la misma longitud
    medias_msqi_original = zeros(1, num_archivos);
    medias_msqi_corregido_arm = zeros(1, num_archivos);
    medias_msqi_corregido_sternum = zeros(1, num_archivos);

    % Leer los datos y calcular la media por archivo -> archivo original y
    % obtener max y min
    for i = 1:num_archivos
        medias_msqi_original(i) = calcularMedia(mSQI_files_top(i));  % Usamos los archivos pasados como input
        medias_msqi_corregido_arm(i) = calcularMedia(corrected_files_brazo(i));
        medias_msqi_corregido_sternum(i) = calcularMedia(corrected_files_esternon(i));
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

     % Crear un nombre de archivo único utilizando la fecha y hora actual
    fecha_hora = datestr(now, 'yyyy-mm-dd_HH-MM-SS');
    filename = sprintf('Comparison_mSQI_mSQIcorrected_%s.csv', fecha_hora);

    % Guardar los resultados en un CSV
    writetable(tabla_resultados, filename);
end
