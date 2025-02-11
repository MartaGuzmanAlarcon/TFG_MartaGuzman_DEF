% Frecuencia de muestreo original
frecuencia_original = 1000;  % Hz
long_ventana = 10; % Duración de la ventana en segundos

% Número de muestras por ventana de n segundos
muestras_por_ventana = round(frecuencia_original * long_ventana); 
TEST = 1;

if (TEST)
    time_vector = 1:(5*60)*frecuencia_original;  % % 5 minutos de registro
    % Recuerda= fs (Hz)= muetsras/s --> 5min x 60s = 300s-> ¿muestras?=
    % fs*s = 1000*300=300000 minimo

    file1 = 'NewIII_Rest_2024-10-18.txt';
    file2 = 'NewIII_Working_2024-10-18.txt';
    file3 = 'NewIII_Walking_2024-10-18.txt';
    file4 = 'NewIII_Stairs_2024-10-18.txt';
    
    file5 = 'NewII_Rest_2024-10-16.txt';
    file6 = 'NewII_Working_2024-10-16.txt';
    file7 = 'NewII_Walking_2024-10-16.txt';
    file8 = 'NewII_Stairs_2024-10-16.txt';

    files_pruebas = {file1, file2, file3, file4, file5, file6, file7, file8};
else
    time_vector = 1:(((7*60 + 59)*60)*frecuencia_original-360000); % 8 horas
    files_pruebas = {'TopS_R1_2024-04-04.txt', 'TopS_R2_2024-04-12.txt', 'TopS_R3_2024-04-16.txt', 'TopS_R4_2024-04-23.txt'};
end

% Calibraciones para cada acelerómetro
min_vals_esternon = [25876, 27540, 24020];
max_vals_esternon = [46152, 38012, 39096];

min_vals_brazo = [27832, 25272, 27584]; % [minx,miny,minz]
max_vals_brazo = [40104, 38076, 40468];

for file_index = 1:numel(files_pruebas)
    file_name = files_pruebas{file_index};

    % Leer los datos del archivo
    data = readmatrix(file_name);
    
    % Extraer las posiciones para ambos acelerómetros
    % en mi caso conecte el rojo al canal:2,3,4 -> x,y,z  (ver col. correspondientes en el .txt)
    % conecte el rojo al canal:6,7,8 -> x,y,z 
    posicion_x_esternon = data(:, 8); posicion_y_esternon = data(:, 9); posicion_z_esternon = data(:, 10);
    posicion_x_brazo = data(:, 4); posicion_y_brazo = data(:, 5); posicion_z_brazo = data(:, 6);

    % Limitar la longitud de los datos según time_vector
    [posicion_x_esternon_acotado, posicion_y_esternon_acotado, posicion_z_esternon_acotado] = limitarPosiciones(posicion_x_esternon, posicion_y_esternon, posicion_z_esternon, time_vector);
    [posicion_x_brazo_acotado, posicion_y_brazo_acotado, posicion_z_brazo_acotado] = limitarPosiciones(posicion_x_brazo, posicion_y_brazo, posicion_z_brazo, time_vector);

    % Procesar cada acelerómetro
    resultados_esternon = procesar_acelerometro(posicion_x_esternon_acotado, posicion_y_esternon_acotado, posicion_z_esternon_acotado, muestras_por_ventana, min_vals_esternon, max_vals_esternon);
    resultados_brazo = procesar_acelerometro(posicion_x_brazo_acotado, posicion_y_brazo_acotado, posicion_z_brazo_acotado, muestras_por_ventana, min_vals_brazo, max_vals_brazo);

    % Guardar resultados en archivos CSV
    nombre_archivo_esternon = ['Power_Sternum_', file_name, '.csv'];
    nombre_archivo_brazo = ['Power_Arm_', file_name, '.csv'];

    columnas = {'power_x', 'power_y', 'power_z', 'power_total_xyz'};
    writetable(array2table(resultados_esternon, 'VariableNames', columnas), nombre_archivo_esternon);
    writetable(array2table(resultados_brazo, 'VariableNames', columnas), nombre_archivo_brazo);

    potencias_archivos_generados_esternon{file_index, 1} = nombre_archivo_esternon;
    potencias_archivos_generados_brazo{file_index, 1} = nombre_archivo_brazo;
end

% Guardar nombres de los archivos generados
file_list_esternon = cell2table(potencias_archivos_generados_esternon, 'VariableNames', {'FileName'});
file_list_brazo = cell2table(potencias_archivos_generados_brazo, 'VariableNames', {'FileName'});

writetable(file_list_esternon, 'power_FileName_Sternum.csv');
writetable(file_list_brazo, 'power_FileName_Arm.csv');
