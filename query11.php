<!-- Sydney Friedel and Shelby Coe -->
<!-- sfriede5 and scoe4 -->

<head><title>Query 11</title></head>
<body>
<?php
	//open a connection to dbase server
        include 'open.php';


	//Override the PHP configuration file to display all errors
	//This is useful during development but generally disabled before release
	ini_set('error_reporting', E_ALL);
	ini_set('display_errors', true);

	//get user input and perform error-checking on it
	$factor = $_POST['factor'];


	if(!empty($factor)) {
		$factor = trim($factor);
		if (strcmp($factor, 'percentInPoverty') == 0 || strcmp($factor, 'unemploymentRate') == 0 || strcmp($factor, 'realGDP') == 0 || strcmp($factor, 'percentUnhoused') == 0 || strcmp($factor, 'homelessnessRatePer10000') == 0 || strcmp($factor, 'medianIncome') == 0 || strcmp($factor, 'foreignBornMedianIncome') == 0 || strcmp($factor, 'USBornMedianIncome') == 0 ) {
		
   		   //input is within range, so we can make stored procedure calls safely
		   echo "<h2>What is the difference in overall health for states ordered by $factor?</h2><br>";

		   //call stored procedures defined on dbase

		   //values for states above and below threshold
		
			if ($stmt1 = $conn->prepare("CALL Query11(?)")) {
      			   $stmt1->bind_param($factor);

      			   //Run the actual query
      			   if ($stmt1->execute()) {

         		      //Store result set generated by the prepared statement
         		      $result1 = $stmt1->get_result();

         		      if (($result1) && ($result1->num_rows != 0)) {

            		      //Create table to display results
           		       echo "<table border=\"1px solid black\">";
            		       echo "<tr><th> State Name </th> <th> $factor </th><th> suicideRate </th><th> teenPregnancyRate </th></tr>";

            		       //Report result set by visiting each row in it
            		       while ($row1 = $result1->fetch_row()) {
               		       	    echo "<tr>";
               			        echo "<td>".$row1[0]."</td>";
               			        echo "<td>".$row1[1]."</td>";
				                echo "<td>".$row1[2]."</td>";
				                echo "<td>".$row1[3]."</td>";
               			        echo "</tr>";
            			    }

            			     echo "</table>";

         			} else {

				  if(!($result1)) {
				  	echo "We do not have information available for this state. Remember that the input must be a valid, capitalized state or US territory name.";
				  }
				}
				  
                                  if(($result1)) {
                                        //We are done with the result set returned above, so free it
                                        $result1->free_result();
                                  }
				
			   	// close down prepared statement
      			      	$stmt1->close();
			} else {
		           //Call to execute failed, e.g. because server is no longer reachable,
         	      	   //or because supplied values are of the wrong type
         	      	   echo "Execute failed.<br>";
			}
		} else {
       		  //A problem occurred when preparing the statement; check for syntax errors
       		  //and misspelled attribute names in the statement string.
      		  echo "Prepare failed.<br>";
      		  $error = $conn->errno . ' ' . $conn->error;
      		  echo $error;
             	}
	   } else {
	   
	     echo "Invalid input given.";
	   }
	} else {
	  echo "Factor Not Set";
	}
      
   // close the connection opened by open.php
   $conn->close();

?>
</body>

