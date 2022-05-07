<!-- Sydney Friedel and Shelby Coe -->
<!-- sfriede5 and scoe4 -->

<head><title>Query 17</title></head>
<body>
<?php
	//open a connection to dbase server
        include 'open.php';

		   echo "<h3>In order of least to most racially diverse, what is each state's real GDP and median household income?</h3>";
		   echo "<h5> Diversity Index is calculated as: 10,000 * (1/average percentage * state's percentage) for the percent of each state's population that is a particular race (white, black, asian, indigenous, other). This equation comes from: https://archives.huduser.gov/healthycommunities/sites/default/files/public/Racial%20Diversity%20using%20Shannon-Wiener%20Index.pdf </h5>";

		   //prepare statement and call query
			if ($stmt1 = $conn->prepare("CALL Query17()")) {

      			   //Run the actual query
      			   if ($stmt1->execute()) {

         		      //Store result set generated by the prepared statement
         		      $result1 = $stmt1->get_result();

         		      if (($result1) && ($result1->num_rows != 0)) {

			         //construct an array in which we'll store our data
                                 $dataPointsGDP = array();
            		         $dataPointsIncome = array();
				 
            		       while ($row1 = $result1->fetch_row()) {
			             array_push($dataPointsGDP, array("y"=> $row1[2], "x"=> $row1[1], "label"=>$row1[0]));
                                     array_push($dataPointsIncome, array("y"=> $row1[3], "x"=> $row1[1], "label"=>$row1[0]));
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
                        text: "Real GDP as a Function of Diversity ",
                        fontFamily: "verdana",
                        fontWeight: "bold",
                        fontSize: 18,
                },
                data: [{
                        type: "bar", //change type to column, bar, line, area, pie, etc
                        dataPoints: <?php echo json_encode($dataPointsGDP, JSON_NUMERIC_CHECK); ?>
                }],
                axisX:{
                        title:"Diversity Index",
			labelFormatter: function ( e ) {
                                return e.value; },
			minimum: 1,

                 },
                 axisY:{
                        title:"State Real GDP ($)",
                 }

        });

        chart.render();

        var chart = new CanvasJS.Chart("container2", {
                animationEnabled: true,
                exportEnabled: true,
                theme: "light1", // "light1", "light2", "dark1", "dark2"
                title:{
                        text: "Median Income as a Function of Diversity",
                        fontFamily: "verdana",
                        fontWeight: "bold",
                        fontSize: 18,
                },
                dataPointWidth: 10,
                data: [{
                        type: "bar", //change type to column, bar, line, area, pie, etc
                        dataPoints: <?php echo json_encode($dataPointsIncome, JSON_NUMERIC_CHECK); ?>
                }],
                axisX:{
                        title:"Diversity Index",
			labelFormatter: function ( e ) {
                                return e.value; },
			minimum: 1
                 },
                 axisY:{
                        title:"Median Income ($)",
                 }

        });
        chart.render();
}
</script>
</head>
<body>
<script src="https://canvasjs.com/assets/script/canvasjs.min.js"></script>
<br>
<div id="container1" style="height: 400px; width: 100%;"></div>
<div id="container2" style="height: 400px; width: 100%;"></div>
     <style>
        body {font-family: 'verdana'; font-size: 18px;}
     </style>

</body>
</html>
		
		