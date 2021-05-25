<?php  
	require('config.php');
	
	$id_coche = $_POST['coche'];
	$id_pieza = $_POST['pieza'];
	$insert = false;
	
		//insert into piezas_coche(coche,pieza) values ($id_coche,$id_pieza)
	$query = "select id from piezas_coche where coche = $id_coche and pieza = $id_pieza";
	
	$select = $conn->query($query);
	
	if(mysqli_num_rows($select)==0){
		$insert = $conn->query("insert into piezas_coche(coche,pieza) values ($id_coche,$id_pieza)");
		if($insert){
			$return = $conn->query("SELECT json_object('insert',true,'id',id) as data from piezas_coche where coche = $id_coche and pieza = $id_pieza");
			echo json_encode($return->fetch_assoc());
		}
	}else{
		$return = $conn->query("select json_object('insert',false) as data");
		echo json_encode($return->fetch_assoc());			
	}
	
	$conn->close();
	return;
?> 
