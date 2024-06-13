<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>State wise Active Cases</title>
  <!-- Bootstrap CSS -->
  <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
  <!-- Font Awesome CSS for icons -->
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" rel="stylesheet">
  <!-- Custom CSS -->
  <link rel="stylesheet" href="../CSS/navbar.css">
  <link rel="stylesheet" href="../CSS/india_rt.css">
  
</head>
<body>
  <?php include 'image_holder.php'; ?>
  <?php include 'navbar.html'; ?>
  <div class="container">
   <div class="container mt-5">
      <div class="row">
        <div class="col-md-8 mx-auto text-center jumbotron bg-info text-white">
          <h2>Total Active Cases for States in India</h2>
          <p>The plots present the progression of active COVID-19 cases across various states over time. The x-axis marks the dates, showing the timeline of the pandemic, while the y-axis displays the number of active cases. This plot provides a comparative view of how different states have experienced and managed the spread of COVID-19. It highlights regional variations, pinpointing areas with significant case surges or declines. This visualization is crucial for understanding the geographical impact of the virus and for directing resources and public health measures to regions in need.
          </p>
          
        </div>
      </div>
    </div> 
    

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
            generateImageHolder("india_active_cases","$i-india-active.svg", "$i-india-active.html","india_statewise_seperate_active_cases.R", 1,[1,2,3],400,500);
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
