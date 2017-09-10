
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

$exists = "SELECT * FROM users where userid = '$unino'";
$existsquery = mysqli_query($conn, $exists);
$numrows = $existsquery->num_rows;
if($numrows==1){
  	//$row = mysqli_fetch_array($existsquery,MYSQLI_ASSOC);
$updatepass = "UPDATE users SET pass = '$pass' WHERE userid = '$unino'";
$updatepassquery = mysqli_query($conn, $updatepass);

}
else{
$checkuser = "INSERT INTO users VALUES('$unino','$pass')";


$userid = mysqli_query($conn, $checkuser);
}




mysqli_close($conn);
?>
