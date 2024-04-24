<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Predictions</title>
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
          <h2>Predictions</h2>
          <p>We use SIR based models to predict the infection counts for districts of Karnataka for the next week.</p>
          <p>Please click here for: <a href = "Documents/Prediction Models Report.pdf"> PDF Format </a> | <a href = "" > Slide Presentation </a> | <a href = "Documents/Prediction.csv"> Data in CSV </a> </p>
          <!-- Add your charts or data visualization here -->
        </div>
      </div>
    </div>
    
    <div class="container mt-5">
      <div class="row">
          <!-- Column for sections -->
          <div class="col-md-6">
              <u><h3>Predictions for Various Models</h3></u>
              <div class="list-group" style="padding: 20px;">
                  <a href="linear_predictions.php" class="list-group-item list-group-item-action">Weekly-Linear Scale</a>
                  <a href="error.php" class="list-group-item list-group-item-action">Error-Band</a>
                  <!-- Add more sections as needed -->
              </div>
          </div>
          <!-- Column for graph -->
          <div class="col-md-6">
              <div id="graphCanvas">
                  <!-- Graph will be displayed here -->
                  <?php generateImageHolder("India_active_cases_statewise","india_active_cases.gif","india_active_cases.gif","rcode.R","test.csv",450,650)?>
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
