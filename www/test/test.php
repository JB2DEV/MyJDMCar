<?php 
	$user = $_GET['mail'];

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
    $mail->addAddress('mrbema222@gmail.com', "mrbema222");  // receiver's email and name

    $mail->Subject = '[MyJDMCar] - Solicitud de cambio de contraseña';
    $mail->Body    = 'La contraseña temporal es: '.$pass;

    $mail->send();
    //echo 'Message has been sent';
	echo '<br>'. $pass;
	$encr_pwd = sha1($pass);
	echo '<br>'. $encr_pwd;
	$updt = $conn->query("UPDATE usuario SET `password`='$encr_pwd' where `email`='$user'");
	if($updt){
		echo "updated";
	}
} catch (Exception $e) { // handle error.
    echo 'Message could not be sent. Mailer Error: ', $mail->ErrorInfo;
}
$conn->close();
?>