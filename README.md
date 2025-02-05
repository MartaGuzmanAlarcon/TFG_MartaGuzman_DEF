Main Scripts in this repository:

**Analizar_dts_acelerometro.m**
-Analiza datos de acelerómetros de archivos dados.
-Calcula media y desviación estándar.
-Grafica el histograma de Potencia Total XYZ.

**Calculo_Potencias.m**
-Procesa datos de acelerómetros.
-Calibra los acelerómetros.
-Filtra las señales aplicando un filtro paso bajo.
-Calcula las potencias en los ejes X, Y, Z y la potencia total en ventanas de 10 segundos.
-Almacena los resultados en archivos CSV.
-Guarda listado de los nombres de archivos generados en CSV.

**Calculo_mSQI.m**
-Procesa datos ECG de archivos para los registros.
-Calcula mSQI .
-Guarda resultados de calidad en archivos CSV.
-Guarda listado de los nombres de archivos generados en CSV.


**Comparison_OldmSQI_CorrectedmSQI_.m**
-Lee archivos CSV con nombres de archivos mSQI original y corregido para brazo y esternón.
-Calcula la media del mSQI para cada archivo.
-Compara los mSQI original y corregido para brazo y esternón: mx-min/min.
-Calculando las diferencias: 
   diferencia_arm = resultado_original - resultado_corregido_arm.
   diferencia_sternum = resultado_original - resultado_corregido_sternum.
-Genera y guarda una tabla con los resultados (máximos, mínimos, resultados y diferencias) en un archivo CSV.


**Correction_mSQI_Potenciaxyz.m**
- Usa funciones como: 
    CorrectionMSQI.m: procesa archivos de mSQI y potencia,los prepara para calculate_product_msqi_power.m, guarda los resultados en archivos CSV, y guarda listado de los nombres de archivos generados en CSV.
    calculate_product_msqi_power: hace la corrección como tal.

**Correlation_Arm_Sternum.m:** calcula la correlacion entre arm y sternum

**Def_mSQI_CI_Median.m:**
-Importar y procesar datos ECG.
-Calcular mSQI.
-Guardar resultados.
-Calcular intervalos de confianza entre registros usando `estimateCIMedian` y `estimateCIMean`.
-Generar histogramas de mSQI para cada registro de ambos tipos de electrodos.



