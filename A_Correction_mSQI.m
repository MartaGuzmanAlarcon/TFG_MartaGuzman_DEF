% CorrectionMSQI - Función para procesar y corregir datos de mSQI y potencia
%
% Descripción:
% Esta función procesa los archivos de mSQI y potencia, ajusta la longitud de los datos,
% y corrige los valores de mSQI, guarda los resultados en archivos CSV. Al final, también guarda un archivo que contiene los
% nombres de todos los archivos generados.

% Entrada:
% - msqi_files: Celda de nombres de archivos de datos de mSQI.
% - potencia_files: Celda de nombres de archivos de potencia.
% - tipo: Cadena que indica el tipo de corrección (por ejemplo, 'Arm' o 'Sternum').

% Salida:
% - nombres_archivos_resultado: Celda con los nombres de los archivos generados.

function nombres_archivos_resultado = A_Correction_mSQI(msqi_files, potencia_files, tipo)

    nombres_archivos_resultado = {}; % Para almacenar los nombres de los archivos resultado
    resultados_totales = []; % Para almacenar todos los resultados

    % Iterar por cada archivo
    for i = 1:length(msqi_files)
        % Accede a los nombres de archivo dentro del struct o cell
        msqi_filename = msqi_files(i).msqi_file;  
        potencia_filename = potencia_files{i};  

        % Leer datos de archivos
        msqi_data = readmatrix(msqi_filename);
        potencia_data = readmatrix(potencia_filename);
        
        % Ajustar las longitudes de los datos
        [msqi_data_adjusted, potencia_xyz_adjusted] = ajustarLongitudDatos(msqi_data, potencia_data(:, 4));

        % Multiplicar los datos de mSQI con la potencia ajustada
        producto = calculate_product_msqi_power(msqi_data_adjusted, potencia_xyz_adjusted);
        
        % Crear un nombre único para el archivo de salida (quitando caracteres problemáticos)
        output_filename = sprintf('Correction_%s_%s_%s.csv', ...
            strrep(msqi_filename, '.csv', ''), strrep(potencia_filename, '.csv', ''), tipo);
        
        % Guardar el resultado en CSV
        guardarEnCSV(output_filename, producto, {'ResultsCorrections'});

        % Almacenar nombres de archivo y resultados
        nombres_archivos_resultado{end+1} = output_filename;
        resultados_totales = [resultados_totales; producto'];
    end

    % Guardar todos los nombres de los archivos generados
    writetable(table(nombres_archivos_resultado'), sprintf('Corrections_%s_FileNames.csv', tipo), 'WriteVariableNames', false);
    
    % Mostrar mensaje de confirmación
    disp(['Corrección completada para ' tipo]);

end
