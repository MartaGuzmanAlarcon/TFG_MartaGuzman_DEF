% Multiplca la potencia y msqi ajustando vectores de dichos valores 
% devuelve el msqi corregido 

function mSQI_corrected = calculate_product_msqi_power(mSQI, power)
    % Verificar que las dimensiones de las matrices coincidan
    if size(mSQI) ~= size(power)
        error('Las dimensiones de los vectores no coinciden');
    end
    
    %Configuration parameters
    
    %Avoid division by zero in the correction
    epsilon = 0.5;
    %percentile to use to threshold power
    perceltil_value = 10;

    %Threshold power below the percentile
    percentil = prctile(power, perceltil_value);
    mascara = power < percentil;
    power_threshold = power;
    power_threshold(mascara) = 0;
    
    %Non-linear emphasis for higher power values
    %Note: we may need to apply a maximum power threshold to avoid ouliers on long records
    power_norm = power_threshold.^(1/3);
    % The maximum value will not be corrected, 
    % and the rest will be corrected linearly with respect to their difference from the maximum.
    maximum = max(mSQI);
    %(1./(mSQI+0.2) -> maximum of 5x (1/0.2) boost 
    mSQI_corrected = mSQI + ((maximum-mSQI).^3).*((1./(mSQI+0.2)).*power_norm);
    end
