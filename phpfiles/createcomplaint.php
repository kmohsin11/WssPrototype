
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

$unino = $_POST["userid"];
$kno = $_POST["kno"];
$type = $_POST["type"];
//$unino = 2;
//$kno = 2;
//$type = "Load Change";
$requestid = uniqid();
$days = "10";
$status = "0";
$datetoday = date("Y-m-d");
$requestidquery = "INSERT INTO complaints VALUES('$kno','$requestid','$days','$status','$datetoday','$unino','$type')";
$result = mysqli_query($conn, $requestidquery);

echo $result;

 // echo json_encode($sessionid);
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
