<?php  
	require('config.php');
	
		
	$select = $conn->query("SELECT json_object('id',id-1, 'name', nombre, 'icon',imagen) as data from tipo_pieza");
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
