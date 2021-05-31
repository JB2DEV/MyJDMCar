<?php 
	$para      = 'mrbema222@gmail.com';
$titulo    = '[MyJDMCar] - Solicitud de cambio de contraseña';
$pass = bin2hex(random_bytes(8));
echo $pass;
$mensaje   = 'La contraseña temporal es: '.$pass;
//$cabeceras = 'From: no-reply@myjdmcar.com';
$cabeceras = 'From: mrbema222@gmail.com';


$enviado = mail($para, $titulo, $mensaje, $cabeceras);

echo $enviado;
return;
?>