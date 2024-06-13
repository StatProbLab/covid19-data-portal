<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>COVID-19 Data Portal</title>
  <!-- Bootstrap CSS -->
  <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
  <!-- Custom CSS -->
  <link rel="stylesheet" href="../CSS/style.css">
  <link rel="stylesheet" href="../CSS/navbar.css">
</head>
<body>


<?php include 'navbar.html'; ?>
<div class="container">
<div class="mx-auto text-center jumbotron bg-info text-white">
        
        <div class="row">
            <div class="col-md-6">
              <a href="../Images/ews/kamap.html" target="_blank">
                <img src="../Images/ews/kamap.png" class="img-fluid" alt="Static Image">
              </a>
            </div>
            <div class="col-md-6">
                <div id="imageCarousel" class="carousel slide" data-ride="carousel">
                    <div class="carousel-inner">
                        <div class="carousel-item active">
                            <img src="../Images/india_active_cases/india_active_cases.gif" class="d-block w-100" alt="Scrolling Image 1">
                        </div>
                        <div class="carousel-item">
                            <img src="../Images/india_active_cases/india_increase_in_cases_stateswise_wt.gif" class="d-block w-100" alt="Scrolling Image 2">
                        </div>
                        <div class="carousel-item">
                            <img src="../Images/india_active_cases/india_active_cases_statewise.gif" class="d-block w-100" alt="Scrolling Image 2">
                        </div>
                        <div class="carousel-item">
                            <img src="../Images/ka_active_cases/ka_increase_in_cases_districtwise_wt.gif" class="d-block w-100" alt="Scrolling Image 2">
                        </div>
                        <div class="carousel-item">
                            <img src="../Images/ka_active_cases/karnataka_active_cases.gif" class="d-block w-100" alt="Scrolling Image 2">
                        </div>
                        <!-- Add more carousel items as needed -->
                    </div>
                    <a class="carousel-control-prev" href="#imageCarousel" role="button" data-slide="prev">
                        <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                        <span class="sr-only">Previous</span>
                    </a>
                    <a class="carousel-control-next" href="#imageCarousel" role="button" data-slide="next">
                        <span class="carousel-control-next-icon" aria-hidden="true"></span>
                        <span class="sr-only">Next</span>
                    </a>
                </div>
            </div>
        </div>
    </div>

 <p>This portal is to understand infection spread across the states in India and districts of Karnataka. At the State level we provide run time monitoring of 
R<sub>t</sub>, Active Cases, and provide an Early warning system for each state. For Karnataka, our analysis is detailed at the district level: we track Deceased data, Active cases, 
R<sub>t</sub>, provide a one week prediction for them and an Early warning system for each.The data are sourced from the Ministry of Health and Family Welfare (MOHFW) website and Media Bulletins published regularly by the Karnataka government. The data available on these websites is in the form of PDF files where it's difficult to extract automatically. We have collected this data and collated it to form the following csv files from where it can used easily by the public. Below we provide all the data in csv format.</p>   
<br>
<div class="row">
  <div class="col-md-4">
    <a href="pan_india_statistics.php" class="card-link">
      <div class="card">
        <div class="card-body">
          <h5 class="card-title"><i class="fas fa-globe"></i> India</h5>
        </div>
      </div>
    </a>
  </div>
  <div class="col-md-4">
    <a href="pan_ka_statistics.php" class="card-link">
      <div class="card">
        <div class="card-body">
          <h5 class="card-title"><i class="fas fa-map-marker-alt"></i> Karnataka</h5>
        </div>
      </div>
    </a>
  </div>
  <div class="col-md-4">
    <a href="predictions.php" class="card-link">
      <div class="card">
        <div class="card-body">
          <h5 class="card-title"><i class="fas fa-chart-line"></i> Predictions</h5>
        </div>
      </div>
    </a>
  </div>
</div>
<div class="row">
  <div class="col-md-4">
    <a href="publications.php" class="card-link" target="_blank">
      <div class="card">
        <div class="card-body">
          <h5 class="card-title"><i class="fas fa-book"></i> Publications & Preprints</h5>
        </div>
      </div>
    </a>
  </div>
  <div class="col-md-4">
    <a href="../Data-repository/data_kacovid19.html" class="card-link" target="_blank">
      <div class="card">
        <div class="card-body">
          <h5 class="card-title"><i class="fas fa-database"></i> Data Repository</h5>
        </div>
      </div>
    </a>
  </div>
  <div class="col-md-4">
    <a href="ews.php" class="card-link">
      <div class="card">
        <div class="card-body">
          <h5 class="card-title"><i class="fas fa-exclamation-triangle"></i> Early Warning System (EWS)</h5>
        </div>
      </div>
    </a>
  </div>
</div>

<!-- Make sure to include Font Awesome for the icons to work -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">


</div>
<?php include 'footer.html'; ?>
<!-- Bootstrap JS (optional, only if you need JavaScript features) -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.bundle.min.js"></script>
<script src="index.js"></script>
</body>
</html>
