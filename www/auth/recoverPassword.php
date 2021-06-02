<?php 
	$user = $_POST['mail'];

use PHPMailer\PHPMailer\PHPMailer;
use PHPMailer\PHPMailer\Exception;
use SMTP\SMTP;
require('config.php');
require 'Exception.php';
require('PHPMailer.php');
require('SMTP.php');

$pass = bin2hex(random_bytes(4));
$mail = new PHPMailer(true);                              
try {
	//$mail->SMTPDebug = 2;
	$mail->isHTML(true);
    $mail->isSMTP(); // using SMTP protocol                                     
    $mail->Host = 'smtp.gmail.com'; // SMTP host as gmail 
    $mail->SMTPAuth = true;  // enable smtp authentication                             
    $mail->Username = 'noreply.myjdmcar@gmail.com';  // sender gmail host              
    $mail->Password = '4dm1n4dm1n'; // sender gmail host password                          
                      
	$mail->SMTPSecure = PHPMailer::ENCRYPTION_STARTTLS;
    $mail->Port = 587;   // port for SMTP     
	$mail->SMTPOptions = array(
		'ssl' => array(
				'verify_peer' => false,
				'verify_peer_name' => false,
				'allow_self_signed' => true
			)
		);

    $mail->setFrom('noreply.myjdmcar@gmail.com', "No-Reply"); // sender's email and name
    $mail->addAddress("$user", "$user");  // receiver's email and name

    $mail->Subject = utf8_decode('[MyJDMCar] - Solicitud de cambio de contraseña');
    $mail->Body    = '<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
	<meta http-equiv="content-type" content="text/html; charset=windows-1252"/>
	<title></title>
	<meta name="generator" content="LibreOffice 6.3.2.2 (Windows)"/>
	<meta name="created" content="2021-06-02T17:08:58.635000000"/>
	<meta name="changed" content="2021-06-02T17:51:28.192000000"/>
	<style type="text/css">
		@page { size: 21cm 29.7cm; margin: 2cm }
		p { margin-bottom: 0.25cm; line-height: 115%; background: transparent }
		a:link { color: #000080; so-language: zxx; text-decoration: underline }
		a:visited { color: #800000; so-language: zxx; text-decoration: underline }
	</style>
</head>
<body lang="es-ES" link="#000080" vlink="#800000" dir="ltr"><p align="center" style="margin-bottom: 0cm; line-height: 100%">
<div><img src="http://bema222.com/banner.png" alt="banner" width="600" height="300" /></div>
<div>
<h2>Ha solicitado reestablecer su contrase&ntilde;a.</h2>
<p>Su contrase&ntilde;a provisional es:</p>
<h4>'.$pass.'</h4>
</div>
<footer>
<p>El equipo de MyJDMCar</p>
</footer>
</body>
</html>';
	
    $mail->send();
    //echo 'Message has been sent';
	
	$encr_pwd = sha1($pass);
	
	$updt = $conn->query("UPDATE usuario SET `password`='$encr_pwd' where `email`='$user'");
	if($updt){
		$return = $conn->query("SELECT json_object('changed',true) as data");
			if($return)
				echo json_encode($return->fetch_assoc());
	}
} catch (Exception $e) { // handle error.
    echo 'Message could not be sent. Mailer Error: ', $mail->ErrorInfo;
}
$conn->close();
?>