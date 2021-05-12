<?php  
	require('config.php');
	
	$user = $_POST['user'];
	$pass = sha1($_POST['pass']);
	
	$select = $conn->query("SELECT case when password = '$pass' then 'success' else 'error' END as RESPONSE FROM `usuario` WHERE email = '$user'");
	if($select){
		echo json_encode($select->fetch_assoc());
	}
	
	$conn->close();
	return;
?> 
