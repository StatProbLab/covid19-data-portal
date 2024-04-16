<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Karnataka Statistics</title>
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
          <h2>Karnataka Statistics</h2>
          <p>District-wise Analysis on Active Cases, Reproduction Rate, Vaccination, and Early Warning System</p>
          <!-- Add your charts or data visualization here -->
        </div>
      </div>
    </div>
    
    <div class="container mt-5">
      <div class="row">
          <!-- Column for sections -->
          <div class="col-md-6">
              
              <div class="list-group" style="padding: 20px;">
                  <a href="ka_active_cases.php" class="list-group-item list-group-item-action">Active Cases</a>
                  <a href="ka_infected_cases.php" class="list-group-item list-group-item-action">Infected Cases</a>
                  <a href="ka_deceased_data.php" class="list-group-item list-group-item-action">Deceased Data</a>
                  <a href="ka_rt.php" class="list-group-item list-group-item-action">Reproduction Rate R<sub>t</sub></a>
                  <a href="ka_cluster_tlinf.php" class="list-group-item list-group-item-action">Cluster Timeline and Information</a>
                  <a href="ka_vac.php" class="list-group-item list-group-item-action">Vaccination Coverage</a>
                  <!-- Add more sections as needed -->
              </div>
          </div>
          <!-- Column for graph -->
          <div class="col-md-6">
          
              <div class="list-group" style="padding: 20px;">
                  
                  <a href="ka_hosp_req.php" class="list-group-item list-group-item-action">Hospitalization Requirements</a>
                  <a href="ka_tracehist.php" class="list-group-item list-group-item-action">Trace History</a>
                  <a href="ka_ews.php" class="list-group-item list-group-item-action">Early Warning Systems</a>
                  <a href="ka_doubling_time.php" class="list-group-item list-group-item-action">Doubling Time</a>
                  <a href="ka_foe_growth.php" class="list-group-item list-group-item-action">Fall of Exponential</a>
                  <!-- Add more sections as needed -->
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
