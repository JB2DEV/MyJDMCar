<?php 
	$date = getdate();
	$filename ="user_".strval($date['mday']).strval($date['mon']).strval($date['year'])."_".strval($date['hours']).strval($date['minutes']).strval($date['seconds']).".txt";
	$file = fopen($filename, "w");
	fwrite($file,"hola");
	fclose($file);
	return;


?>