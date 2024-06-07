<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Days to Decease</title>
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
          <h2>Days to Decease</h2>
          <p>The Media Bulletin reports each deceased patient as either admitted to hospital, or brought dead or died at residences. All these graphs provide the stacked age distribution of the deceased COVID-19 patients in every district. The yellow bar is for male while the blue bar is for female. Since the number of transgender, neutral gender, unknown ages, district and gender were small, they have not been plotted. The data has a district called as others, whose count was also less and hence not plotted.</p>
          <p>For all the graphs on this page, if you click on the image then it will display an interactive graph, where as you hover your mouse pointer over the graph annotations with details will be displayed.</p>
        </div>
      </div>
    </div>

    <div class = "row">
      <div class="col-md-12">
        <div id="graphCanvas">
             <!-- Graph will be displayed here -->
             <?php generateImageHolder("daysToDecease","daystodecease_wavewise.png","daystodecease_wavewise.html","admissionfinal.R",1,[1],580,1100)?>
         </div>
      </div>    
    </div>
    <br><br>
    <hr>
    <br><br>
    <!-- Image holders -->
    <div class="row">
        <br>
        <?php
        // Generate image holders
        for ($i = 1; $i <= 30; $i++) {
            // Check if it's the first image holder of the row
            if (($i - 1) % 2 == 0) {
                echo '</div><div class="row">'; // Close the previous row and start a new one
            }
            echo '<div class="col-md-12">';
            generateImageHolder("daysToDecease","$i-District_decease.png", "$i-District_decease.html","admissionfinal.R",1,[1],700,1100);
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
