<!-- Sydney Friedel and Shelby Coe -->
<!-- sfriede5 and scoe4 -->

<head><title>Query 9</title></head>
 <body>
<?php     
    //open a connection to dbase server 
	include 'open.php';

	// echo some basic header info onto the page
	echo "<h2>For states in which the rate of drug overdoses or sucide are significantly lower than other states, 
    what was the highschool graduation rate? Average SAT/ACT scores?</h2>";
    	 echo "<h4> Here, we defined 'significantly lower' as at least 1.5 standard deviations lower than the average suicide rate across all existing states/territories in the dataset </h4>";	
    // call the stored procedure we already defined on dbase
	if ($result = $conn->query("CALL Query9();")) {

	    echo "<table border=\"2px solid black\">";

        // output a row of table headers
	    echo "<tr>";
	    // collect an array holding all attribute names in $result
	    $flist = $result->fetch_fields();
        // output the name of each attribute in flist
	    foreach($flist as $fname){
	        echo "<td>".$fname->name."</td>";
	    }
	    echo "</tr>";

        // output a row of table for each row in result, using flist names
        // to obtain the appropriate attribute value for each column
	    foreach($result as $row){
            // reset the attribute names array
    	    $flist = $result->fetch_fields(); 
	        echo "<tr>";
	        foreach($flist as $fname){
                echo "<td>".$row[$fname->name]."</td>";
            }
  	        echo "</tr>";
	    }
	    echo "</table>";

        } else {
            echo "Call to Query9 failed<br>";
	  }   


   // close the connection opened by open.php
   $conn->close();

?>
</body>
<html>
<body>
     <style>
        body {font-family: 'verdana'; font-size: 18px;}
     </style>

</body>
</html>
