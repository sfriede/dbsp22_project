<!-- Sydney Friedel and Shelby Coe -->
<!-- sfriede5 and scoe4 -->

<head><title>Query 14</title></head>
<body>
<?php
	//open a connection to dbase server
        include 'open.php';


	//Override the PHP configuration file to display all errors
	//This is useful during development but generally disabled before release
	ini_set('error_reporting', E_ALL);
	ini_set('display_errors', true);

		   //prepare statements and call queries
           if ($stmt3 = $conn->prepare("CALL Query14()")) {

            //Run the actual query
            if ($stmt3->execute()) {

               //Store result set generated by the prepared statement
               $result3 = $stmt3->get_result();

               if (($result3) && ($result3->num_rows != 0)) {
                //construct an array in which we'll store our data
                  $dataPoints = array();
                //Report result set by visiting each row in it
                while ($row3 = $result3->fetch_row()) {
                      array_push($dataPoints, array("y"=> $row3[1]));
                  }

                 } else {

                   if(!($result3)) {
                         echo "Internal error: procedure failed";
                   }
                 }

                   if(($result3)) {
                         //We are done with the result set returned above, so free it
                         $result3->free_result();
                   }

                 // close down prepared statement
                 $stmt3->close();
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
<script type="text/javascript">
window.onload = function () {
        var chart = new CanvasJS.Chart("container5", {
                animationEnabled: true,
                exportEnabled: true,
                theme: "light1", // "light1", "light2", "dark1", "dark2"
                title:{
                        text: "Graduation Rates for State with the Lowest Poverty Levels",
                        fontFamily: "verdana",
                        fontWeight: "bold",
			            fontSize: 18,
                },
                data: [{
                        type: "bar", //change type to column, bar, line, area, pie, etc
                        dataPoints: <?php echo json_encode($dataPoints, JSON_NUMERIC_CHECK); ?>,
                        toolTipContent: "<b>{label} </b>",
                }],
                axisX:{
                        title:"Poverty LevelS",
                        labelFontSize: 14,
                        interval: 1
                 },
                 axisY:{
                        title:"Graduation Rate",
                 }

        });
        chart.render();

}
</script>
</head>
<body>
        <script type="text/javascript" src="https://canvasjs.com/assets/script/canvasjs.min.js"></script>
        <h3 style = "font-family: 'verdana'">What is the average graduation rate of each state for the ten states with the lowest poverty levels</h3>
        <div id="container5" style="height: 100%; width: 100%;display: inline-block;"></div>

     <style>
        body {font-family: 'verdana'; font-size: 18px;}
     </style>

</body>
</html>