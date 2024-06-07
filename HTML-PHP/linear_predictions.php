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
          <h2>Predictions: Weekly against Linear Scale</h2>
          <p>Explore the weekly COVID-19 predictions for Karnataka's districts with our comprehensive graphs. These 
            visualizations showcase the forecasted infection rates over time, presented on a linear scale. Leveraging 
            six distinct models, including INDSCI-SIM, IISC-ISI, SAIR, and CSIR, our predictions offer valuable insights 
            into the potential spread of the virus across various regions. Stay informed and prepared with our up-to-date 
            projections.</p>
          
          <p><b>Each graph is interactive, revealing interactive features when clicked. Hovering over the graphs 
            displays annotations with detailed information.</b></p>
          <!-- Add your charts or data visualization here -->
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
            generateImageHolder("Prediction_Linear","$i-predlin.svg", "$i-predlin.html","rcode$i.R",1,[1],500,550);
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
