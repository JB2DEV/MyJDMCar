<?php  
	require('config.php');
	
	$user = $_POST['user'];
	$pass = sha1($_POST['pass']);
	
	$select = $conn->query("SELECT case when password = '$pass' then 'success' else 'error' END as response, case when password = '$pass' then concat('{\"id\":',id,',\"userName\":\"',username,'\",\"email\":\"$user\",\"token\":\"', case when token is null then \"null\" else token end,'\"}') else 'null' end as data FROM `usuario` WHERE email = '$user'");
	if($select){
		echo json_encode($select->fetch_assoc());
	}
	
	$conn->close();
	return;
?> 
