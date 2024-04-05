<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Statewide Active Cases</title>
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
          <h2>Active Cases in India - Statewise</h2>
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
                <h3>Total Active Cases in India</h3>
                <p>In the above graph the orange line is the number of total tests done daily and the red line is the number of tests found positive daily.
                </p>
            </div>
    
         <!-- Column for graph -->
            <div class="col-md-6">
            <div id="graphCanvas">
                <!-- Graph will be displayed here -->
                <?php generateImageHolder("india_active_cases","india_active_cases.gif","india_active_cases.gif","rcode.R","test.csv",400,650)?>
            </div>
            </div>
        </div>
        
    </div>
  <div class="container mt-5">
    <div class="row">
        <!-- Column for sections -->
        
            <div class="col-md-6 icu-timeline">
                <h3>Statewise Active Cases in India</h3>
                <p>In the above graph the orange line is the number of total tests done daily and the red line is the number of tests found positive daily.
                </p>
            </div>
    
         <!-- Column for graph -->
            <div class="col-md-6">
            <div id="graphCanvas">
                <!-- Graph will be displayed here -->
                <?php generateImageHolder("india_active_cases","india_active_cases_statewise.gif","india_active_cases_statewise.gif","rcode.R","test.csv",400,650)?>
            </div>
            </div>
      </div>
        
    </div>


    <div class="container mt-5">
    <div class="row">
        <!-- Column for sections -->
        
            <div class="col-md-6 icu-timeline">
                <h3>Statewise Increase in Cases</h3>
                <p>(With Total). In the above graph the orange line is the number of total tests done daily and the red line is the number of tests found positive daily.
                If you want to see the graph without total cases click here: <a href="../Images/india_active_cases/india_increase_in_cases_statewise_wt.gif" target="_blank">gif</a> and <a href="../Images/india_active_cases/india_increase_in_cases_statewise_wt.html" target="_blank">html</a></p>  
              </p>
            </div>
    
         <!-- Column for graph -->
            <div class="col-md-6">
            <div id="graphCanvas">
                <!-- Graph will be displayed here -->
                <?php generateImageHolder("india_active_cases","india_increase_in_cases_stateswise.gif","india_increase_in_cases_stateswise.html","rcode.R","test.csv",400,650)?>
            </div>
            </div>  
      </div>
        
    </div>


    
  <br>
  <br>
  <br>
  


    <!-- Image holders -->
    <div class="row">
        <?php
        // Generate image holders
        for ($i = 1; $i <= 37; $i++) {
            // Check if it's the first image holder of the row
            if (($i - 1) % 2 == 0) {
                echo '</div><div class="row">'; // Close the previous row and start a new one
            }
            echo '<div class="col-md-6">';
            generateImageHolder("india_active_cases","$i-india-active.svg", "$i-india-active.html","rcode$i.R", "csv$i.csv",400,500);
            echo '</div>';
        }
        ?>
    </div>
  </div>
  <?php include 'footer.html'; ?>
  <!-- Bootstrap JS, Popper.js, and jQuery -->
  <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.3/dist/umd/popper.min.js"></script>
  <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
