<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>India Statistics</title>
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
          <h2>EWS</h2>
          <p>Early Warning System for India and Karnataka</p>
          <!-- Add your charts or data visualization here -->
        </div>
      </div>
    </div>
    
    <div class="container mt-5">
      <div class="row">
          <!-- Column for sections -->
          <div class="col-md-6">
              <div class="list-group" style="padding: 20px;">
                  <a href="ews_definition.php" class="list-group-item list-group-item-action">Definition</a>
                  <a href="ews_india.php" class="list-group-item list-group-item-action">EWS for India</a>
                  <a href="ews_karnataka.php" class="list-group-item list-group-item-action">EWS for Karnataka</a>
              </div>
          </div>
          <!-- Column for graph -->
          <div class="col-md-6">
            <div id="graphCanvas">
                <!-- Graph will be displayed here -->
                <?php generateImageHolder("ews","1-India_lamda_t_plots.png","1-India_lamda_t_plots.html","ka_districtwise_increased_cases.R",2,[1],400,650)?>
            </div>
            </div>
      </div>
  
    </div>
  </div>
  <br>
  <br>
  <br>
  <br>
  <br>
  <?php include 'footer.html'; ?>



  <!-- Bootstrap JS, Popper.js, and jQuery -->
  <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.3/dist/umd/popper.min.js"></script>
  <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
