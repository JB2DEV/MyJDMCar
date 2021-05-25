<?php  
	require('config.php');
	
	$id_coche = $_GET['coche'];
	$id_pieza = $_GET['pieza'];
	$insert = false;
	
		//insert into piezas_coche(coche,pieza) values ($id_coche,$id_pieza)
	$query = "select id from piezas_coche where coche = $id_coche and pieza = $id_pieza";
	
	$select = $conn->query($query);
	if(mysqli_num_rows($select)==0){
		$insert = $conn->query("insert into piezas_coche(coche,pieza) values ($id_coche,$id_pieza)");
		
	}
	$check = $conn->query("select json_object('id',id,'insertado',$insert) as data from piezas_coche where coche = $id_coche and pieza = $id_pieza");
	echo json_encode($check->fetch_assoc());
	$conn->close();
	return;
?> 
