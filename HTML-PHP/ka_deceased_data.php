<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Deceased Data</title>
  <!-- Bootstrap CSS -->
  <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
  <!-- Font Awesome CSS for icons -->
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" rel="stylesheet">
  <!-- Custom CSS -->
  <link rel="stylesheet" href="../CSS/navbar.css">
  <link rel="stylesheet" href="../CSS/ka_hosp_req.css">
  <!-- <link rel="stylesheet" href="../CSS/deceased.css"> -->
  
  <!-- <style>
    .hidden-content {
      display: none;
    }
    
    .hidden-content:target {
      display: block;
    }
    
    .hidden-content:target ~ .content {
      display: block;
    }

    .dropdown-link {
      cursor: pointer;
      color: #007bff;
    }

    .dropdown-link:hover {
      text-decoration: underline;
    }
  </style> -->

  <style>
    .hidden-content {
      display: none;
    }

    input[type="checkbox"] {
      display: none;
    }

    input[type="checkbox"]:checked + .dropdown-link + .hidden-content {
      display: block;
    }

    .dropdown-link {
      cursor: pointer;
      color: #007bff;
      display: block;
      padding: 0px;
    }

    .dropdown-link:hover {
      text-decoration: underline;
    }
  </style>

</head>
<body>
  <?php include 'image_holder.php'; ?>
  <?php include 'navbar.html'; ?>
<div class="container">

    <div class="container mt-5">
      <div class="row ">
        <div class="col-md-8 mx-auto text-center jumbotron bg-info text-white">
          <h2>Deceased Data in Karnataka</h2>
          <p>Karnataka State Government's Ministry of Health and Family Welfare has a dedicated COVID-19 Dashboard on its website and also has been providing detailed Media Bulletins on a daily basis since March 9th, 2020. In this page, we track the Deceased data provided in bulletins to give a more comprehensive view of the COVID-19 fatalities in the state of Karnataka.</p>
          <!-- Add your charts or data visualization here -->
        </div>
      </div>
    </div>
    <!-- <div class="fancy-heading">
      <img src="../Images/ka_deceased_data/heart_rate.jpg" alt="Profile Picture">
      <h3>Fatality Rate</h3>
    </div> -->
    <div class="container mt-5">
      <div class="row">
        <!-- Column for sections -->
        
        <div class="col-md-6 icu-timeline">
          <h3>Deceased by Infected Ratio</h3>
          <p>The plot depicts the ratio of deceased individuals to the total number of infected cases over time. On the x-axis, dates are plotted to show the progression of the COVID-19 pandemic, while the y-axis represents the calculated ratio. This plot offers insights into the severity of the virus's impact by tracking how the mortality rate relative to the infection rate evolves throughout the pandemic.</p>
        </div>
    
         <!-- Column for graph -->
          <div class="col-md-6">
            <div id="graphCanvas">
                <!-- Graph will be displayed here -->
                <?php generateImageHolder("ka_deceased_data","ka_deceased_ratio.gif","ka_deceased_ratio.gif","ka_decbyinf.R",2,[1],400,550)?>
            </div>
          </div>
      </div>
    </div>    
        
        
    <div class="container mt-5">
      <div class="row">    
      
        <div class="col-md-12 icu-timeline">
          <h3>Age-Gender Distribution of the Deceased</h3>
          <p>The graph on the left (below) provides the stacked age distribution of the deceased COVID-19 patients in Karnataka along with the census of the population of Karnataka for reference. The graph on the right is the stacked age gender distribution of the deceased in Karnataka. The filled in blue color indicates the distribution of the deceased coronavirus patients in Karnataka and the red outline represents the census of population. From the graphs we see that mean age of the deceased is around 60 yrs, the age group 60-70 have the highest number of deceased patients, while the age group 0-30 have very less death count. The number of Male deaths in each group is uniformly higher across all age groups over corresponding female deaths. In the media bulletins, some entries did not mention, age, sex, and districts and also some entries were attributed to "others". Such entries have not been plotted in the above.
          </p>
        </div>
      
        <div class="col-md-6">
          <div id="graphCanvas">
            <!-- Graph will be displayed here -->
            <?php generateImageHolder("deceased_data","kaAgePop.png","kaAgePop.html","finalDeceasedDataAgeGender.R",2,[35],300,550)?>
          </div>
        </div>

        <div class="col-md-6">
          <div id="graphCanvas">
              <!-- Graph will be displayed here -->
              <?php generateImageHolder("deceased_data","kaAge.png","kaAge.html","finalDeceasedDataAgeGender.R",2,[35],300,550)?>
          </div>
        </div>
      
        <div class="col-md-12">
          
            <ul>
              <li>
                <input type="checkbox" id="dropdown1">
                <label for="dropdown1" class="dropdown-link">District Wise Data Set</label>
                <div class="hidden-content">
                  <p><a href = "">This zipped file</a> is a collection of files that contain data for each district in Karnataka, where each file contains all the information of all the people who died in that particular district. 
                    <br><br>
                    The columns have data on:
                    <ol>
                        <li>The district name.
                        <li>The State P Code for that patient.
                        <li>The age of the patient, given in years.
                        <li>The sex of the patient.
                        <li>The description of the patient including why they were tested and which cluster they fall in.
                        <li>The symptoms of the patients.
                        <li>Any co-morbidities that the patients might have had.
                        <li>The date at which they were admitted to the hospital. For the patients who were brought dead or passed away at their residence, that has been mentioned.
                        <li>The date on which they passed away.
                        <li>The date of the media bulletin they appeared in.
                    </ol>
                  </p>
                </div>
              </li>
              
              <li> <a href = "StackedAgeGen.php">Stacked Age-Gender Distribution of Deceased across Districts</a></li>
              
              <li> 
                <input type="checkbox" id="dropdown2">
                <label for="dropdown2" class="dropdown-link">District-Wise Age-Scatter Plot</label>
                <div class="hidden-content">
                  <p>This graph is the scatter plot of the total age distribution across all districts.</p>
                  <div class="col-md-12">
                    <div id="graphCanvas">
                      <!-- Graph will be displayed here -->
                      <?php generateImageHolder("deceased_data","ageScatter.png","ageScatter.html","finalDeceasedDataAgeGender.R",2,[35],580,1100)?>
                    </div>
                  </div>
                </div>
              </li>
              
              <li>
                <input type="checkbox" id="dropdown3">
                <label for="dropdown3" class="dropdown-link">District-Wise Age-Scatter Plot</label>
                <div class="hidden-content">
                  <p>The below box-plot, across districts, suggest that the median age of the deceased from every district is around 60 mostly, consistent with the general overall trends and across waves. We can see that the maximum number of outliers can be observed with Bengaluru Urban while Bidar has no outliers.</p>
                  <div class="col-md-12">
                    <div id="graphCanvas">
                      <!-- Graph will be displayed here -->
                      <?php generateImageHolder("deceased_data","ageBoxPlot.png","ageBoxPlot.html","finalDeceasedDataAgeGender.R",2,[35],580,1100)?>
                    </div>
                  </div>
                </div>
              </li>
            </ul>
            <hr>
          
        </div>

      </div>  
    </div>

    <div class="container mt-5">
      <div class="row">
        <!-- Column for sections -->
        
        <div class="col-md-12 icu-timeline">
          <h3>Days to Decease</h3>
          <p>The graph below represents a scatter plot of days to decease for each patnly considered the patients who were admitted to a hospital and then computed the difference between admission date and decease date to arrive at days to decease.</p>
        </div>
        
        <div class="col-md-6">
          <div id="graphCanvas">
              <!-- Graph will be displayed here -->
              <?php generateImageHolder("DistrictWiseScatter","scat_death_rep.png","scat_death_rep.html","admissionfinal.R",2,[35],300,550)?>
          </div>
        </div>

        <div class="col-md-6">
          <div id="graphCanvas">
              <!-- Graph will be displayed here -->
              <?php generateImageHolder("DistrictWiseScatter","scat_death_blr.png","scat_death_blr.html","admissionfinal.R",2,[35],300,550)?>
          </div>
        </div>
      
        <!-- Column for sections -->
        
        <div class="col-md-12">
          <p>More than 4000 people die just after first day of hospitalisation. Days to decease for a majority of patients is within 2 weeks and and the mean is nearly 6 days.
            <ul>
              <li><a href = "DaysToDecease.php">Wave-Wise Days to Decease</a></li>

              <li>
              <input type="checkbox" id="dropdown4">
                <label for="dropdown4" class="dropdown-link">Days to Decease: Data Set</label>
                <div class="hidden-content">
                  <p><a href = "">CSV File.</a> From the media bulletin, we took the difference between the date of decease and admission date and call the difference as days to decease. 
                    <br><br>
                    The csv file conatains:
                    <ol>
                      <li>The patient id,
                      <li>Name of District,
                      <li>Date of Admission,
                      <li>Date of Decease,
                      <li>The days to decease being the difference between the dates mentioned in third and second column.
                    </ol>
                  </p>
                </div>
              </li> 

              <li>
              <input type="checkbox" id="dropdown5">
                <label for="dropdown5" class="dropdown-link">District-Wise: Days to Decease</label>
                <div class="hidden-content">
                  <p>The graph below represents the Box-plot for days to decease in Karnataka(District-wise) based on the data reported.All District shows similar trend.</p>
                  <div class="col-md-12">
                    <div id="graphCanvas">
                      <!-- Graph will be displayed here -->
                      <?php generateImageHolder("daysToDecease","box_decease.png","box_decease.html","admissionfinal.R",2,[35],580,1100)?>
                    </div>
                  </div>
                </div>
              </li>
                
              <li>
              <input type="checkbox" id="dropdown6">
                <label for="dropdown6" class="dropdown-link">Age-Gender: Days to Decease</label>
                <div class="hidden-content">
                  <p>Below we plot the 95% t-confidence interval around the mean for days to decease across gender in various age bins.</p>
                  <div class="col-md-12">
                    <div id="graphCanvas">
                      <!-- Graph will be displayed here -->
                      <?php generateImageHolder("agewise","age_ag_days_t.png","age_ag_days_t.html","agewise_daystodecease.R",2,[35],580,1100)?>
                    </div>
                  </div>
                </div>
              </li>

              <li>
              <input type="checkbox" id="dropdown7">
                <label for="dropdown7" class="dropdown-link">Age-Gender Wise-Days to Decease: Data Set</label>
                <div class="hidden-content">
                  <p><a href = "">CSV File.</a>From the media bulletin, we took the difference between the date of decease and admission date and call the difference as days to decease.We then separated the deceased on the basis of age and gender and calculated the mean, variance, and standard deviation for days to decease. 
                    <br><br>
                    The column has data on:
                    <ol>
                      <li>Age-Gender Category,
                      <li>Total deceased patients,
                      <li>t-value of Total deceased patients,
                      <li>Mean Days to decease,
                      <li>Variance of Days to decease,
                      <li>Standard deviation of Days to decease,
                      <li>Gender.
                    </ol>
                  </p>
                </div>
              </li>  
            </ul>
            <hr>
          </p>
        </div>

      </div>
    </div>

    <div class="container mt-5">
      <div class="row">
        <!-- Column for sections -->
        
        <div class="col-md-12 icu-timeline">
          <h3>Days to Report</h3>
          <p>The graph below represents the histogram of days to report in Karnataka. Here we considered all deceased patients and computed the difference between the date they were reported in the Media Bulletin and the decease date. Thus we arrive at days to report for each deceased patient.</p>
        </div>
        
        <div class="col-md-6">
          <div id="graphCanvas">
              <!-- Graph will be displayed here -->
              <?php generateImageHolder("daysToReport","scat_death_rep.png","scat_death_rep.html","admissionfinal.R",2,[35],300,550)?>
          </div>
        </div>

        <div class="col-md-6">
          <div id="graphCanvas">
              <!-- Graph will be displayed here -->
              <?php generateImageHolder("daysToReport","scat_death_rep_blr.png","scat_death_rep_blr.html","admissionfinal.R",2,[35],300,550)?>
          </div>
        </div>
      
        <!-- Column for sections -->
        
        <div class="col-md-12">
          <p>The above histogram is right-skewed indicating early reporting of deaths by the district administration. The mean time is nearly 7 days.
            <ul>
              <li><a href = "DaysToReport.php">Wave-Wise Days to Report</a></li>

              <li>
                <input type="checkbox" id="dropdown8">
                <label for="dropdown8" class="dropdown-link">Days to Decease: Data Set</label>
                <div class="hidden-content">
                  <p><a href = "">CSV File.</a> From the media bulletin published by the state government, we took the difference between the date of decease and the media bulletin date and call the difference as the days to report. 
                    <br><br>
                    The column has data on:
                    <ol>
                      <li>The patient id,
                      <li>Name of District,
                      <li>Date of Decease,
                      <li>Date of Report,
                      <li>The days to report being the difference between the dates mentioned in third and second column.
                    </ol>
                  </p>
                </div>  
              </li>

              <li>
              <input type="checkbox" id="dropdown9">
                <label for="dropdown9" class="dropdown-link">District-Wise: Days to Report</label>
                <div class="hidden-content">
                  <p>The graph below represents the Box-plot for days to report in Karnataka(District-wise) based on the data reported.Most districts have similar trend but some have high interquartile range along with high number of outliers.</p>
                  <div class="col-md-12">
                    <div id="graphCanvas">
                      <!-- Graph will be displayed here -->
                      <?php generateImageHolder("daysToReport","box_rep.png","box_rep.html","admissionfinal.R",2,[35],580,1100)?>
                    </div>
                  </div>
                </div>
              </li>

              <li>
              <input type="checkbox" id="dropdown10">
                <label for="dropdown10" class="dropdown-link">Age-Gender: Days to Report</label>
                <div class="hidden-content">
                  <p>Below we plot the 95% t-confidence interval around the mean for days to report across gender in various age bins.</p>
                  <div class="col-md-12">
                    <div id="graphCanvas">
                      <!-- Graph will be displayed here -->
                      <?php generateImageHolder("agewise","age_ag_rep_t.png","age_ag_rep_t.html","agewise_daystodecease.R",2,[35],580,1100)?>
                    </div>
                  </div>
                </div>
              </li>

            </ul>
            <hr>
          </p>
        </div>

      </div>
    </div>

    <div class="container mt-5">
      <div class="row">
        <!-- Column for sections -->
        
        <div class="col-md-12 icu-timeline">
          <h3>Hospitalisation Ratio</h3>
          <p>In the media bulletin each deceased patient is reported as either admitted to hospital or has been brought dead or has died at her/his residence. We take the ratio of hospitalised patients to total deceased patients to arrive at the hospitalisation ratio. Below we present the data of Hospitalisation Ratio of the deceased patients as scatter plots across months. The size of the blob in the scatter plot indicates the number of monthly deaths.</p>
        </div>
        
        <div class="col-md-12">
          <div id="graphCanvas">
              <!-- Graph will be displayed here -->
              <?php generateImageHolder("deceased_data","hospitalizationhospitalisation_ratioKA.png","hospitalisation_ratioKA.html","hospitalisation.R",2,[35],580,1100)?>
          </div>
        </div>
      
        <!-- Column for sections -->
        
        <div class="col-md-12">
          <p>We have marked a line at 95% hospitalisation ratio in the scatter plots or at the minimum monthly hospilisation ratio if it is higher. This line may be viewed as an ideal hospitalisation ratio. In comparison with days to decease one may arrive at a standard for clinical treatment.
            <ul>
              <li>
              <input type="checkbox" id="dropdown11">
                <label for="dropdown11" class="dropdown-link">Hospitalisation Ratio Data Set</label>
                <div class="hidden-content">
                  <p> As per the media bulletin published by the state government, each individual death is reported either as hospitalised, brought dead,or died at residence.In the data file, for each individual district, we provide the count of total death, total deceased patients who were hospitalised, and deceased patients who were not hospitalised, that is, we added the deceased who were either brought dead or died at residence.Then we also calculate the ratio of hospitalisation and the ratio of unhospitalised patients and the values are listed in individual column of the csv file attached. 
                    <br><br>
                    The column has data on:
                    <ol>
                      <li>Each row represents a district in Karnataka. 
                      <li>Each row in this column represents total deaths in that district. 
                      <li>Each row represents total deceased patients who were hospitalised in that district. 
                      <li>Each row represents total deceased patients who were not-hospitalised in that district. 
                      <li>Each row represents ratio of hospitalisation in that district. 
                      <li>Each row represents ratio of un-hospitalised deceased patients in that district.
                    </ol>
              
                    <a href = "#">Data in CSV</a>
                  </p>
                </div>  
              </li>
        
              <li><a href = "hospitalisationRatio.php">District Wise Hospitalisation Ratio</a></li>

            </ul>
            
            From the above we can see that the majority of deceased patients sought treatment at a hospital. A siginficant proportion still succumb without treatment at a medical having been brought dead or passing away at their residence.
            <br><br>

            <ul>

              <li>
              <input type="checkbox" id="dropdown12">
                <label for="dropdown12" class="dropdown-link">Bar Plot of Place of Death</label>
                <div class="hidden-content">
                  <p>The graph below represents the Barplot of Place of Death for the state of Karnataka based on the data reported.</p>
                  
                  <div class="col-md-12">
                    <div id="graphCanvas">
                      <!-- Graph will be displayed here -->
                      <?php generateImageHolder("hospitalization","Deathplot.png","hosp_barplot.html","hospitalisation.R",2,[35],580,1100)?>
                    </div>
                  </div>

                  <p>The graph below represents the Barplot of Place of Death(District wise) in Karnataka based on the data reported.</p>
                  
                  <div class="col-md-12">
                    <div id="graphCanvas">
                      <!-- Graph will be displayed here -->
                      <?php generateImageHolder("hospitalization","dist.wise_place.png","hosp1.html","hospotalisation.R",2,[35],580,1100)?>
                    </div>
                  </div>

                  <p>Most of the patients were actually diagnosed in hospitals before death.But Bengaluru urban shows a peak in death count in hospitals.</p>

                </div>
              </li>

            </ul>
            <hr>
          </p>
        </div>

      </div>
    </div>

    <div class="container mt-5">
      <div class="row">
        <!-- Column for sections -->
        
        <div class="col-md-12 icu-timeline">
          <h3>Description of Source of Illness</h3>
          <p>In the media bulletin for each deceased patient the source of illness is identified in the Description column. We have grouped the sources into 4 travel related clusters, SARI, ILI and Unkown. To see the variation in description of source of illness we have plotted a heat map of the percentage (within each district) number of deceased patients across description clusters for all districts. Every tick on the x-axis represents the different source of illness. The y-axis represents the different districts. Each cell represents the percentage number of deceased patients in that description cluster for that particular district. The darker the colour of a cell, the smaller the percentage of deaths in that description for the given district while the brighter the colour, the larger is the corresponding percentage.</p>
        </div>
        
        <div class="col-md-6">
          <div id="graphCanvas">
              <!-- Graph will be displayed here -->
              <?php generateImageHolder("DescriptionCluster","Descriptionclusters_vs_districts_A.png","DescCluster.html","descriptionCluster.R",2,[35],700,550)?>
          </div>
        </div>

        <div class="col-md-6">
          <div id="graphCanvas">
              <!-- Graph will be displayed here -->
              <?php generateImageHolder("DescriptionCluster","Descriptionclusters_vs_districts_A.png","descClust2.html","descriptionCluster.R",2,[35],700,550)?>
          </div>
        </div>
      
        <!-- Column for sections -->
        
        <div class="col-md-12">
          <p>
            <ul>
              <li>
              <input type="checkbox" id="dropdown13">
                <label for="dropdown13" class="dropdown-link">Description of Source of Illness: Classification Details</label>
                <div class="hidden-content">
                  <p> <a href = "#">This csv file</a> contains information about the 7 different clusters of description of sources of illness of deceased patients and the percentage of the number of deceased patients in each cluster of description of source of illness for each district in Karnataka. The 7 columns represent the following 7 clusters of description and the headings in each column are the name of the clusters of description. 
                    <br><br>
                    The column has data on:
                    <ol>
                      <li>Influenza Like Illness
                      <li>Severe Acute Respiratory Illness
                      <li>Contact of Patient or Containment Zone
                      <li>Inter District Travel in Karnataka
                      <li>Domestic Travel outside of Karnataka
                      <li> International Travel
                      <li>Unknown (Contact under tracing or ongoing investigation) 
                    </ol>
                    <br><br>
                    <p>All the rows below the headings (except the last row) contain the percentage of the number of deceased patients in each of the 7 clusters of description of source of illness for each district. The last row represents the percentage of deceased patients in each of the 7 clusters of description in all of Karnataka.</p>
              
                  </p>
                </div>  
              </li>

              <li>
              <input type="checkbox" id="dropdown14">
                <label for="dropdown14" class="dropdown-link">Description of Source of Illness: Data Set</label>
                <div class="hidden-content">
                  <p>In the media bulletin for each deceased patient the source of illness is identified in the Description column. We have grouped the sources into 4 travel related clusters, SARI, ILI and Unknown. The specific clustering is provided in the following csv file.
                    <br>
                    <a href = "#">Clusters of Description of Source of Illness</a>
                    <br><br>                   
                    This CSV file contains information about the clusters of sources of illness based on the description associated with each patient in the Description column of the Media Bulletin. In the CSV file, the 7 columns represent the 7 clusters of description and the heading of each column is the name of that cluster of description of the source of illness. The rows below the headings are the description of the sources of illness classified under the corresponding cluster of description of the sources of illness.
                  </p>
                </div>  
              </li>

              <li>
              <input type="checkbox" id="dropdown15">
                <label for="dropdown15" class="dropdown-link">Karnataka Description Cluster Histogram</label>
                <div class="hidden-content">

                  <div class="col-md-12">
                    <div id="graphCanvas">
                      <!-- Graph will be displayed here -->
                      <?php generateImageHolder("SourceOfIllness","Karnataka_Description_Clusters.png","Karnataka_Description_Cluster.html","decsriptionCluster.R",2,[35],580,1100)?>
                    </div>
                  </div>

                  <p>The above bar graph represents the 7 clusters of the description of the sources of illness vs. the percentage of deceased patients in each of the clusters of description for all of Karnataka in total. As we can see, the percentage of deceased patients in the clusters of ILI (Influenza Like Illness), SARI (Severe Acute Respiratory Illness) and Unknown (Contact Under Tracing and Under Investigation), far exceed those in each of the other clusters. After clicking on the graph, hovering on the bars in the graph reveals the percentage of deceased patients in the given cluster. For clusters of description other than those related to ILI, SARI and Unknown, the bars are very short and hence hovering on them might not reveal the percentage of deceased patients. In such a case, please zoom on the graph to make visible the percentage of deceased patients in clusters with shorter bars while hovering on them.</p>
                  
                </div>
              </li>

            </ul>
            <hr>
          </p>
        </div>

      </div>
    </div>

    <div class="container mt-5">
      <div class="row">
        <!-- Column for sections -->
        
        <div class="col-md-12 icu-timeline">
          <h3>Symptoms of the Patient</h3>
          <p>The above bar graph represents the ten symptom clusters vs. the percentage of deceased patients in each of the symptom clusters for all of Karnataka in total. As we can see, the percentage of deceased patients in the symptom clusters of breathlessness, cold, cough and fever, far exceed those in each of the other symptom clusters. After clicking on the graph, hovering on the bars in the graph reveals the percentage of deceased patients in the given symptom cluster. For symptom clusters other than those related to fever, cough, cold and breathlessness, the bars are very short and hence hovering on them might not reveal the percentage of deceased patients. In such a case, please zoom on the graph to make visible the percentage of deceased patients in clusters with shorter bars while hovering on them.</p>
        </div>
        
        <div class="col-md-6">
          <div id="graphCanvas">
              <!-- Graph will be displayed here -->
              <?php generateImageHolder("SymptomCluster","Symptomclusters_vs_districts_A.png","Symptomclusters_vs_districts_A.html","symptomCluster.R",2,[35],500,550)?>
          </div>
        </div>

        <div class="col-md-6">
          <div id="graphCanvas">
              <!-- Graph will be displayed here -->
              <?php generateImageHolder("SymptomCluster","Symptomclusters_vs_districts_B.png","Symptomclusters_vs_districts_B.html","symptomCluster.R",2,[35],500,550)?>
          </div>
        </div>
      
        <!-- Column for sections -->
        
        <div class="col-md-12">
          <p>
            <ul>
              <li>
              <input type="checkbox" id="dropdown16">
                <label for="dropdown16" class="dropdown-link">Symptom Cluster: Classification Details</label>
                <div class="hidden-content">
                  <p>In the media bulletin in the Symptoms column the symptoms observed in each deceased patient is listed. To see the variation in symptoms of deceased patients across different districts, we first grouped symptoms into 10 clusters. The specific clustering is provided in the following csv file.
                  <br>
                  <a href = "">Clusters of Symptoms</a>  
                  <br> <br>                   
                    This CSV file contains information about the different symptom clusters and the different sets of symptoms that are classified under each symptom cluster. In the CSV file, the 10 columns represent the 10 symptom clusters and the heading of each column is the name of that symptom cluster. The rows below the headings represent the different symptoms classified under the corresponding symptom clusters.
                  </p>
                </div>  
              </li>

              <li>
                <input type="checkbox" id="dropdown17">
                <label for="dropdown17" class="dropdown-link">Symptom Cluster: Data Set</label>
                <div class="hidden-content">
                  <p><a href = "">This csv file</a> contains information about the 10 different clusters of symptoms of deceased patients and the percentage of the number of deceased patients in each symptom cluster for each district in Karnataka. 
                  <br><br>
                  The 10 columns represent the following 10 symptom clusters and the headings in each column are the name of the symptom clusters.
                  <br>
                  <ol>
                    <li>Asymptomatic
                    <li>Abdominal Pain and Released Symptoms
                    <li>Chest pain and Pneumonia
                    <li>Body Pain and Fatigue
                    <li>Breathlessness and Respiratory Failure
                    <li>Fever, Cold or Cough without Breathlessness
                    <li>Fever, Cold or Cough with Breathlessness
                    <li>Anorexia and Decreased Appetite
                    <li>Acute Myocardial Infarction
                    <li>Altered Sensorium
                  </ol>
                  <br> <br>                   
                  All the rows below the headings (except the last row) contain the percentage of the number of deceased patients in each of the 10 symptom clusters for each district. The last row represents the percentage of deceased patients in each of the 10 symptom clusters for all of Karnataka.
                  </p>
                </div>
              </li>  

              <li>
                <input type="checkbox" id="dropdown18">
                <label for="dropdown18" class="dropdown-link">Karnataka Symptom Cluster Histogram</label>
                <div class="hidden-content">

                  <div class="col-md-12">
                    <div id="graphCanvas">
                      <!-- Graph will be displayed here -->
                      <?php generateImageHolder("SymptomCluster","Karnataka_Symptom_Clusters.png","Karnataka_Symptom_Clusters.html","symptomCluster.R",2,[35],580,1100)?>
                    </div>
                  </div>

                  <p>The above bar graph represents the ten symptom clusters vs. the percentage of deceased patients in each of the symptom clusters for all of Karnataka in total. As we can see, the percentage of deceased patients in the symptom clusters of breathlessness, cold, cough and fever, far exceed those in each of the other symptom clusters. After clicking on the graph, hovering on the bars in the graph reveals the percentage of deceased patients in the given symptom cluster. For symptom clusters other than those related to fever, cough, cold and breathlessness, the bars are very short and hence hovering on them might not reveal the percentage of deceased patients. In such a case, please zoom on the graph to make visible the percentage of deceased patients in clusters with shorter bars while hovering on them.
                  </p>
                  
                </div>
              </li>
            </ul>
            <hr>
          </p>
        </div>

      </div>
    </div>

    <div class="container mt-5">
      <div class="row">
        <!-- Column for sections -->
        
        <div class="col-md-12 icu-timeline">
          <h3>Comorbidities in the Patient</h3>
          <p>In the media bulletin in the Comorbidities column the Comoorbidities observed for each deceased patient is listed. To see the variation in Co-Morbidities of deceased patients across different districts, we first grouped the Co-Morbidities into 15 clusters. In the above graph we have plotted a heat map of the percentage(within each district) number of deceased patients across comorbidities clusters for all districts. Every tick on the x-axis represents the different comorbidities clusters. The y-axis represents the different districts. Each cell represents the percentage number of deceased patients in that comorbidity clusters for a district. The darker the colour of a cell, the smaller the percentage of deaths in that symptom for the given district while the brighter the colour, the larger is the corresponding percentage.</p>
        </div>
        
        <div class="col-md-6">
          <div id="graphCanvas">
              <!-- Graph will be displayed here -->
              <?php generateImageHolder("ComorbiditiesCluster","Comorbiditiesclusters_vs_districts_A.png","Comorbiditiesclusters_vs_districts_A.html","comorbiditiesCluster.R",2,[35],500,550)?>
          </div>
        </div>

        <div class="col-md-6">
          <div id="graphCanvas">
              <!-- Graph will be displayed here -->
              <?php generateImageHolder("ComorbiditiesCluster","Comorbiditiesclusters_vs_districts_B.png","Comorbiditiesclusters_vs_districts_B.html","comorbiditiesCluster.R",2,[35],500,550)?>
          </div>
        </div>
      
        <!-- Column for sections -->
        
        <div class="col-md-12">
          <p>
            <ul>
              <li>
              <input type="checkbox" id="dropdown19">
                <label for="dropdown19" class="dropdown-link">Comorbidities Cluster: Classification Details</label>
                <div class="hidden-content">
                  <p>In the media bulletin in the Comorbidities column the Comoorbidities observed for each deceased patient is listed. To see the variation in comorbidities of deceased patients across different districts, we first grouped the comorbidities into 15 clusters. The specific clustering is provided in the following csv file.
                  <br><br>
                  <a href = "">Clusters of Comorbidities</a>
                  <br><br>
                  This CSV file contains information about the different clusters of comorbidities and the different sets of comorbidities that are classified under each comorbidity cluster. In the CSV file, the 15 columns represent the 15 comorbidities clusters and the heading of each column is the name of that comorbidity cluster. The rows below the headings are the comorbidities classified under the corresponding clusters of comorbidities
                  </p>
                </div>  
              </li>

              <li>
              <input type="checkbox" id="dropdown20">
                <label for="dropdown20" class="dropdown-link">Comorbidities Cluster: Data Set</label>
                <div class="hidden-content">
                  <p>This csv file contains information about the 10 different clusters of comorbidities of deceased patients and the percentage of the number of deceased patients in each comorbidities cluster for each district in Karnataka. The 15 columns represent the following 15 comorbidities clusters and the headings in each column are the name of the comorbidities clusters.
                  <br><br>
                  <ol>
                    <li>Respiratory Diseases
                    <li>Kidney Related Diseases
                    <li>Liver Related Diseases
                    <li>Heart and Blood Pressure Related Diseases
                    <li>Epilepsy
                    <li>Diabetes and Obesity
                    <li>Hormone and Gland Diseases
                    <li>Anaemia and Myasthenia
                    <li>Cancer
                    <li>Sepsis
                    <li>Pulmonary and Lung Diseases
                    <li>Brain Related Diseases
                    <li>Skin Diseases
                    <li>Pregnancy Related Illness
                    <li>Infectious Disease
                  </ol>
                  <br><br>
                  All the rows below the headings (except the last row) contain the percentage of the number of deceased patients in each of the 15 comorbidities clusters for each district. The last row represents the percentage of deceased patients in each of the 15 comorbidities clusters in all of Karnataka.
                  </p>
                </div>  
              </li>

              <li>
              <input type="checkbox" id="dropdown21">
                <label for="dropdown21" class="dropdown-link">Karnataka Comorbidities Cluster Histogram</label>
                <div class="hidden-content">

                  <div class="col-md-12">
                    <div id="graphCanvas">
                      <!-- Graph will be displayed here -->
                      <?php generateImageHolder("ComorbiditiesCluster","Karnataka_Comorbidities_Clusters.png","Karnataka_Comorbidities_Clusters.html","comorbiditiesCluster.R",2,[35],580,1100)?>
                    </div>
                  </div>

                  <p>The above bar graph represents the 15 comorbidities clusters vs. the percentage of deceased patients in each of the comorbidities clusters for all of Karnataka in total. As we can see, the percentage of deceased patients in the comorbidities clusters of Diabetes and Obesity and Heart Disease, far exceed those in each of the other comorbidities clusters. After clicking on the graph, hovering on the bars in the graph reveals the percentage of deceased patients in the given comorbidities cluster. For comorbidities clusters other than those related to Heart Disease, Diabetes and Obesity and Kidney Diseases, the bars are very short and hence hovering on them might not reveal the percentage of deceased patients. In such a case, please zoom on the graph to make visible the percentage of deceased patients in clusters with shorter bars while hovering on them.
                  </p>
                  
                </div>
              </li>

            </ul>
            <hr>
          </p>
        </div>

      </div>
    </div>

    

</div>
<?php include 'footer.html'; ?>



  <!-- Bootstrap JS, Popper.js, and jQuery -->
  <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.3/dist/umd/popper.min.js"></script>
  <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
  <script>
    document.addEventListener('DOMContentLoaded', function() {
      const listItems = document.querySelectorAll('.list-item');
      listItems.forEach(function(item) {
        item.addEventListener('click', function() {
          const targetId = this.getAttribute('data-target');
          const targetContent = document.getElementById(targetId);
          targetContent.classList.toggle('active');
        });
      });
    });
  </script>

</body>
</html>
