<?php
	include "connect.php";

	$email = $_POST["email"];
	$userPassword = $_POST["password"];

	$query = "select * from userinfo where email ='$email' and userPassword ='$userPassword' ";
	$data = array();
	$result = $con->query($query);
	while($row = $result->fetch_assoc()){
		$data[] = $row;
	}
	echo json_encode($data);
?>