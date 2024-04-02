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
  <div class="jumbotron bg-info text-white">
    <h1>Step into our COVID-19 Data Hub! </h1>
    <p>Explore detailed insights on COVID-19 stats, with a spotlight on India and a closer look at Karnataka.</p>
    <p>Our main goal is to understand the spread of infections in different states of India and districts within Karnataka. 
      At the state level, we offer real-time monitoring of R<sub>t</sub>, Active Cases, and deploy an Early Warning System (EWS) for each 
      state. In Karnataka, our analysis delves into district-level data, tracking Deceased cases, Active cases, R<sub>t</sub>, along 
      with providing one-week predictions and an EWS for each district.</p>
  </div>


  <div class="row">
    <div class="col-md-4">
      <a href="pan_india_statistics.php" class="card-link">
        <div class="card">
          <div class="card-body">
            <h5 class="card-title">Pan-India Statistics</h5>
            <p class="card-text">State-wise Analysis on Active Cases, Reproduction Rate, Vaccination, and EWS</p>
          </div>
        </div>
      </a>
    </div>
    <div class="col-md-4">
      <a href="karnataka_statistics.php" class="card-link">
        <div class="card">
          <div class="card-body">
            <h5 class="card-title">Karnataka Statistics</h5>
            <p class="card-text">District-wise Analysis on Active Cases, Reproduction Rate, Vaccination, and EWS</p>
          </div>
        </div>
      </a>
    </div>
    <div class="col-md-4">
      <a href="modeling_and_simulation.html" class="card-link">
        <div class="card">
          <div class="card-body">
            <h5 class="card-title">Modeling and Simulation</h5>
            <p class="card-text">Learn about our modeling and simulation efforts for COVID-19 prediction.</p>
          </div>
        </div>
      </a>
    </div>
  </div>
  <div class="row">
    <div class="col-md-4">
      <a href="publications.html" class="card-link">
        <div class="card">
          <div class="card-body">
            <h5 class="card-title">Publications</h5>
            <p class="card-text">Explore our collection of COVID-19 related publications for reference.</p>
          </div>
        </div>
      </a>
    </div>
    <div class="col-md-4">
      <a href="data_repository.html" class="card-link">
        <div class="card">
          <div class="card-body">
            <h5 class="card-title">Data Repository</h5>
            <p class="card-text">Access our data repository for COVID-19 datasets used in our analysis.</p>
          </div>
        </div>
      </a>
    </div>
    <div class="col-md-4">
      <a href="modeling_and_simulation.html" class="card-link">
        <div class="card">
          <div class="card-body">
            <h5 class="card-title">Modeling and Simulation</h5>
            <p class="card-text">Learn about our modeling and simulation efforts for COVID-19 prediction.</p>
          </div>
        </div>
      </a>
    </div>
  </div>

</div>
<?php include 'footer.html'; ?>

<!-- Bootstrap JS (optional, only if you need JavaScript features) -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.bundle.min.js"></script>
<script src="index.js"></script>



</body>
</html>