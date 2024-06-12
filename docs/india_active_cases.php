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
          <h2>Active Cases in India</h2>
          <p>Total active COVID-19 cases for all over india and each states are plotted. Along with the active cases, increase in cases and daily new cases 
            are considered.
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
                <p>The plot illustrates the trend of active COVID-19 cases over time. The x-axis represents the dates, providing a chronological timeline, while the y-axis indicates the number of active cases. This plot allows viewers to observe how the number of active COVID-19 cases has fluctuated during the pandemic, highlighting periods of surge and decline. It serves as a valuable tool for understanding the dynamic nature of the outbreak in India.
                </p>
            </div>
    
         <!-- Column for graph -->
            <div class="col-md-6">
            <div id="graphCanvas">
                <!-- Graph will be displayed here -->
                <?php generateImageHolder("india_active_cases","india_active_cases.gif","india_active_cases.gif","india_active_cases.R",1,[1],400,650)?>
            </div>
            </div>
        </div>
        
    </div>
  <div class="container mt-5">
    <div class="row">
        <!-- Column for sections -->
        
            <div class="col-md-6 icu-timeline">
                <h3>State wise Active Cases in India</h3>
                <p>The plot presents a comparative view of the active COVID-19 cases across different states. The x-axis lists the states of India, while the y-axis shows the number of active cases in each state. This visualization helps in identifying which states are experiencing higher or lower levels of active COVID-19 cases at a given time. By providing a clear snapshot of the distribution of active cases, this plot aids in understanding regional disparities in the impact of the pandemic and assists in resource allocation and targeted intervention strategies.</p>
            </div>
    
         <!-- Column for graph -->
            <div class="col-md-6">
            <div id="graphCanvas">
                <!-- Graph will be displayed here -->
                <?php generateImageHolder("india_active_cases","india_active_cases_statewise.gif","india_active_cases_statewise.gif","india_statewise_active_cases.R",1,[1],400,650)?>
            </div>
            </div>
      </div>
        
    </div>
    <div class="container mt-5">
      <div class="row">
        <!-- Column for sections -->
        
      <div class="col-md-12 icu-timeline">
        <h3>Total Active Cases for States in India</h3>
        <p>The plots present the progression of active COVID-19 cases across various states over time. The x-axis marks the dates, showing the timeline of the pandemic, while the y-axis displays the number of active cases. This plot provides a comparative view of how different states have experienced and managed the spread of COVID-19.
        Click <a href="india_active_cases_plots.php" target="_blank">here</a> to see the graphs for all states.
        </p>
      </div>
      </div>
  </div>

    <div class="container mt-5">
    <div class="row">
        <!-- Column for sections -->
        
            <div class="col-md-6 icu-timeline">
                <h3>Increase in Cases for States in India</h3>
                <p>The "Increase in Cases for States in India" plot showcases the daily or periodic rise in COVID-19 cases across different states in India. The x-axis represents the dates, offering a temporal perspective, while the y-axis depicts the number of new cases reported. To see plots without total increased cases in india, click here:<a href="../Images/india_active_cases/india_increase_in_cases_stateswise_wt.gif" target="_blank">gif</a> and <a href="../Images/india_active_cases/india_increase_in_cases_stateswise_wt.html" target="_blank">html</a>.</p>  
              </p>
            </div>
    
         <!-- Column for graph -->
            <div class="col-md-6">
            <div id="graphCanvas">
                <!-- Graph will be displayed here -->
                <?php generateImageHolder("india_active_cases","india_increase_in_cases_stateswise.gif","india_increase_in_cases_stateswise.html","india_statewise_increased_cases.R",1,[1],400,650)?>
            </div>
            </div>  
      </div>
        
    </div>

    <div class="container mt-5">
    <div class="row">
        <!-- Column for sections -->
        
            <div class="col-md-6 icu-timeline">
                <h3>Daily New Cases</h3>
                <p>
The plot showcases the number of new COVID-19 cases reported each day over a specified period. The x-axis represents the dates, providing a sequential timeline, while the y-axis indicates the number of new cases. This plot is crucial for understanding the day-to-day changes in the spread of the virus, identifying trends, and pinpointing spikes in infection rates. By examining this data, one can gauge the impact of public health measures, detect emerging hotspots, and make informed decisions regarding the management and mitigation of the pandemic.</p>
            </div>
    
         <!-- Column for graph -->
            <div class="col-md-6">
            <div id="graphCanvas">
                <!-- Graph will be displayed here -->
                <?php generateImageHolder("india_daily_new_cases","india_daily_new.gif","india_daily_new.gif","india_dailynew_cases.R",1,[1],400,650)?>
            </div>
            </div>
        </div>
        
    </div>

    <div class="container mt-5">
    <div class="row">
        <!-- Column for sections -->
        
            <div class="col-md-6 icu-timeline">
                <h3>Daily Increase in Cases</h3>
                <p>The "Daily Increase in Cases" plot depicts the daily changes in the number of COVID-19 cases across India. The x-axis represents the dates, offering a day-by-day account, while the y-axis shows the number of new cases reported each day. </p>
            </div>
            
         <!-- Column for graph -->
            <div class="col-md-6">
            <div id="graphCanvas">
                <!-- Graph will be displayed here -->
                <?php generateImageHolder("india_daily_increase_cases","der-timeline.png","der-timeline.html","india_dailynew_cases2.R",1,[1],400,650)?>
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
