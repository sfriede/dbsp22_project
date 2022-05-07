<!-- Sydney Friedel and Shelby Coe -->
<!-- sfriede5 and scoe4 -->

<head><title>Delete Health</title></head>
<body>
<?php
	//open a connection to dbase server
        include 'open.php';


	//get user input and perform error-checking on it
	$state = $_POST['demographicsDelState'];
	
	if(!empty($state)) {

			   if ($stmt1 = $conn->prepare("CALL DeleteDemographics(?)")) {
                           $stmt1->bind_param("s", $state);

                           //Run the actual query
                           if ($stmt1->execute()) {

                              //Store result set generated by the prepared statement
                              $result1 = $stmt1->get_result();
			      
			      //the result will contain whether or not such a state's record existed in the health table, so we can report that
                              if (($result1) && ($result1->num_rows != 0)) {
                              echo "Attempted to delete a record for ".$state." from the Demographics Table";

                              //Create table to display results
                               echo "<table border=\"1px solid black\">";
                               echo "<tr><th> Deletion Result </th></tr>";

                               //Report result set by visiting each row in it
                               while ($row1 = $result1->fetch_row()) {
                                    echo "<tr>";
                                        echo "<td>".$row1[0]."</td>";
                                        echo "</tr>";
                                    }
                                     echo "</table>";
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

	  echo "State name not set";
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
