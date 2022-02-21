<?php
	include "connect.php";

	$email = $_POST["email"];
	$userPassword = $_POST["password"];
	$phone = $_POST["phone"];
	$username = $_POST["username"];	

/*
	$email = "rn";
	$userPassword = "rn";
	$phone ="rn";
	$username ="rn";

*/

	$checkQuery = "select * from userinfo where email ='$email'";
	$doQuery = "insert into userinfo (phone, email , userName , userPassword ) values ('$phone', '$email', '$username', '$userPassword')";
	$data = array();
	$result = $con->query($checkQuery);
	while($row = $result->fetch_assoc()){
		$data[] = $row;
	}
	if(empty($data)){
		$result = $con->query($doQuery);
		echo json_encode($result);
	}
	else{
	echo json_encode(empty($data));
	}
?>
