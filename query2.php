<!-- Sydney Friedel and Shelby Coe -->
<!-- sfriede5 and scoe4 -->

<head><title>Query 2</title></head>
<body>
<?php
	//open a connection to dbase server
        include 'open.php';


	//Override the PHP configuration file to display all errors
	//This is useful during development but generally disabled before release
	ini_set('error_reporting', E_ALL);
	ini_set('display_errors', true);

	//get user input and perform error-checking on it
	$teenPregRate = $_POST['teenPregRate'];

	$resultsNotFound = 0;

	if(isset($teenPregRate)) {

		if (is_numeric($teenPregRate) && $teenPregRate >= 0 && $teenPregRate <= 100) {
		
   		   //input is within range, so we can make stored procedure calls safely
		   echo "<h2>Household income change for the states where the teen pregancy rate is above or below $teenPregRate%</h2><br>";

		   //call stored procedures defined on dbase

		   
		   
		   //values for states above and below threshold
		
			if ($stmt1 = $conn->prepare("CALL Query2HigherUserInput(?)")) {
      			   $stmt1->bind_param("d", $teenPregRate);

      			   //Run the actual query
      			   if ($stmt1->execute()) {

         		      //Store result set generated by the prepared statement
         		      $result1 = $stmt1->get_result();

         		      if (($result1) && ($result1->num_rows != 0)) {

			         //construct an array in which we'll store our data
        			 $dataPoints1 = array();

            		     
            		       //Report result set by visiting each row in it
            		       while ($row1 = $result1->fetch_row()) {
			       	     array_push($dataPoints1, array( "y"=> $row1[1], "label"=> $row1[0]));
            			     }

         			} else {
        			  if ($result1->num_rows == 0) {
				     	
				     	echo "No states have a teen pregnancy rate above this threshold";
					$resultsNotFound = 1;				     
				  }

				  if(!($result1)) {
				  	echo "Internal error: procedure failed";
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

		//get states with teen pregnancy rate below this threshold
		 if ($stmt2 = $conn->prepare("CALL Query2LowerUserInput(?)")) {
                           $stmt2->bind_param("d", $teenPregRate);

                           //Run the actual query
                           if ($stmt2->execute()) {

                              //Store result set generated by the prepared statement
                              $result2 = $stmt2->get_result();

                              if (($result2) && ($result2->num_rows != 0)) {
                                //construct an array in which we'll store our data
                                 $dataPoints2 = array();


                               //Report result set by visiting each row in it
                               while ($row2 = $result2->fetch_row()) {
                                     array_push($dataPoints2, array( "y"=> $row2[1], "label"=> $row2[0]));
                                     }

                                } else {
                                  if ($result2->num_rows == 0) {
				      
                                        echo "No states have a teen pregnancy rate below this threshold";
					$resultsNotFound = 1;
                                  }

                                  if(!($result2)) {
                                        echo "Internal error: procedure failed";
                                  }
                                }

                                  if(($result2)) {
                                        //We are done with the result set returned above, so free it
					 $result2->free_result();
				  }

                                // close down prepared statement
                                $stmt2->close();
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
		}	
	   } else {
	   
	     echo "Input must be a decimal between 0 and 100, inclusive";
	   }
	} else {
	  echo "Threshhold Not Set";
	}

	//if there were not states with a tenn pregnancy rate above or below this threshold, just show all information for all states in a table
	if ($resultsNotFound == 1) {
	   	echo "<br>";
	   	echo "<h5> Here are the teen pregnancy rates and median incomes for all states for which this information was available </h5>";
                    if ($stmt2 = $conn->prepare("SELECT Health.stateName, Health.teenPregnancyRate, Economy.medianIncome FROM Health JOIN Economy ON Health.stateName = Economy.stateName")) {

                           //Run the actual query
                           if ($stmt2->execute()) {

                              //Store result set generated by the prepared statement
                              $result2 = $stmt2->get_result();


                              if (($result2) && ($result2->num_rows != 0)) {

                              //Create table to display results
                               echo "<table border=\"1px solid black\">";
			       echo "<tr><th> State </th> <th> Teen Pregnancy Rate </th> <th> Median Income </th> </tr>";
                               //Report result set by visiting each row in it
                               while ($row2 = $result2->fetch_row()) {
                                    echo "<tr>";
                                        echo "<td>".$row2[0]."</td>";
                                        echo "<td>".$row2[1]."</td>";
                                        echo "<td>".$row2[2]."</td>";
                                        
                                        echo "</tr>";
                                    }

                                     echo "</table>";

                                }

                               if(($result2)) {
                               //We are done with the result set returned above, so free it
                                    $result2->free_result();
                               }
                                // close down prepared statement
                                $stmt2->close();

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




	}
      
   // close the connection opened by open.php
   $conn->close();

?>
</body>

<html>
<head>
<script type="text/javascript">
window.onload = function () {
	
        var chart = new CanvasJS.Chart("container1", {
                animationEnabled: true,
                exportEnabled: true,
                theme: "light1", // "light1", "light2", "dark1", "dark2"
                title:{
                        text: "Median Household Income for States with Teen Pregnancy Rate Above Threshold",
			fontFamily: "verdana",
			fontWeight: "bold"
                },
                data: [{
                        type: "line", //change type to column, bar, line, area, pie, etc
                        dataPoints: <?php echo json_encode($dataPoints1, JSON_NUMERIC_CHECK); ?>
                }],
		axisX:{
 		  interval: 1
	        }
        });
      	chart.render();
	
        var chart = new CanvasJS.Chart("container2", {
                animationEnabled: true,
                exportEnabled: true,
                theme: "light2", // "light1", "light2", "dark1", "dark2"
                title:{
                        text: "Median Household Income for States with Teen Pregnancy Rate Below Threshold",
			fontFamily: "verdana",
			fontWeight: "bold"
                },
                data: [{
                        type: "line", //change type to column, bar, line, area, pie, etc
                        dataPoints: <?php echo json_encode($dataPoints2, JSON_NUMERIC_CHECK); ?>
                }],
                axisX:{
                  interval: 1
                }

        });
	
	chart.render();
}
</script>
</head>
<body>
        <script type="text/javascript" src="https://canvasjs.com/assets/script/canvasjs.min.js"></script>

        <div id="container1" style="height: 300px; width: 100%;display: inline-block;"></div>
        <div id="container2" style="height: 300px; width: 100%;display: inline-block;"></div>  
     <style>
        body {font-family: 'verdana'; font-size: 18px;}
     </style>

</body>
</html>


