<?php  
	require('config.php');
	
	$id_coche = $_POST['id'];
	//concat('{\"id\":', id, ',\"nombre\":\"', nombre, '\",\"motor\":\"', motor,'\",\"potencia\":\"', potencia,'\",\"transmision\":\"', transmision,'\",\"imagen\":\"', imagen,'\",\"descripcion\":\"', descripcion,'\"}') as data
		//json_object('id',id,'nombre',nombre,'motor',motor,'potencia',potencia,'transmision',transmision,'imagen',imagen,'descripcion',descripcion) 
	$select = $conn->query("SELECT * from modelo_coche where id = (SELECT modelo_coche FROM coche WHERE id = $id_coche)");
	
	if($select){
		$data = $select->fetch_assoc();
		echo json_encode($data);
	}
	$conn->close();
	return;
?> 
