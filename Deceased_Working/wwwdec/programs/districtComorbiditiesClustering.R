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


# Reading Data
mydata=read.csv("mediadata/Master.csv")
district=mydata$District

#district_code_names takes a part of the string of each district name to use the grep function to compare strings for the district.

district_code_names=c("Bagal", "Ballari", "Belagavi", "Rural", "Bidar", "Chamaraja", "Ballapura", "Magalur", "Chitra", "Dakshina", "Davan", "Dharawad", "Gadag", "Hassan", "Haveri", "Kalabur", "Kodagu", "Kolar", "Koppal", "Mandya", "Mysuru", "Raichur", "Ramanagara", "Mog", "Tumakuru", "Udupi", "Uttara", "Vijay", "Yadgir")

district_names=c("Bagalkote", "Ballari", "Belagavi", "Bengaluru Rural", "Bidar", "Chamarajanagara", "Chikkaballapura", "Chikkamagaluru", "Chitradurga", "Dakshina Kannada", "Davanagere", "Dharawada", "Gadag", "Hassan", "Haveri", "Kalaburagi", "Kodagu", "Kolar", "Koppal", "Mandya", "Mysuru", "Raichur", "Ramanagara", "Shivamogga", "Tumakuru", "Udupi", "Uttara Kannada", "Vijayapura", "Yadgiri")

comorbidities_clusters=c("Respiratory Diseases", "Kidney\nRelated Diseases", "Liver\nRelated Diseases", "Heart\nRelated Diseases", "Epilepsy", "Diabetes and\nObesity", "Hormone and\nGland Diseases", "Anaemia and\nMyasthenia", "Cancer", "Sepsis and\nSepticaemia", "Pulmonary and\nLung Diseases", "Brain\nRelated Disease", "Skin Diseases", "Pregnancy\nRelated Illness", "Infectious Diseases")

 #We now count the number of patients in each district in each comorbidities cluster.

cluster=matrix(c(1:435), nrow=15)

#We now count the number of patients in each district in each description cluster.

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

#Now we create plots of each of the 15 comorbidities clusters between the districts vs. the frequency of patients in the given description cluster.

for(n in 1:15) #A loop to run over all comorbidities clusters 
{
	arr=c()
	for(i in 1:29)# A loop to run over all districts except Bengaluru Urban
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
        ggtitle(comorbidities_clusters[n])+
	labs(fill="Deceased\nPatients")

	plotly_arr=ggplotly(plot_arr) #converting ggplot to plotly
	
	#Saving the png file of the graph of each comorbidities cluster

	name1=paste("ComorbiditiesClusterNew_", n, ".png", sep="")
        name2=paste0("graphs/districtComorbiditiesCluster/", name1)
        ggsave(name2, plot=plot_arr, width = 20, height = 10.7, dpi = 300, units = "in", device='png') 
	
	#Saving the html file of the graph of each comorbidities cluster
        
        name=paste("ComorbiditiesClusterNew_", n, ".html", sep="")
        path=file.path(getwd(), "graphs/districtComorbiditiesCluster/", name)
        htmlwidgets::saveWidget(plotly_arr, file=path, selfcontained = FALSE, libdir = "plotly.html")
}

#Specifically for Bengaluru Urban

count_comorbidities_cluster_bu=c()
bu_district=subset(mydata, grepl("Urban", district, ignore.case="True"))
bu_comorbidities=bu_district$Co.Morbidities

count_comorbidities_cluster_bu[1]=length(grep("Asthma|ARDS", bu_comorbidities, ignore.case="True"))
count_comorbidities_cluster_bu[2]=length(grep("Kidney|Renal|AKD|CKD|AKI|ARF|RTA|RVD", bu_comorbidities, ignore.case="True"))
count_comorbidities_cluster_bu[3]=length(grep("Liver|Cirrhosis|CLD", bu_comorbidities, ignore.case="True"))
count_comorbidities_cluster_bu[4]=length(grep("Heart|Blood|CHD|IHD|RHD|COPD|CAD|Cardio|LVF|Tension|HTN|HTM|IDH|PTCA|DVT|PNC|Pancytopenia|CVD", bu_comorbidities, ignore.case="True"))
count_comorbidities_cluster_bu[5]=length(grep("Epilepsy", bu_comorbidities, ignore.case="True"))

count_comorbidities_cluster_bu[6]=length(grep("Diabeties|Obesity|Juvenile DM|Type 2 DM|Uncontrolled DM|DN", bu_comorbidities, ignore.case="True"))

count_comorbidities_cluster_bu[7]=length(grep("Hypothyroidism|Thyroid|BPH", bu_comorbidities, ignore.case="True"))
count_comorbidities_cluster_bu[8]=length(grep("Anaemia|Anemia|Anamea|Myasthenia", bu_comorbidities, ignore.case="True"))
count_comorbidities_cluster_bu[9]=length(grep("Cancer|Carcinoma|Colon|CA|Leuk", bu_comorbidities, ignore.case="True"))
count_comorbidities_cluster_bu[10]=length(grep("Sepsis|Septicaemia|Septic", bu_comorbidities, ignore.case="True"))

count_comorbidities_cluster_bu[11]=length(grep("Pulmonary|Lung|COPD|Pneumonia|Chronic Lung Disease|CLD|Chronic Smoker|Tuberculosis|TB", bu_comorbidities, ignore.case="True"))

count_comorbidities_cluster_bu[12]=length(grep("Brain|Neuro|Encephalopathy|Hepatic Encephalopathy|Encephalitis|Hemiplegic|CBA|Park", bu_comorbidities, ignore.case="True"))

count_comorbidities_cluster_bu[13]=length(grep("DH", bu_comorbidities, ignore.case="True"))
count_comorbidities_cluster_bu[14]=length(grep("PIH", bu_comorbidities, ignore.case="True"))
       
count_comorbidities_cluster_bu[15]=length(grep("Filariasis|HBSAG|HPTN", bu_comorbidities, ignore.case="True"))

count_comorbidities_cluster_bu_A=c(count_comorbidities_cluster_bu[1], count_comorbidities_cluster_bu[3], count_comorbidities_cluster_bu[5],count_comorbidities_cluster_bu[6], count_comorbidities_cluster_bu[7], count_comorbidities_cluster_bu[8], count_comorbidities_cluster_bu[9], count_comorbidities_cluster_bu[10], count_comorbidities_cluster_bu[11], count_comorbidities_cluster_bu[12], count_comorbidities_cluster_bu[13], count_comorbidities_cluster_bu[14], count_comorbidities_cluster_bu[15])

count_comorbidities_cluster_bu_B=c(count_comorbidities_cluster_bu[2], count_comorbidities_cluster_bu[4])

comorbidities_clusters_A=c(comorbidities_clusters[1], comorbidities_clusters[3], comorbidities_clusters[5],comorbidities_clusters[6], comorbidities_clusters[7], comorbidities_clusters[8], comorbidities_clusters[9], comorbidities_clusters[10], comorbidities_clusters[11], comorbidities_clusters[12], comorbidities_clusters[13], comorbidities_clusters[14], comorbidities_clusters[15])

comorbidities_clusters_B=c(comorbidities_clusters[2], comorbidities_clusters[4])

df_bengurban_A=data.frame(comorbidities_clusters_A, count_comorbidities_cluster_bu_A)

plot_bengurban_A=ggplot(df_bengurban_A, aes(x=comorbidities_clusters_A, y=count_comorbidities_cluster_bu_A, fill=count_comorbidities_cluster_bu_A))+
geom_bar(stat="identity", width=0.2, color="black")+
ylim(0, max(count_comorbidities_cluster_bu_A))+
scale_fill_continuous(type="viridis")+
xlab("Comorbidities Clusters")+
ylab("Number of Deceased Patients")+
theme(text = element_text(size=15))+
theme(axis.text.x = element_text(angle = 90, hjust = 1))+
ggtitle("Deaths in each Comorbidities Cluster except Heart and Kidney Related Diseases in Bengaluru Urban")+
labs(fill="Deceased\nPatients")

plotly_bengurban_A=ggplotly(plot_bengurban_A)

df_bengurban_B=data.frame(comorbidities_clusters_B, count_comorbidities_cluster_bu_B)

plot_bengurban_B=ggplot(df_bengurban_B, aes(x=comorbidities_clusters_B, y=count_comorbidities_cluster_bu_B, fill=count_comorbidities_cluster_bu_B))+
geom_bar(stat="identity", width=0.08, color="black")+
ylim(0, max(count_comorbidities_cluster_bu_B))+
scale_fill_continuous(type="viridis")+
xlab("Comorbidities Clusters")+
ylab("Number of Deceased Patients")+
theme(text = element_text(size=15))+
theme(axis.text.x = element_text(angle = 90, hjust = 1))+
ggtitle("Deaths in each Comorbidities Cluster: Heart and Kidney Related Diseases in Bengaluru Urban")+
labs(fill="Deceased\nPatients")

plotly_bengurban_B=ggplotly(plot_bengurban_B)


name1_bu_A=paste("Bengaluru_Urban_Comorbidities_Clusters_A", ".png", sep="") 
name2_bu_A=paste0("graphs/districtComorbiditiesCluster/", name1_bu_A)
ggsave(name2_bu_A, plot=plot_bengurban_A, width = 20, height = 10.7, dpi = 300, units = "in", device='png')

name_bu_A=paste("Bengaluru_Urban_Comorbidities_Clusters_A", ".html", sep="")
path_bu_A=file.path(getwd(), "graphs/districtComorbiditiesCluster/", name_bu_A)
htmlwidgets::saveWidget(plotly_bengurban_A, file=path_bu_A, selfcontained = FALSE, libdir = "plotly.html")

name1_bu_B=paste("Bengaluru_Urban_Comorbidities_Clusters_B", ".png", sep="")
name2_bu_B=paste0("graphs/districtComorbiditiesCluster/", name1_bu_B)
ggsave(name2_bu_B, plot=plot_bengurban_B, width = 20, height = 10.7, dpi = 300, units = "in", device='png')

name_bu_B=paste("Bengaluru_Urban_Comorbidities_Clusters_B", ".html", sep="")
path_bu_B=file.path(getwd(), "graphs/districtComorbiditiesCluster/", name_bu_B)
htmlwidgets::saveWidget(plotly_bengurban_B, file=path_bu_B, selfcontained = FALSE, libdir = "plotly.html")
