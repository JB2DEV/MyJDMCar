<?php  
	require('config.php');
	
	$marca = $_POST['marca'];
	
	$get = $conn->query("select id as id_marca from marca_coche where nombre = '$marca'");
	
	if($get) {
		$result = $get->fetch_assoc();
		$id_marca=$result['id_marca'];
		
		$select = $conn->query("SELECT json_object('id',id, 'name', nombre,'engine',motor,'image',imagen) as data from modelo_coche where marca_coche = $id_marca");
		
		if($select){
			$data = array();
			
			while($row = $select->fetch_assoc()){			
				$data[] = $row['data'];
				
			}
			echo json_encode($data,JSON_UNESCAPED_SLASHES);
		}
	}
	
	$conn->close();
	return;
?> 
