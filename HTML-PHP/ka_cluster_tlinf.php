<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Cluster Timeline and Information</title>
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
        <div class="col-md-8 mx-auto text-center jumbotron bg-info text-white">
          <h2>Cluster Data</h2>
          <p>The growth of the clusters in the Karnataka Trace History chart over time.
          </p>
          <!-- Add your charts or data visualization here -->
        </div>
      </div>
    </div>
    
    
    <div class="container mt-5">
    <div class="row">
        <!-- Column for sections -->
        
            <div class="col-md-6 icu-timeline">
                <h3>Cluster Timeline</h3>
                <p>An animation showing the growth of the clusters in the Karnataka Trace History chart over time. 
                    Different clusters have been represented by differently colored lines. Get here to get R code and CSV file.
                </p>
            </div>
    
         <!-- Column for graph -->
            <div class="col-md-6">
            <div id="graphCanvas">
                <!-- Graph will be displayed here -->
                <iframe src="../Images/ka_infocus/dynamic-hist.html" frameborder="0" height="450px" width="700px"></iframe>
                <!-- <?php generateImageHolder("ka_infocus","dynamic-hist.svg","dynamic-hist.html","rcode.R",1,[1],400,650)?> -->
            </div>
            </div>
     </div>
    </div>
  

   
    <div class="container mt-5">
    <div class="row">
        <!-- Column for sections -->
        
            <div class="col-md-6 icu-timeline">
                <h3>Cluster Information</h3>
                <p>(With Total)In the above graph the orange line is the number of total tests done daily and the red line is the number of tests found positive daily.
                If you want to see the graph without total cases click here: <a href="../Images/ka_active_cases/ka_increase_in_cases_districtwise_wt.gif" target="_blank">gif</a> and <a href="../Images/ka_active_cases/ka_increase_in_cases_districtwise_wt.gif" target="_blank">html</a></p>
            </div>
    
         <!-- Column for graph -->
            <div class="col-md-6">
            <div id="graphCanvas">
                <!-- Graph will be displayed here -->
                <?php generateImageHolder("ka_infocus","ka-hist1.svg","ka-hist1.html","rcode.R",1,[1],400,650)?>
            </div>
            </div>
        </div>
        
    </div>

    <br>
    <br>
    <br>
    <br>
    <div class="container mt-5">
    <div class="row">
        <!-- Column for sections -->
        
            <div class="col-md-6 icu-timeline">
                <h3>The Cluster From Maharastra</h3>
                <p>The cluster: From Maharashtra is quite large and we have again divided it into sub-clusters according to the resident city of the infected.</p>
            </div>
    
         <!-- Column for graph -->
            <div class="col-md-6">
            <div id="graphCanvas">
                <!-- Graph will be displayed here -->
                <?php generateImageHolder("ka_infocus","ka-histMah.svg","ka-histMah.html","rcode.R",1,[1],510,650)?>
            </div>
            </div>
        </div>
        
    </div>
    <div class="container mt-5">
    <div class="row">
        <!-- Column for sections -->
        
            <div class="col-md-6 icu-timeline">
                <h3>The Cluster From Maharastra</h3>
                <p>The cluster: From Maharashtra is quite large and we have again divided it into sub-clusters according to the resident city of the infected.</p>
            </div>
    
         <!-- Column for graph -->
            <div class="col-md-6">
            <div id="graphCanvas">
                <!-- Graph will be displayed here -->
                <?php generateImageHolder("ka_infocus","infdedrec-clusters1.svg","infdedrec-clusters1.html","rcode.R",1,[1],510,650)?>
            </div>
            </div>
        </div>
        
    </div>
    <div class="container mt-5">
    <div class="row">
        <!-- Column for sections -->
        
            <div class="col-md-6 icu-timeline">
                <h3>The Cluster From Maharastra</h3>
                <p>The cluster: From Maharashtra is quite large and we have again divided it into sub-clusters according to the resident city of the infected.</p>
            </div>
    
         <!-- Column for graph -->
            <div class="col-md-6">
            <div id="graphCanvas">
                <!-- Graph will be displayed here -->
                <?php generateImageHolder("ka_infocus","infdedrec-clustersMah.svg","infdedrec-clustersMah.html","rcode.R",1,[1],510,650)?>
            </div>
            </div>
        </div>
        
    </div>
    
    <div class="container mt-5">
    <div class="row">
        <!-- Column for sections -->
        
            <div class="col-md-6 icu-timeline">
                <h3>Days taken to Recover</h3>
                <p>The cluster: From Maharashtra is quite large and we have again divided it into sub-clusters according to the resident city of the infected.</p>
            </div>
    
         <!-- Column for graph -->
            <div class="col-md-6">
            <div id="graphCanvas">
                <!-- Graph will be displayed here -->
                <?php generateImageHolder("ka_infocus","age-dtc.png","age-dtc.html","rcode.R",1,[1],510,650)?>
            </div>
            </div>
        </div>
        
    </div>

    <div class="container mt-5">
    <div class="row">
        <!-- Column for sections -->
        
            <div class="col-md-6 icu-timeline">
                <h3>Days taken to succumb to the disease</h3>
                <p>The cluster: From Maharashtra is quite large and we have again divided it into sub-clusters according to the resident city of the infected.</p>
            </div>
    
         <!-- Column for graph -->
            <div class="col-md-6">
            <div id="graphCanvas">
                <!-- Graph will be displayed here -->
                <?php generateImageHolder("ka_infocus","age-dtd.png","age-dtd.html","rcode.R",1,[1],510,650)?>
            </div>
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
