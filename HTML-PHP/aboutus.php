<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>About Us - COVID-19 Data Portal</title>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            font-family: Arial, sans-serif;
        }
        .hero {
            background: #f8f9fa;
            padding: 50px 0;
            text-align: center;
        }
        .hero h1 {
            font-size: 3rem;
            margin-bottom: 20px;
        }
        .hero p {
            font-size: 1.2rem;
        }
        .section-title {
            font-size: 2rem;
            margin-top: 50px;
            margin-bottom: 30px;
            text-align: center;
        }
        .section-content {
            margin-bottom: 50px;
        }
        .team-member {
            margin-bottom: 30px;
        }
        .card:hover {
            box-shadow: 0px 0px 15px 0px rgba(0,0,0,0.3);
        }
    </style>
    <link rel="stylesheet" href="../CSS/navbar.css">
</head>
<body>
    <?php include 'navbar.html'; ?>
<br>
    <!-- Hero Section -->
    

    <!-- Mission Section -->
    <section id="mission" class="container section-content">
        <h2 class="section-title">Our Mission</h2>
        <center><p>Our primary aim is to understand infection spread across the states in India and districts of Karnataka.</p></center>
    </section>

    <!-- Team Section -->
    <section id="team" class="container section-content">
        <h2 class="section-title">Who We Are</h2>
        <div class="row">
            <div class="col-md-4">
                <div class="card team-member">
                    <div class="card-body">
                        <h3 class="card-title"><a href="https://www.isibang.ac.in/~athreya/"  target="_blank">Prof. Siva Athreya</a></h3>
                        <p class="card-text">Mentor</p>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card team-member">
                    <div class="card-body">
                        <h3 class="card-title"><a href="https://sites.google.com/view/paavan-m-parekh/home?authuser=0" target="_blank">Paavan Parekh</a></h3>
                        <p class="card-text">Creator</p>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card team-member">
                    <div class="card-body">
                        <h3 class="card-title"><a href="https://sites.google.com/view/paavan-m-parekh/home?authuser=0" target="_blank">Rashi Srivastava</a></h3>
                        <p class="card-text">Creator</p>
                    </div>
                </div>
            </div>
            
        </div>
    </section>

    <!-- What We Do Section -->
    <section id="what-we-do" class="container section-content">
        <h2 class="section-title">What We Do</h2>
        <ul>
            <li><strong>Data Collection and Integration:</strong> We gather data from trusted sources such as the World Health Organization (WHO), the Centers for Disease Control and Prevention (CDC), and various national health ministries.</li>
            <li><strong>Data Analysis and Visualization:</strong> We used R language to generate interactive charts, maps, and dashboards from complex data sets</li>
            
        </ul>
    </section>

    <!-- Values Section -->
   

    <!-- Contact Section -->
    <section id="contact" class="container section-content">
        <h2 class="section-title">Contact Us</h2>
        <p>We welcome feedback, questions, and collaboration opportunities. Please feel free to reach out to us at <a href="mailto:statprob@icts.res.in">statprob@icts.res.in</a>.</p>
    </section>

    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.3/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <?php include 'footer.html'; ?>
</body>
</html>
