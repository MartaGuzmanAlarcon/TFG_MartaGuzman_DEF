
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
%

files = {{'NewI_Working_2024-10-16.txt', 'NewI_Stairs_2024-10-16.txt'}, {'NewII_Working_2024-10-16.txt', 'NewII_Stairs_2024-10-16.txt'}};

frecuencia_original = 1000;
%time_vector = 1:(((7*60 + 59)*60)*frecuencia_original - 360000); % 8h
time_vector = 1:(5*60)*frecuencia_original;  % 5mins

% Llamar a la función que organiza todo el flujo de trabajo
A_Compare_OldmSQI_CorrectedmSQI(files, time_vector);
