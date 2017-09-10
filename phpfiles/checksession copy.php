
<?php
if($conn=mysqli_connect("localhost","root","","rapdrp"))
{
	//echo("succes");
}
else
{
die("Connection unuccessful".mysqli_connect_error());
}


$userid = "2";
//$sessionid = 1;
$knoquery = "SELECT * FROM crm WHERE userid = '$userid'";
$result = mysqli_query($conn, $knoquery);

//$returnValue = false;
$resultArray = array();
$numrows = $result->num_rows;
if($numrows>0){

	while($row = $result->fetch_object())
	{
		$tempArray = $row;
	    array_push($resultArray, $tempArray);
	}

	   
  
}

echo json_encode($resultArray);


mysqli_close($conn);
?>
