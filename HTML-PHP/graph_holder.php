<style>
    /* Define the light slightly opaque green color */
    .highlighted {
        background-color: rgba(144, 238, 144, 0.5); /* Adjust opacity as needed */
    }
</style>
<div class="ghcontainer">
    <div class="row">
        <div class="col-md-12">
            <div class="image-holder" style="height: <?php echo $h; ?>px; width: <?php echo $w; ?>px;">
                <img src="../Images/<?php echo $imageFolderName; ?>/<?php echo $imageName; ?>" class="img-fluid" alt="Image">
                <div class="icons text-center">
                    <a href="../Images/<?php echo $imageFolderName; ?>/<?php echo $externalImageName; ?>" class="box-link" target="_blank"><i class="fas fa-external-link-alt"></i></a>
                    <a href="../Images/<?php echo $imageFolderName; ?>/<?php echo $imageName; ?>" class="box-link" download><i class="fas fa-download"></i></a>
                    <a id="highlightLink" href="../Data-repository/data_kacovid19.html?tableNumber=1&rowIndices=1,2" class="box-link" target="_blank"><i class="fab fa-r-project"></i></a>
                    <a id="highlightLink" href="../Data-repository/data_kacovid19.html?tableNumber=1&rowIndices=1,2" class="box-link" target="_blank"><i class="fas fa-file-csv"></i></a>
                </div>
            </div>
        </div>
    </div>
</div>

