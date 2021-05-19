<?php  
	require('config.php');
	$select = $conn->query("SELECT * FROM usuario");
	$data = array();
	
	while($row = $select->fetch_assoc()){
		$data[] = $row;
	}
	echo json_encode($data);
	$conn->close();
	return;
 ?> 
