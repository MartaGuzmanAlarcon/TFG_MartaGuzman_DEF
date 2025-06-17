% Lista de archivos mSQI en formato CSV
msqi_files = {
    'mSQI_Top_R1_Electr_S_2025-03-10.txt.csv'
};

% Lista de archivos de potencia en formato CSV
potencia_files = {
    'Power_Arm_R1_Electr_S_2025-03-10.txt.csv'
};

tipo = 'arm';  % o 'sternum'

resultados_totales = [];         % Para almacenar todos los resultados

for i = 1:length(msqi_files)
    msqi_filename = msqi_files{i};
    potencia_filename = potencia_files{i};

    % Leer los datos desde CSV (sin encabezados)
    msqi_data = readmatrix(msqi_filename);
    potencia_data = readmatrix(potencia_filename);

    % Extraer columna 4: potencia total XYZ
    potencia_xyz = potencia_data(:, 4);

    % Ajustar longitudes de ambas señales
    [msqi_data_adjusted, potencia_xyz_adjusted] = ajustarLongitudDatos(msqi_data, potencia_xyz);

    % Aplicar corrección de mSQI con potencia
    mSQI_corrected = calculate_product_msqi_power(msqi_data_adjusted, potencia_xyz_adjusted);
   
end

fprintf("Proceso completado. %d archivo(s) procesado(s).\n", length(msqi_files));
