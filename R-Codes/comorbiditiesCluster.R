###############################################################################
## Title:                                                                    ##
## Input: mediadata/Master.csv	                                             ##
## Output: "csv/ComorbiditiesClassification.csv |                            ##
##          csv/Comorbidities_vs_Districts.csv"                              ##
## Date Modified: 3rd May 2024                                               ##
###############################################################################


#libraries
library("readxl")
library("ggplot2")
library("grid")
library("gridExtra")
library("plotly")
library("htmlwidgets")
library("tidyr")
library("tidyverse")
library("reshape")

# Set current working directory
setwd("/opt/lampp/htdocs/covid19-data-portal/Deceased_Working/wwwdec/")

# Reading data from csv file
mydata=read.csv("mediadata/Master.csv")

district=mydata$District
district_code_names=c("Bagal", "Ballari", "Belagavi", "Rural", "Urban", "Bidar", "Chamaraja", "Ballapura", "Magalur", "Chitra", "Dakshina", "Davan", "Dharwad", "Gadag", "Hassan", "Haveri", "Kalabur", "Kodagu", "Kolar", "Koppal", "Mandya", "Mysuru", "Raichur", "Ramanagara", "Mog", "Tumakuru", "Udupi", "Uttara", "Vijay", "Yadgir")

district_names=c("Bagalkote", "Ballari", "Belagavi", "Bengaluru Rural", "Bengaluru Urban", "Bidar", "Chamarajanagara", "Chikkaballapura", "Chikkamagaluru", "Chitradurga", "Dakshina Kannada", "Davanagere", "Dharawada", "Gadag", "Hassan", "Haveri", "Kalaburagi", "Kodagu", "Kolar", "Koppal", "Mandya", "Mysuru", "Raichur", "Ramanagara", "Shivamogga", "Tumakuru", "Udupi", "Uttara Kannada", "Vijayapura", "Yadgiri", "All Karnataka")

comorbidities_clusters=c("Resp.\nDiseases", "Kidney\nRelated\nDiseases", "Liver\nRelated\nDiseases", "Heart\nand\nBlood\nPressure\nDisease", "Epilepsy", "Diabetes\nand\nObesity", "Hormone\nand\nGland\nDiseases", "Anaemia\nand\nMyas-\nthenia", "Cancer", "Sepsis", "Pulmonary\nand\nLung\nDiseases", "Brain\nRelated\nDisease", "Skin\nDiseases", "Preg-\nnancy\nRelated\nIllness", "Infect-\nious\nDiseases")
cluster=matrix(c(1:465), nrow=15)

for(a in 1:length(district_code_names))
{
        p=c()
        given_district=subset(mydata, grepl(district_code_names[a], district, ignore.case="True"))
        comorbidities=given_district$Co.Morbidities

        count_comorbidities_cluster=c()

        count_comorbidities_cluster[1]=length(grep("Asthma|ARDS", comorbidities, ignore.case="True"))
        cluster[1,a]=count_comorbidities_cluster[1]

        count_comorbidities_cluster[2]=length(grep("Kidney|Renal|AKD|CKD|AKI|ARF|RTA|RVD", comorbidities, ignore.case="True"))
        cluster[2,a]=count_comorbidities_cluster[2]

        count_comorbidities_cluster[3]=length(grep("Liver|Cirrhosis|CLD", comorbidities, ignore.case="True"))
        cluster[3,a]=count_comorbidities_cluster[3]

        count_comorbidities_cluster[4]=length(grep("Heart|Blood|CHD|IHD|RHD|COPD|CAD|Cardio|LVF|Tension|HTN|HTM|IDH|PTCA|DVT|PNC|Pancytopenia|CVD", comorbidities, ignore.case="True"))
        cluster[4,a]=count_comorbidities_cluster[4]

        count_comorbidities_cluster[5]=length(grep("Epilepsy", comorbidities, ignore.case="True"))
        cluster[5,a]=count_comorbidities_cluster[5]

        count_comorbidities_cluster[6]=length(grep("Diabeties|Obesity|Juvenile DM|Type 2 DM|Uncontrolled DM|DN|DM", comorbidities, ignore.case="True"))
        cluster[6,a]=count_comorbidities_cluster[6]

        count_comorbidities_cluster[7]=length(grep("Hypothyroidism|Thyroid|Tyroid|roidism|Hypoth|BPH", comorbidities, ignore.case="True"))
        cluster[7,a]=count_comorbidities_cluster[7]

	count_comorbidities_cluster[8]=length(grep("Anaemia|Anemia|Anamea|Myasthenia", comorbidities, ignore.case="True"))
        cluster[8,a]=count_comorbidities_cluster[8]

        count_comorbidities_cluster[9]=length(grep("Cancer|Carcinoma|Colon|CA|Leuk|Metastatic", comorbidities, ignore.case="True"))
        cluster[9,a]=count_comorbidities_cluster[9]

        count_comorbidities_cluster[10]=length(grep("Sepsis|Septicaemia|Septic", comorbidities, ignore.case="True"))
        cluster[10,a]=count_comorbidities_cluster[10]

        count_comorbidities_cluster[11]=length(grep("Pulmonary|Lung|COPD|Pneumonia|Chronic Lung Disease|CLD|Chronic Smoker|Tuberculosis|TB", comorbidities, ignore.case="True"))
        cluster[11,a]=count_comorbidities_cluster[11]

        count_comorbidities_cluster[12]=length(grep("Brain|Neuro|Encephalopathy|Hepatic Encephalopathy|Encephalitis|Hemiplegic|CBA|Park", comorbidities, ignore.case="True"))
        cluster[12,a]=count_comorbidities_cluster[12]

        count_comorbidities_cluster[13]=length(grep("DH", comorbidities, ignore.case="True"))
        cluster[13,a]= count_comorbidities_cluster[13]

        count_comorbidities_cluster[14]=length(grep("PIH", comorbidities, ignore.case="True"))
        cluster[14,a]=count_comorbidities_cluster[14]

        count_comorbidities_cluster[15]=length(grep("Filariasis|HBSAG|HPTN", comorbidities, ignore.case="True"))
        cluster[15,a]=count_comorbidities_cluster[15]

	perarr=c(cluster[1,a], cluster[2,a], cluster[3,a], cluster[4,a], cluster[5,a], cluster[6,a], cluster[7,a], cluster[8,a], cluster[9,a], cluster[10,a], cluster[11,a], cluster[12,a], cluster[13,a], cluster[14,a], cluster[15,a])
	cluster[1,a]=round((cluster[1,a]/sum(perarr)*100), digits=3)
        cluster[2,a]=round((cluster[2,a]/sum(perarr)*100), digits=3)
        cluster[3,a]=round((cluster[3,a]/sum(perarr)*100), digits=3)
        cluster[4,a]=round((cluster[4,a]/sum(perarr)*100), digits=3)
        cluster[5,a]=round((cluster[5,a]/sum(perarr)*100), digits=3)
        cluster[6,a]=round((cluster[6,a]/sum(perarr)*100), digits=3)
        cluster[7,a]=round((cluster[7,a]/sum(perarr)*100), digits=3)
        cluster[8,a]=round((cluster[8,a]/sum(perarr)*100), digits=3)
        cluster[9,a]=round((cluster[9,a]/sum(perarr)*100), digits=3)
        cluster[10,a]=round((cluster[10,a]/sum(perarr)*100), digits=3)
        cluster[11,a]=round((cluster[11,a]/sum(perarr)*100), digits=3)
	cluster[12,a]=round((cluster[12,a]/sum(perarr)*100), digits=3)
	cluster[13,a]=round((cluster[13,a]/sum(perarr)*100), digits=3)
	cluster[14,a]=round((cluster[14,a]/sum(perarr)*100), digits=3)
	cluster[15,a]=round((cluster[15,a]/sum(perarr)*100), digits=3)

}

com=mydata$Co.Morbidities

cluster[1,31]=length(grep("Asthma|ARDS", com, ignore.case="True"))
cluster[2,31]=length(grep("Kidney|Renal|AKD|CKD|AKI|ARF|RTA|RVD", com, ignore.case="True"))
cluster[3,31]=length(grep("Liver|Cirrhosis|CLD", com, ignore.case="True"))
cluster[4,31]=length(grep("Heart|Blood|CHD|IHD|RHD|COPD|CAD|Cardio|LVF|Tension|HTN|HTM|IDH|PTCA|DVT|PNC|Pancytopenia|CVD", com, ignore.case="True"))
cluster[5,31]=length(grep("Epilepsy", com, ignore.case="True"))
cluster[6,31]=length(grep("Diabeties|Obesity|Juvenile DM|Type 2 DM|Uncontrolled DM|DN|DM", com, ignore.case="True"))
cluster[7,31]=length(grep("Hypothyroidism|Thyroid|Tyroid|roidism|Hypoth|BPH", com, ignore.case="True"))
cluster[8,31]=length(grep("Anaemia|Anemia|Anamea|Myasthenia", com, ignore.case="True"))
cluster[9,31]=length(grep("Cancer|Carcinoma|Colon|CA|Leuk|Metastatic", com, ignore.case="True"))
cluster[10,31]=length(grep("Sepsis|Septicaemia|Septic", com, ignore.case="True"))
cluster[11,31]=length(grep("Pulmonary|Lung|COPD|Pneumonia|Chronic Lung Disease|CLD|Chronic Smoker|Tuberculosis|TB", com, ignore.case="True"))
cluster[12,31]=length(grep("Brain|Neuro|Encephalopathy|Hepatic Encephalopathy|Encephalitis|Hemiplegic|CBA|Park", com, ignore.case="True"))
cluster[13,31]=length(grep("DH", com, ignore.case="True"))
cluster[14,31]=length(grep("PIH", com, ignore.case="True"))
cluster[15,31]=length(grep("Filariasis|HBSAG|HPTN", com, ignore.case="True"))


totalarr=c(cluster[1,31], cluster[2,31], cluster[3,31], cluster[4,31], cluster[5,31], cluster[6,31], cluster[7,31], cluster[8,31], cluster[9,31], cluster[10,31], cluster[11,31], cluster[12,31], cluster[13,31], cluster[14,31], cluster[15,31])
        cluster[1,31]=round((cluster[1,31]/sum(totalarr)*100), digits=3)
        cluster[2,31]=round((cluster[2,31]/sum(totalarr)*100), digits=3)
        cluster[3,31]=round((cluster[3,31]/sum(totalarr)*100), digits=3)
        cluster[4,31]=round((cluster[4,31]/sum(totalarr)*100), digits=3)
        cluster[5,31]=round((cluster[5,31]/sum(totalarr)*100), digits=3)
        cluster[6,31]=round((cluster[6,31]/sum(totalarr)*100), digits=3)
        cluster[7,31]=round((cluster[7,31]/sum(totalarr)*100), digits=3)
        cluster[8,31]=round((cluster[8,31]/sum(totalarr)*100), digits=3)
        cluster[9,31]=round((cluster[9,31]/sum(totalarr)*100), digits=3)
        cluster[10,31]=round((cluster[10,31]/sum(totalarr)*100), digits=3)
	cluster[11,31]=round((cluster[11,31]/sum(totalarr)*100), digits=3)
	cluster[12,31]=round((cluster[12,31]/sum(totalarr)*100), digits=3)
	cluster[13,31]=round((cluster[13,31]/sum(totalarr)*100), digits=3)
	cluster[14,31]=round((cluster[14,31]/sum(totalarr)*100), digits=3)
	cluster[15,31]=round((cluster[15,31]/sum(totalarr)*100), digits=3)

comorbidities_cluster_matrix=t(cluster)
dimnames(comorbidities_cluster_matrix)=list(district_names, comorbidities_clusters)

comorbidities_cluster=as.data.frame(comorbidities_cluster_matrix)
write.csv(x=comorbidities_cluster, file="csv/Comorbidities_vs_Districts.csv")

part_A=c(comorbidities_clusters[1],comorbidities_clusters[3], comorbidities_clusters[5], comorbidities_clusters[7], comorbidities_clusters[8], comorbidities_clusters[9], comorbidities_clusters[10],comorbidities_clusters[11], comorbidities_clusters[12], comorbidities_clusters[13], comorbidities_clusters[14], comorbidities_clusters[15])

matrix_A=cbind(comorbidities_cluster_matrix[,1], comorbidities_cluster_matrix[,3], comorbidities_cluster_matrix[,5], comorbidities_cluster_matrix[,7], comorbidities_cluster_matrix[,8], comorbidities_cluster_matrix[,9], comorbidities_cluster_matrix[,10],comorbidities_cluster_matrix[,11], comorbidities_cluster_matrix[,12], comorbidities_cluster_matrix[,13], comorbidities_cluster_matrix[,14], comorbidities_cluster_matrix[,15])

part_B=c(comorbidities_clusters[2], comorbidities_clusters[4], comorbidities_clusters[6])

matrix_B=cbind(comorbidities_cluster_matrix[,2], comorbidities_cluster_matrix[,4], comorbidities_cluster_matrix[,6])

dimnames(matrix_A)=list(district_names, part_A)
dimnames(matrix_B)=list(district_names, part_B)

matrix_A_onlydistricts=head(matrix_A, 30)
heatmap_A=matrix_A_onlydistricts %>%
        as.data.frame() %>%
        rownames_to_column("District") %>%
        pivot_longer(-c(District), names_to = "Symptom_Cluster", values_to = "Percentage") %>%
        ggplot(aes(x=Symptom_Cluster, y=District, fill=Percentage))+
        geom_raster()+
        theme(axis.text.y=element_text(size=94),axis.text.x=element_text(size=77))+
        theme(axis.title.x=element_blank(),  axis.ticks.x=element_blank())+
        theme(axis.title.y=element_blank(),  axis.ticks.y=element_blank())+
        scale_fill_viridis_c()+
        theme(legend.key.size = unit(3, 'cm'))+
	theme(legend.title=element_text(size=80),legend.text=element_text(size=80))


heatmap_A_new=matrix_A_onlydistricts %>%
        as.data.frame() %>%
        rownames_to_column("District") %>%
        pivot_longer(-c(District), names_to = "Symptom_Cluster", values_to = "Percentage") %>%
        ggplot(aes(x=Symptom_Cluster, y=District, fill=Percentage))+
        geom_raster()+
        theme(text=element_text(size=13))+
        theme(axis.title.x=element_blank(),  axis.ticks.x=element_blank())+
        theme(axis.title.y=element_blank(),  axis.ticks.y=element_blank())+
        scale_fill_viridis_c()

name1=paste("Comorbiditiesclusters_vs_districts_A", ".png", sep="")
name2=paste0("graphs/ComorbiditiesCluster/", name1)
ggsave(name2, plot=heatmap_A, width = 69, height = 59, dpi = 300, units = "in", device='png', limitsize = FALSE)

heatmap_A_plotly=ggplotly(heatmap_A_new)

name=paste("Comorbiditiesclusters_vs_districts_A", ".html", sep="")
path=file.path(getwd(), "graphs/ComorbiditiesCluster/", name)
htmlwidgets::saveWidget(heatmap_A_plotly, file=path, selfcontained = FALSE, libdir = "plotly.html")

matrix_B_onlydistricts=head(matrix_B, 30)

heatmap_B=matrix_B_onlydistricts %>%
        as.data.frame() %>%
        rownames_to_column("District") %>%
        pivot_longer(-c(District), names_to = "Symptom_Cluster", values_to = "Percentage") %>%
        ggplot(aes(x=Symptom_Cluster, y=District, fill=Percentage))+
        geom_raster()+
        theme(text = element_text(size=44))+
        theme(axis.title.x=element_blank(),  axis.ticks.x=element_blank())+
        theme(axis.title.y=element_blank(),  axis.ticks.y=element_blank())+
        scale_fill_viridis_c()+
        theme(legend.key.size = unit(2, 'cm'))

heatmap_B_new=matrix_B_onlydistricts %>%
        as.data.frame() %>%
        rownames_to_column("District") %>%
        pivot_longer(-c(District), names_to = "Symptom_Cluster", values_to = "Percentage") %>%
        ggplot(aes(x=Symptom_Cluster, y=District, fill=Percentage))+
        geom_raster()+
        theme(text = element_text(size=15))+
        theme(axis.title.x=element_blank(),  axis.ticks.x=element_blank())+
        theme(axis.title.y=element_blank(),  axis.ticks.y=element_blank())+
        scale_fill_viridis_c()

name1=paste("Comorbiditiesclusters_vs_districts_B", ".png", sep="")
name2=paste0("graphs/ComorbiditiesCluster/", name1)
ggsave(name2, plot=heatmap_B, width = 28, height = 25, dpi = 300, units = "in", device='png')

heatmap_B_plotly=ggplotly(heatmap_B_new)

name=paste("Comorbiditiesclusters_vs_districts_B", ".html", sep="")
path=file.path(getwd(), "graphs/ComorbiditiesCluster/", name)
htmlwidgets::saveWidget(heatmap_B_plotly, file=path, selfcontained = FALSE, libdir = "plotly.html")

Karnataka_A=c(matrix_A[31, 1], matrix_A[31, 2], matrix_A[31, 3], matrix_A[31, 4], matrix_A[31, 5], matrix_A[31, 6],matrix_A[31, 7], matrix_A[31, 8], matrix_A[31, 9], matrix_A[31, 10], matrix_A[31, 11], matrix_A[31, 12])

df_A_Karnataka=data.frame(part_A, Karnataka_A)
plot_A_Karnataka=ggplot(df_A_Karnataka, aes(x=part_A, y=Karnataka_A, fill=Karnataka_A))+
                 geom_bar(stat="identity", width=0.2, color="black")+
                 ylim(0, max(Karnataka_A))+
                 scale_fill_continuous(type="viridis")+
                 theme(text = element_text(size=18))+
                 theme(axis.text.x = element_text(angle = 0, hjust = 1))+
                 theme(axis.title.x=element_blank(),  axis.ticks.x=element_blank())+
                 theme(axis.title.y=element_blank(),  axis.ticks.y=element_blank())+
                 labs(fill="Deceased\nPatients")

plotly_A_Karnataka=ggplotly(plot_A_Karnataka)

name1=paste("Karnataka_Comorbidities_Clusters_A", ".png", sep="")
name2=paste0("graphs/ComorbiditiesCluster/", name1)
ggsave(name2, plot=plot_A_Karnataka, width = 20, height = 10.7, dpi = 300, units = "in", device='png')

name=paste("Karnataka_Comorbidities_Clusters_A", ".html", sep="")
path=file.path(getwd(), "graphs/ComorbiditiesCluster/", name)
htmlwidgets::saveWidget(plotly_A_Karnataka, file=path, selfcontained = FALSE, libdir = "plotly.html")

Karnataka_B=c(matrix_B[31,1], matrix_B[31,2], matrix_B[31,3])

df_B_Karnataka=data.frame(part_B, Karnataka_B)
plot_B_Karnataka=ggplot(df_B_Karnataka, aes(x=part_B, y=Karnataka_B, fill=Karnataka_B))+
                 geom_bar(stat="identity", width=0.085, color="black")+
                 ylim(0, max(Karnataka_B))+
                 scale_fill_continuous(type="viridis")+
                 theme(text = element_text(size=18))+
                 theme(axis.text.x = element_text(angle = 0, hjust = 1))+
                 theme(axis.title.x=element_blank(),  axis.ticks.x=element_blank())+
                 theme(axis.title.y=element_blank(),  axis.ticks.y=element_blank())+
                 labs(fill="Deceased\nPatients")

plotly_B_Karnataka=ggplotly(plot_B_Karnataka)

name1=paste("Karnataka_Comorbidities_Clusters_B", ".png", sep="")
name2=paste0("graphs/ComorbiditiesCluster/", name1)
ggsave(name2, plot=plot_B_Karnataka, width = 20, height = 10.7, dpi = 300, units = "in", device='png')

name=paste("Karnataka_Comorbidities_Clusters_B", ".html", sep="")
path=file.path(getwd(), "graphs/ComorbiditiesCluster/", name)
htmlwidgets::saveWidget(plotly_B_Karnataka, file=path, selfcontained = FALSE, libdir = "plotly.html")

percentage_of_total_deaths=c(cluster[1,31], cluster[2,31], cluster[3,31], cluster[4,31], cluster[5,31], cluster[6,31], cluster[7,31], cluster[8,31], cluster[9,31], cluster[10,31], cluster[11,31],cluster[12,31], cluster[13,31], cluster[14,31], cluster[15,31])

kardf=data.frame(comorbidities_clusters, percentage_of_total_deaths)
plot_karnataka=ggplot(kardf, aes(x=comorbidities_clusters, y=percentage_of_total_deaths, fill=percentage_of_total_deaths))+
               geom_bar(stat="identity", width=0.4, color="black")+
               ylim(0, max(percentage_of_total_deaths))+
               scale_fill_continuous(type="viridis")+
               theme(text = element_text(size=20))+
                 theme(axis.text.x = element_text(angle = 0, hjust = 1))+
                 theme(axis.title.x=element_blank(),  axis.ticks.x=element_blank())+
                 theme(axis.title.y=element_blank(),  axis.ticks.y=element_blank())+
                 labs(fill="Percentage of\nDeceased\nPatients")

plot_karnataka_new=ggplot(kardf, aes(x=comorbidities_clusters, y=percentage_of_total_deaths, fill=percentage_of_total_deaths))+
               geom_bar(stat="identity", width=0.4, color="black")+
               ylim(0, max(percentage_of_total_deaths))+
               scale_fill_continuous(type="viridis")+
               theme(text = element_text(size=12))+
                 theme(axis.text.x = element_text(angle = 0, hjust = 1))+
                 theme(axis.title.x=element_blank(),  axis.ticks.x=element_blank())+
                 theme(axis.title.y=element_blank(),  axis.ticks.y=element_blank())+
                 labs(fill="Percentage of \nDeceased\nPatients")

plotly_karnataka=ggplotly(plot_karnataka_new, tooltip = "y")

name1=paste("Karnataka_Comorbidities_Clusters", ".png", sep="")
name2=paste0("graphs/ComorbiditiesCluster/", name1)
ggsave(name2, plot=plot_karnataka, width = 20, height = 10.7, dpi = 300, units = "in", device='png')

name=paste("Karnataka_Comorbidities_Clusters", ".html", sep="")
path=file.path(getwd(), "graphs/ComorbiditiesCluster/", name)
htmlwidgets::saveWidget(plotly_karnataka, file=path, selfcontained = FALSE, libdir = "plotly.html")

#creating the csv file for lists of comorbidities under each cluster

classcluster1=unique((mydata[grepl("Asthma|ARDS", com, ignore.case="True"),])$Co.Morbidities)
classcluster2=unique((mydata[grepl("Kidney|Renal|AKD|CKD|AKI|ARF|RTA|RVD", com, ignore.case="True"),])$Co.Morbidities)
classcluster3=unique((mydata[grepl("Liver|Cirrhosis|CLD", com, ignore.case="True"),])$Co.Morbidities)
classcluster4=unique((mydata[grepl("Heart|Blood|CHD|IHD|RHD|COPD|CAD|Cardio|LVF|Tension|HTN|HTM|IDH|PTCA|DVT|PNC|Pancytopenia|CVD", com, ignore.case="True"),])$Co.Morbidities)
classcluster5=unique((mydata[grepl("Epilepsy", com, ignore.case="True"),])$Co.Morbidities)
classcluster6=unique((mydata[grepl("Diabeties|Obesity|Juvenile DM|Type 2 DM|Uncontrolled DM|DN|DM", com, ignore.case="True"),])$Co.Morbidities)
classcluster7=unique((mydata[grepl("Hypothyroidism|Thyroid|Tyroid|roidism|Hypoth|BPH", com, ignore.case="True"),])$Co.Morbidities)
classcluster8=unique((mydata[grepl("Anaemia|Anemia|Anamea|Myasthenia", com, ignore.case="True"),])$Co.Morbidities)
classcluster9=unique((mydata[grepl("Cancer|Carcinoma|Colon|CA|Leuk|Metastatic", com, ignore.case="True"),])$Co.Morbidities)
classcluster10=unique((mydata[grepl("Sepsis|Septicaemia|Septic", com, ignore.case="True"),])$Co.Morbidities)
classcluster11=unique((mydata[grepl("Pulmonary|Lung|COPD|Pneumonia|Chronic Lung Disease|CLD|Chronic Smoker|Tuberculosis|TB", com, ignore.case="True"),])$Co.Morbidities)
classcluster12=unique((mydata[grepl("Brain|Neuro|Encephalopathy|Hepatic Encephalopathy|Encephalitis|Hemiplegic|CBA|Park", com, ignore.case="True"),])$Co.Morbidities)
classcluster13=unique((mydata[grepl("DH", com, ignore.case="True"),])$Co.Morbidities)
classcluster14=unique((mydata[grepl("PIH", com, ignore.case="True"),])$Co.Morbidities)
classcluster15=unique((mydata[grepl("Filariasis|HBSAG|HPTN", com, ignore.case="True"),])$Co.Morbidities)

cluster1=as.matrix(classcluster1)
cluster2=as.matrix(classcluster2)
cluster3=as.matrix(classcluster3)
cluster4=as.matrix(classcluster4)
cluster5=as.matrix(classcluster5)
cluster6=as.matrix(classcluster6)
cluster7=as.matrix(classcluster7)
cluster8=as.matrix(classcluster8)
cluster9=as.matrix(classcluster9)
cluster10=as.matrix(classcluster10)
cluster11=as.matrix(classcluster11)
cluster12=as.matrix(classcluster12)
cluster13=as.matrix(classcluster13)
cluster14=as.matrix(classcluster14)
cluster15=as.matrix(classcluster15)



classclustermatrix=matrix("", nrow=500, ncol=15)
for(i in 1:length(classcluster1))
{
        classclustermatrix[i,1]=cluster1[i,1]
}
for(i in 1:length(classcluster2))
{
        classclustermatrix[i,2]=cluster2[i,1]
}
for(i in 1:length(classcluster3))
{
        classclustermatrix[i,3]=cluster3[i,1]
}
for(i in 1:length(classcluster4))
{
        classclustermatrix[i,4]=cluster4[i,1]
}
for(i in 1:length(classcluster5))
{
        classclustermatrix[i,5]=cluster5[i,1]
}
for(i in 1:length(classcluster6))
{
        classclustermatrix[i,6]=cluster6[i,1]
}
for(i in 1:length(classcluster7))
{
        classclustermatrix[i,7]=cluster7[i,1]
}
for(i in 1:length(classcluster8))
{
        classclustermatrix[i,8]=cluster8[i,1]
}
for(i in 1:length(classcluster9))
{
        classclustermatrix[i,9]=cluster9[i,1]
}
for(i in 1:length(classcluster10))
{
        classclustermatrix[i,10]=cluster10[i,1]
}
for(i in 1:length(classcluster11))
{
        classclustermatrix[i,11]=cluster11[i,1]
}
for(i in 1:length(classcluster12))
{
        classclustermatrix[i,12]=cluster12[i,1]
}
for(i in 1:length(classcluster13))
{
        classclustermatrix[i,13]=cluster13[i,1]
}
for(i in 1:length(classcluster14))
{
        classclustermatrix[i,14]=cluster15[i,1]
}
for(i in 1:length(classcluster15))
{
        classclustermatrix[i,15]=cluster15[i,1]
}
dimnames(classclustermatrix)=list(NULL, comorbidities_clusters)
comorbiditiesdataframe=as.data.frame(classclustermatrix)
write.csv(x=comorbiditiesdataframe, file="csv/ComorbiditiesClassification.csv", row.names=F)
