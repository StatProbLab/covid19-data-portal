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
          <h2>Deceased Data in India</h2>
          <p>This section presents a comprehensive analysis of mortality related to the pandemic within the country. It encompasses various plots and visualizations that shed light on different aspects of fatalities caused by COVID-19. The section typically includes plots such as "Total Deceased Cases Over Time" which illustrates the cumulative number of deaths recorded over the course of the pandemic, providing a longitudinal view of mortality trends. Additionally, plots like "Deceased by Infected Ratio" are featured, offering insights into the relationship between confirmed cases and fatalities, aiding in understanding the severity and fatality rate of the virus.</p>
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
                <p>
The "Deceased by Infected Ratio" plot depicts the ratio of deceased individuals to the total number of infected cases over time. On the x-axis, dates are plotted to show the progression of the COVID-19 pandemic, while the y-axis represents the calculated ratio. This plot offers insights into the severity of the virus's impact by tracking how the mortality rate relative to the infection rate evolves throughout the pandemic.</p>
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
                <h3>State wise Change in Deceased Ratio</h3>
                <p>The "Statewise Change in Deceased Ratio" plot depicts the variation in the deceased ratio across different states over time. On the x-axis, dates are represented to provide a temporal perspective, while the y-axis displays the deceased ratio, which is the proportion of confirmed COVID-19 cases that result in fatalities. This visualization enables viewers to track how the mortality rate has evolved in various states throughout the course of the pandemic.</p>
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
