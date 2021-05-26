<?php  
	require('config.php');
	
		
	$select = $conn->query("SELECT json_object('id',id, 'name', nombre, 'image',imagen) as data from marca_coche");
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
