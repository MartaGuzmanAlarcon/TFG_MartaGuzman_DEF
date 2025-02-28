
% El objetivo es crear la tabla directamente para facilitar su apertura en Excel,  
% mediante la función procesar_datosGraficas.  
%  
% La tabla generada incluye mSQI original, corrección y potencia tanto  
% para brazo como el esternón.  
%  
% Los archivos de entrada contienen los nombres de los archivos a analizar.  


% Definir los archivos CSV
files = {'mSQI_FileNames.csv' ,'Corrections_Arm_FileNames.csv','Corrections_Sternum_FileNames.csv', 'Power_Arm_FileNames.csv','Power_Sternum_FileNames'};

% Cargar los datos de los archivos CSV
data = cell(size(files));
for i = 1:length(files)
data{i} = readtable(files{i}, 'ReadVariableNames', false, 'Delimiter', ''); 
end

% Obtener el número de filas
nRows = height(data{1});

% Procesar cada fila
toProcess = cell(1, length(files));
for i = 1:nRows
    for j = 1:length(files)
        toProcess{j} = data{j}{i, 1}{1};
    end
    procesar_datosGraficas(toProcess{:});
end
