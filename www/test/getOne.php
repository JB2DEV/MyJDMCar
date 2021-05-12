<?php  
	require('config.php');
	
	$user = $_POST['user'];
	
	$insert = $conn->query("SELECT * FROM usuario WHERE username = '$user'");
	if($insert){
		echo json_encode($insert->fetch_assoc());
	}
	
	$conn->close();
	return;
?> 
