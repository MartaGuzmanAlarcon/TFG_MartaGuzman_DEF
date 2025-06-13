% Multiplca la potencia y msqi ajustando vectores de dichos valores
% devuelve el msqi corregido

function mSQI_corrected = calculate_product_msqi_power(mSQI, power)
% Verificar que las dimensiones de las matrices coincidan
if size(mSQI) ~= size(power)
    error('Las dimensiones de los vectores no coinciden');
end

% Configuración de parámetros
epsilon = 0.1;%0.5;  % Evitar división por cero
percentil_value = 10;  % Percentil para umbral de potencia
percentil_30 = prctile(mSQI, 30);
percentil_70 = prctile(mSQI, 70);

% Umbral de potencia por debajo del percentil
percentil_10 = prctile(power, percentil_value);
mascara = power < percentil_10;
power_threshold = power;
power_threshold(mascara) = power_threshold(mascara) + epsilon; % Evitar 0 absoluto

% Normalización no lineal de la potencia
power_norm = power_threshold.^(1/3)*5;

% Máximo de mSQI en el registro
maximum = max(mSQI);

% Corrección basada en la diferencia con el máximo
correction_factor = ((maximum - mSQI).^2) .* ((1./(mSQI + 0.3)) .* power_norm);

% Nuevo peso que equilibra la corrección en valores intermedios
weight = ((maximum - mSQI) ./ maximum).^1.5;
weight = weight + (0.2 * (maximum > 0.85)); % Aumenta peso si el máximo es alto (>0.85)

% Corrección extra para valores intermedios (0.6-0.7) independientemente de la potencia
intermediate_boost = 1+0.2 * (mSQI > percentil_30 & mSQI < percentil_70)  % Pequeño empuje extra
% Aplicación de la corrección
    %mSQI_corrected = mSQI + weight .* correction_factor + (intermediate_boost .* (1-(mSQI-percentil_10)));  
    mSQI_corrected = mSQI + weight .* correction_factor .*intermediate_boost;  
end
