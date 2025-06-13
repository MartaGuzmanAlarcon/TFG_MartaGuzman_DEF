
% Script principal
% % Este script se encarga de organizar y comparar las métricas mSQI original
% y corregido (tanto para brazo como esternón) a lo largo de un intervalo de tiempo.
%
% Se requiere definir:
% 1. Archivos que se quieran analizar: filesFabrics,filesElectrodeSizes, filesRegistrosControlados
% 2. Un vector de tiempo: elegir 
% 3. frecuencia
%
% Salida: Se genera una tabla de resultados que compara las métricas y sus diferencias.
% corrected arm, ster.

filesSizeXL = {'R1_Electr_XL_2025-02-24.txt', 'R2_Electr_XL_2025-03-20.txt', 'R3_Electr_XL_2025-03-26.txt', 'R4_Electr_XL_2025-05-07.txt'};
filesSizeL = {'R1_Electr_L_2025-02-26.txt', 'R2_Electr_L_2025-03-24.txt', 'R3_Electr_L_2025-03-26.txt', 'R4_Electr_L_2025-05-05.txt'};
filesSizeS = {'R1_Electr_S_2025-03-10.txt', 'R2_Electr_S_2025-04-24.txt', 'R3_Electr_S_2025-04-28.txt', 'R4_Electr_S_2025-04-30.txt'};

filesFabric1 = {'Top2_R1_2024-11-21.txt', 'Top2_R2_2024-11-22.txt', 'Top2_R3_2024-11-25.txt', 'Top2_R4_2024-12-09.txt'};
filesFabric2 = {'TopS_R1_2024-04-04.txt', 'TopS_R2_2024-04-12.txt', 'TopS_R3_2024-04-16.txt', 'TopS_R4_2024-04-23.txt'};
filesFabric3 = {'Top1_R1_Registro8h_2024-11-04.txt', 'Top1_R2_Registro8h_2024-11-05.txt', 'Top1_R3_2024-11-07.txt', 'Top1_R4_2024-11-18.txt'};

filesRegistrosControlados = {
    {'I_Rest_Stairs_2025-02-21.txt', 'I_Rest_Walking_2025-02-21.txt'},
    {'I_Rest_Stairs_2025-02-21.txt', 'I_Rest_Working_2025-02-21.txt'},
    {'I_Rest_Walking_2025-02-21.txt', 'I_Rest_Working_2025-02-21.txt'},

    {'II_Rest_Stairs_2025-02-21.txt', 'II_Rest_Walking_2025-02-21.txt'},
    {'II_Rest_Stairs_2025-02-21.txt', 'II_Rest_Working_2025-02-21.txt'},
    {'II_Rest_Walking_2025-02-21.txt', 'II_Rest_Working_2025-02-21.txt'},

    };

filesFabrics= {filesFabric1,filesFabric2,filesFabric3}
filesElectrodeSizes = {filesSizeXL,filesSizeL,filesSizeS}

frecuencia_original = 1000;
%time_vector = 1:(((7*60 + 59)*60)*frecuencia_original - 360000); % 8h
time_vector = 1:(2*60)*frecuencia_original;  % 2mins

% Llamar a la función que organiza todo el flujo de trabajo
A_Compare_OldmSQI_CorrectedmSQI(filesFabrics, time_vector);

