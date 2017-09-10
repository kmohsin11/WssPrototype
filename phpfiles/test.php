
<?php
if($conn=mysqli_connect("localhost","root","","rapdrp"))
{
	//echo("succes");
}
else
{
die("Connection unuccessful".mysqli_connect_error());
}

//$name1 = $_POST["name"];



 
// Check if there are results

//$unino = $_POST["userid"];


//$userid = $_POST["userid"];
$userid = "2";
//$sessionid = 1;
$knoquery = "SELECT * FROM crm WHERE mobno = '$userid'";
$result = mysqli_query($conn, $knoquery);

//$returnValue = false;
$resultArray = array();
$numrows = $result->num_rows;
if($numrows>0){

	while($row = $result->fetch_array(MYSQLI_ASSOC ))
	{
		// Add each row into our results array
		echo($row['kno']);
		$tempArray = $row;
	    array_push($resultArray, $tempArray);
	}

	   
  
}

echo json_encode($resultArray);
/*
$sql = "SELECT * FROM users";
if ($result = mysqli_query($conn, $sql))
{
	// If so, then create a results array and a temporary one
	// to hold the data
	$resultArray = array();
	$tempArray = array();
 
	// Loop through each row in the result set
	while($row = $result->fetch_object())
	{
		// Add each row into our results array
		$tempArray = $row;
	    array_push($resultArray, $tempArray);
	}
 
	// Finally, encode the array to JSON and output the results
	echo json_encode($resultArray);

}
*/

mysqli_close($conn);
?>
