<?php
	require('config.php');
	
	$user = $_POST['user'];
	$email = $_POST['email'];
	$pass = sha1($_POST['pass']);

	$check = $conn->query("SELECT * FROM usuario WHERE email = '$email'");
	if($check){
		if($check->fetch_assoc() != null){
			echo "{\"response\":\"duplicado\"}";
		}else{
			$query = "INSERT INTO usuario(username,email,password) VALUES('$user','$email','$pass')";

			$insert = $conn->query($query);
			if($insert){
				$return = $conn->query("SELECT 'insertado' as response, concat('{\"id\":',id,',\"userName\":\"',username,'\",\"email\":\"',email,'\",\"token\":\"', case when token is null then \"null\" else token end,'\"}') as data FROM usuario where email = '$email'");
				echo json_encode($return->fetch_assoc());
				 
			}
		}
	}
	$conn->close();
	return;
?>