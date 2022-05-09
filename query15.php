<!-- Sydney Friedel and Shelby Coe -->
<!-- sfriede5 and scoe4 -->

<head><title>Query 15</title></head>
 <body>
<?php     
    //open a connection to dbase server 
	include 'open.php';

	// echo some basic header info onto the page
	echo "<h2>Of states with the highest rates of suicide, what is their average annual education funding and teacher starting salary? 
    	How does this compare to states with the lowest rates of suicide?</h2><br>";
	
    // call the stored procedure we already defined on dbase
	if ($result = $conn->query("CALL Query15();")) {

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
            echo "Call to Query15 failed<br>";
	  }   


   // close the connection opened by open.php
   $conn->close();

?>
</body>