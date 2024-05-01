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
  
</head>
<body>
  <?php include 'image_holder.php'; ?>
  <?php include 'navbar.html'; ?>
<div class="container">

    <div class="container mt-5">
      <div class="row ">
        <div class="col-md-8 mx-auto text-center jumbotron bg-info text-white">
          <h2>Deceased Data - India</h2>
          <p>During the spread of an infection as contagious as COVID-19, it is imperative for the state to understand the capacity of Hospital beds, ICU beds, ICU Oxygen/Ventilators required. This will reduce a patient's
            waiting time for treatment and also maximize health care response.</p>
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
                <p>The graph on the right hand side plots the case fatality rate for the duration of the pandemic.</p>
            </div>
    
         <!-- Column for graph -->
            <div class="col-md-6">
            <div id="graphCanvas">
                <!-- Graph will be displayed here -->
                <?php generateImageHolder("india_deceased_data","india_deceased_ratio.gif","india_deceased_ratio.gif","india_decbyinf.R",1,[1],400,650)?>
            </div>
            </div>
        </div>
        <div class="row">
        <!-- Column for sections -->
        
            <div class="col-md-6 icu-timeline">
                <h3>Statewise Change in Deceased Ratio</h3>
                <p>The percentage of positive tests is an indication of the prevalence of the infection in the population. Below we have plotted, the total number of positives tests upto that day over the culumative tests done upto that day.
                </p>
            </div>
    
         <!-- Column for graph -->
            <div class="col-md-6">
            <div id="graphCanvas">
                <!-- Graph will be displayed here -->
                <?php generateImageHolder("india_deceased_data","india_states_dr.png","india_states_dr.html","india_statewise_decbyinf.R.R",1,[1],500,700)?>
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
        
      <div class="col-md-6 icu-timeline">
        <h3>ICU Timeline</h3>
        <p>In an article published in the New England Journal of Medicine article Fair Allocation of Scarce Medical Resources in the Time of Covid-19 by Ezekiel J. Emanuel Et.all, the authors simulate possible hospitalisation requirements. In the article and otherwise it is widely accepted that the COVID-19 virus has the following distribution among the infected people:
          80% of infected will be asymptomatic or have mild symptoms, 6% will require health care but no hospitalization, 8% will require hospitalization and the final 6% will require ICU.
          <br>The patients in the ICU include those on Oxygen or on a Ventilator. They include a very small [less than 5%] percentage of the number of currently infected people. On hovering, one can see what percentage of the currently infected people that require an ICU.
          In Karnataka, everyone who is infected is being hospitalized regardless of whether they show symptoms or not, as it would ensure isolation. This isn't the case for countries like Netherlands where only those who require hospitalization are hospitalized.
        </p>
      </div>
    
        <!-- Column for graph -->
        <div class="col-md-6">
          <div id="graphCanvas">
            <!-- Graph will be displayed here -->
            <?php generateImageHolder("ka_hospitalization_requirements","ka-icu.png","ka-icu.html","rcode.R",1,[1],450,700)?>
          </div>
        </div>
      </div>
    </div>
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
          <a href="ka_icu_utilization_timeline.php">Click here to see the graphs for all districts.</a>
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
