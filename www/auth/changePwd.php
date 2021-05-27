<?php  
	require('config.php');
	
	$user = $_POST['id'];
	
	$select = $conn->query("SELECT * FROM usuario WHERE id = $user");
	if($select){
		$updt = $conn->query("UPDATE usuario SET token = null, exp_date = null where id = $user");
		$return = $conn->query("SELECT json_object('logout',true) as data");
			if($return)
				echo json_encode($return->fetch_assoc());
			
	}
	
	$conn->close();
	return;
?> 
