<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>FOE in Karnataka</title>
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
                            <h2>Falling off Exponential Growth in Karnataka</h2>
                            <p>For more detailed information about these graphs, please visit the <a href="https://www.isibang.ac.in/~athreya/incovid19/fegnotes.php">Falling of Exponential Growth page</a>.
                            </p>
                            <!-- Add your charts or data visualization here -->
                        </div>
                    </div>
                </div>

            <div class="container mt-5">
                <div class="row">
                    <!-- Column for sections -->

                    <div class="col-md-12 icu-timeline">
                        <h3>Falling Of Exponential Growth for Districts in Karnataka</h3>
                        <p>These plots depict the relationship between the 7-day moving average of case increases and the total number of cases in each district. The x-axis represents the 7-day moving average of new COVID-19 cases, providing a smoothed view of recent trends. The y-axis shows the total number of cases in each district.
                        Click <a href="ka_foe_plots.php" target="_blank">here</a> to see the graphs for all districts.
                        </p>
                    </div>
                </div>
                <br>
                <br>
            </div>





            </div>
            <?php include 'footer.html'; ?>
                <!-- Bootstrap JS, Popper.js, and jQuery -->
                <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
                <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.3/dist/umd/popper.min.js"></script>
                <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>

</html>