
% Función para leer archivos y calcular la media ignorando la cabecera
function media = calcularMedia(archivo)
    datos = readmatrix(archivo, 'Delimiter', ',', 'NumHeaderLines', 1);
    media = mean(datos, 'omitnan'); % Calcula la media ignorando valores NaN
end