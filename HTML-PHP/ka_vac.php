<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Vaccination Coverage</title>
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
          <h2>Vaccination Coverage in Karnataka</h2>
          <p>We provide extensive data for COVID-19 Vaccination coverage in districts of Karnataka and Karnataka as whole. Three doses vaccination 
           has been performed: Dose1, Dose2 and Precaution Dose.
          </p>
          <!-- Add your charts or data visualization here -->
        </div>
      </div>
    </div>

    <div class="container mt-5">
    <div class="row">
        <!-- Column for sections -->
        
            <div class="col-md-6 icu-timeline">
                <h3>Vaccination - Dose 1 Vs Dose 2 Percentage</h3>
                <p>The plot compares the percentage of the population that has received the first dose of the COVID-19 vaccine to those who have received the second dose. The x-axis represents the percentage of people who have received the first dose, while the y-axis shows the percentage of those who have completed the vaccination regimen with the second dose. This plot effectively visualizes the progress of the vaccination campaign, highlighting the gap between the initial and full vaccination coverage. It helps in understanding the overall vaccination uptake and the rate at which people are returning for their second dose.</p>
            </div>
    
         <!-- Column for graph -->
            <div class="col-md-6">
            <div id="graphCanvas">
                <!-- Graph will be displayed here -->
                <?php generateImageHolder("ka_vaccination_data","dose1VsDose2.png","dose1VsDose2.html","karnataka_districtwise_vaccination_data.R",2,[14,15,28,29],400,650)?>
            </div>
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
        <h3>Dose 1 Data</h3>
        <p>These plots show the progression of the COVID-19 vaccination campaign in terms of the first dose administered. The x-axis represents the dates, giving a timeline of the vaccination rollout, while the y-axis indicates the total number of first dose vaccinations administered.
         Click <a href="ka_dose1_data.php" target="_blank">here</a> to see the graphs for all districts.</p>
        </p>
      </div>
      </div>
    </div>

    <div class="container mt-5">
      <div class="row">
        <!-- Column for sections -->
        
      <div class="col-md-12 icu-timeline">
        <h3>Dose 1, Dose2 and Precaution Dose Percentage</h3>
        <p>All the graphs below provide the cumulative dose 1, dose 2 and precaution dose vaccination percentage for each district. The dose 1 and 2 counts of BBMP district, if present, were added to Bengaluru Urban.
        Click <a href="ka_dose12prec_data.php" target="_blank">here</a> to see the graphs for all districts.
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
