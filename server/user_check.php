<?php
header("Content-Type: application/json; charset=UTF-8");

include "database.php";

//TODO Prevent SQL injection!

if(isset($_GET['user']) == false) {
	error_log( "User email pramater is missing!" );
	die();
} else {
}

//TODO Plain text passwords are very bad approach!
if(isset($_GET['pass']) == false) {
	error_log( "User password pramater is missing!" );
	die();
} else {
}

if(isset($_GET['hash']) == false) {
	error_log( "User hash pramater is missing!" );
	die();
} else {
}

$conn = new mysqli($server, $user, $pass, $db);
if ($conn->connect_error) {
	error_log( "Database problem!" );
	die();
}

//TODO Use prepared statments!
$result = $conn->query( "CALL user_check('".$_GET['email']."','".$_GET['pass']."','".$_GET['hash']."');" );

$conn->close();

//TODO Return response!

?>
