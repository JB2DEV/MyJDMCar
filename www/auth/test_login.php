<?php  
	require('config.php');
	

	$pass = sha1('asdf1234');
	$t = bin2hex(random_bytes(128));
	$select = $conn->query("SELECT case when password = '$pass' then 'success' else 'error' END as response, case when password = '$pass' then concat('{\"id\":',id,',\"userName\":\"',username,'\",\"email\":\"mail9@gmail.com\",\"token\":\"', case when token is null then \"null\" else token end,'\"}') else 'null' end as data FROM `usuario` WHERE email = 'mail9@gmail.com'");
	if($select){
		
		
		$updt = $conn->query("UPDATE usuario SET token = '$t', exp_date = DATE_ADD(CURDATE(),INTERVAL 2 DAY) where email = 'mail9@gmail.com'");
		echo json_encode($select->fetch_assoc());
	}
	
	$conn->close();
	return;
?> 
