<?php  
	require('config.php');
	
	$id_usuario = $_POST['id'];
	
	$select = $conn->query("SELECT json_object('id',id, 'carBrand', (select json_object('name',nombre) from marca_coche where id = c.marca_coche), 'carModel', (select json_object('name',nombre) from modelo_coche where id = c.modelo_coche)) as data from coche c where usuario = $id_usuario and id = (select min(id) from coche where usuario = $id_usuario) LIMIT 1");
	
	if($select){
		$data = $select->fetch_assoc();
		echo json_encode($data);
	}
	$conn->close();
	return;
?> 
