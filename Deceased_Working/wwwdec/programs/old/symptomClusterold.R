#libraries
library("readxl")
library("ggplot2")
library("grid")
library("gridExtra")
library("plotly")
library("htmlwidgets")
library(tidyr)
library("reshape")
library("viridis")
library("tidyverse")
mydata=read.csv("../mediadata/Master.csv")
district=mydata$District

district_code_names=c("Bagal", "Ballari", "Belagavi", "Rural", "Urban", "Bidar", "Chamaraja", "Ballapura", "Magalur", "Chitra", "Dakshina", "Davan", "Dharawad", "Gadag", "Hassan", "Haveri", "Kalabur", "Kodagu", "Kolar", "Koppal", "Mandya", "Mysuru", "Raichur", "Ramanagara", "Mog", "Tumakuru", "Udupi", "Uttara", "Vijay", "Yadgir")

district_names=c("Bagalkote", "Ballari", "Belagavi", "Bengaluru Rural", "Bengaluru Urban", "Bidar", "Chamarajanagara", "Chikkaballapura", "Chikkamagaluru", "Chitradurga", "Dakshina Kannada", "Davanagere", "Dharawada", "Gadag", "Hassan", "Haveri", "Kalaburagi", "Kodagu", "Kolar", "Koppal", "Mandya", "Mysuru", "Raichur", "Ramanagara", "Shivamogga", "Tumakuru", "Udupi", "Uttara Kannada", "Vijayapura", "Yadgiri", "All Karnataka")

symptom_clusters=c("Asympto-\nmatic", "Abdominal\nPain\nand\nrelated\nsymptoms", "Chest\nPain\nand\nPneumonia", "Body Pain\nand\nFatigue", "Breathlessness\nand\nRespiratory\nFailure", "Fever\nCold or\nCough\nwithout\nBreathlessness", "Fever,\nCold or\nCough\nwith\nBreathlessness", "Anorexia\nand\nDecreased\nAppetite", "Acute\nMyocardial\nInfarction", "Altered\nSensorium")

cluster=matrix(c(1:310), nrow=10)

for(a in 1:length(district_code_names))
{
    p=c()
    given_district=subset(mydata, grepl(district_code_names[a], district, ignore.case="True"))
    symptoms=given_district$Symptoms

    count_symptom_cluster=c()

    count_symptom_cluster[1]=length(grep("Asymptomatic", symptoms, ignore.case="True"))
    cluster[1,a]=count_symptom_cluster[1]

    count_symptom_cluster[2]=length(grep("Abdominal|Abdomen|Abd|Distension|Stomach|Vomit|Stool|Diarr", symptoms, ignore.case="True"))
    cluster[2,a]=count_symptom_cluster[2]

    count_symptom_cluster[3]=length(grep("Chest|pneumonia", symptoms, ignore.case="True"))
    cluster[3,a]=count_symptom_cluster[3]

    count_symptom_cluster[4]=length(grep("Body Pain|Fatigue|Weakness|Tiredness", symptoms, ignore.case="True"))
    cluster[4,a]=count_symptom_cluster[4]
	
    df_without_fevercoldcough=given_district[!grepl("Fever|Cold|Cough", symptoms, ignore.case="True"),]
    symptoms_without_fevercoldcough=df_without_fevercoldcough$Symptoms
    count_symptom_cluster[5]=length(grep("Breath|lesness|lessness|lessnes|Respiratory", symptoms_without_fevercoldcough, ignore.case="True"))
    cluster[5,a]=count_symptom_cluster[5]



    df_without_breathlessness=given_district[!grepl("Breath|lesness|lessness|lessnes", symptoms, ignore.case="True"),]
    count_symptom_cluster[6]=length(grep("Fever|Feve|Cold|Cough|Coug|Chills", df_without_breathlessness$Symptoms, ignore.case="True"))
    cluster[6,a]=count_symptom_cluster[6]

    count_clusteroffevercoldcough=length(grep("Fever|Feve|Cold|Cough|Coug|Chills", symptoms, ignore.case="True"))
    count_symptom_cluster[7]=count_clusteroffevercoldcough-count_symptom_cluster[6]
    cluster[7,a]=count_symptom_cluster[7]


    count_symptom_cluster[8]=length(grep("Anorexia|Appetite", symptoms, ignore.case="True"))
    cluster[8,a]=count_symptom_cluster[8]



    count_symptom_cluster[9]=length(grep("Acute MI", symptoms, ignore.case="True"))
    cluster[9,a]=count_symptom_cluster[9]

    count_symptom_cluster[10]=length(grep("Sensorium|Conscious", symptoms, ignore.case="True"))
    cluster[10,a]=count_symptom_cluster[10]
}

totalsymptoms=mydata$Symptoms

cluster[1,31]=length(grep("Asymptomatic", totalsymptoms, ignore.case="True"))
cluster[2,31]=length(grep("Abdominal|Abdomen|Abd|Distension|Stomach|Vomit|Stool|Diarr", totalsymptoms, ignore.case="True"))
cluster[3,31]=length(grep("Chest|pneumonia", totalsymptoms, ignore.case="True"))
cluster[4,31]=length(grep("Body Pain|Fatigue|Weakness|Tiredness", totalsymptoms, ignore.case="True"))

df_without_fevercoldcough_total=mydata[!grepl("Fever|Cold|Cough", totalsymptoms, ignore.case="True"),]
symptoms_without_fevercoldcough_total=df_without_fevercoldcough_total$Symptoms
cluster[5,31]=length(grep("Breath|lesness|lessness|lessnes|Respiratory", symptoms_without_fevercoldcough_total, ignore.case="True"))

 df_without_breathlessness_total=mydata[!grepl("Breath|lesness|lessness|lessnes", totalsymptoms, ignore.case="True"),]
cluster[6,31]=length(grep("Fever|Feve|Cold|Cough|Coug|Chills", df_without_breathlessness_total$Symptoms, ignore.case="True"))

count_clusteroffevercoldcough_total=length(grep("Fever|Feve|Cold|Cough|Coug|Chills", totalsymptoms, ignore.case="True"))
cluster[7,31]=count_clusteroffevercoldcough_total-cluster[6,31]

cluster[8,31]=length(grep("Anorexia|Appetite", totalsymptoms, ignore.case="True"))

cluster[9,31]=length(grep("Acute MI", totalsymptoms, ignore.case="True"))

cluster[10,31]=length(grep("Sensorium|Conscious", totalsymptoms, ignore.case="True"))

symptoms_cluster_matrix=t(cluster)
dimnames(symptoms_cluster_matrix)=list(district_names, symptom_clusters)
part_A=c(symptom_clusters[1], symptom_clusters[2], symptom_clusters[3], symptom_clusters[4], symptom_clusters[8], symptom_clusters[9], symptom_clusters[10])
matrix_A=cbind(symptoms_cluster_matrix[,1],symptoms_cluster_matrix[,2], symptoms_cluster_matrix[,3], symptoms_cluster_matrix[,4], symptoms_cluster_matrix[,8], symptoms_cluster_matrix[,9], symptoms_cluster_matrix[,10])

part_B=c(symptom_clusters[5], symptom_clusters[6], symptom_clusters[7])
matrix_B=cbind(symptoms_cluster_matrix[,5], symptoms_cluster_matrix[,6], symptoms_cluster_matrix[,7])

dimnames(matrix_A)=list(district_names, part_A)
dimnames(matrix_B)=list(district_names, part_B)
symptoms_cluster=as.data.frame(symptoms_cluster_matrix)
write.csv(symptoms_cluster, file="Symptoms_vs_Districts.csv")

matrix_A_onlydistricts=head(matrix_A, 30)

heatmap_A=matrix_A_onlydistricts %>%
	as.data.frame() %>%
	rownames_to_column("f_id") %>%
	pivot_longer(-c(f_id), names_to = "samples", values_to = "counts") %>%
	ggplot(aes(x=samples, y=f_id, fill=counts))+
	geom_raster()+
	theme(text=element_text(size=48))+
	theme(axis.title.x=element_blank(),  axis.ticks.x=element_blank())+
	theme(axis.title.y=element_blank(),  axis.ticks.y=element_blank())+ 
  	scale_fill_viridis_c()+
	theme(legend.key.size = unit(2, 'cm'))
	

heatmap_A_new=matrix_A_onlydistricts %>%
        as.data.frame() %>%
        rownames_to_column("f_id") %>%
        pivot_longer(-c(f_id), names_to = "samples", values_to = "counts") %>%
        ggplot(aes(x=samples, y=f_id, fill=counts))+
        geom_raster()+
        theme(text=element_text(size=15))+
        theme(axis.title.x=element_blank(),  axis.ticks.x=element_blank())+
        theme(axis.title.y=element_blank(),  axis.ticks.y=element_blank())+
        scale_fill_viridis_c()


name1=paste("Symptomclusters_vs_districts_A_old", ".png", sep="")
name2=paste0("../graphs/", name1)
ggsave(name2, plot=heatmap_A, width = 28, height = 25, dpi = 300, units = "in", device='png')

heatmap_A_plotly=ggplotly(heatmap_A_new)

name=paste("Symptomclusters_vs_districts_A_old", ".html", sep="")
path=file.path(getwd(), "../graphs", name)
htmlwidgets::saveWidget(heatmap_A_plotly, file=path, selfcontained = FALSE, libdir = "plotly.html")

matrix_B_onlydistricts=head(matrix_B, 30)

heatmap_B=matrix_B_onlydistricts %>%
        as.data.frame() %>%
        rownames_to_column("f_id") %>%
        pivot_longer(-c(f_id), names_to = "samples", values_to = "counts") %>%
        ggplot(aes(x=samples, y=f_id, fill=counts))+
	geom_raster()+
	theme(text = element_text(size=48))+
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

name1=paste("Symptomclusters_vs_districts_B_old", ".png", sep="")
name2=paste0("../graphs/", name1)
ggsave(name2, plot=heatmap_B, width = 28, height = 25, dpi = 300, units = "in", device='png')

heatmap_B_plotly=ggplotly(heatmap_B_new)

name=paste("Symptomclusters_vs_districts_B_old", ".html", sep="")
path=file.path(getwd(), "../graphs", name)
htmlwidgets::saveWidget(heatmap_B_plotly, file=path, selfcontained = FALSE, libdir = "plotly.html")


Karnataka_A=c(matrix_A[31, 1], matrix_A[31, 2], matrix_A[31, 3], matrix_A[31, 4], matrix_A[31, 5], matrix_A[31, 6],matrix_A[31, 7])

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

name1=paste("Karnataka_Symptom_Clusters_A_old", ".png", sep="")
name2=paste0("../graphs/", name1)
ggsave(name2, plot=plot_A_Karnataka, width = 20, height = 10.7, dpi = 300, units = "in", device='png')

name=paste("Karnataka_Symptom_Clusters_A_old", ".html", sep="")
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

name1=paste("Karnataka_Symptom_Clusters_B_old", ".png", sep="")
name2=paste0("../graphs/", name1)
ggsave(name2, plot=plot_B_Karnataka, width = 20, height = 10.7, dpi = 300, units = "in", device='png')

name=paste("Karnataka_Symptom_Clusters_B_old", ".html", sep="")
path=file.path(getwd(), "../graphs", name)
htmlwidgets::saveWidget(plotly_B_Karnataka, file=path, selfcontained = FALSE, libdir = "plotly.html")

kardata=c(cluster[1,31], cluster[2,31], cluster[3,31], cluster[4,31], cluster[5,31], cluster[6,31], cluster[7,31], cluster[8,31], cluster[9,31], cluster[10,31])
kardf=data.frame(symptom_clusters, kardata)
plot_karnataka=ggplot(kardf, aes(x=symptom_clusters, y=kardata, fill=kardata))+
	       geom_bar(stat="identity", width=0.3, color="black")+
	       ylim(0, max(kardata))+
	       scale_fill_continuous(type="viridis")+
	       theme(text = element_text(size=20))+
                 theme(axis.text.x = element_text(angle = 0, hjust = 1))+
                 theme(axis.title.x=element_blank(),  axis.ticks.x=element_blank())+
                 theme(axis.title.y=element_blank(),  axis.ticks.y=element_blank())+
                 labs(fill="Deceased\nPatients")
		
plot_karnataka_new=ggplot(kardf, aes(x=symptom_clusters, y=kardata, fill=kardata))+
               geom_bar(stat="identity", width=0.3, color="black")+
               ylim(0, max(kardata))+
               scale_fill_continuous(type="viridis")+
               theme(text = element_text(size=12))+
                 theme(axis.text.x = element_text(angle = 0, hjust = 1))+
                 theme(axis.title.x=element_blank(),  axis.ticks.x=element_blank())+
                 theme(axis.title.y=element_blank(),  axis.ticks.y=element_blank())+
                 labs(fill="Deceased\nPatients")

plotly_karnataka=ggplotly(plot_karnataka_new, tooltip = "y")

name1=paste("Karnataka_Symptom_Clusters_old", ".png", sep="")
name2=paste0("../graphs/", name1)
ggsave(name2, plot=plot_karnataka, width = 20, height = 10.7, dpi = 300, units = "in", device='png')

name=paste("Karnataka_Symptom_Clusters_old", ".html", sep="")
path=file.path(getwd(), "../graphs", name)
htmlwidgets::saveWidget(plotly_karnataka, file=path, selfcontained = FALSE, libdir = "plotly.html")
