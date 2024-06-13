<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Deceased Data</title>
  <!-- Bootstrap CSS -->
  <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
  <!-- Font Awesome CSS for icons -->
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" rel="stylesheet">
  <!-- Custom CSS -->
  <link rel="stylesheet" href="../CSS/navbar.css">
  <link rel="stylesheet" href="../CSS/ka_hosp_req.css">
  
</head>
<body>
  <?php include 'image_holder.php'; ?>
  <?php include 'navbar.html'; ?>
<div class="container">

    <div class="container mt-5">
      <div class="row ">
        <div class="col-md-8 mx-auto text-center jumbotron bg-info text-white">
          <h2>Deceased Data in Karnataka</h2>
          <p>This section presents a comprehensive analysis of COVID-19-related mortality. It encompasses various plots and visualizations that shed light on different aspects of the fatalities caused by the pandemic. The analysis is divided into two parts: 'Karnataka in Focus' and 'Deceased Data'.</p>
          <!-- Add your charts or data visualization here -->
        </div>
      </div>
    </div>

    <div class="container mt-5">
      <div class="row">
          <!-- Column for sections -->
          <div class="col-md-6">

              <div class="list-group" style="padding: 20px;">
                  <a href="ka_in_focus.php" class="list-group-item list-group-item-action">Karnataka in Focus</a>
                  <a href="ka_deceased_data.php" class="list-group-item list-group-item-action">Karnataka Deceased Data</a>
              </div>
          </div>
          <div class="col-md-6">
              <div id="graphCanvas">
                  <!-- Graph will be displayed here -->
                  <?php generateImageHolder("ka_deceased_data","ka_deceased_ratio.gif","ka_deceased_ratio.gif","ka_decbyinf.R",2,[1],400,650)?>
              </div>
          </div>
          <!-- Column for graph -->
      </div>
  
    </div>

</div>
<?php include 'footer.html'; ?>



  <!-- Bootstrap JS, Popper.js, and jQuery -->
  <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.3/dist/umd/popper.min.js"></script>
  <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
  <script>
    document.addEventListener('DOMContentLoaded', function() {
      const listItems = document.querySelectorAll('.list-item');
      listItems.forEach(function(item) {
        item.addEventListener('click', function() {
          const targetId = this.getAttribute('data-target');
          const targetContent = document.getElementById(targetId);
          targetContent.classList.toggle('active');
        });
      });
    });
  </script>

</body>
</html>
