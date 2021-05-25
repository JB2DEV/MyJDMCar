<?php  
	require('config.php');
	
	$id_coche = $_POST['coche'];
	$id_pieza = $_POST['pieza'];
	
	
		//(select nombre from marca_coche where id = c.marca_coche) as carBrand, (select nombre from modelo_coche where id = c.modelo_coche) as carModel
	$query = "insert into coche_piezas(coche,pieza) values ($id_coche,$id_pieza)";
	
	$select = $conn->query($query);
	if($select){
		
		echo json_encode($select,JSON_UNESCAPED_SLASHES);;
	}
	
	$conn->close();
	return;
?> 
