
% Esta función procesa un conjunto de archivos, realizando los siguientes pasos:
    % 1. Calcular mSQI para los datos de los archivos de entrada.
    % 2. Calcular las potencias de las señales en el esternón y el brazo.
    % 3. Aplicar corrección a los datos de mSQI utilizando las potencias calculadas.
    % 4. Comparar los valores de mSQI original y corregido, y guardar los resultados.
    %
    % Parámetros de entrada:
    %   files - Celda con los nombres de los archivos de datos para procesar.
    %   time_vector - Vector de tiempo para ajustar las señales de los archivos.
    %
    % Salida:
    %   Genera archivos de comparación entre los mSQI originales y corregidos, incluyendo las diferencias.
    %

function A_Compare_OldmSQI_CorrectedmSQI(files, time_vector)

    
    % Recorrer cada grupo de archivos
    for i = 1:length(files)
        file_group = files{i};  % Extraer el grupo de archivos
        
        % PASO 1: Calcular mSQI y guardar resultados
        [mSQI_files_top] = A_Calculo_mSQI(file_group, time_vector);
        
        % PASO 2: Calcular Potencias y guardar resultados
        [potencias_archivos_generados_esternon, potencias_archivos_generados_brazo] = A_Calculo_Potencias(file_group, time_vector);
        
        % PASO 3: Aplicar corrección con mSQI y Potencia para el esternón
        corrected_files_esternon = A_Correction_mSQI(mSQI_files_top, potencias_archivos_generados_esternon, 'Sternum');
        
        % Aplicar corrección para el brazo
        corrected_files_brazo = A_Correction_mSQI(mSQI_files_top, potencias_archivos_generados_brazo, 'Arm');
        
        % PASO 4: Comparar mSQI original y corregido
        A_Comparison_OldmSQI_CorrectedmSQI(mSQI_files_top, corrected_files_esternon, corrected_files_brazo);
    end
end
