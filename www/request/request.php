<?php 
	$user = $_POST['id'];
	$marca = $_POST['marca'];
	$modelo = $_POST['modelo'];
	$info = $_POST['info'];
	if($info=='null'){
		$folder = "./coche/";
	}else{
		$folder = "./pieza/";
	}
	$date = getdate();	
	$filename =$folder.strval($user)."_".($date['mday']<10?'0'.strval($date['mday']):strval($date['mday'])).($date['mon']<10?'0'.strval($date['mon']):strval($date['mon'])).strval($date['year'])."_".	($date['hours']+2<10?'0'.strval($date['hours']+2):strval($date['hours']+2)).($date['minutes']<10?'0'.strval($date['minutes']):strval($date['minutes'])).($date['seconds']<10?'0'.strval($date['seconds']):strval($date['seconds'])).".txt";
	$file = fopen($filename, "w");
	fwrite($file,$marca.",".$modelo.",".$info);
	fclose($file);
	
	return json_encode(true); 
?>