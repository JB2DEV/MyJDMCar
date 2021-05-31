<?php  
	require('config.php');


	$id_usuario = $_POST['id'];
	
		//(select nombre from marca_coche where id = c.marca_coche) as carBrand, (select nombre from modelo_coche where id = c.modelo_coche) as carModel
	$select = $conn->query("SELECT json_object('id',id, 'carBrand', (select json_object('name',nombre) from marca_coche where id = c.marca_coche), 'carModel', (select json_object('name',nombre,'engine',motor) from modelo_coche where id = c.modelo_coche)) as data from coche c where usuario = $id_usuario");
	if($select){
		$data = array();
	
		while($row = $select->fetch_assoc()){			
			$data[] = $row['data'];
		}
		echo json_encode($data,JSON_UNESCAPED_SLASHES);
	}
	
	$conn->close();
	return;
?> 
