
% idea: msqi*potencia(mov)

% Leer los archivos CSV
msqi_files = readmatrix('mSQI_FileName_Top.csv', 'Delimiter', ',', 'NumHeaderLines', 1, 'OutputType', 'string');
potencia_files_arm = readmatrix('power_FileName_Arm.csv', 'Delimiter', ',', 'NumHeaderLines', 1, 'OutputType', 'string');
potencia_files_sternum = readmatrix('power_FileName_Sternum.csv', 'Delimiter', ',', 'NumHeaderLines', 1, 'OutputType', 'string');

% Llamar a la función para procesar los archivos para "potencia_files_arm" y "msqi_files"
CorrectionMSQI(msqi_files, potencia_files_arm, 'Arm');

% Llamar a la función para procesar los archivos para "potencia_files_sternum" y "msqi_files"
CorrectionMSQI(msqi_files, potencia_files_sternum, 'Sternum');
