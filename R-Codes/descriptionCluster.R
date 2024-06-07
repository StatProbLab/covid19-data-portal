###############################################################################
## Title:                                                                    ##
## Input: mediadata/Master.csv	                                                                  ##
## Output: csv/Description_vs_Districts.csv |                                ##
##         csv/DescriptionClassification.csv                                 ##
## Date Modified: 3rd May 2024                                               ##
###############################################################################


#libraries
library("readxl")
library("ggplot2")
library("grid")
library("gridExtra")
library("plotly")
library("htmlwidgets")
library(tidyr)
library("reshape")
library("tidyverse")
library("viridis")

# Set current working directory
setwd("/opt/lampp/htdocs/covid19-data-portal/Deceased_Working/wwwdec/")

# reading Files
mydata=read.csv("mediadata/Master.csv")

district=mydata$District

#table(mydata$Description)

# District names
district_code_names=c("Bagal", "Ballari", "Belagavi", "Rural", "Urban", "Bidar", "Chamaraja", "Ballapura", "Magalur", "Chitra", "Dakshina", "Davan", "Dharwad", "Gadag", "Hassan", "Haveri", "Kalabur", "Kodagu", "Kolar", "Koppal", "Mandya", "Mysuru", "Raichur", "Ramanagara", "Mog", "Tumakuru", "Udupi", "Uttara", "Vijay", "Yadgir")
district_names=c("Bagalkote", "Ballari", "Belagavi", "Bengaluru Rural", "Bengaluru Urban", "Bidar", "Chamarajanagara", "Chikkaballapura", "Chikkamagaluru", "Chitradurga", "Dakshina Kannada", "Davanagere", "Dharawada", "Gadag", "Hassan", "Haveri", "Kalaburagi", "Kodagu", "Kolar", "Koppal", "Mandya", "Mysuru", "Raichur", "Ramanagara", "Shivamogga", "Tumakuru", "Udupi", "Uttara Kannada", "Vijayapura", "Yadgiri", "All Karnataka")

description_clusters=c("ILI", "SARI", "Contact\nof Patient\nor Containment Zone", "Inter\nDistrict Travel in\nKarnataka", "Domestic\nTravel\noutside\nof Karnataka", "International Travel", "Unknown")
#description_clusters_new=c("ILI", "SARI", "Contact of Patient\nor Containment Zone", "Inter District Travel\nin Karnataka", "Domestic Travel\noutside of Karnataka", "International Travel", "Unknown")

cluster=matrix(c(1:217), nrow=7)
for(a in 1:length(district_code_names))
{
    p=c()
    given_district=subset(mydata, grepl(district_code_names[a], district, ignore.case="True"))

    description=given_district$Description

    count_description_cluster=c()

    count_description_cluster[1]=length(grep("ILI", description, ignore.case="True"))
    cluster[1,a]=count_description_cluster[1]

    count_description_cluster[2]=length(grep("SARI|SAARI|SASRI|SARI | SARI", description, ignore.case="True"))
    cluster[2,a]=count_description_cluster[2]

    count_description_cluster[3]=length(grep("Contact of P|containment", description, ignore.case="True"))
    cluster[3,a]=count_description_cluster[3]

    count_description_cluster[4]=length(grep("district|Bagal|Ballari|Bellari|Bangalore|Bengaluru|Belagavi|Rural|Urban|Bidar|Chamaraja|Ballapura|Magalur|Chitra|Dakshina|Davan|Dharwad|Gadag|Hassan|Haveri|Hubb|Kalabur|Kodagu|Kolar|Koppal|Mandya|Mysuru|Raichur|Ramanagara|Mog|Tumakuru|Udupi|Uttara|Vijay|Yadgir|Yadagiri", description, ignore.case="True")) 
    cluster[4,a]=count_description_cluster[4]
	
	new_dat_dist=given_district[!grepl("Bagal|Ballari|Bellari|Bangalore|Bengaluru|Belagavi|Rural|Urban|Bidar|Chamaraja|Ballapura|Magalur|Chitra|Dakshina|Davan|Dharwad|Gadag|Hassan|Haveri|Hubb|Kalabur|Kodagu|Kolar|Koppal|Mandya|Mysuru|Raichur|Ramanagara|Mog|Tumakuru|Udupi|Uttara|Vijay|Yadgir|Yadagiri|Saudi|Mecca", description, ignore.case="True"),]	  
	new_desc_dist=new_dat_dist$Description
	  
    	count_description_cluster[5]=length(grep("State|Domestic|Travel|History|From|Return", new_desc_dist, ignore.case="True"))

	#count_description_cluster[5]=length(grep("Delhi|Hyderabad|Maharashtra|Andhra Pradesh|Telangana|Domestic|Tamil Nadu|Goa|Bihar|Vellore",description, ignore.case="True"))
    cluster[5,a]=count_description_cluster[5]

    count_description_cluster[6]=length(grep("Saudi|Mecca", description, ignore.case="True"))
    cluster[6,a]=count_description_cluster[6]

    count_description_cluster[7]=length(grep("Under|Investigation|Tracing", description, ignore.case="True"))
    cluster[7,a]=count_description_cluster[7]

	 perarr=c(cluster[1,a], cluster[2,a], cluster[3,a], cluster[4,a], cluster[5,a], cluster[6,a], cluster[7,a])

        cluster[1,a]=round((cluster[1,a]/sum(perarr)*100), digits=3)
        cluster[2,a]=round((cluster[2,a]/sum(perarr)*100), digits=3)
        cluster[3,a]=round((cluster[3,a]/sum(perarr)*100), digits=3)
        cluster[4,a]=round((cluster[4,a]/sum(perarr)*100), digits=3)
        cluster[5,a]=round((cluster[5,a]/sum(perarr)*100), digits=3)
        cluster[6,a]=round((cluster[6,a]/sum(perarr)*100), digits=3)
        cluster[7,a]=round((cluster[7,a]/sum(perarr)*100), digits=3)

}

totaldescription=mydata$Description

cluster[1,31]=length(grep("ILI", totaldescription, ignore.case="True"))
cluster[2,31]=length(grep("SARI|SAARI|SASRI|SARI | SARI", totaldescription, ignore.case="True"))
cluster[3,31]=length(grep("Contact of P|containment", totaldescription, ignore.case="True"))
cluster[4,31]=length(grep("district|Bagal|Ballari|Bellari|Bangalore|Bengaluru|Belagavi|Rural|Urban|Bidar|Chamaraja|Ballapura|Magalur|Chitra|Dakshina|Davan|Dharwad|Gadag|Hassan|Haveri|Hubb|Kalabur|Kodagu|Kolar|Koppal|Mandya|Mysuru|Raichur|Ramanagara|Mog|Tumakuru|Udupi|Uttara|Vijay|Yadgir|Yadagiri", totaldescription, ignore.case="True"))

new_dat=mydata[!grepl("Bagal|Ballari|Bellari|Bangalore|Bengaluru|Belagavi|Rural|Urban|Bidar|Chamaraja|Ballapura|Magalur|Chitra|Dakshina|Davan|Dharwad|Gadag|Hassan|Haveri|Hubb|Kalabur|Kodagu|Kolar|Koppal|Mandya|Mysuru|Raichur|Ramanagara|Mog|Tumakuru|Udupi|Uttara|Vijay|Yadgir|Yadagiri|Saudi|Mecca", mydata$Description, ignore.case="True"),]

new_desc=new_dat$Description

cluster[5,31]=length(grep("State|Domestic|Travel|History|From|Return", new_desc, ignore.case="True"))

cluster[6,31]=length(grep("Saudi|Mecca", totaldescription, ignore.case="True"))
cluster[7,31]=length(grep("Under|Investigation|Tracing", totaldescription, ignore.case="True"))

totalarr=c(cluster[1,31], cluster[2,31], cluster[3,31], cluster[4,31], cluster[5,31], cluster[6,31], cluster[7,31])
       
        cluster[1,31]=round((cluster[1,31]/sum(totalarr)*100), digits=3)
        cluster[2,31]=round((cluster[2,31]/sum(totalarr)*100), digits=3)
        cluster[3,31]=round((cluster[3,31]/sum(totalarr)*100), digits=3)
        cluster[4,31]=round((cluster[4,31]/sum(totalarr)*100), digits=3)
        cluster[5,31]=round((cluster[5,31]/sum(totalarr)*100), digits=3)
        cluster[6,31]=round((cluster[6,31]/sum(totalarr)*100), digits=3)
        cluster[7,31]=round((cluster[7,31]/sum(totalarr)*100), digits=3)

description_cluster_matrix=t(cluster)
dimnames(description_cluster_matrix)=list(district_names, description_clusters)
description_cluster=as.data.frame(description_cluster_matrix)
write.csv(x=description_cluster, file="csv/Description_vs_Districts.csv")

part_A=c(description_clusters[1], description_clusters[2], description_clusters[7])
part_B=c(description_clusters[3], description_clusters[4], description_clusters[5], description_clusters[6])
matrix_A=cbind(description_cluster_matrix[,1], description_cluster_matrix[,2], description_cluster_matrix[,7])
matrix_B=cbind(description_cluster_matrix[,3], description_cluster_matrix[,4], description_cluster_matrix[,5], description_cluster_matrix[,6])

dimnames(matrix_A)=list(district_names, part_A)
dimnames(matrix_B)=list(district_names, part_B)

matrix_A_onlydistricts=head(matrix_A, 30)

heatmap_A=matrix_A_onlydistricts %>%
        as.data.frame() %>%
        rownames_to_column("District") %>%
        pivot_longer(-c(District), names_to = "Symptom_Cluster", values_to = "Percentage") %>%
        ggplot(aes(x=Symptom_Cluster, y=District, fill=Percentage))+
        geom_raster()+
        theme(text = element_text(size=40))+
        theme(axis.title.x=element_blank(),  axis.ticks.x=element_blank())+
        theme(axis.title.y=element_blank(),  axis.ticks.y=element_blank())+
        scale_fill_viridis_c()+
	theme(legend.key.size = unit(2, 'cm'))

heatmap_A_new=matrix_A_onlydistricts %>%
        as.data.frame() %>%
        rownames_to_column("District") %>%
        pivot_longer(-c(District), names_to = "Symptom_Cluster", values_to = "Percentage") %>%
        ggplot(aes(x=Symptom_Cluster, y=District, fill=Percentage))+
        geom_raster()+
        theme(text = element_text(size=15))+
        theme(axis.title.x=element_blank(),  axis.ticks.x=element_blank())+
        theme(axis.title.y=element_blank(),  axis.ticks.y=element_blank())+
        scale_fill_viridis_c()

name1=paste("Descriptionclusters_vs_districts_A", ".png", sep="")
name2=paste0("graphs/DescriptionCluster/", name1)
ggsave(name2, plot=heatmap_A, width = 20, height = 25, dpi = 300, units = "in", device='png')

heatmap_A_plotly=ggplotly(heatmap_A_new)

name=paste("Descriptionclusters_vs_districts_A", ".html", sep="")
path=file.path(getwd(), "graphs/DescriptionCluster/", name)
htmlwidgets::saveWidget(heatmap_A_plotly, file=path, selfcontained = FALSE, libdir = "plotly.html")

matrix_B_onlydistricts=head(matrix_B, 30)

heatmap_B=matrix_B_onlydistricts %>%
        as.data.frame() %>%
        rownames_to_column("District") %>%
        pivot_longer(-c(District), names_to = "Symptom_Cluster", values_to = "Percentage") %>%
        ggplot(aes(x=Symptom_Cluster, y=District, fill=Percentage))+
        geom_raster()+
        theme(text = element_text(size=40))+
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

name1=paste("Descriptionclusters_vs_districts_B", ".png", sep="")
name2=paste0("graphs/DescriptionCluster/", name1)
ggsave(name2, plot=heatmap_B, width = 20, height = 26.5, dpi = 300, units = "in", device='png')

heatmap_B_plotly=ggplotly(heatmap_B_new)

name=paste("Descriptionclusters_vs_districts_B", ".html", sep="")
path=file.path(getwd(), "graphs/DescriptionCluster/", name)
htmlwidgets::saveWidget(heatmap_B_plotly, file=path, selfcontained = FALSE, libdir = "plotly.html")

Karnataka_A=c(matrix_A[31, 1], matrix_A[31, 2], matrix_A[31, 3])

df_A_Karnataka=data.frame(part_A, Karnataka_A)
plot_A_Karnataka=ggplot(df_A_Karnataka, aes(x=part_A, y=Karnataka_A, fill=Karnataka_A))+
                 geom_bar(stat="identity", width=0.075, color="black")+
                 ylim(0, max(Karnataka_A))+
                 scale_fill_continuous(type="viridis")+
                 theme(text = element_text(size=17))+
                 theme(axis.text.x = element_text(angle = 90, hjust = 1))+
                 theme(axis.title.x=element_blank(),  axis.ticks.x=element_blank())+
                 theme(axis.title.y=element_blank(),  axis.ticks.y=element_blank())+
                 labs(fill="Deceased\nPatients")

plotly_A_Karnataka=ggplotly(plot_A_Karnataka)

name1=paste("Karnataka_Description_Clusters_A", ".png", sep="")
name2=paste0("graphs/DescriptionCluster/", name1)
ggsave(name2, plot=plot_A_Karnataka, width = 20, height = 10.7, dpi = 300, units = "in", device='png')

name=paste("Karnataka_Description_Clusters_A", ".html", sep="")
path=file.path(getwd(), "graphs/DescriptionCluster/", name)
htmlwidgets::saveWidget(plotly_A_Karnataka, file=path, selfcontained = FALSE, libdir = "plotly.html")

Karnataka_B=c(matrix_B[31,1], matrix_B[31,2], matrix_B[31,3], matrix_B[31,4])

df_B_Karnataka=data.frame(part_B, Karnataka_B)
plot_B_Karnataka=ggplot(df_B_Karnataka, aes(x=part_B, y=Karnataka_B, fill=Karnataka_B))+
                 geom_bar(stat="identity", width=0.1, color="black")+
                 ylim(0, max(Karnataka_B))+
                 scale_fill_continuous(type="viridis")+
                 theme(text = element_text(size=17))+
                 theme(axis.text.x = element_text(angle = 90, hjust = 1))+
                 theme(axis.title.x=element_blank(),  axis.ticks.x=element_blank())+
                 theme(axis.title.y=element_blank(),  axis.ticks.y=element_blank())+
                 labs(fill="Deceased\nPatients")

plotly_B_Karnataka=ggplotly(plot_B_Karnataka)

name1=paste("Karnataka_Description_Clusters_B", ".png", sep="")
name2=paste0("graphs/DescriptionCluster/", name1)
ggsave(name2, plot=plot_B_Karnataka, width = 20, height = 10.7, dpi = 300, units = "in", device='png')

name=paste("Karnataka_Description_Clusters_B", ".html", sep="")
path=file.path(getwd(), "graphs/DescriptionCluster/", name)
htmlwidgets::saveWidget(plotly_B_Karnataka, file=path, selfcontained = FALSE, libdir = "plotly.html")

percentage_of_total_deaths=c(cluster[1,31], cluster[2,31], cluster[3,31], cluster[4,31], cluster[5,31], cluster[6,31], cluster[7,31])
kardf=data.frame(description_clusters, percentage_of_total_deaths)
plot_karnataka=ggplot(kardf, aes(x=description_clusters, y=percentage_of_total_deaths, fill=percentage_of_total_deaths))+
               geom_bar(stat="identity", width=0.2, color="black")+
               ylim(0, max(percentage_of_total_deaths))+
               scale_fill_continuous(type="viridis")+
               theme(text = element_text(size=20))+
                 theme(axis.text.x = element_text(angle = 0, hjust = 1))+
                 theme(axis.title.x=element_blank(),  axis.ticks.x=element_blank())+
                 theme(axis.title.y=element_blank(),  axis.ticks.y=element_blank())+
                 labs(fill="Percentage of\nDeceased\nPatients")

plot_karnataka_new=ggplot(kardf, aes(x=description_clusters, y=percentage_of_total_deaths, fill=percentage_of_total_deaths))+
               geom_bar(stat="identity", width=0.2, color="black")+
               ylim(0, max(percentage_of_total_deaths))+
               scale_fill_continuous(type="viridis")+
               theme(text = element_text(size=12))+
                 theme(axis.text.x = element_text(angle = 0, hjust = 1))+
                 theme(axis.title.x=element_blank(),  axis.ticks.x=element_blank())+
                 theme(axis.title.y=element_blank(),  axis.ticks.y=element_blank())+
                 labs(fill="Percentage of\nDeceased\nPatients")

plotly_karnataka=ggplotly(plot_karnataka_new, tooltip = "y")

name1=paste("Karnataka_Description_Clusters", ".png", sep="")
name2=paste0("graphs/DescriptionCluster/", name1)
ggsave(name2, plot=plot_karnataka, width = 20, height = 10.7, dpi = 300, units = "in", device='png')

name=paste("Karnataka_Description_Clusters", ".html", sep="")
path=file.path(getwd(), "graphs/DescritpionCluster", name)
htmlwidgets::saveWidget(plotly_karnataka, file=path, selfcontained = FALSE, libdir = "plotly.html")

#creating the csv file for lists of description under each cluster

classcluster1=unique((mydata[grepl("ILI", totaldescription, ignore.case="True"),])$Description)
cluster1=as.matrix(classcluster1)
classcluster2=unique((mydata[grepl("SARI", totaldescription, ignore.case="True"),])$Description)
cluster2=as.matrix(classcluster2)
classcluster3=unique((mydata[grepl("Contact of P|containment", totaldescription, ignore.case="True"),])$Description)
cluster3=as.matrix(classcluster3)

classcluster4=unique((mydata[grepl("district|Bagal|Ballari|Bellari|Bangalore|Bengaluru|Belagavi|Rural|Urban|Bidar|Chamaraja|Ballapura|Magalur|Chitra|Dakshina|Davan|Dharwad|Gadag|Hassan|Haveri|Hubb|Kalabur|Kodagu|Kolar|Koppal|Mandya|Mysuru|Raichur|Ramanagara|Mog|Tumakuru|Udupi|Uttara|Vijay|Yadgir|Yadagiri", totaldescription, ignore.case="True"),])$Description)
cluster4=as.matrix(classcluster4)

newdat=mydata[!grepl("Bagal|Ballari|Bellari|Bangalore|Bengaluru|Belagavi|Rural|Urban|Bidar|Chamaraja|Ballapura|Magalur|Chitra|Dakshina|Davan|Dharwad|Gadag|Hassan|Haveri|Hubb|Kalabur|Kodagu|Kolar|Koppal|Mandya|Mysuru|Raichur|Ramanagara|Mog|Tumakuru|Udupi|Uttara|Vijay|Yadgir|Yadagiri|Saudi|Mecca", mydata$Description, ignore.case="True"),]

newdesc=newdat$Description

classcluster5=unique((newdat[grepl("State|Domestic|Travel|History|From|Return", newdesc, ignore.case="True"),])$Description)
cluster5=as.matrix(classcluster5)
classcluster6=unique((mydata[grepl("Saudi|Mecca", totaldescription, ignore.case="True"),])$Description)
cluster6=as.matrix(classcluster6)
classcluster7=unique((mydata[grepl("Under|Investigation|Tracing", totaldescription, ignore.case="True"),])$Description)
cluster7=as.matrix(classcluster7)

classclustermatrix=matrix("", nrow=100, ncol=7)
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
dimnames(classclustermatrix)=list(NULL, description_clusters)
descriptiondataframe=as.data.frame(classclustermatrix)
write.csv(x=descriptiondataframe, file="csv/DescriptionClassification.csv", row.names=F)

