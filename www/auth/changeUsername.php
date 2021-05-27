<?php  
	require('config.php');
	
	$user = $_POST['id'];
	$username = $_POST['user'];
	
	$select = $conn->query("SELECT * FROM usuario WHERE id = $user");
	if($select){
		$updt = $conn->query("UPDATE usuario SET username = '$username' where id = $user");
		$return = $conn->query("SELECT json_object('changed',true) as data");
			if($return)
				echo json_encode($return->fetch_assoc());
			
	}
	
	$conn->close();
	return;
?> 
