<?php  
	require('config.php');
	
	$id_pieza = $_GET['id'];
	
		//(select nombre from marca_coche where id = c.marca_coche) as carBrand, (select nombre from modelo_coche where id = c.modelo_coche) as carModel
	$select = $conn->query("select json_object('id',id,'name',nombre_pieza,'description',descripcion,'image',imagen,'url',url,'carPartBrand',(select json_object('id',id,'name',nombre,'image',imagen) from marca_pieza where id = p.marca_pieza)) as data from pieza p where id = $id_pieza");
	if($select){
		$row = $select->fetch_assoc();
		echo json_encode($row,JSON_UNESCAPED_SLASHES);
	}
	
	$conn->close();
	return;
?> 
