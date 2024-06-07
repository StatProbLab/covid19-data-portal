<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Active Cases</title>
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
          <h2>Active Cases in Karnataka</h2>
          <p>Total active COVID-19 cases for all over Karnataka and each districts are plotted. Along with the active cases, increase in cases and daily new cases are considered.</p>
          <!-- Add your charts or data visualization here -->
        </div>
      </div>
    </div>
    
   
    <div class="container mt-5">
    <div class="row">
        <!-- Column for sections -->
        
            <div class="col-md-6 icu-timeline">
                <h3>Total Active Cases in Karnataka</h3>
                <p>The plot illustrates the trend of active COVID-19 cases over time. The x-axis represents the dates, 
                  providing a chronological timeline, while the y-axis indicates the number of active cases. This plot 
                  allows viewers to observe how the number of active COVID-19 cases has fluctuated during the pandemic, 
                  highlighting periods of surge and decline. It serves as a valuable tool for understanding the dynamic 
                  nature of the outbreak in Karnataka.</p>
            </div>
    
         <!-- Column for graph -->
            <div class="col-md-6">
            <div id="graphCanvas">
                <!-- Graph will be displayed here -->
                <?php generateImageHolder("ka_active_cases","karnataka_active_cases.gif","karnatka_active_cases.gif","ka_active_cases.R",2,[1],400,650)?>
            </div>
            </div>
        </div>
        
    </div>
    <div class="container mt-5">
      <div class="row">
        <!-- Column for sections -->
        
      <div class="col-md-12 icu-timeline">
        <h3>District wise Active Cases in Karnataka</h3>
        <p>The plots present the progression of active COVID-19 cases across various districts over time. The x-axis 
          marks the dates, showing the timeline of the pandemic, while the y-axis displays the number of active cases. This plot provides a comparative view of how different states have experienced and managed the spread of COVID-19. 
          Click <a href="ka_active_cases_plots.php" target="_blank">here</a> to see the graphs for all districts.
          
        </p>
      </div>
      </div>
  </div>

   
    <div class="container mt-5">
    <div class="row">
        <!-- Column for sections -->
        
            <div class="col-md-6 icu-timeline">
                <h3>Increase in Cases for Districts in Karnataka</h3>
                <p>The plot showcases the daily or periodic rise in COVID-19 cases across different districts in Karnataka. The x-axis represents the dates, offering a temporal perspective, while the y-axis depicts the number of new cases reported. To see plots without total increased cases in Karnataka, If you want to see the graph without total cases click here: <a href="../Images/ka_active_cases/ka_increase_in_cases_districtwise_wt.gif" target="_blank">gif</a> and <a href="../Images/ka_active_cases/ka_increase_in_cases_districtwise_wt.gif" target="_blank">html</a>.</p>
            </div>
    
         <!-- Column for graph -->
            <div class="col-md-6">
            <div id="graphCanvas">
                <!-- Graph will be displayed here -->
                <?php generateImageHolder("ka_active_cases","ka_increase_in_cases_districtwise.gif","ka_increase_in_cases_districtwise.html","ka_districtwise_increased_cases.R",2,[1],400,650)?>
            </div>
            </div>
        </div>
        
    </div>

    
    <div class="container mt-5">
    <div class="row">
        <!-- Column for sections -->
        
            <div class="col-md-6 icu-timeline">
                <h3>Daily New Cases</h3>
                <p>The plot showcases the number of new COVID-19 cases reported each day over a specified period. The x-axis represents the dates, providing a sequential timeline, while the y-axis indicates the number of new cases. This plot is crucial for understanding the day-to-day changes in the spread of the virus, identifying trends, and pinpointing spikes in infection rates. By examining this data, one can gauge the impact of public health measures, detect emerging hotspots, and make informed decisions regarding the management and mitigation of the pandemic.</p>
            </div>
    
         <!-- Column for graph -->
            <div class="col-md-6">
            <div id="graphCanvas">
                <!-- Graph will be displayed here -->
                <?php generateImageHolder("ka_daily_new_cases","ka_daily_new.gif","ka_daily_new.gif","ka_dailynew_cases.R",2,[1],400,650)?>
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
