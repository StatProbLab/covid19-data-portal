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
        <div class="col-md-16 mx-auto text-center jumbotron bg-info text-white">
          <h2>Predictions: Error Bands for IISC-ISI FIT 1 and 2</h2>
          <p>Dive deeper into the uncertainty surrounding COVID-19 predictions for Karnataka's districts with our error 
            band graphs. These visualizations provide valuable insights into the range of possible infection rates over 
            time, depicted alongside the predicted values. By incorporating error bands derived from diverse modeling 
            approaches, including INDSCI-SIM, IISC-ISI, SAIR, and CSIR, our graphs offer a comprehensive understanding 
            of the potential variability in projected outcomes.</p>
          
          <p><b>Each graph is interactive, revealing interactive features when clicked. Hovering over the graphs 
            displays annotations with detailed information.</b></p>
          <!-- Add your charts or data visualization here -->
        </div>
      </div>
    </div>


    <div class="container mt-5 mx-auto" style="width: fit-content;">
      <div class="row">
          <!-- Column for sections -->
          <div class="col-md-14" style="margin: 0 auto; text-align: center;">
              <u><h3>Predictions for Various Models</h3></u>
              <div class="list-group" style="padding: 20px;">
                  <a href="linear_predictions.php" class="list-group-item list-group-item-action">Weekly-Linear Scale</a>
                  <a href="error.php" class="list-group-item list-group-item-action">Error-Band</a>
                  <!-- Add more sections as needed -->
                  <br><br><br>
              </div>
          </div>
      </div>
  
    </div>
    

    <!-- Image holders -->
    <div class="row">
        <?php
        // Generate image holders
        for ($i = 1; $i <= 30; $i++) {
            // Check if it's the first image holder of the row
            if (($i - 1) % 2 == 0) {
                echo '</div><div class="row">'; // Close the previous row and start a new one
            }
            echo '<div class="col-md-6">';
            generateImageHolder("Prediction_Error","$i-errband.svg", "$i-errband.html","rcode$i.R",1,[1],400,500);
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
