<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Pan India Statistics</title>
  <!-- Bootstrap CSS -->
  <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
  <!-- Font Awesome CSS for icons -->
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" rel="stylesheet">
  <!-- Custom CSS -->
  <link rel="stylesheet" href="../CSS/navbar.css">
  <link rel="stylesheet" href="../CSS/pan_india_statistics.css">
</head>
<body>
  <?php include 'image_holder.php'; ?>
  <?php include 'navbar.html'; ?>
  <div class="container">
    <div class="container mt-5">
      <div class="row">
        <div class="col-md-8 mx-auto text-center jumbotron bg-info text-white">
          <h2>Pan India Statistics</h2>
          <p>State-wise Analysis on Active Cases, Reproduction Rate, Vaccination, and Early Warning System</p>
          <!-- Add your charts or data visualization here -->
        </div>
      </div>
    </div>
    
    <div class="container mt-5">
      <div class="row">
          <!-- Column for sections -->
          <div class="col-md-6">
              <u><h3>Summary Statistics</h3></u>
              <div class="list-group" style="padding: 20px;">
                  <a href="india_active_cases.php" class="list-group-item list-group-item-action">Active Cases</a>
                  <a href="india_infected_cases.php" class="list-group-item list-group-item-action">Infected Cases</a>
                  <a href="india_daily_new_cases.php" class="list-group-item list-group-item-action">Daily New Cases</a>
                  <a href="india_deceased_data.php" class="list-group-item list-group-item-action">Deceased Data</a>
                  <a href="india_rt.php" class="list-group-item list-group-item-action">Reproduction Rate R<sub>t</sub></a>
                  <a href="india_ews.php" class="list-group-item list-group-item-action">Early Warning Systems</a>
                  <!-- Add more sections as needed -->
              </div>
          </div>
          <!-- Column for graph -->
          <div class="col-md-6">
              <div id="graphCanvas">
                  <!-- Graph will be displayed here -->
                  <?php generateImageHolder("india_active_cases","india_active_cases.gif","india_active_cases.gif","rcode.R","test.csv",450,650)?>
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
