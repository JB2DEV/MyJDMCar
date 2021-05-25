<?php  
	require('config.php');
	
	$id_coche = $_POST['id'];
	
	$select = $conn->query("SELECT json_object('id',id,'name',nombre,'image',imagen) as data from marca_pieza where id in (SELECT DISTINCT marca_pieza FROM pieza WHERE modelo_coche = (select modelo_coche from coche where id = $id_coche))");
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
