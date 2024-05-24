<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>EWS for Karnataka</title>
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
          <h2>Early Warning System for Districts in Karnataka</h2>
          <p>It serves as a proactive tool to anticipate and mitigate potential spikes in COVID-19 cases across different regions of the state. According to the definition of EWS, we four categories in which districts are divided.</p>
          <!-- Add your charts or data visualization here -->
        </div>
      </div>
    </div>


    <!-- <div class="fancy-heading">
      <img src="../Images/ka_vaccination_data/vaccination.jpg" alt="Profile Picture">
      <h3>Vaccine Dose Statistics</h3>
    </div>
     -->
    <div class="container mt-5">
      <div class="row">
        <!-- Column for sections -->
        
      <div class="col-md-12 icu-timeline">
        <h3>Category 1: Predicted Days to 1500 Active cases per million population is less than 100 days</h3>
        <p>
        Click <a href="ews_ka_cat1.php" target="_blank">here</a> to see the graphs for all districts.
        </p>
      </div>
      </div>
    </div>

    <div class="container mt-5">
      <div class="row">
        <!-- Column for sections -->
        
      <div class="col-md-12 icu-timeline">
        <h3>Category 2: Growing and Alert Raisedd</h3>
        <p>
        Click <a href="ews_ka_cat2.php" target="_blank">here</a> to see the graphs for all districts.
        </p>
      </div>
      </div>
    </div>


    <div class="container mt-5">
      <div class="row">
        <!-- Column for sections -->
        
      <div class="col-md-12 icu-timeline">
        <h3>Category 3: Stable but Need to be watched</h3>
        <p>
        Click <a href="ews_ka_cat3.php" target="_blank">here</a> to see the graphs for all districts.
        </p>
      </div>
      </div>
    </div>

    <div class="container mt-5">
      <div class="row">
        <!-- Column for sections -->
        
      <div class="col-md-12 icu-timeline">
        <h3>Category 4: Stable</h3>
        <p>
        Click <a href="ews_ka_cat4.php" target="_blank">here</a> to see the graphs for all districts.
        </p>
      </div>
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
