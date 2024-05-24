<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Hospitalization Requirements</title>
  <!-- Bootstrap CSS -->
  <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
  <!-- Font Awesome CSS for icons -->
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" rel="stylesheet">
  <!-- Custom CSS -->
  <link rel="stylesheet" href="../CSS/navbar.css">
  <link rel="stylesheet" href="../CSS/ka_hosp_req.css">
  
</head>
<body>
  <?php include 'image_holder.php'; ?>
  <?php include 'navbar.html'; ?>
<div class="container">

    <div class="container mt-5">
      <div class="row ">
        <div class="col-md-8 mx-auto text-center jumbotron bg-info text-white">
          <h2>Hospitalization Requirements</h2>
          <p>During the spread of an infection as contagious as COVID-19, it is imperative for the state to understand the capacity of Hospital beds, ICU beds, ICU Oxygen/Ventilators required. This will reduce a patient's
            waiting time for treatment and also maximize health care response.</p>
          <!-- Add your charts or data visualization here -->
        </div>
      </div>
    </div>

    <div class="container mt-5">
      <div class="row">
        <!-- Column for sections -->
        
      <div class="col-md-6 icu-timeline">
        <h3>Total Tests Done</h3>
        <p>It is widely believed a strong testing regimen is the best indicator of infection spread.
<br><br>
        The above graph is a continuous analog of a stacked bar chart. It is used here to show the composition of the testing done in Karnataka. The growth in area of red colour over time represents the total number of positive tests till that day, green colour over time represents the total number of negative tests till that day and finally the blue color represents the total number of tests whose results are awaited till that day.
<br><br>
From 17-July onwards, the Media Bulletins contained information on the number of Rapid Antigen tests and RTPCR & other methods. Different tests are used for different types of patients and may have different test positive fractions. We consider all the tests cumulatively done, including the Rapid Antigen Tests.
        </p>
      </div>
    
        <!-- Column for graph -->
        <div class="col-md-6">
          <div id="graphCanvas">
            <!-- Graph will be displayed here -->
            <?php generateImageHolder("ka_infocus","sample-test.svg","sample-test.html","ka_testingtimeline.R",2,[19],450,700)?>
          </div>
        </div>
      </div>
    </div> 
    
    <div class="container mt-5">
      <div class="row">
        <!-- Column for sections -->
        
      <div class="col-md-6 icu-timeline">
        <h3>Total Test Samples Collected</h3>
        <p>In this graph we plot the total number of tests done on a daily basis since March 2020 in the state.
          <br><br>
          There were two typographical errors in the Media Bulletins. On 17th March, 2020 the number of positive tests was incorrectly mentioned as 1 even though the cumulative count had gone up by 4. This we have rectified in the above. On 25th March there was a discrepancy in the cumulative and daily counts for negative samples. 25th March onwards, we have considered the daily counts instead of the cumulative counts of negative samples in the Media Bulletins.
        </p>
      </div>
    
        <!-- Column for graph -->
        <div class="col-md-6">
          <div id="graphCanvas">
            <!-- Graph will be displayed here -->
            <?php generateImageHolder("ka_hospitalization_requirements","total_Sample.png","total_Sample.html","rcode.R",1,[1],450,700)?>
          </div>
        </div>
      </div>
    </div> 

    <div class="container mt-5">
      <div class="row">
        <!-- Column for sections -->
        
      <div class="col-md-6 icu-timeline">
        <h3>Daily Positive Rate</h3>
        <p>The percentage of positive tests is an indication of the prevalence of the infection in the population. Below we have plotted, the test positive rate on a daily basis.
        </p>
      </div>
    
        <!-- Column for graph -->
        <div class="col-md-6">
          <div id="graphCanvas">
            <!-- Graph will be displayed here -->
            <?php generateImageHolder("ka_hospitalization_requirements","ratio_positive.png","ratio_positive.html","rcode.R",1,[1],450,700)?>
          </div>
        </div>
      </div>
    </div> 



    <!-- <div class="fancy-heading">
      <img src="../Images/ka_hospitalization_requirements/icu.jpg" alt="Profile Picture">
      <h3>Testing Data</h3>
    </div> -->
    <div class="container mt-5">
    <div class="row">
        <!-- Column for sections -->
        
            <div class="col-md-6 icu-timeline">
                <h3>Tests Done Daily</h3>
                <p>In the graph, the orange line is the number of total tests done daily and the red line is the number of tests found positive daily. The percentage of positive tests is an indication of the prevalence of the infection in the population. </p>
            </div>
    
         <!-- Column for graph -->
            <div class="col-md-6">
            <div id="graphCanvas">
                <!-- Graph will be displayed here -->
                <?php generateImageHolder("ka_hospitalization_requirements","lineplottest.svg","lineplottest.html","ka_testsdone_and_positive_cases.R",2,[18],400,650)?>
            </div>
            </div>
        </div>
    </div>
    <!-- <div class="fancy-heading">
      <img src="../Images/ka_hospitalization_requirements/rtpcr.jpg" alt="Profile Picture">
      <h3>ICU Timeline</h3>
    </div> -->
    
    <div class="container mt-5">
      <div class="row">
        <!-- Column for sections -->
        
      <div class="col-md-12 icu-timeline">
        <h3>ICU Utilization Timeline-Karnataka Districts</h3>
        <p>In Karnataka, the utilization of Intensive Care Units (ICUs) within the district healthcare system has evolved through 
          a dynamic timeline, reflecting a complex interplay of factors. From urban hubs to rural areas, each district presents its
           unique challenges and requirements in managing critical care services. Over the years, ICU utilization has shown fluctuations,
            influenced by diverse variables such as population density, healthcare infrastructure, and the prevalence of diseases. Seasonal patterns, 
          sudden spikes due to emergencies or epidemics, and gradual increases in demand characterize this timeline.
          Click <a href="ka_icu_utilization_timeline.php" target="_blank">here</a> to see the graphs for all districts.
        </p>
      </div>
      </div>
    </div>
    <div class="container mt-5">
      <div class="row">
        <!-- Column for sections -->
        
      <div class="col-md-6 icu-timeline">
        <h3>Days taken to require ICU</h3>
        <p>To further approximate the ICU bed requirements, we consider those patients who have required an ICU, and plot the number of days between their testing positive and being admitted to ICU. 
        </p>
      </div>
    
        <!-- Column for graph -->
        <div class="col-md-6">
          <div id="graphCanvas">
            <!-- Graph will be displayed here -->
            <?php generateImageHolder("ka_infocus","days-toICU.png","days-toICU.html","ka_days_require_before_ICU.R",2,[21],450,700)?>
          </div>
        </div>
      </div>
    </div>
    <div class="container mt-5">
      <div class="row">
        <!-- Column for sections -->
        
      <div class="col-md-6 icu-timeline">
        <h3>Days spent in ICU</h3>
        <p>We also plot the distribution of the days spent by the patients in ICU.
          <br>Both these plots have been frozen on 8th May as the Media Bulletins post 8th May provided consolidated numbers of patients in ICU.
        </p>
      </div>
    
        <!-- Column for graph -->
        <div class="col-md-6">
          <div id="graphCanvas">
            <!-- Graph will be displayed here -->
            <?php generateImageHolder("ka_infocus","days-inICU.png","days-inICU.html","ka_days_require_in_ICU.R",2,[21],450,700)?>
          </div>
        </div>
      </div>
    </div>
    <div class="container mt-5">
      <div class="row">
        <!-- Column for sections -->
        
      <div class="col-md-6 icu-timeline">
        <h3>Days to recover</h3>
        <p>To better approximate the hospital beds requirement, and get an idea of how long an infected person remains infectious, we plot the time taken for recovery for the patients in Karnataka alongside the time taken for the patient to succumb to the disease.
        <br><br>On the right, we have plotted a histogram of the number of days to recover for all discharged patients. The blue dotted line shows the mean of the recovery time of the patients. Note that the above graph contains information only on those patients whose recovery has been reported by the state. For a few days after 8th May, the recovery data was provided in a consolidated manner. This graph contains information on all the patients who have recovered, excluding the ones who have recovered on those days.
        </p>
      </div>
    
        <!-- Column for graph -->
        <div class="col-md-6">
          <div id="graphCanvas">
            <!-- Graph will be displayed here -->
            <?php generateImageHolder("ka_infocus","days-tocure.png","days-tocure.html","ka_days_to_Cure.R",2,[21],450,700)?>
          </div>
        </div>
      </div>
    </div>
    <div class="container mt-5">
      <div class="row">
        <!-- Column for sections -->
        
      <div class="col-md-6 icu-timeline">
        <h3>Days from tested Positive to succumbed to the disease</h3>
        <p>On the right, we plot the same for those who have succumbed to the disease. This distribution continues information on all those patients who have succumbed to the infection.
<br><br>
Further, it is seen in the graph on the right that a large fraction of patients who have succumbed to the disease have tested positive on the day they died. This is because the first column also includes those patients who passed away and later tested positive for COVID-19.</p>
      </div>
    
        <!-- Column for graph -->
        <div class="col-md-6">
          <div id="graphCanvas">
            <!-- Graph will be displayed here -->
            <?php generateImageHolder("ka_infocus","days-todie.png","days-todie.html","ka_days_to_Die.R",2,[21],450,700)?>
          </div>
        </div>
      </div>
    </div>
    <div class="container mt-5">
      <div class="row">
        <!-- Column for sections -->
        
      <div class="col-md-6 icu-timeline">
        <h3>Days from tested Positive to succumbed to the disease</h3>
        <p>For those patients who were in ICU before May 8th, below is a scatter plot of the days they were infected before requiring an ICU and the number of days they've spent in the ICU so far.
<br><br>        The y-axis represents the number of days between the patient's testing positive and requiring ICU. The y-axis has the days they spent in an ICU. Since this graph also contains information on those patients who are still in ICU, some of the points may move further left. The points are colored based on the patient's current condition i.e. if they're recovered, deceased, still in ICU or requiring hospitalization. Hovering on the points will give you information on the patient's age, sex, city of residence and the cluster of origin of the infection.
<br><br>
Note that this graphs has been frozen on 8th May. The colors represent the condition of those patients who were in ICU on 8th May.
        </p>
      </div>
    
        <!-- Column for graph -->
        <div class="col-md-6">
          <div id="graphCanvas">
            <!-- Graph will be displayed here -->
            <!-- <iframe src="../Images/ka_hospitalization_requirements/dticu-diicu.html" frameborder="0" height="450px" width="700px"></iframe> -->
            <?php generateImageHolder("ka_infocus","dticu-diicu.png","dticu-diicu.html","ka_scatterplot_days_require_in&to_ICU.R",2,[21,25],450,700)?>
          </div>
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
