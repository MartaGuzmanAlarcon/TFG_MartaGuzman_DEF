% Función para procesar un conjunto de archivos y generar una tabla

function procesar_datosGraficas(archivo_msqi, archivo_corrected_Arm, archivo_corrected_Sternum, archivo_power_Arm, archivo_power_Sternum)

% Extraer el nombre base del archivo_msqi eliminando "mSQI_Top" y la extensión
    [~, nombre_base, ~] = fileparts(archivo_msqi);
    nombre_registro = erase(nombre_base, "mSQI_Top");

    % Cargar datos eliminando encabezado
    msqi_original = readmatrix(archivo_msqi, 'NumHeaderLines', 1);
    corrected_msqi_Arm = readmatrix(archivo_corrected_Arm, 'NumHeaderLines', 1);
    corrected_msqi_Sternum = readmatrix(archivo_corrected_Sternum, 'NumHeaderLines', 1);

    % Importar solo la cuarta columna de power_Arm y power_Sternum -> powertotal
    power_Arm = readmatrix(archivo_power_Arm, 'NumHeaderLines', 1);
    power_Arm = power_Arm(:,4);

    power_Sternum = readmatrix(archivo_power_Sternum, 'NumHeaderLines', 1);
    power_Sternum = power_Sternum(:,4);

    % Calcular diferencias
    Diff_Arm = msqi_original - corrected_msqi_Arm;
    Diff_Sternum = msqi_original - corrected_msqi_Sternum;

    % Crear tabla final con nombres de columnas adecuados
    tabla_final = table(msqi_original, corrected_msqi_Arm, corrected_msqi_Sternum, ...
        power_Arm, power_Sternum, Diff_Arm, Diff_Sternum, ...
        'VariableNames', {'msqi_original', 'corrected_msqi_Arm', ...
        'corrected_msqi_Sternum', 'power_Arm', ...
        'power_Sternum', 'Diff_Arm', 'Diff_Sternum'});

    % Nombre del archivo de salida
    nombre_salida = ['AnalisisGrafico', nombre_registro, '.csv'];

    % Guardar tabla en un archivo CSV con encabezados
    writetable(tabla_final, nombre_salida);

    disp(['Archivo generado: ', nombre_salida]);

end
