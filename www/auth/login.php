<?php  
	require('config.php');
	
	$user = $_POST['user'];
	$pass = sha1($_POST['pass']);
	
	$t = sha1(bin2hex(random_bytes(128)));
	
	$select = $conn->query("SELECT case when password = '$pass' then 'success' else 'error' END as response, case when password = '$pass' then concat('{\"id\":',id,',\"userName\":\"',username,'\",\"email\":\"$user\",\"token\":\"$t\"}') else 'null' end as data FROM `usuario` WHERE email = '$user'");
	if($select){
		$updt = $conn->query("UPDATE usuario SET token = '$t', exp_date = DATE_ADD(CURDATE(),INTERVAL 1 DAY) where email = '$user'");
		echo json_encode($select->fetch_assoc());
	}
	
	$conn->close();
	return;
?> 
