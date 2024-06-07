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
          <p>Mathematical models used to characterize early epidemic growth feature an exponential curve. 
            This phase of exponential growth can be characterized by the doubling time. Doubling time is the time it takes for the number of infections to double. Our study here has been inspired by the study of <a href="https://deepayan.github.io/covid-19/doubling">Doubing times of COVID-19 cases worldwide by Deepayan Sarkar</a>.
</p>
          <!-- Add your charts or data visualization here -->
        </div>
      </div>
    </div>
    
   

    

        
    
    <div class="container mt-5">
      <div class="row">
        <!-- Column for sections -->
        
      <div class="col-md-12 icu-timeline">
        <h3>Doubling Time for Districts in Karnataka</h3>
        <p>We presents an analysis of the doubling time for COVID-19 cases across various districts during different phases of the lockdown. On the x-axis, dates are plotted to showcase the progression of time, while the y-axis represents the doubling time for each district. Doubling time is a critical metric in understanding the rate of growth or decline of infections, indicating how long it takes for the number of cases to double. By segmenting the data into different phases of the lockdown, this plot provides insights into how the effectiveness of containment measures influenced the spread of the virus in different regions over time. It helps in assessing the impact of lockdown policies on controlling the outbreak and identifying areas that may require targeted interventions or support.
        Click <a href="ka_dbtimes_plots.php" target="_blank">here</a> to see the graphs for all districts.
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
