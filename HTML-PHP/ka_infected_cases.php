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
          <h2>Infected Cases in Karnataka</h2>
          <p>We provide a comprehensive overview of the COVID-19 situation in the state through various plots. It includes a plot of infected cases displayed in both normal and logarithmic scales, allowing for an in-depth analysis of the growth pattern and rate of infection. Additionally, an area graph illustrates the distribution of active, recovered, and deceased cases over time within a single graph. This section is designed to give a clear and detailed understanding of the progression and current status of COVID-19 in Karnataka, highlighting the dynamics between active cases, recoveries, and fatalities.</p>
          <!-- Add your charts or data visualization here -->
        </div>
      </div>
    </div>
    
    <div class="container mt-5">
    <div class="row">
        <!-- Column for sections -->
        
            <div class="col-md-6 icu-timeline">
                <h3>Total Infected Cases in Karnataka</h3>
                <p>The plot showcases the cumulative count of COVID-19 infections across India over time. With dates along the x-axis marking the progression of time, and the y-axis denoting the total number of infected cases, this visualization offers a comprehensive view of the pandemic's spread throughout the state.</p>
            </div>
    
         <!-- Column for graph -->
            <div class="col-md-6">
            <div id="graphCanvas">
                <!-- Graph will be displayed here -->
                <?php generateImageHolder("ka_infected_cases","ka_infected.gif","ka_infected.gif","ka_infected_cases.R",2,[1],400,650)?>
            </div>
            </div>
        </div>
        
    </div>

    <div class="container mt-5">
    <div class="row">
        <!-- Column for sections -->
        
            <div class="col-md-6 icu-timeline">
                <h3>Total Infected Cases in Karnataka</h3>
                <p>The plot presented as an area graph, provides a comprehensive overview of COVID-19 cases across various categories over time. The x-axis delineates dates, offering a chronological perspective, while the y-axis captures the cumulative numbers of active, recovered, and deceased cases. This visualization encapsulates the trajectory of the pandemic in Karnataka, offering insights into the progression of active cases, recoveries, and unfortunate fatalities. The area graph format enables viewers to easily discern the relative proportions of each category and track changes in their distribution over time.</p>
            </div>
    
         <!-- Column for graph -->
            <div class="col-md-6">
            <div id="graphCanvas">
                <!-- Graph will be displayed here -->
                <?php generateImageHolder("ka_infected_cases","ka-all.svg","ka-all.html","karnataka_ird_cases.R",2,[20],400,650)?>
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
        <h3>Total Infected Cases for Districts in Karnataka</h3>
        <p>The plot showcases the cumulative number of COVID-19 cases across different districts in Karnataka over time. This plot enables viewers to compare the severity of the outbreak in different regions and track the progression of infections over time. Click <a href="ka_infected_cases_plots.php" target="_blank">here</a> to see the graphs for each district.
          
        </p>
      </div>
      </div>
  </div>
    <div class="container mt-5">
      <div class="row">
        <!-- Column for sections -->
        
      <div class="col-md-12 icu-timeline">
        <h3>Log scale - Total Infected Cases for Districts in Karnataka</h3>
        <p>The plot utilizes a logarithmic scale to illustrate the cumulative number of COVID-19 cases across various states in India over time. Click <a href="ka_infected_cases_log_plots.php" target="_blank">here</a> to see the graphs for each state.
          
        </p>
      </div>
      </div>
  </div>
  
  <div class="container mt-5">
    <div class="row">
        <!-- Column for sections -->
        
            <div class="col-md-6 icu-timeline">
                <h3>Age Distribution of COVID-19 Patients in Karnataka</h3>
                <p>It is important to understand how the virus affects different age groups in the population. 
                  Towards this we present a graph of the age distributions for the COVID-19 patients in Karnataka
                   with along with the distribution of the entire population of Karnataka [data taken from the 2011 census].
                   <br><br>
                   The filled in orange color indicates the distribution of the coronavirus patients in Karnataka and the navy 
                   outline represents the Age distribution of the entire population of Karnataka for reference. Out of all the cases, 
                   three have unknown ages. Medical practitioners may be interested in knowing how the virus is affecting the people 
                   across age groups, whether or not it is affecting different age groups differently.
                    <br><br>
                   It is seen that the distribution of the coronavirus patients has a higher fraction of the patients among the range of 
                   ages in 20-35 and not too many in the range 0-20, when compared to the demographic in Karnataka. A possible reason for
                    this might be that imported cases, i.e. due to travel abroad, were due to travel of working professionals. The state 
                    also took steps quite early on to lock down schools and universities to prevent the younger segment of the population to be affected.
                     Those in the age group of 0-15 are primary or secondary contacts of those who have some sort of travel history to COVID-19 affected
                    locations.
                </p>
            </div>
    
         <!-- Column for graph -->
            <div class="col-md-6">
            <div id="graphCanvas">
                <!-- Graph will be displayed here -->
                <?php generateImageHolder("ka_infocus","ageka-hist.png","ageka-hist.html","ka_agewise_distribution.R",2,[26],600,550)?>
            </div>
            </div>
        </div>
        
    </div>


    <div class="container mt-5">
    <div class="row">
        <!-- Column for sections -->
        
            <div class="col-md-6 icu-timeline">
                <h3>Distribution across Cities in Karnataka</h3>
                <p>We present observable timeline of the distribution of total number of infections in Karnataka across the cities.
                The graph, presented here is a continuous analog of a stacked bar chart. It is used here to show how the composition of the total Coronavirus cases in Karnataka varies across the different cities. The growth in area of each color over time represents the corresponding increase in the number of Coronavirus cases for that city.
                </p>
            </div>
    
         <!-- Column for graph -->
            <div class="col-md-6">
            <div id="graphCanvas">
                <!-- Graph will be displayed here -->
                <?php generateImageHolder("ka_infocus","ka-cities.png","ka-cities.html","ka_allcities_infected_cases.R",2,[25],400,650)?>
            </div>
            </div>
        </div>
        
    </div>

  
  
    <!-- Image holders -->
</div>
  <?php include 'footer.html'; ?>
  <!-- Bootstrap JS, Popper.js, and jQuery -->
  <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.3/dist/umd/popper.min.js"></script>
  <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
