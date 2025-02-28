
% Esta función recibe un grupo de archivos (file_group) y analiza datos de los acelerómetros,
% los procesa para calcular las potencias en los ejes x, y, z, la potencia
% total en cada eje, y guarda estos resultados en archivos CSV. La función también limita los datos
% a un rango de tiempo especificado y utiliza las calibraciones predefinidas para los acelerómetros.
% Los resultados se guardan por separado para los dos acelerómetros: uno en el esternón y otro en el brazo.
%
% Entradas:
%   - file_group: Celda de nombres de archivos que contienen los datos de los acelerómetros.
%   - time_vector: Vector de tiempo que define el rango de datos a procesar.
%
% Salidas:
%   - potencias_archivos_generados_esternon, potencias_archivos_generados_brazo: DESCRIBIR BIEN.


function [corrected_files_esternon, corrected_files_brazo] = A_Calculo_Potencias(file_group, time_vector)

% Definir la frecuencia de muestreo original y la longitud de la ventana
frecuencia_original = 1000;  % Hz
long_ventana = 10;  % Duración de la ventana en segundos
muestras_por_ventana = round(frecuencia_original * long_ventana);

% Inicializar las variables para guardar los archivos de salida
corrected_files_esternon = {};  % Archivos corregidos para el esternón
corrected_files_brazo = {};     % Archivos corregidos para el brazo

% Calibraciones para cada acelerómetro
min_vals_esternon = [25876, 27540, 24020];
max_vals_esternon = [46152, 38012, 39096];

min_vals_brazo = [27832, 25272, 27584]; % [minx, miny, minz]
max_vals_brazo = [40104, 38076, 40468];

% Recorrer cada archivo en el grupo
for file_index = 1:numel(file_group)
    file_name = file_group{file_index};  % Nombre del archivo

    % Leer los datos del archivo
    data = readmatrix(file_name);

    % Extraer las posiciones para ambos acelerómetros (Esternón y Brazo)
    posicion_x_esternon = data(:, 7);
    posicion_y_esternon = data(:, 8);
    posicion_z_esternon = data(:, 9);

    posicion_x_brazo = data(:, 4);
    posicion_y_brazo = data(:, 5);
    posicion_z_brazo = data(:, 6);

    % Limitar la longitud de los datos según el time_vector definido
    %time_vector = time_vector * frecuencia_original;  % Convertir a muestras
    [posicion_x_esternon_acotado, posicion_y_esternon_acotado, posicion_z_esternon_acotado] = limitarPosiciones(posicion_x_esternon, posicion_y_esternon, posicion_z_esternon, time_vector);
    [posicion_x_brazo_acotado, posicion_y_brazo_acotado, posicion_z_brazo_acotado] = limitarPosiciones(posicion_x_brazo, posicion_y_brazo, posicion_z_brazo, time_vector);

    % Procesar cada acelerómetro para calcular las potencias
    resultados_esternon = procesar_acelerometro(posicion_x_esternon_acotado, posicion_y_esternon_acotado, posicion_z_esternon_acotado, muestras_por_ventana, min_vals_esternon, max_vals_esternon);
    resultados_brazo = procesar_acelerometro(posicion_x_brazo_acotado, posicion_y_brazo_acotado, posicion_z_brazo_acotado, muestras_por_ventana, min_vals_brazo, max_vals_brazo);

    % Guardar resultados de potencias en archivos CSV
    nombre_archivo_esternon = ['Power_Sternum_', file_name, '.csv'];
    nombre_archivo_brazo = ['Power_Arm_', file_name, '.csv'];

    % Escribir los resultados en los archivos CSV
    columnas = {'power_x', 'power_y', 'power_z', 'power_total_xyz'};
    writetable(array2table(resultados_esternon, 'VariableNames', columnas), nombre_archivo_esternon);
    writetable(array2table(resultados_brazo, 'VariableNames', columnas), nombre_archivo_brazo);

    % Almacenar los nombres de los archivos generados en sus celdas
    corrected_files_esternon{file_index, 1} = nombre_archivo_esternon;
    corrected_files_brazo{file_index, 1} = nombre_archivo_brazo;
end

% Guardar nombres de archivos generados en CSV

writetable(table(unique((corrected_files_esternon))), 'Power_Sternum_FileNames.csv', ...
           'WriteVariableNames', false, 'WriteMode', 'append');

writetable(table(unique((corrected_files_brazo))), 'Power_Arm_FileNames.csv', ...
           'WriteVariableNames', false, 'WriteMode', 'append');

end

