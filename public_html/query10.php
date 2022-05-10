<!-- Sydney Friedel and Shelby Coe -->
<!-- sfriede5 and scoe4 -->

<head><title>Query 10</title></head>
<body>
<?php
	//open a connection to dbase server
        include 'open.php';

        //get user input and perform error-checking on it
        $q6state = $_POST['q10state'];


        if(!empty($q6state)) {
                $q6state = trim($q6state);
                if (strcmp($q6state, 'Alabama') == 0 || strcmp($q6state, 'Alaska') == 0 || strcmp($q6state, 'Arizona') == 0 ||
		strcmp($q6state, 'Arkansas') == 0 || strcmp($q6state, 'California') == 0 || strcmp($q6state, 'Colorado') == 0 ||
		strcmp($q6state, 'Connecticut') == 0 || strcmp($q6state, 'Delaware') == 0 || strcmp($q6state, 'Flordia') == 0 ||
		strcmp($q6state, 'Georgia') == 0 || strcmp($q6state, 'Hawaii') == 0 || strcmp($q6state, 'Idaho') == 0 ||
		strcmp($q6state, 'Illinois') == 0 || strcmp($q6state, 'Indiana') == 0 || strcmp($q6state, 'Iowa') == 0 ||
		strcmp($q6state, 'Kansas') == 0 || strcmp($q6state, 'Kentucky') == 0 || strcmp($q6state, 'Louisiana') == 0 ||
		strcmp($q6state, 'Maine') == 0 || strcmp($q6state, 'Maryland') == 0 || strcmp($q6state, 'Massachusetts') == 0 ||
		strcmp($q6state, 'Michigan') == 0 || strcmp($q6state, 'Minnesota') == 0 || strcmp($q6state, 'Mississippi') == 0 ||
		strcmp($q6state, 'Missouri') == 0|| strcmp($q6state, 'Montana') == 0 || strcmp($q6state, 'Nebraska') == 0 ||
		strcmp($q6state, 'Nevada') == 0 || strcmp($q6state, 'New Hampshire') == 0 || strcmp($q6state, 'New Jersey') == 0 ||
		strcmp($q6state, 'New Mexico') == 0 || strcmp($q6state, 'New York') == 0 || strcmp($q6state, 'North Carolina') == 0 ||
		strcmp($q6state, 'North Dakota') == 0 || strcmp($q6state, 'Ohio') == 0 || strcmp($q6state, 'Oklahoma') == 0 ||
		strcmp($q6state, 'Oregon') == 0 || strcmp($q6state, 'Pennsylvania') == 0 || strcmp($q6state, 'Rhode Island') == 0 ||
		strcmp($q6state, 'South Carolina') == 0 || strcmp($q6state, 'South Dakota') == 0 || strcmp($q6state, 'Tennessee') == 0 ||
		strcmp($q6state, 'Texas') == 0 || strcmp($q6state, 'Utah') == 0 || strcmp($q6state, 'Vermont') == 0 ||
		strcmp($q6state, 'Virginia') == 0 || strcmp($q6state, 'Washington') == 0 || strcmp($q6state, 'West Virginia') == 0 ||
		strcmp($q6state, 'Wisconsin') == 0 || strcmp($q6state,'Wyoming') == 0 || strcmp($q6state, 'Washington DC') == 0 ||
		strcmp($q6state, 'Puerto Rico') == 0 || strcmp($q6state, 'Washington D.C.') == 0 || strcmp($q6state, 'Guam') == 0 ||
		strcmp($q6state, 'US Virgin Islands') == 0 ||  strcmp($q6state, 'Northern Mariana Islands') == 0 ||
		strcmp($q6state, 'American Samoa') == 0 ||  strcmp($q6state, 'Midway Atoll') == 0 ||  strcmp($q6state, 'Palmyra Atoll') == 0 ||
		strcmp($q6state, 'Baker Island') == 0 ||  strcmp($q6state,'Howland Island') == 0 ||  strcmp($q6state, 'Jarvis Island') == 0 ||
		strcmp($q6state, 'Johnston Atoll') == 0 ||  strcmp($q6state, 'Kingman Reef') == 0 || strcmp($q6state, 'Wake Island') == 0 ||
		strcmp($q6state, 'Navassa Island') == 0) {
 
		   echo "<h3>In descending order of education spending per pupil, see each states highschool graduation rate and percent of adults who have completed at least some part of college. How do these statistics compare for $q6state? </h3>";

		   //prepare statement and call query
			if ($stmt1 = $conn->prepare("CALL Query10()")) {

      			   //Run the actual query
      			   if ($stmt1->execute()) {

         		      //Store result set generated by the prepared statement
         		      $result1 = $stmt1->get_result();

         		      if (($result1) && ($result1->num_rows != 0)) {

			         //construct an array in which we'll store our data
                                 $dataPointsHigh = array();
            		         $dataPointsCollege = array();
				 
            		       while ($row1 = $result1->fetch_row()) {
			             array_push($dataPointsHigh, array("y"=> $row1[2], "x"=> $row1[1], "label"=>$row1[0]));
                                     array_push($dataPointsCollege, array("y"=> $row1[3], "x"=> $row1[1], "label"=>$row1[0]));
			       }
	
               		       	  
         			} else {

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
		
 		 if ($stmt4 = $conn->prepare("CALL Query7()")) {

                           //Run the actual query
                           if ($stmt4->execute()) {

                              //Store result set generated by the prepared statement
                              $result4 = $stmt4->get_result();

                              if (($result4) && ($result4->num_rows != 0)) {

                              echo "<h3> Does teacher salary play a role in this? For states with the highest highschool graduation rate and average SAT/ACT scores, here are the average teacher starting salaries</h3>";

                              //Create table to display results
                               echo "<table border=\"1px solid black\">";
                               echo "<tr><th> State </th> <th> Average Teacher Starting Salary</th></tr>";
                               //Report result set by visiting each row in it
                               while ($row4 = $result4->fetch_row()) {
			      
                                     echo "<tr>"; 
                                     echo "<td>".$row4[1]."</td>"; 
                                     echo "<td>".$row4[0]."</td>"; 
                                     echo "</tr>";
                                     }

                                     echo "</table>";

                                } else {

                                  if(!($result4)) {
                                        echo "Internal error: procedure failed";
                                  }
                                }
                                  if(($result4)) {
                                        //We are done with the result set returned above, so free it
                                        $result4->free_result();
                                  }

                                // close down prepared statement
                                $stmt4->close();
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

                 if ($stmt5  = $conn->prepare("CALL Query7UI(?)")) {
		    	   $stmt5->bind_param("s", $q6state);

                           //Run the actual query
                           if ($stmt5->execute()) {

                              //Store result set generated by the prepared statement
                              $result5 = $stmt5->get_result();

                              if (($result5) && ($result5->num_rows != 0)) {

                              echo "<h3> Here is the average teacher starting salary for $q6state, along with how far it deviates from the mean high school graduation rate and percent of adults who've completed college for all states.</h3>";

                              //Create table to display results
                               echo "<table border=\"1px solid black\">";
                               echo "<tr><th> Average Teacher Starting Salary </th> <th> Deviation from Mean High School Graduation Rate (%) </th><th> Deviation from Mean Percent of Adults Completing College (%)</th></tr>";
			       
                               //Report result set by visiting each row in it
                               while ($row5 = $result5->fetch_row()) {
                                     echo "<tr>";
		                     echo "<td>".$row5[0]."</td>";
                                     echo "<td>".$row5[1]."</td>";
                                     echo "<td>".$row5[2]."</td>";
                                     echo "</tr>";
                                     }
                                     echo "</table>";

                                } else {

                                  if(!($result5)) {
                                     echo "<br>We do not have information available for $q6state. Remember that the input must be a valid, capitalized state or US territory name.<br>";
                                  }
                                }
                                  if(($result5)) {
                                        //We are done with the result set returned above, so free it
                                        $result5->free_result();
                                  }

                                // close down prepared statement
                                $stmt5->close();
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
             echo "Invalid input given. Remember that the input must be a valid, capitalized state or US territory name";
          }
        } else {
          echo "State Name Not Set";
        }
	

      
   // close the connection opened by open.php
   $conn->close();

?>
</body>

<html>
<head>  
<script>
window.onload = function () {
        var chart = new CanvasJS.Chart("container1", {
                animationEnabled: true,
                exportEnabled: true,
                theme: "light1", // "light1", "light2", "dark1", "dark2"
                title:{
                        text: "High School Graduation Rate as a Function of Education Spending Per Pupil ",
                        fontFamily: "verdana",
                        fontWeight: "bold",
                        fontSize: 18,
                },
                data: [{
                        type: "line", //change type to column, bar, line, area, pie, etc
                        dataPoints: <?php echo json_encode($dataPointsHigh, JSON_NUMERIC_CHECK); ?>
                }],
                axisX:{
                        title:"Education Spending Per Pupil ($)",
			labelFormatter: function ( e ) {
                                return e.value; }

                 },
                 axisY:{
                        title:"High School Graduation Rate",
                 }

        });

        chart.render();

        var chart = new CanvasJS.Chart("container2", {
                animationEnabled: true,
                exportEnabled: true,
                theme: "light1", // "light1", "light2", "dark1", "dark2"
                title:{
                        text: "Percent Completing College as a Function of Education Spending Per Pupil",
                        fontFamily: "verdana",
                        fontWeight: "bold",
                        fontSize: 18,
                },
                data: [{
                        type: "line", //change type to column, bar, line, area, pie, etc
                        dataPoints: <?php echo json_encode($dataPointsCollege, JSON_NUMERIC_CHECK); ?>
                }],
                axisX:{
                        title:"Education Spending Per Pupil ($)",
			labelFormatter: function ( e ) {
                                return e.value; }

                 },
                 axisY:{
                        title:"Percent Completing College",
                 }

        });
        chart.render();
}
</script>
</head>
<body>
<script src="https://canvasjs.com/assets/script/canvasjs.min.js"></script>
<br>
<div id="container1" style="height: 300px; width: 100%;"></div>
<div id="container2" style="height: 300px; width: 100%;"></div>
     <style>
        body {font-family: 'verdana'; font-size: 18px;}
     </style>

</body>
</html>
		
		