<?php  
	require('config.php');
	
	$user = $_POST['id'];
	$pass = sha1($_POST['pwd']);
	$actual = sha1($_POST['actual']);
	
	$select = $conn->query("SELECT case when password = '$actual' then true else false end as ok FROM usuario WHERE id = $user");
	if($select){
		if($select->fetch_assoc()['ok']){
		$updt = $conn->query("UPDATE usuario SET password = '$pass' where id = $user");
		$return = $conn->query("SELECT json_object('changed',true) as data");
			if($return)
				echo json_encode($return->fetch_assoc());
		}else{
		$return = $conn->query("SELECT json_object('changed',false) as data");
			if($return)
				echo json_encode($return->fetch_assoc());
		}
	}
	
	$conn->close();
	return;
?> 
