<?php  
	require('config.php');
	
	$user = $_POST['id'];
	$pass = sha1($_POST['pwd']);
	$actual = sha1($_POST['actual']);
	
	$select = $conn->query("SELECT * FROM usuario WHERE id = $user and password = '$actual'");
	if($select){
		$updt = $conn->query("UPDATE usuario SET password = '$pass' where id = $user");
		$return = $conn->query("SELECT json_object('changed',true) as data");
			if($return)
				echo json_encode($return->fetch_assoc());
			
	}
	
	$conn->close();
	return;
?> 
