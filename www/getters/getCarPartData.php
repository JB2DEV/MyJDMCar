<?php  
	require('config.php');
	
	$id_coche = $_POST['id'];
	$id_tipo = $_POST['typeId'];
	
		//(select nombre from marca_coche where id = c.marca_coche) as carBrand, (select nombre from modelo_coche where id = c.modelo_coche) as carModel
		
	if($id_tipo == 0) $query = "select json_object('id',id,'name',nombre,'description',descripcion,'image',imagen,'url',url,'carPartBrand',(select json_object('name',nombre,'image',imagen,'description',descripcion) from marca_pieza where id = p.marca_pieza)) as data from pieza p where id in (select pieza from piezas_coche where coche = $id_coche)";
	else $query = "select json_object('id',id,'name',nombre,'description',descripcion,'image',imagen,'url',url,'carPartBrand',(select json_object('name',nombre,'image',imagen,'description',descripcion) from marca_pieza where id = p.marca_pieza)) as data from pieza p where id in (select pieza from piezas_coche where coche = $id_coche) and tipo = $id_tipo+1 ";
	$select = $conn->query($query);
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
