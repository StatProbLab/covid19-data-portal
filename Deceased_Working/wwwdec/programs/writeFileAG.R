##Writing data as files

write.csv(wave_1_no_na,file = "csv/Wave1Data.csv", row.names=FALSE)
write.csv(wave_2_no_na,file = "csv/Wave2Data.csv", row.names=FALSE)
write.csv(mid_wave_no_na,file = "csv/MidWaveData.csv", row.names=FALSE)
write.csv(final_ratio_df_for_file, file = "csv/AgeBinDataWaveWise.csv", row.names=FALSE)
write.csv(wave_conf_df,file = "csv/WaveWiseStatisticsAcrossDistricts.csv", row.names=FALSE)
write.csv(df,file = "csv/DataWithWaveCategory.csv", row.names=FALSE)
write.csv(death_cnt_df,file = "csv/DeathCountAcrossWavesDistrictWise.csv", row.names=FALSE)
write.csv(df_new, file = "csv/DataWithAgeWiseCategory.csv", row.names=FALSE)

##Saving zip file - problem - says the zipped folder is invalid idk y
#files_to_zip <- dir('DistrictAge', full.names = TRUE)
#zip::zip(zipfile = 'DistrictAgeZip.zip', files = files_to_zip)
