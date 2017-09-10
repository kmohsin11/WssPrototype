
<?php
if($conn=mysqli_connect("localhost","root","","rapdrp"))
{
	//echo("succes");
}
else
{
die("Connection unuccessful".mysqli_connect_error());
}


$kno = $_POST["kno"];
$mobno = $_POST["mobno"];
//$unino = "mohsin";
//$pass = "mm";
$checkuser = "SELECT * FROM crm where kno = '$kno'";


$userid = mysqli_query($conn, $checkuser);

//	while($row = $userid->fetch_object())
//	{
		// Add each row into our results array
//		echo json_encode($row);
//	}
//$row = mysqli_fetch_array($userid,MYSQLI_ASSOC);
//$numrows = $mysqli_num_rows($userid);
$numrows=$userid->num_rows;
	//echo json_encode($row["pass"]);
//echo $userid;
//echo ($userid+"");
  if($numrows==1){
   $row = mysqli_fetch_array($userid,MYSQLI_ASSOC);
  	$usermobno =  $row["mobno"];
//echo $pass+"";
  	if($usermobno==$mobno){
$result = True;
  	}
  	else{
$result = False;
  	}
  }
  else{
$result = False;
  }
  //$result.append("a"=>8);

  echo json_encode($result);


mysqli_close($conn);
?>
