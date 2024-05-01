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
          <h2>Infection Doubling Time in India</h2>
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
        
            <div class="col-md-6 icu-timeline">
                <h3>All India Timeline</h3>
                <p>In the above graph the orange line is the number of total tests done daily and the red line is the number of tests found positive daily.
                </p>
            </div>
    
         <!-- Column for graph -->
            <div class="col-md-6">
            <div id="graphCanvas">
                <!-- Graph will be displayed here -->
                <!-- <iframe src="../Images/india_db_time/allindia-dt.html" frameborder="0" height="400px" width=650px></iframe> -->
                <?php generateImageHolder("india_db_time","allindia-timeline.png","allindia-timeline.html","allindia_infected_growth_timeline_logscale.R",1,[1],400,650)?>
            </div>
            </div>
        </div>
        
    </div>




    <div class="container mt-5">
    <div class="row">
        <!-- Column for sections -->
        
            <div class="col-md-6 icu-timeline">
                <h3>All India Doubling Time</h3>
                <p>In the above graph the orange line is the number of total tests done daily and the red line is the number of tests found positive daily.
                </p>
            </div>
    
         <!-- Column for graph -->
            <div class="col-md-6">
            <div id="graphCanvas">
                <!-- Graph will be displayed here -->
                <!-- <iframe src="../Images/india_db_time/allindia-dt.html" frameborder="0" height="400px" width=650px></iframe> -->
                <?php generateImageHolder("india_db_time","allindia-dt.png","allindia-dt.html","india_doubling_time.R",1,[1],400,650)?>
            </div>
            </div>
        </div>
        
    </div>

        
    </div>
    <div class="container mt-5">
      <div class="row">
        <!-- Column for sections -->
        
      <div class="col-md-12 icu-timeline">
        <h3>Doubling Time - States of India</h3>
        <p>In Karnataka, the utilization of Intensive Care Units (ICUs) within the district healthcare system has evolved through 
          a dynamic timeline, reflecting a complex interplay of factors. From urban hubs to rural areas, each district presents its
           unique challenges and requirements in managing critical care services. Over the years, ICU utilization has shown fluctuations,
            influenced by diverse variables such as population density, healthcare infrastructure, and the prevalence of diseases. Seasonal patterns, 
          sudden spikes due to emergencies or epidemics, and gradual increases in demand characterize this timeline.
          <a href="india_dbtimes_plots.php" target="_blank">Click here to see the graphs for all districts.</a>
        </p>
      </div>
      </div>

      <div class="container mt-5">
    <div class="row">
        <!-- Column for sections -->
        
            <div class="col-md-6 icu-timeline">
                <h3>Maharashtra Doubling Time</h3>
                <p>In the above graph the orange line is the number of total tests done daily and the red line is the number of tests found positive daily.
                </p>
            </div>
    
         <!-- Column for graph -->
            <div class="col-md-6">
            <div id="graphCanvas">
                <!-- Graph will be displayed here -->
                <iframe src="../Images/india_db_time/20-dl.html" frameborder="0" height="400px" width=650px></iframe>
                <!-- <?php generateImageHolder("india_db_time","20-dl.png","allindia-dt.html","rcode.R",1,[1],400,650)?> -->
            </div>
            </div>
        </div>
        
    </div>
      
    <div class="container mt-5">
    <div class="row">
        <!-- Column for sections -->
        
            <div class="col-md-6 icu-timeline">
                <h3>Kerala Doubling Time</h3>
                <p>In the above graph the orange line is the number of total tests done daily and the red line is the number of tests found positive daily.
                </p>
            </div>
    
         <!-- Column for graph -->
            <div class="col-md-6">
            <div id="graphCanvas">
                <!-- Graph will be displayed here -->
                <iframe src="../Images/india_db_time/17-dl.html" frameborder="0" height="400px" width=650px></iframe>
                <!-- <?php generateImageHolder("india_db_time","allindia-dt.png","allindia-dt.html","rcode.R",1,[1],400,650)?> -->
            </div>
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
</body>
</html>
