<?php  
	require('config.php');
	$id_marca = $_POST['marca'];
	$id_coche = $_POST['id'];
	
	$select = $conn->query("SELECT json_object('id',id,'name',nombre,'image',imagen) as data from pieza where marca_pieza = $id_marca and modelo_coche = (select modelo_coche from coche where id = $id_coche)");
	if($select){
$data = array();
	
		while($row = $select->fetch_assoc()){			
			$data[] = $row['data'];
		}
		echo json_encode($data,JSON_UNESCAPED_SLASHES);;
	}
	
	$conn->close();
	return;
?> 
