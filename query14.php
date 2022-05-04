<!-- Sydney Friedel and Shelby Coe -->
<!-- sfriede5 and scoe4 -->

<head><title>Query 14</title></head>
 <body>
<?php     
    //open a connection to dbase server 
	include 'open.php';

	// echo some basic header info onto the page
	echo "<h2>What is the average graduation rate of each state for the five states with the lowest poverty levels?</h2><br>";
	
    // call the stored procedure we already defined on dbase
	if ($result = $conn->query("CALL Query14();")) {

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
            echo "Call to Query14 failed<br>";
	  }   


   // close the connection opened by open.php
   $conn->close();

?>
</body>