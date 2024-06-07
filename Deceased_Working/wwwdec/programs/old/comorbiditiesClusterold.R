#libraries
library("readxl")
library("ggplot2")
library("grid")
library("gridExtra")
library("plotly")
library("htmlwidgets")
library(tidyr)
library("tidyverse")
library("reshape")
mydata=read.csv("../mediadata/Master.csv")

district=mydata$District
district_code_names=c("Bagal", "Ballari", "Belagavi", "Rural", "Urban", "Bidar", "Chamaraja", "Ballapura", "Magalur", "Chitra", "Dakshina", "Davan", "Dharawad", "Gadag", "Hassan", "Haveri", "Kalabur", "Kodagu", "Kolar", "Koppal", "Mandya", "Mysuru", "Raichur", "Ramanagara", "Mog", "Tumakuru", "Udupi", "Uttara", "Vijay", "Yadgir")

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

comorbidities_cluster_matrix=t(cluster)
dimnames(comorbidities_cluster_matrix)=list(district_names, comorbidities_clusters)

comorbidities_cluster=as.data.frame(comorbidities_cluster_matrix)
write.csv(comorbidities_cluster, file="Comorbidities_vs_Districts.csv")

part_A=c(comorbidities_clusters[1],comorbidities_clusters[3], comorbidities_clusters[5], comorbidities_clusters[7], comorbidities_clusters[8], comorbidities_clusters[9], comorbidities_clusters[10],comorbidities_clusters[11], comorbidities_clusters[12], comorbidities_clusters[13], comorbidities_clusters[14], comorbidities_clusters[15])

matrix_A=cbind(comorbidities_cluster_matrix[,1], comorbidities_cluster_matrix[,3], comorbidities_cluster_matrix[,5], comorbidities_cluster_matrix[,7], comorbidities_cluster_matrix[,8], comorbidities_cluster_matrix[,9], comorbidities_cluster_matrix[,10],comorbidities_cluster_matrix[,11], comorbidities_cluster_matrix[,12], comorbidities_cluster_matrix[,13], comorbidities_cluster_matrix[,14], comorbidities_cluster_matrix[,15])

part_B=c(comorbidities_clusters[2], comorbidities_clusters[4], comorbidities_clusters[6])

matrix_B=cbind(comorbidities_cluster_matrix[,2], comorbidities_cluster_matrix[,4], comorbidities_cluster_matrix[,6])

dimnames(matrix_A)=list(district_names, part_A)
dimnames(matrix_B)=list(district_names, part_B)

matrix_A_onlydistricts=head(matrix_A, 30)
heatmap_A=matrix_A_onlydistricts %>%
        as.data.frame() %>%
        rownames_to_column("f_id") %>%
        pivot_longer(-c(f_id), names_to = "samples", values_to = "counts") %>%
        ggplot(aes(x=samples, y=f_id, fill=counts))+
        geom_raster()+
        theme(axis.text.y=element_text(size=94),axis.text.x=element_text(size=77))+
        theme(axis.title.x=element_blank(),  axis.ticks.x=element_blank())+
        theme(axis.title.y=element_blank(),  axis.ticks.y=element_blank())+
        scale_fill_viridis_c()+
        theme(legend.key.size = unit(3, 'cm'))+
	theme(legend.title=element_text(size=80),legend.text=element_text(size=80))


heatmap_A_new=matrix_A_onlydistricts %>%
        as.data.frame() %>%
        rownames_to_column("f_id") %>%
        pivot_longer(-c(f_id), names_to = "samples", values_to = "counts") %>%
        ggplot(aes(x=samples, y=f_id, fill=counts))+
        geom_raster()+
        theme(text=element_text(size=13))+
        theme(axis.title.x=element_blank(),  axis.ticks.x=element_blank())+
        theme(axis.title.y=element_blank(),  axis.ticks.y=element_blank())+
        scale_fill_viridis_c()

name1=paste("Comorbiditiesclusters_vs_districts_A", ".png", sep="")
name2=paste0("../graphs/", name1)
ggsave(name2, plot=heatmap_A, width = 69, height = 59, dpi = 300, units = "in", device='png', limitsize = FALSE)

heatmap_A_plotly=ggplotly(heatmap_A_new)

name=paste("Comorbiditiesclusters_vs_districts_A", ".html", sep="")
path=file.path(getwd(), "../graphs", name)
htmlwidgets::saveWidget(heatmap_A_plotly, file=path, selfcontained = FALSE, libdir = "plotly.html")

matrix_B_onlydistricts=head(matrix_B, 30)

heatmap_B=matrix_B_onlydistricts %>%
        as.data.frame() %>%
        rownames_to_column("f_id") %>%
        pivot_longer(-c(f_id), names_to = "samples", values_to = "counts") %>%
        ggplot(aes(x=samples, y=f_id, fill=counts))+
        geom_raster()+
        theme(text = element_text(size=44))+
        theme(axis.title.x=element_blank(),  axis.ticks.x=element_blank())+
        theme(axis.title.y=element_blank(),  axis.ticks.y=element_blank())+
        scale_fill_viridis_c()+
        theme(legend.key.size = unit(2, 'cm'))

heatmap_B_new=matrix_B_onlydistricts %>%
        as.data.frame() %>%
        rownames_to_column("f_id") %>%
        pivot_longer(-c(f_id), names_to = "samples", values_to = "counts") %>%
        ggplot(aes(x=samples, y=f_id, fill=counts))+
        geom_raster()+
        theme(text = element_text(size=15))+
        theme(axis.title.x=element_blank(),  axis.ticks.x=element_blank())+
        theme(axis.title.y=element_blank(),  axis.ticks.y=element_blank())+
        scale_fill_viridis_c()

name1=paste("Comorbiditiesclusters_vs_districts_B", ".png", sep="")
name2=paste0("../graphs/", name1)
ggsave(name2, plot=heatmap_B, width = 28, height = 25, dpi = 300, units = "in", device='png')

heatmap_B_plotly=ggplotly(heatmap_B_new)

name=paste("Symptomclusters_vs_districts_B", ".html", sep="")
path=file.path(getwd(), "../graphs", name)
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
name2=paste0("../graphs/", name1)
ggsave(name2, plot=plot_A_Karnataka, width = 20, height = 10.7, dpi = 300, units = "in", device='png')

name=paste("Karnataka_Comorbidities_Clusters_A", ".html", sep="")
path=file.path(getwd(), "../graphs", name)
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
name2=paste0("../graphs/", name1)
ggsave(name2, plot=plot_B_Karnataka, width = 20, height = 10.7, dpi = 300, units = "in", device='png')

name=paste("Karnataka_Comorbidities_Clusters_B", ".html", sep="")
path=file.path(getwd(), "../graphs", name)
htmlwidgets::saveWidget(plotly_B_Karnataka, file=path, selfcontained = FALSE, libdir = "plotly.html")

kardata=c(cluster[1,31], cluster[2,31], cluster[3,31], cluster[4,31], cluster[5,31], cluster[6,31], cluster[7,31], cluster[8,31], cluster[9,31], cluster[10,31], cluster[11,31],cluster[12,31], cluster[13,31], cluster[14,31], cluster[15,31])

kardf=data.frame(comorbidities_clusters, kardata)
plot_karnataka=ggplot(kardf, aes(x=comorbidities_clusters, y=kardata, fill=kardata))+
               geom_bar(stat="identity", width=0.4, color="black")+
               ylim(0, max(kardata))+
               scale_fill_continuous(type="viridis")+
               theme(text = element_text(size=20))+
                 theme(axis.text.x = element_text(angle = 0, hjust = 1))+
                 theme(axis.title.x=element_blank(),  axis.ticks.x=element_blank())+
                 theme(axis.title.y=element_blank(),  axis.ticks.y=element_blank())+
                 labs(fill="Deceased\nPatients")

plot_karnataka_new=ggplot(kardf, aes(x=comorbidities_clusters, y=kardata, fill=kardata))+
               geom_bar(stat="identity", width=0.4, color="black")+
               ylim(0, max(kardata))+
               scale_fill_continuous(type="viridis")+
               theme(text = element_text(size=12))+
                 theme(axis.text.x = element_text(angle = 0, hjust = 1))+
                 theme(axis.title.x=element_blank(),  axis.ticks.x=element_blank())+
                 theme(axis.title.y=element_blank(),  axis.ticks.y=element_blank())+
                 labs(fill="Deceased\nPatients")

plotly_karnataka=ggplotly(plot_karnataka_new)

name1=paste("Karnataka_Comorbidities_Clusters", ".png", sep="")
name2=paste0("../graphs/", name1)
ggsave(name2, plot=plot_karnataka, width = 20, height = 10.7, dpi = 300, units = "in", device='png')

name=paste("Karnataka_Comorbidities_Clusters", ".html", sep="")
path=file.path(getwd(), "../graphs", name)
htmlwidgets::saveWidget(plotly_karnataka, file=path, selfcontained = FALSE, libdir = "plotly.html")
