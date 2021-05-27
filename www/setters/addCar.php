<?php  
	require('config.php');
	
	$modelo = $_POST['modelo'];
	$id_user = $_POST['user'];
	
	$select = $conn->query("select marca_coche as id_marca, id as id_modelo from modelo_coche where concat(nombre,' (',motor,')') = '$modelo'");
	if($select) {
		$result = $select->fetch_assoc();
		$id_marca=$result['id_marca'];
		$id_modelo=$result['id_modelo'];
		
		$insert = $conn->query("insert into coche(marca_coche,modelo_coche,usuario) values ($id_marca,$id_modelo,$id_user)");
		if($insert){
			$return = $conn->query("SELECT json_object('insert',true,'car',json_object('id',id,'carBrand',(select json_object('name',nombre) from marca_coche where id = c.marca_coche), 'carModel', (select json_object('nombre',nombre) from modelo_coche where id = c.modelo_coche))) as data from coche c where marca_coche = $id_marca and modelo_coche = $id_modelo and usuario = $id_user and id=(select max(id) from coche where marca_coche = $id_marca and modelo_coche = $id_modelo and usuario = $id_user)");
			if($return)
				echo json_encode($return->fetch_assoc());
		}else{
			$return = $conn->query("select json_object('insert',false) as data");
			echo json_encode($return->fetch_assoc());			
		}
	}
	$conn->close();
	return;
?> 
