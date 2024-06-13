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
  <link rel="stylesheet" href="../CSS/ka_hosp_req.css">

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
      <div class="row ">
        <div class="col-md-8 mx-auto text-center jumbotron bg-info text-white">
          <h2>Omicron</h2>
          <p>Total Omicron cases for all over Karnataka and each districts are plotted. Along with the active cases, increase in cases and daily new cases are considered.</p>
          <!-- Add your charts or data visualization here -->
        </div>
      </div>
    </div>

    <div class="container mt-5">
      <div class="row">
          <!-- Column for sections -->
          <div class="col-md-6">

              <div class="list-group" style="padding: 20px;">
                  <a href="omicron.php" class="list-group-item list-group-item-action">Omicron Projections</a>
                  <a href="#" class="list-group-item list-group-item-action">Forecast Hub</a>
                  <a href="#" class="list-group-item list-group-item-action">Karnataka Districts</a>
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

    <div class="container mt-5">
      <div class="row ">
        <div class="col-md-12">
          <p>This page provides infection counts across the states in India and districts of Karnataka.
          <br><br>
          Raw Data from Media Bulletins
          <ul>
            <li>
              <input type="checkbox" id="dropdown1">
                <label for="dropdown1" class="dropdown-link">Summary for All India</label>
                <div class="hidden-content">
                  <p><a href = "">This csv file</a> contains the counts of infected [both Indian and Foreign nationals], recovered and deceased for each state with at least one COVID-19 case. The rows correspond to different states and the columns represent the daily counts. Each day corresponds to four columns: Total Confirmed cases of Indian Nationals [TCIN], Total Confirmed cases of Foreign Nationals [TCFN], Recoveries [Cured] and Deaths [Death] for that day. This file is updated from the MOHFW website.
                  </p>
                </div>  
            </li>

            <li>
              <a href = "">Plots: Active Cases</a> 
            </li>
            <br>
            <li>
              <input type="checkbox" id="dropdown2">
                <label for="dropdown2" class="dropdown-link">Karnataka District Timeline</label>
                <div class="hidden-content">
                  <p>
                    <ul>  
                      <li>Till April 9th 2023: <a href = "">This csv file</a> contains counts of the infected, recovered and deceased patients districtwise in Karnataka. 
                      <br>
                      The data is organized as follows:
                      <ol>
                        <li>Each row represents a District.
                        <li>For each date, there are 3 columns representing the total number of infected patients, the total number of recoveries and the total number of deceased patients.
                      </ol>
                      <br><br>
                      <li>Post April 9th 2023: <a href = "">This csv file</a> contains counts of the infected, recovered and deceased patients districtwise in Karnataka. 
                      <br>
                      The data is organized as follows:
                      <ol>
                        <li>Each row represents a District.
                        <li>For each date, there are 3 columns representing the total number of infected patients, the total number of recoveries and the total number of deceased patients.
                      </ol>
                    </ul>
                  </p>
                </div>  
            </li>

            <li>
              <a href = "">Plots: Active Cases: Post April 9th 2023</a> 
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
