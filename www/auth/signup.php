<?php
	require('config.php');
	
	$user = $_POST['user'];
	$email = $_POST['email'];
	$pass = sha1($_POST['pass']);

	$query = "INSERT INTO usuario(username,email,password) VALUES('$user','$email','$pass')";

	$insert = $conn->query($query);
	
	if($insert){
		echo "{response:insertado}";
	}
	$conn->close();
	return;
?>