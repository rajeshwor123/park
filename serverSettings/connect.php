<?php
	$server = "localhost";
	$username = "root";
	$password = "";
	$db = "flutterdb";

	$con = mysqli_connect($server,$username,$password,$db);
	if(!$con){
		die('connection failed'. mysqli_connect_error);
	}
?>