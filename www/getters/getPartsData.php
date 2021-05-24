<?php  
	require('config.php');
	
	$id_usuario = $_POST['id'];
	
		//(select nombre from marca_coche where id = c.marca_coche) as carBrand, (select nombre from modelo_coche where id = c.modelo_coche) as carModel
	$select = $conn->query("SELECT json_object('id',id, 'name', nombre_pieza, 'image',imagen,'carPartBrand',(select json_object('name',nombre) from marca_pieza where id = p.marca_pieza)) as data from pieza p where id in (select pieza from piezas_coche where coche = $id_coche)");
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
