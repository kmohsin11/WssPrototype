
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
$pass = $_POST["passw"];
//$unino = "mohsin";
//$pass = "mm";
$checkuser = "SELECT * FROM users where userid = '$unino'";


$userid = mysqli_query($conn, $checkuser);

//	while($row = $userid->fetch_object())
//	{
		// Add each row into our results array
//		echo json_encode($row);
//	}
//$numrows = $mysqli_num_rows($userid);
$numrows=$userid->num_rows;
	//echo json_encode($row["pass"]);
//echo $userid;
//echo ($userid+"");
  if($numrows==1){
   //$row = mysqli_fetch_array($userid,MYSQLI_ASSOC);
  	$row = mysqli_fetch_array($userid,MYSQLI_ASSOC);

  	$userpass =  $row["pass"];
//echo $pass+"";
  	if($userpass==$pass){
$result = array("status"=>1);
  	}
  	else{
$result = array("status"=>2);
  	}
  }
  else{
$result = array("status"=>0);
  }
  //$result.append("a"=>8);

  echo json_encode($result);
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
