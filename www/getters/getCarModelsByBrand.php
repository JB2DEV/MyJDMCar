<?php  
	require('config.php');
	
	$marca = $_POST['marca'];
	
		
	$select = $conn->query("SELECT json_object('id',id, 'name', nombre,'engine',motor,'image',imagen) as data from modelo_coche where id_marca = $marca");
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
