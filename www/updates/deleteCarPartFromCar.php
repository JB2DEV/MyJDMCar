<?php  
	require('config.php');
	
	$id_coche = $_POST['coche'];
	$id_pieza = $_POST['pieza'];
	
	$query = "select id from piezas_coche where coche = $id_coche and pieza = $id_pieza";
	
	$select = $conn->query($query);
	
	if(mysqli_num_rows($select)==0){
		$return = $conn->query("select json_object('delete',false) as data");
		echo json_encode($return->fetch_assoc());	
	}else{		
		$delete = $conn->query("delete from piezas_coche where coche = $id_coche and pieza = $id_pieza");
		if($delete){
			$return = $conn->query("SELECT json_object('delete',true) as data");
			echo json_encode($return->fetch_assoc());
		}	
	}
	
	$conn->close();
	return;
?> 
