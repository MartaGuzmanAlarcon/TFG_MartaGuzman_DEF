
% Script principal
% % Este script se encarga de organizar y comparar las métricas mSQI original
% y corregido (tanto para brazo como esternón) a lo largo de un intervalo de tiempo.
%
% Se requiere definir:
% 1. Archivos que se quieran analizar
% 2. Un vector de tiempo
% 3. frecuencia
%
% Salida: Se genera una tabla de resultados que compara las métricas y sus diferencias.
% corrected 3arm, 3ster

files = {
    {'I_Rest_Stairs_2025-02-21.txt', 'I_Rest_Walking_2025-02-21.txt'},
    {'I_Rest_Stairs_2025-02-21.txt', 'I_Rest_Working_2025-02-21.txt'},
    {'I_Rest_Walking_2025-02-21.txt', 'I_Rest_Working_2025-02-21.txt'},

    {'II_Rest_Stairs_2025-02-21.txt', 'II_Rest_Walking_2025-02-21.txt'},
    {'II_Rest_Stairs_2025-02-21.txt', 'II_Rest_Working_2025-02-21.txt'},
    {'II_Rest_Walking_2025-02-21.txt', 'II_Rest_Working_2025-02-21.txt'},



    };

frecuencia_original = 1000;
%time_vector = 1:(((7*60 + 59)*60)*frecuencia_original - 360000); % 8h
time_vector = 1:(8*60)*frecuencia_original;  % 8mins

% Llamar a la función que organiza todo el flujo de trabajo
A_Compare_OldmSQI_CorrectedmSQI(files, time_vector);

