
% Función para leer archivos y calcular la media ignorando la cabecera

function media = calcularMedia(archivo)
    % Asegúrate de que archivo es una cadena
    if iscell(archivo)
        archivo = archivo{1};  % Extrae el nombre si es una celda
    elseif isstruct(archivo)
        archivo = archivo.msqi_file;  % Cambia 'msqi_file' por el campo adecuado si es un struct
    end

    % Leer los datos del archivo
    try
        datos = readmatrix(archivo, 'Delimiter', ',', 'NumHeaderLines', 1);  % Lee el archivo
        media = mean(datos);  % Calcular la media
    catch
        warning('No se pudo leer el archivo: %s', archivo);
        media = NaN;  % Retorna NaN si ocurre un error
    end
end
