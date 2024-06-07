<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Omicron</title>
  <!-- Bootstrap CSS -->
  <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
  <!-- Font Awesome CSS for icons -->
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" rel="stylesheet">
  <!-- Custom CSS -->
  <link rel="stylesheet" href="../CSS/navbar.css">
  <link rel="stylesheet" href="../CSS/pan_india_statistics.css">

  <style>
    .hidden-content {
      display: none;
    }

    input[type="checkbox"] {
      display: none;
    }

    input[type="checkbox"]:checked + .dropdown-link + .hidden-content {
      display: block;
    }

    .dropdown-link {
      cursor: pointer;
      color: #007bff;
      display: block;
      padding: 0px;
    }

    .dropdown-link:hover {
      text-decoration: underline;
    }
  </style>


</head>
<body>
  <?php include 'image_holder.php'; ?>
  <?php include 'navbar.html'; ?>
  <div class="container">
    <div class="container mt-5">
      <div class="row">
        <div class="col-md-8 mx-auto text-center jumbotron bg-info text-white">
          <h2>IISc-ISI Predictions based on Omicron Transmissibility Rates in South Africa</h2>
          <p>(Last updated February 7th, 2022)</p>
          <!-- Add your charts or data visualization here -->
        </div>
      </div>
    </div>
    
    <div class="container mt-5">
      <p><b>India Predictions</b></p>
      <div class="row">
          <!-- Column for sections -->
          <div class="col-md-6">
              <div id="graphCanvas">
                  <!-- Graph will be displayed here -->
                  <?php generateImageHolder("omicron","0.png","",".R",1,[1],400,500)?>
              </div>
          </div>

          <div class="col-md-6">
              <div id="graphCanvas">
                  <!-- Graph will be displayed here -->
                  <?php generateImageHolder("omicron","0-in.png","",".R",1,[1],400,500)?>
              </div>
          </div>
          <!-- Column for graph -->
      </div>
  
    </div>

    <div class="container mt-5">
      <p><b>India Estimated Hospital and ICU Requirement</b></p>
      <div class="row">
          <!-- Column for sections -->
          <div class="col-md-6">
              <div id="graphCanvas">
                  <!-- Graph will be displayed here -->
                  <?php generateImageHolder("omicron","0-hosp.png","",".R",1,[1],400,500)?>
              </div>
          </div>

          <div class="col-md-6">
              <div id="graphCanvas">
                  <!-- Graph will be displayed here -->
                  <?php generateImageHolder("omicron","0-icu.png","",".R",1,[1],400,500)?>
              </div>
          </div>
          <!-- Column for graph -->
      </div>
  
    </div>

    <div class="container mt-5">
      <div class="row ">
        <div class="col-md-12">
          <ul>

            <li>
              <input type="checkbox" id="dropdown1">
                <label for="dropdown1" class="dropdown-link">India States Predictions</label>
                <div class="hidden-content">
                  <div class="row">
                    <div class="col-md-6">
                      <?php
                      // Generate image holders
                      for ($i = 1; $i <= 36; $i++) {
                          // Check if it's the first image holder of the row
                          if (($i - 1) % 2 == 0) {
                              echo '</div><div class="row">'; // Close the previous row and start a new one
                          }
                          echo '<div class="col-md-6">';
                          generateImageHolder("omicron","$i.png", "$i-.html","$i.R",1,[1],400,550);
                          echo '</div>';

                          echo '<div class="col-md-6">';
                          generateImageHolder("omicron","$i-in.png", "$i-.html","$i.R",1,[1],400,550);
                          echo '</div>';
                      }
                      ?>
                  </div>                 
                </div>  
            </li>
            
            <li>
              <input type="checkbox" id="dropdown2">
                <label for="dropdown2" class="dropdown-link">India States Estimated Hospital and ICU Requirements</label>
                <div class="hidden-content">
                <div class="row">
                    <div class="col-md-6">
                      <?php
                      // Generate image holders
                      for ($i = 1; $i <= 36; $i++) {
                          // Check if it's the first image holder of the row
                          if (($i - 1) % 2 == 0) {
                              echo '</div><div class="row">'; // Close the previous row and start a new one
                          }
                          echo '<div class="col-md-6">';
                          generateImageHolder("omicron","$i-hosp.png", "$i-.html","$i.R",1,[1],400,550);
                          echo '</div>';

                          echo '<div class="col-md-6">';
                          generateImageHolder("omicron","$i-icu.png", "$i-.html","$i.R",1,[1],400,550);
                          echo '</div>';
                      }
                      ?>
                  </div>
                </div>  
            </li>

            <li>
              <input type="checkbox" id="dropdown3">
                <label for="dropdown3" class="dropdown-link">Methodology Summary</label>
                <div class="hidden-content">
                  <p>
                    <a href = "">Write-up in PDF Model:</a>

                    <br>

                    <ul>
                      <li>SEIR model with Vaccination
                      <li>Model Parameters: Contact Rates β, Recovery period (1/γ = 5 days), Incubation period (1/α = 5.8 days).
                    </ul>

                    <br>

                    <b>Method</b>

                    <br><br>

                    <ul>
                      <li>Past infection, vaccination, affected by immunity waning makes a certain fraction of the population susceptible to the new variant which is taken as a parameter: 30%, 60%,100%.</li>
                      <br>
                      <li>Contact Rates:
                        <ul>
                          <li>Estimated by the comparison of contact rates for South Africa during 15 May-15 June 2021 and 01-12 December 2021.
                          <li>Assumed contact rate: Omicron = 1.41 x Delta for 100%. Similar calibration for others.
                        </ul>
                      </li> 
                      <br>
                      <li>Calibration:
                        <ul>
                          <li>On day 0, each state is seeded with 20 cases.
                          <li>Once simulated, a suitable delay is added to align to the increasing trend during 27 December 2021 - 02 January 2022.
                        </ul>
                      </li>  
                    </ul>  
                      <br>
                    <b>Based on our earlier work:</b> <a href = "https://www.medrxiv.org/content/10.1101/2021.05.26.21257836v1">Strategies to Mitigate COVID-19 Resurgence Assuming Immunity Waning: A Study for Karnataka</a>, India Aniruddha Adiga, Siva Athreya, Bryan Lewis, Madhav V. Marathe, Nihesh Rathod, Rajesh Sundaresan, Samarth Swarup, Srinivasan Venkatramanan and Sarath Yasodharan</p>
                    

                </div>  
            </li>

            <li>
              <input type="checkbox" id="dropdown4">
                <label for="dropdown4" class="dropdown-link">South Africa Summary</label>
                <div class="hidden-content">
                <div id="graphCanvas">
                  <!-- Graph will be displayed here -->
                  <?php generateImageHolder("SouthAfrica","saum.png","",".R",1,[1],600,1050)?>
              </div>
                </div>  
            </li>

            <li>
              <input type="checkbox" id="dropdown5">
                <label for="dropdown5" class="dropdown-link">Data</label>
                <div class="hidden-content">
                  <p>
                    <ul>
                      <li>Prediction 100% Susceptible <a href = "">CSV</a>
                      <li>Prediction 60% Susceptible <a href = "">CSV</a>
                      <li>Prediction 30% Susceptible <a href = "">CSV</a>
                      <li>Reported Cases <a href = "">CSV</a> (Source:www.incovid19.org)
                    </ul>
                  </p>
                </div>  
            </li>

            <li>
              <input type="checkbox" id="dropdown6">
                <label for="dropdown6" class="dropdown-link">Error Analysis</label>
                <div class="hidden-content">
                  <p>
                  <ul>
                  <li>Prediction 2nd January, 2022:  
                    <ul>
                      <li>Report in PDF
                      <li>Data in CSV.  
                    </ul>

                  <li>Prediction 10th January, 2022:
                    <ul>
                      <li>Report in PDF
                      <li>Data in CSV.  
                    </ul>

                  <li>Prediction 17th January, 2022:
                    <ul>
                      <li>Report in PDF
                      <li>Data in CSV.  
                    </ul>


                  <li>Prediction 24th January, 2022:
                    <ul>
                      <li>Report in PDF
                      <li>Data in CSV.    
                    </ul>

                  <li>Prediction 31st January, 2022:
                    <ul>
                      <li>Report in PDF
                      <li>Data in CSV.  
                    </ul>
                  </ul>
            
                  </p>
                </div>  
            </li>

            

          </ul>
          </p>
          <!-- Add your charts or data visualization here -->
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
