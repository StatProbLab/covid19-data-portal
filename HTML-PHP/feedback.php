<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Feedback Form</title>
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">

    <style>
        body {
            background-color: #f8f9fa;
        }
        .container {
            margin-top: 50px;
            background-color: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        iframe {
            width: 100%;
            height: 1000px;
            border: none;
        }
    </style>
    <link rel="stylesheet" href="../CSS/navbar.css">
</head>
<body>
    <?php include 'navbar.html'; ?>
    <div class="container">
        <h2 class="text-center">Feedback Form</h2>
        <iframe src="https://forms.gle/9hTXNVod2vYnWaRG9"></iframe>
    </div>
    <?php include 'footer.html'; ?>
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
