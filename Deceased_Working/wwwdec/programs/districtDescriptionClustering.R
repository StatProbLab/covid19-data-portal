###############################################################################
## Title:                                                                    ##
## Input: mediadata/Master.csv                                               ##
## Output: Plots                                                             ##
## Date Modified: 3rd May 2024                                               ##
###############################################################################

# libraries
library("readxl")
library("ggplot2")
library("grid")
library("gridExtra")
library("plotly")
library("htmlwidgets")
library("viridis")

# Set current working directory
setwd("/opt/lampp/htdocs/covid19-data-portal/Deceased_Working/wwwdec/")

#Reading Data
mydata=read.csv("mediadata/Master.csv")
district=mydata$District

#district_code_names takes a part of the string of each district name to use the grep function to compare strings for the district.

district_code_names=c("Bagal", "Ballari", "Belagavi", "Rural", "Bidar", "Chamaraja", "Ballapura", "Magalur", "Chitra", "Dakshina", "Davan", "Dharawad", "Gadag", "Hassan", "Haveri", "Kalabur", "Kodagu", "Kolar", "Koppal", "Mandya", "Mysuru", "Raichur", "Ramanagara", "Mog", "Tumakuru", "Udupi", "Uttara", "Vijay", "Yadgir")

district_names=c("Bagalkote", "Ballari", "Belagavi", "Bengaluru Rural", "Bidar", "Chamarajanagara", "Chikkaballapura", "Chikkamagaluru", "Chitradurga", "Dakshina Kannada", "Davanagere", "Dharawada", "Gadag", "Hassan", "Haveri", "Kalaburagi", "Kodagu", "Kolar", "Koppal", "Mandya", "Mysuru", "Raichur", "Ramanagara", "Shivamogga", "Tumakuru", "Udupi", "Uttara Kannada", "Vijayapura", "Yadgiri")

description_clusters=c("ILI", "SARI", "Contact of Patient\nor Containment Zone", "Inter District Travel\nin Karnataka", "Domestic Travel\noutside of Karnataka", "International Travel", "Under investigation and\nContact Tracing")

#We now count the number of patients in each district in each description cluster.

cluster=matrix(c(1:203), nrow=7)

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

    count_description_cluster[4]=length(grep("Inter|District", description, ignore.case="True"))
    cluster[4,a]=count_description_cluster[4]

    #new_data=mydata[!grepl("Bengaluru|Bangalore|Hubballi", mydata$Description, ignore.case="True"),]
    count_description_cluster[5]=length(grep("Return|Travel History|interstate", description, ignore.case="True"))
    cluster[5,a]=count_description_cluster[5]

    count_description_cluster[6]=length(grep("Saudi|Mecca", description, ignore.case="True"))
    cluster[6,a]=count_description_cluster[6]

    count_description_cluster[7]=length(grep("Under|Investigation|Tracing", description, ignore.case="True"))
    cluster[7,a]=count_description_cluster[7]

}
#Now we create plots of each of the 7 description clusters between the districts vs. the frequency of patients in the given description cluster.

for(n in 1:7) #A loop to run over all symptom clusters
{
	 arr=c()
    for(i in 1:29) #A loop to run over all districts
    {
        arr[i]=cluster[n,i] #Creating an array of number of deceased patients in the nth cluster. The ith index of the array is the ith district.

    }
	df=data.frame(district_names, arr)
	
	plot_arr=ggplot(df, aes(x=district_names, y=arr, fill=arr))+ #using ggplot to create a plot of districts vs number of deceased patients in given cluster.
        geom_bar(stat="identity", width=0.7, color="black")+
        ylim(0, max(arr))+
	scale_fill_continuous(type="viridis")+
        xlab("Districts")+
        ylab("Number of Deceased Patients")+
        theme(text = element_text(size=15))+
        theme(axis.text.x = element_text(angle = 90, hjust = 1))+
        ggtitle(description_clusters[n])+
	labs(fill="Deceased\nPatients")

	 plotly_arr=ggplotly(plot_arr) #converting ggplot to plotly
	
	#Saving the png file of the graph of each symptom cluster

	name1=paste("DescriptionClusterNew_", n, ".png", sep="")
        name2=paste0("graphs/districtDescriptionClustering/", name1)
        ggsave(name2, plot=plot_arr, width = 20, height = 10.7, dpi = 300, units = "in", device='png')
        
        #Saving the html file of the graph of each symptom cluster
        
        name=paste("DescriptionClusterNew_", n, ".html", sep="")
        path=file.path(getwd(), "graphs/districtDescriptionClustering/", name)
        htmlwidgets::saveWidget(plotly_arr, file=path, selfcontained = FALSE, libdir = "plotly.html")
}

#Specifically for Bengaluru Urban

count_description_cluster_bu=c()

bu_district=subset(mydata, grepl("Urban", district, ignore.case="True"))
bu_description=bu_district$Description


    count_description_cluster_bu[1]=length(grep("ILI", bu_description, ignore.case="True"))

    count_description_cluster_bu[2]=length(grep("SARI|SAARI|SASRI|SARI | SARI", bu_description, ignore.case="True"))

    count_description_cluster_bu[3]=length(grep("Contact of P|containment", bu_description, ignore.case="True"))
    

    count_description_cluster_bu[4]=length(grep("Inter|District", bu_description, ignore.case="True"))

    #new_data=mydata[!grepl("Bengaluru|Bangalore|Hubballi", mydata$Description, ignore.case="True"),]
    count_description_cluster_bu[5]=length(grep("Return|Travel History|interstate", bu_description, ignore.case="True"))

    count_description_cluster_bu[6]=length(grep("Saudi", bu_description, ignore.case="True"))

    count_description_cluster_bu[7]=length(grep("Under|Investigation|Tracing", bu_description, ignore.case="True"))

df_bengurban=data.frame(description_clusters, count_description_cluster_bu)

plot_bengurban=ggplot(df_bengurban, aes(x=description_clusters, y=count_description_cluster_bu, fill=count_description_cluster_bu))+
geom_bar(stat="identity", width=0.2, color="black")+
ylim(0, max(count_description_cluster_bu))+
scale_fill_continuous(type="viridis")+
xlab("Description Clusters")+
ylab("Number of Deceased Patients")+
theme(text = element_text(size=15))+
theme(axis.text.x = element_text(angle = 90, hjust = 1))+
ggtitle("Deaths in each Description Cluster in Bengaluru Urban")+
labs(fill="Deceased\nPatients")

plotly_bengurban=ggplotly(plot_bengurban)

name1_bu=paste("Bengaluru_Urban_Description_Clusters", ".png", sep="")
name2_bu=paste0("graphs/districtDescriptionClustering/", name1_bu)
ggsave(name2_bu, plot=plot_bengurban, width = 20, height = 10.7, dpi = 300, units = "in", device='png')

name_bu=paste("Bengaluru_Urban_Description_Clusters", ".html", sep="")
path_bu=file.path(getwd(), "graphs/districtDescriptionClustering/", name_bu)
htmlwidgets::saveWidget(plotly_bengurban, file=path_bu, selfcontained = FALSE, libdir = "plotly.html")

