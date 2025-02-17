archivos_mSQI_original = {'mSQI_Top_NewIII_Working_2024-10-18.txt.csv', 'mSQI_Top_NewIII_Stairs_2024-10-18.txt.csv'};
archivos_mSQI_corregido_arm = {'CorrectionmSQITopNewIIIWorking20241018_csvPowerArmNewIIIWorking.csv', 'CorrectionmSQITopNewIIIStairs20241018_csvPowerArmNewIIIStairs20.csv'};
archivos_mSQI_corregido_sternum = {'CorrectionmSQITopNewIIIWorking20241018_csvPowerSternumNewIIIWor.csv', 'CorrectionmSQITopNewIIIStairs20241018_csvPowerSternumNewIIIStai.csv'}; 


%files={{'file1_top1.txt', 'file2_top1.txt'},{'file1_top2.txt', 'file2_top2.txt'},{'file1_camiseta1.txt', 'file2_camiseta1.txt'}}
%Compare_OldmSQI_CorrectedmSQI(files)

files={{'...'},{'mSQI_Top_NewIII_Working_2024-10-18.txt.csv', 'mSQI_Top_NewIII_Stairs_2024-10-18.txt.csv',
    'CorrectionmSQITopNewIIIWorking20241018_csvPowerArmNewIIIWorking.csv', 'CorrectionmSQITopNewIIIStairs20241018_csvPowerArmNewIIIStairs20.csv',
    'CorrectionmSQITopNewIIIWorking20241018_csvPowerSternumNewIIIWor.csv', 'CorrectionmSQITopNewIIIStairs20241018_csvPowerSternumNewIIIStai.csv'},{
   }
   Compare_OldmSQI_CorrectedmSQI(files)

Compare_OldmSQI_CorrectedmSQI(archivos_mSQI_original, archivos_mSQI_corregido_arm, archivos_mSQI_corregido_sternum)

{'NewI_Working_2024-10-16.txt', 'NewI_Stairs_2024-10-16.txt'},
{'NewI_Rest_2024-10-16.txt', 'NewI_Walking_2024-10-16.txt'},

{'NewII_Working_2024-10-16.txt', 'NewII_Stairs_2024-10-16.txt'},
{'NewII_Rest_2024-10-16.txt', 'NewII_Walking_2024-10-16.txt'},

{'NewIII_Working_2024-10-18.txt', 'NewIII_Stairs_2024-10-18.txt'},
{'NewIII_Rest_2024-10-18.txt', 'NewIII_Walking_2024-10-18.txt'},

{'Trabajando_2024-09-21.txt', 'Escaleras_2024-09-21.txt'},
{'Reposo_2024-09-21.txt', 'Andando_2024-09-21.txt'},

{'WorkingII_2024-09-24.txt', 'StairsII_2024-09-24.txt'},
{'RestII_2024-09-24.txt', 'WalkingII_2024-09-24.txt'}