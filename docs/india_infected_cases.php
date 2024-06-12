<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Infected Cases</title>
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
          <h2>Infected Cases in India</h2>
          <p>It provides a comprehensive overview of the total COVID-19 infections in the country, 
            featuring two distinct plots. The first type of plot showcases the total number of infected cases 
            in India over time and the second type of plot presents the same data but with a logarithmic scale on the y-axis, 
             offering a different perspective by compressing large numerical ranges and emphasizing changes in 
             growth rates. Together, these plots serve as invaluable tools for understanding the magnitude and 
             progression of the COVID-19 outbreak in India.
          </p>
          <!-- Add your charts or data visualization here -->
        </div>
      </div>
    </div>
    



    <div class="container mt-5">
    <div class="row">
        <!-- Column for sections -->
        
            <div class="col-md-6 icu-timeline">
                <h3>Total Infected Cases in India</h3>
                <p>The plot showcases the cumulative count of COVID-19 infections across India over time. With dates along the x-axis marking the progression of time, and the y-axis denoting the total number of infected cases, this visualization offers a comprehensive view of the pandemic's spread throughout the country. </p>
            </div>
    
         <!-- Column for graph -->
            <div class="col-md-6">
            <div id="graphCanvas">
                <!-- Graph will be displayed here -->
                <?php 
                generateImageHolder("india_infected_cases","india_infected.gif","india_infected.gif","india_infected_cases.R",1,[1,6],400,650)?>
            </div>
            </div>
        </div>
        
    </div>

    <div class="container mt-5">
    <div class="row">
        <!-- Column for sections -->
        
            <div class="col-md-6 icu-timeline">
                <h3>Log Scale - Total Infected Cases in India</h3>
                <p>This plot presents a logarithmic representation of the cumulative COVID-19 cases in India over time. On the x-axis, dates are marked to denote the progression of the pandemic, while the y-axis displays the number of infected cases on a logarithmic scale. This transformation allows for a clearer visualization of the growth trajectory of the pandemic, especially during periods of exponential increase. By compressing the scale for larger values, the plot aids in discerning patterns and trends in the spread of the virus that may not be as evident on a linear scale.</p>
            </div>
    
         <!-- Column for graph -->
            <div class="col-md-6">
            <div id="graphCanvas">
                <!-- Graph will be displayed here -->
                <?php  
                      generateImageHolder("india_infected_cases","allindia-log.svg","allindia-log.html","india_infected_cases_log_scale.R",1,[1],400,650)
                ?>
            </div>
            </div>
        </div>
        
    </div>
  <br>
  <br>
  <br>
  
   <div class="container mt-5">
      <div class="row">
        <!-- Column for sections -->
        
      <div class="col-md-12 icu-timeline">
        <h3>Total Infected Cases for States in India</h3>
        <p>
The plot showcases the cumulative number of COVID-19 cases across different states of India over time. This plot enables viewers to compare the severity of the outbreak in different regions and track the progression of infections over time.
Click <a href="india_infected_cases_plots.php" target="_blank">here</a> to see the graphs for each state.
        </p>
      </div>
      </div>
  </div>

  <div class="container mt-5">
      <div class="row">
        <!-- Column for sections -->
        
      <div class="col-md-12 icu-timeline">
        <h3>Log Scale - Total Infected Cases for States in India</h3>
        <p>The plot utilizes a logarithmic scale to illustrate the cumulative number of COVID-19 cases across various states in India over time.
        Click <a href="india_infected_cases_log_plots.php" target="_blank">here</a> to see the graphs for each state.
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
