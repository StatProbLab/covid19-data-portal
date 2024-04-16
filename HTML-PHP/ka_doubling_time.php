<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Doubling Time</title>
  <!-- Bootstrap CSS -->
  <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
  <!-- Font Awesome CSS for icons -->
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" rel="stylesheet">
  <!-- Custom CSS -->
  <link rel="stylesheet" href="../CSS/navbar.css">
  <link rel="stylesheet" href="../CSS/india_active_cases.css">
  
</head>
<body>
  <?php include 'image_holder.php'; ?>
  <?php include 'navbar.html'; ?>
  <div class="container">
   <div class="container mt-5">
      <div class="row">
        <div class="col-md-8 mx-auto text-center jumbotron bg-info text-white">
          <h2>Infection Doubling Time in Karnataka</h2>
          <p>Varying numbers of active COVID-19 cases across different states. X axes represents timeline and Y axes represents total number of active cases for each date. Hover on 
            the image to see the annotation options like wiew Plotly file, download the plot, see R or CSV file.
          </p>
          <!-- Add your charts or data visualization here -->
        </div>
      </div>
    </div>
    
   

    

        
    
    <div class="container mt-5">
      <div class="row">
        <!-- Column for sections -->
        
      <div class="col-md-12 icu-timeline">
        <h3>Doubling Time - districts of Karnataka</h3>
        <p>In Karnataka, the utilization of Intensive Care Units (ICUs) within the district healthcare system has evolved through 
          a dynamic timeline, reflecting a complex interplay of factors. From urban hubs to rural areas, each district presents its
           unique challenges and requirements in managing critical care services. Over the years, ICU utilization has shown fluctuations,
            influenced by diverse variables such as population density, healthcare infrastructure, and the prevalence of diseases. Seasonal patterns, 
          sudden spikes due to emergencies or epidemics, and gradual increases in demand characterize this timeline.
          <a href="ka_dbtimes_plots.php" target="_blank">Click here to see the graphs for all districts.</a>
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
</body>
</html>
