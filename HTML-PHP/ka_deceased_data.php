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
            <?php generateImageHolder("deceased_data","kaAgePop.png","kaAgePop.html","rcode.R",1,[1],300,550)?>
          </div>
        </div>

        <div class="col-md-6">
          <div id="graphCanvas">
              <!-- Graph will be displayed here -->
              <?php generateImageHolder("deceased_data","kaAge.png","kaAge.html","rcode.R",1,[1],300,550)?>
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
                      <?php generateImageHolder("deceased_data","ageScatter.png","ageScatter.html","rcode.R",1,[1],580,1100)?>
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
                      <?php generateImageHolder("deceased_data","ageBoxPlot.png","ageBoxPlot.html","rcode.R",1,[1],580,1100)?>
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
              <?php generateImageHolder("DistrictWiseScatter","scat_death_rep.png","scat_death_rep.html","rcode.R",1,[1],300,550)?>
          </div>
        </div>

        <div class="col-md-6">
          <div id="graphCanvas">
              <!-- Graph will be displayed here -->
              <?php generateImageHolder("DistrictWiseScatter","scat_death_blr.png","scat_death_blr.html","rcode.R",1,[1],300,550)?>
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
                      <?php generateImageHolder("daysToDecease","box_decease.png","box_decease.html","rcode.R",1,[1],580,1100)?>
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
                      <?php generateImageHolder("agewise","age_ag_days_t.png","age_ag_days_t.html","rcode.R",1,[1],580,1100)?>
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
              <?php generateImageHolder("daysToReport","scat_death_rep.png","scat_death_rep.html","rcode.R",1,[1],300,550)?>
          </div>
        </div>

        <div class="col-md-6">
          <div id="graphCanvas">
              <!-- Graph will be displayed here -->
              <?php generateImageHolder("daysToReport","scat_death_rep_blr.png","scat_death_rep_blr.html","rcode.R",1,[1],300,550)?>
          </div>
        </div>
      
        <!-- Column for sections -->
        
        <div class="col-md-12">
          <p>The above histogram is right-skewed indicating early reporting of deaths by the district administration. The mean time is nearly 7 days.
            <ul>
              <li><a href =>Wave-Wise Days to Report</a>
              <li><a href =>Days to Report: Data Set</a> 
              <li><a href =>District-Wise Days to Report</a>
              <li><a href =>Age-Gender Days to Report</a>
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
              <?php generateImageHolder("deceased_data","hospitalizationhospitalisation_ratioKA.png","hospitalisation_ratioKA.html","rcode.R",1,[1],580,1100)?>
          </div>
        </div>
      
        <!-- Column for sections -->
        
        <div class="col-md-12">
          <p>We have marked a line at 95% hospitalisation ratio in the scatter plots or at the minimum monthly hospilisation ratio if it is higher. This line may be viewed as an ideal hospitalisation ratio. In comparison with days to decease one may arrive at a standard for clinical treatment.
            <ul>
              <li><a href =>Hospitalisation Ratio-Data Set</a>
              <li><a href =>District Wise Hospitalisation Ratio</a> 
            </ul>
            
            From the above we can see that the majority of deceased patients sought treatment at a hospital. A siginficant proportion still succumb without treatment at a medical having been brought dead or passing away at their residence.
            <br><br>
            <ul>
              <li><a href =>Bar-Plot of Place of Death</a>
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
              <?php generateImageHolder("DescriptionCluster","Descriptionclusters_vs_districts_A.png","DescCluster.html","rcode.R",1,[1],700,550)?>
          </div>
        </div>

        <div class="col-md-6">
          <div id="graphCanvas">
              <!-- Graph will be displayed here -->
              <?php generateImageHolder("DescriptionCluster","Descriptionclusters_vs_districts_A.png","descClust2.html","rcode.R",1,[1],700,550)?>
          </div>
        </div>
      
        <!-- Column for sections -->
        
        <div class="col-md-12">
          <p>
            <ul>
              <li><a href =>Description of Source of Illness: Classification Details</a>
              <li><a href =>Description of Source of Illness: Data Set</a> 
              <li><a href =>Karnataka Description Cluster Histogram</a>
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
              <?php generateImageHolder("SymptomCluster","Symptomclusters_vs_districts_A.png","Symptomclusters_vs_districts_A.html","rcode.R",1,[1],500,550)?>
          </div>
        </div>

        <div class="col-md-6">
          <div id="graphCanvas">
              <!-- Graph will be displayed here -->
              <?php generateImageHolder("SymptomCluster","Symptomclusters_vs_districts_B.png","Symptomclusters_vs_districts_B.html","rcode.R",1,[1],500,550)?>
          </div>
        </div>
      
        <!-- Column for sections -->
        
        <div class="col-md-12">
          <p>
            <ul>
              <li><a href =>Symptom Cluster: Classification Details</a>
              <li><a href =>Symptom Cluster: Data Set</a> 
              <li><a href =>Karnataka Symptom Cluster Histogram</a>
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
              <?php generateImageHolder("ComorbiditiesCluster","Comorbiditiesclusters_vs_districts_A.png","Comorbiditiesclusters_vs_districts_A.html","rcode.R",1,[1],500,550)?>
          </div>
        </div>

        <div class="col-md-6">
          <div id="graphCanvas">
              <!-- Graph will be displayed here -->
              <?php generateImageHolder("ComorbiditiesCluster","Comorbiditiesclusters_vs_districts_B.png","Comorbiditiesclusters_vs_districts_B.html","rcode.R",1,[1],500,550)?>
          </div>
        </div>
      
        <!-- Column for sections -->
        
        <div class="col-md-12">
          <p>
            <ul>
              <li><a href =>Comorbidities Cluster: Classification Details</a>
              <li><a href =>Comorbidities Cluster: Data Set</a> 
              <li><a href =>Karnataka Comorbidities Cluster Histogram</a>
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
