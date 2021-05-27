<?php  
	require('config.php');
	
	$marca = $_GET['marca'];
	
	$get = $conn->query("select id as id_marca from marca_coche where nombre = '$marca'");
	echo "h";
	if($get) {
		$result = $get->fetch_assoc();
		$id_marca=$result['id_marca'];
		echo "o";
		$select = $conn->query("SELECT json_object('id',id, 'name', nombre,'engine',motor,'image',imagen) as data from modelo_coche where id_marca = $id_marca");
		echo "l";
		if($select){
			$data = array();
		
			while($row = $select->fetch_assoc()){			
				$data[] = $row['data'];
				
			}
			echo json_encode($data,JSON_UNESCAPED_SLASHES);
		}
	}
	echo "a";
	$conn->close();
	return;
?> 
