
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


$sessionid = $_POST["sessionid"];
//$sessionid = 1;
$sessionidquery = "SELECT * FROM session WHERE sessionid = '$sessionid'";
$result = mysqli_query($conn, $sessionidquery);

//$returnValue = false;
$returnValue = array();
$numrows = $result->num_rows;
if($numrows==1){
	   $row = mysqli_fetch_array($result,MYSQLI_ASSOC);
	   $userid = $row['userid'];
	$x = ['userid' => $userid];
	$y = ['status' => true];
 array_push($returnValue,$y);
 array_push($returnValue,$x);
  

}
else{
		$y = ['status' => false];
		  array_push($returnValue,$y);


}

echo json_encode($returnValue);
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
