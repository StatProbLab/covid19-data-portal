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
library(viridis)

# Set current working directory
setwd("/opt/lampp/htdocs/covid19-data-portal/Deceased_Working/wwwdec/")

#Reading Data
mydata=read.csv("mediadata/Master.csv")
district=mydata$District

#district_code_names takes a part of the string of each district name to use the grep function to compare strings for the district.

district_code_names=c("Bagal", "Ballari", "Belagavi", "Rural", "Bidar", "Chamaraja", "Ballapura", "Magalur", "Chitra", "Dakshina", "Davan", "Dharawad", "Gadag", "Hassan", "Haveri", "Kalabur", "Kodagu", "Kolar", "Koppal", "Mandya", "Mysuru", "Raichur", "Ramanagara", "Mog", "Tumakuru", "Udupi", "Uttara", "Vijay", "Yadgir")

district_names=c("Bagalkote", "Ballari", "Belagavi", "Bengaluru Rural", "Bidar", "Chamarajanagara", "Chikkaballapura", "Chikkamagaluru", "Chitradurga", "Dakshina Kannada", "Davanagere", "Dharawada", "Gadag", "Hassan", "Haveri", "Kalaburagi", "Kodagu", "Kolar", "Koppal", "Mandya", "Mysuru", "Raichur", "Ramanagara", "Shivamogga", "Tumakuru", "Udupi", "Uttara Kannada", "Vijayapura", "Yadgiri")

symptom_clusters=c("Asymptomatic", "Abdominal Pain and\nrelated symptoms", "Chest Pain and Pneumonia", "Body Pain and Fatigue", "Breathlessness and\nRespiratory Failure", "Fever, Cold or Cough\nwithout Breathlessness", "Fever, Cold or Cough\nwith Breathlessness", "Anorexia and\nDecreased Appetite", "Acute Myocardial\nInfarction", "Altered Sensorium")

 #We now count the number of patients in each district in each symptom cluster.

cluster=matrix(c(1:290), nrow=10)

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
    
    count_symptom_cluster[4]=length(grep("Body Pain|Fatigue|Weakness|Tired", symptoms, ignore.case="True"))
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


#Now we create plots of each of the 10 symptom clusters between the districts vs. the frequency of patients in the given symptom cluster.

for(n in 1:10) #A loop to run over all symptom clusters
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
	xlab("Districts")+
	ylab("Number of Deceased Patients")+
	scale_fill_continuous(type = "viridis")+
	theme(text = element_text(size=15))+
	theme(axis.text.x = element_text(angle = 90, hjust = 1))+
	ggtitle(symptom_clusters[n])+
	labs(fill="Deceased\nPatients")

	plotly_arr=ggplotly(plot_arr) #converting ggplot to plotly

	#Saving the png file of the graph of each symptom cluster
      
	name1=paste("SymptomClusterNew_", n, ".png", sep="")
	name2=paste0("graphs/SymptomsCluster/", name1)
	ggsave(name2, plot=plot_arr, width = 20, height = 10.7, dpi = 300, units = "in", device='png')
	
	#Saving the html file of the graph of each symptom cluster
	
	name=paste("SymptomClusterNew_", n, ".html", sep="")
	path=file.path(getwd(), "graphs/SymptomsCluster/", name)
	htmlwidgets::saveWidget(plotly_arr, file=path, selfcontained = FALSE, libdir = "plotly.html")

}
count_symptom_cluster_bu=c()

#Specifically for Bengaluru Urban

bu_district=subset(mydata, grepl("Urban", district, ignore.case="True"))
bu_symptoms=bu_district$Symptoms
count_symptom_cluster_bu[1]=length(grep("Asymptomatic", bu_symptoms, ignore.case="True"))
count_symptom_cluster_bu[2]=length(grep("Abdominal|Abdomen|Abd|Distension|Stomach|Vomit|Stool|Diarr", bu_symptoms, ignore.case="True"))
count_symptom_cluster_bu[3]=length(grep("Chest|pneumonia", bu_symptoms, ignore.case="True"))
count_symptom_cluster_bu[4]=length(grep("Body Pain|Fatigue|Weakness", bu_symptoms, ignore.case="True"))

df_without_fevercoldcough_bu=bu_district[!grepl("Fever|Cold|Cough", bu_symptoms, ignore.case="True"),]
count_symptom_cluster_bu[5]=length(grep("Breath|lesness|lessness|lessnes|Respiratory", df_without_fevercoldcough_bu$Symptoms, ignore.case="True"))

df_without_breathlessness_bu=bu_district[!grepl("Breath|lesness|lessness|lessnes", bu_symptoms, ignore.case="True"),]
count_symptom_cluster_bu[6]=length(grep("Fever|Feve|Cold|Cough|Coug|Chills", df_without_breathlessness$Symptoms, ignore.case="True"))

count_clusteroffevercoldcough_bu=length(grep("Fever|Feve|Cold|Cough|Coug|Chills", bu_symptoms, ignore.case="True"))
count_symptom_cluster_bu[7]=count_clusteroffevercoldcough_bu-count_symptom_cluster_bu[6]

count_symptom_cluster_bu[8]=length(grep("Anorexia|Appetite", bu_symptoms, ignore.case="True"))

count_symptom_cluster_bu[9]=length(grep("Acute MI", bu_symptoms, ignore.case="True"))

count_symptom_cluster_bu[10]=length(grep("Sensorium|Conscious", bu_symptoms, ignore.case="True"))

count_symptom_cluster_bu_A=c(count_symptom_cluster_bu[1], count_symptom_cluster_bu[2], count_symptom_cluster_bu[3], count_symptom_cluster_bu[4], count_symptom_cluster_bu[8], count_symptom_cluster_bu[9], count_symptom_cluster_bu[10])

count_symptom_cluster_bu_B=c(count_symptom_cluster_bu[5], count_symptom_cluster_bu[6], count_symptom_cluster_bu[7])

symptom_clusters_A=c(symptom_clusters[1], symptom_clusters[2], symptom_clusters[3], symptom_clusters[4], symptom_clusters[8], symptom_clusters[9], symptom_clusters[10])

symptom_clusters_B=c(symptom_clusters[5], symptom_clusters[6], symptom_clusters[7])


df_bengurban_A=data.frame(symptom_clusters_A, count_symptom_cluster_bu_A)
df_bengurban_B=data.frame(symptom_clusters_B, count_symptom_cluster_bu_B)


plot_bengurban_A=ggplot(df_bengurban_A, aes(x=symptom_clusters_A, y=count_symptom_cluster_bu_A, fill=count_symptom_cluster_bu_A))+
geom_bar(stat="identity", width=0.2, color="black")+
ylim(0, max(count_symptom_cluster_bu_A))+
scale_fill_continuous(type="viridis")+
xlab("Symptom Clusters without Fever, Cold, Cough and Breathlessness")+
ylab("Number of Deceased Patients")+
theme(text = element_text(size=15))+
theme(axis.text.x = element_text(angle = 90, hjust = 1))+
ggtitle("Deaths in each Symptom Cluster in Bengaluru Urban")+
labs(fill="Deceased\nPatients")

plotly_bengurban_A=ggplotly(plot_bengurban_A)

plot_bengurban_B=ggplot(df_bengurban_B, aes(x=symptom_clusters_B, y=count_symptom_cluster_bu_B, fill=count_symptom_cluster_bu_B))+
geom_bar(stat="identity", width=0.15, color="black")+
scale_fill_continuous(type="viridis")+
ylim(0, max(count_symptom_cluster_bu_B))+
xlab("Symptom Clusters: Fever, Cold, Cough and Breathlessness")+
ylab("Number of Deceased Patients")+
theme(text = element_text(size=15))+
theme(axis.text.x = element_text(angle = 90, hjust = 1))+
ggtitle("Deaths in each Symptom Cluster in Bengaluru Urban")+
labs(fill="Deceased\nPatients")

plotly_bengurban_B=ggplotly(plot_bengurban_B)

name1_bu_A=paste("Bengaluru_Urban_Symptom_Clusters_A", ".png", sep="")
name2_bu_A=paste0("graphs/SymptomsCluster/", name1_bu_A)
ggsave(name2_bu_A, plot=plot_bengurban_A, width = 20, height = 10.7, dpi = 300, units = "in", device='png')

name_bu_A=paste("Bengaluru_Urban_Symptom_Clusters_A", ".html", sep="")
path_bu_A=file.path(getwd(), "graphs/SymptomsCluster/", name_bu_A)
htmlwidgets::saveWidget(plotly_bengurban_A, file=path_bu_A, selfcontained = FALSE, libdir = "plotly.html")


name1_bu_B=paste("Bengaluru_Urban_Symptom_Clusters_B", ".png", sep="")
name2_bu_B=paste0("graphs/SymptomsCluster/", name1_bu_B)
ggsave(name2_bu_B, plot=plot_bengurban_B, width = 20, height = 10.7, dpi = 300, units = "in", device='png')

name_bu_B=paste("Bengaluru_Urban_Symptom_Clusters_B", ".html", sep="")
path_bu_B=file.path(getwd(), "graphs/SymptomsCluster/", name_bu_B)
htmlwidgets::saveWidget(plotly_bengurban_B, file=path_bu_B, selfcontained = FALSE, libdir = "plotly.html")
