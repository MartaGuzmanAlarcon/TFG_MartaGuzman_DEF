
% msqi*potencia

function CorrectionMSQI(msqi_files, potencia_files, tipo)
    % Inicializar una lista para nombres de archivos y una celda para almacenar los resultados
    nombres_archivos_resultado = {};
    resultados_totales = [];
    
    % Función para codificar nombres largos
    codificarNombre = @(nombre) matlab.lang.makeValidName(strrep(nombre, '_', ''));
    
    % Iterar a través de los nombres de archivo y cargar datos
    for i = 1:length(msqi_files)
        % Obtener el nombre del archivo mSQI actual y el correspondiente de potencia
        msqi_filename = char(msqi_files(i));
        potencia_filename = char(potencia_files(i));
        
        % Cargar los datos de los archivos de mSQI y potencia
        msqi_data = readmatrix(msqi_filename);
        potencia_data = readmatrix(potencia_filename);
        
        % Extraer la cuarta columna de potencia_data
        potencia_xyz = potencia_data(:, 4);
        
        % Ajustar longitudes de msqi_data y potencia_xyz usando la función
        [msqi_data_adjusted, potencia_xyz_adjusted] = ajustarLongitudDatos(msqi_data, potencia_xyz);
        
        % Multiplicar los valores de mSQI con los valores de potencia ajustados
        % producto = msqi_data_adjusted .* potencia_xyz_adjusted;
        %usar mejor funcion
        producto = calculate_product_msqi_power(msqi_data_adjusted, potencia_xyz_adjusted);

        
        % Crear un nombre de archivo fusionado con ambos nombres
        msqi_base = erase(msqi_filename, '.txt');
        potencia_base = erase(potencia_filename, '.txt');
        
        % Eliminar guiones de la fecha en el nombre de los archivos
        msqi_base = strrep(msqi_base, '-', '');  % Eliminar guiones de la fecha
        potencia_base = strrep(potencia_base, '-', '');  % Eliminar guiones de la fecha
        
        % Fusionar los nombres de archivos
        raw_filename = ['Correction_' msqi_base '_' potencia_base '_' tipo '.csv'];
        
        % Codificar el nombre para evitar truncamientos y caracteres no válidos
        output_filename = codificarNombre(raw_filename);
        
        % Guardar el resultado en un archivo CSV
       guardarEnCSV(output_filename, producto, {'ResultsCorrections'});

        % Almacenar el nombre del archivo en la lista
        nombres_archivos_resultado = [nombres_archivos_resultado; {output_filename}];
        resultados_totales = [resultados_totales; producto'];
    end

    % Crear una tabla para almacenar todos los nombres de archivos
    tabla_nombres = table(nombres_archivos_resultado, 'VariableNames', {'FileName'});
    writetable(tabla_nombres, ['Corrections_msqi_power_FileName_' tipo '.csv']);
    
    disp(['Multiplicación de datos para ' tipo ' completada. Los resultados están almacenados en archivos CSV y los nombres de archivo en Corrections_msqi_potencia_NombreArchivos_' tipo '.csv.']);
end
