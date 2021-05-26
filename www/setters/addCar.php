<?php  
	require('config.php');
	
	$id_marca = $_POST['marca'];
	$id_modelo = $_POST['modelo'];
	$id_user = $_POST['user'];
	
	$insert = $conn->query("insert into coche(marca_coche,modelo_coche,usuario) values ($id_marca,$id_modelo,$id_user)");
	if($insert){
		$return = $conn->query("SELECT json_object('insert',true,'id',max(id)) as data from coche where marca_coche = $id_marca and modelo_coche = $id_modelo and usuario = $id_user");
		echo json_encode($return->fetch_assoc());
	}else{
		$return = $conn->query("select json_object('insert',false) as data");
		echo json_encode($return->fetch_assoc());			
	}
	
	$conn->close();
	return;
?> 
