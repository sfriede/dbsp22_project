<!-- Sydney Friedel and Shelby Coe -->
<!-- sfriede5 and scoe4 -->
<!-- Sydney Friedel and Shelby Coe -->
<!-- sfriede5 and scoe4 -->

<head><title>Query 16 User Input</title></head>
<body>
<?php
	//open a connection to dbase server
        include 'open.php';



        //get user input and perform error-checking on it
        $state1 = $_POST['q16state1'];
	$state2 = $_POST['q16state2'];

	$state1Valid = 0;
	$state2Valid = 0;

	
        if(!empty($state1)) {
                $state1 = trim($state1);
                if (strcmp($state1, 'Alabama') == 0 || strcmp($state1, 'Alaska') == 0 || strcmp($state1, 'Arizona') == 0 ||
                strcmp($state1, 'Arkansas') == 0 || strcmp($state1, 'California') == 0 || strcmp($state1, 'Colorado') == 0 ||
                strcmp($state1, 'Connecticut') == 0 || strcmp($state1, 'Delaware') == 0 || strcmp($state1, 'Flordia') == 0 ||
                strcmp($state1, 'Georgia') == 0 || strcmp($state1, 'Hawaii') == 0 || strcmp($state1, 'Idaho') == 0 ||
                strcmp($state1, 'Illinois') == 0 || strcmp($state1, 'Indiana') == 0 || strcmp($state1, 'Iowa') == 0 ||
                strcmp($state1, 'Kansas') == 0 || strcmp($state1, 'Kentucky') == 0 || strcmp($state1, 'Louisiana') == 0 ||
                strcmp($state1, 'Maine') == 0 || strcmp($state1, 'Maryland') == 0 || strcmp($state1, 'Massachusetts') == 0 ||
                strcmp($state1, 'Michigan') == 0 || strcmp($state1, 'Minnesota') == 0 || strcmp($state1, 'Mississippi') == 0 ||
                strcmp($state1, 'Missouri') == 0|| strcmp($state1, 'Montana') == 0 || strcmp($state1, 'Nebraska') == 0 ||
                strcmp($state1, 'Nevada') == 0 || strcmp($state1, 'New Hampshire') == 0 || strcmp($state1, 'New Jersey') == 0 ||
                strcmp($state1, 'New Mexico') == 0 || strcmp($state1, 'New York') == 0 || strcmp($state1, 'North Carolina') == 0 ||
                strcmp($state1, 'North Dakota') == 0 || strcmp($state1, 'Ohio') == 0 || strcmp($state1, 'Oklahoma') == 0 ||
                strcmp($state1, 'Oregon') == 0 || strcmp($state1, 'Pennsylvania') == 0 || strcmp($state1, 'Rhode Island') == 0 ||
                strcmp($state1, 'South Carolina') == 0 || strcmp($state1, 'South Dakota') == 0 || strcmp($state1, 'Tennessee') == 0 ||
                strcmp($state1, 'Texas') == 0 || strcmp($state1, 'Utah') == 0 || strcmp($state1, 'Vermont') == 0 ||
                strcmp($state1, 'Virginia') == 0 || strcmp($state1, 'Washington') == 0 || strcmp($state1, 'West Virginia') == 0 ||
                strcmp($state1, 'Wisconsin') == 0 || strcmp($state1,'Wyoming') == 0 || strcmp($state1, 'Washington DC') == 0 ||
                strcmp($state1, 'Puerto Rico') == 0 || strcmp($state1, 'Washington D.C.') == 0 || strcmp($state1, 'Guam') == 0 ||
                strcmp($state1, 'US Virgin Islands') == 0 ||  strcmp($state1, 'Northern Mariana Islands') == 0 ||
                strcmp($state1, 'American Samoa') == 0 ||  strcmp($state1, 'Midway Atoll') == 0 ||  strcmp($state1, 'Palmyra Atoll') == 0 ||
                strcmp($state1, 'Baker Island') == 0 ||  strcmp($state1,'Howland Island') == 0 ||  strcmp($state1, 'Jarvis Island') == 0 ||
                strcmp($state1, 'Johnston Atoll') == 0 ||  strcmp($state1, 'Kingman Reef') == 0 || strcmp($state1, 'Wake Island') == 0 ||
                strcmp($state1, 'Navassa Island') == 0) {
				
				 $state1Valid = 1;
				 }} 

	        if(!empty($state2)) {
                $state2 = trim($state2);
                if (strcmp($state2, 'Alabama') == 0 || strcmp($state2, 'Alaska') == 0 || strcmp($state2, 'Arizona') == 0 ||
                strcmp($state2, 'Arkansas') == 0 || strcmp($state2, 'California') == 0 || strcmp($state2, 'Colorado') == 0 ||
                strcmp($state2, 'Connecticut') == 0 || strcmp($state2, 'Delaware') == 0 || strcmp($state2, 'Flordia') == 0 ||
                strcmp($state2, 'Georgia') == 0 || strcmp($state2, 'Hawaii') == 0 || strcmp($state2, 'Idaho') == 0 ||
                strcmp($state2, 'Illinois') == 0 || strcmp($state2, 'Indiana') == 0 || strcmp($state2, 'Iowa') == 0 ||
                strcmp($state2, 'Kansas') == 0 || strcmp($state2, 'Kentucky') == 0 || strcmp($state2, 'Louisiana') == 0 ||
                strcmp($state2, 'Maine') == 0 || strcmp($state2, 'Maryland') == 0 || strcmp($state2, 'Massachusetts') == 0 ||
                strcmp($state2, 'Michigan') == 0 || strcmp($state2, 'Minnesota') == 0 || strcmp($state2, 'Mississippi') == 0 ||
                strcmp($state2, 'Missouri') == 0|| strcmp($state2, 'Montana') == 0 || strcmp($state2, 'Nebraska') == 0 ||
                strcmp($state2, 'Nevada') == 0 || strcmp($state2, 'New Hampshire') == 0 || strcmp($state2, 'New Jersey') == 0 ||
                strcmp($state2, 'New Mexico') == 0 || strcmp($state2, 'New York') == 0 || strcmp($state2, 'North Carolina') == 0 ||
                strcmp($state2, 'North Dakota') == 0 || strcmp($state2, 'Ohio') == 0 || strcmp($state2, 'Oklahoma') == 0 ||
                strcmp($state2, 'Oregon') == 0 || strcmp($state2, 'Pennsylvania') == 0 || strcmp($state2, 'Rhode Island') == 0 ||
                strcmp($state2, 'South Carolina') == 0 || strcmp($state2, 'South Dakota') == 0 || strcmp($state2, 'Tennessee') == 0 ||
                strcmp($state2, 'Texas') == 0 || strcmp($state2, 'Utah') == 0 || strcmp($state2, 'Vermont') == 0 ||
                strcmp($state2, 'Virginia') == 0 || strcmp($state2, 'Washington') == 0 || strcmp($state2, 'West Virginia') == 0 ||
                strcmp($state2, 'Wisconsin') == 0 || strcmp($state2,'Wyoming') == 0 || strcmp($state2, 'Washington DC') == 0 ||
                strcmp($state2, 'Puerto Rico') == 0 || strcmp($state2, 'Washington D.C.') == 0 || strcmp($state2, 'Guam') == 0 ||
                strcmp($state2, 'US Virgin Islands') == 0 ||  strcmp($state2, 'Northern Mariana Islands') == 0 ||
                strcmp($state2, 'American Samoa') == 0 ||  strcmp($state2, 'Midway Atoll') == 0 ||  strcmp($state2, 'Palmyra Atoll') == 0 ||
                strcmp($state2, 'Baker Island') == 0 ||  strcmp($state2,'Howland Island') == 0 ||  strcmp($state2, 'Jarvis Island') == 0 ||
                strcmp($state2, 'Johnston Atoll') == 0 ||  strcmp($state2, 'Kingman Reef') == 0 || strcmp($state2, 'Wake Island') == 0 ||
                strcmp($state2, 'Navassa Island') == 0) {

                                 $state2Valid = 1;
                                 } }


	if ($state1Valid == 1 && $state2Valid == 1) {
	 echo "<h4>For 2 states of your choice, how do the difference between their median incomes and average teacher starting salaries compare, as well as their educational performance in terms of average SAT/ACT/NAEP scores? Note that not all educational information may be available for some states.</h4>";

          //prepare statements and call queries
           if ($stmt = $conn->prepare("CALL Query16UI(?, ?)")) {
	   $stmt->bind_param("ss", $state1, $state2);
            //Run the actual query
            if ($stmt->execute()) {

               //Store result set generated by the prepared statement
               $result = $stmt->get_result();

               if (($result) && ($result->num_rows != 0)) {
		  
		  echo "States Chosen: $state1 and $state2";


	                       //Create table to display results
                               echo "<table border=\"1px solid black\">";
                               echo "<tr><th> State </th> <th> Median Income - Average Teacher Starting Salary</th><th> (National Average for Income-Salary Difference) - This State's Difference</th><th>Average SAT Score</th><th>Average ACT Score</th><th>NAEP Reading Score</th><th>NAEP Math Score </th></tr>";
                               //Report result set by visiting each row in it
                               while ($row = $result->fetch_row()) {

                                     echo "<tr>";
                                     echo "<td>".$row[0]."</td>";
                                     echo "<td>".$row[1]."</td>";
				     echo "<td>".$row[2]."</td>";
                                     echo "<td>".$row[3]."</td>";
                                     echo "<td>".$row[4]."</td>";
				     echo "<td>".$row[5]."</td>";
				     echo "<td>".$row[6]."</td>";
                                     echo "</tr>";
                                     }

                                     echo "</table>";               	  	 

				 } else {

				 if(!($result)) {
                        	    echo "Error: We do not have records for at least one of these states/territories in our educational and/or economic datasets";
                  	      		 }
				 }

				 if(($result)) {
                         	  //We are done with the result set returned above, so free it
                              	   $result->free_result();
                  	  	   }

			    // close down prepared statement
                    	   $stmt->close();
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

		  echo "Invalid input given. Remember that both names provided must be valid, capitalized U.S. states or territories";

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