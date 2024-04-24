<?php

echo"Starting IISCISI WP";

// //For iiscisci
// exec("cd  ./Data  && python3 predpy.py" );
// exec("cd  .csv2/Data  && python3 predpy1.py" );
// exec("cd  ./Data  && python3 predpy3.py" );
 cd .. echo"DONE python programs";
exec("cp ../CSIR/Karnataka_forecastscsir.csv ./Data/dataprograms/csircsv/csir3.csv");
 exec("cd  ./Data/dataprograms  && Rscript csir.r");
  echo"DONE CSIR ";
exec("cd  ./iiscisi && Rscript iisc.r" );
  echo"DONE IISC";

exec("cd  ./iiscisi && Rscript dailycount.r" );
  echo"DONE IISC-csv file";
   exec("cd ./iiscisi && php table.php" );
   echo"DONE CSVTOLATEX";

   // exec("cd  ./iiscisi/plotlyfigures && php table.php" );
   // echo"DONE SVGTOPDF";
   exec("cd  ./iiscisi && pdflatex report.tex" );
   echo"DONE REPORTPDF and DpythoONE all";
?>
