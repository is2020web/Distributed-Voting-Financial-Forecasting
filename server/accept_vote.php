<?php
header("Content-Type: application/json; charset=UTF-8");

include "database.php";

//TODO Prevent SQL injection!

if(isset($_GET['user_email']) == false) {
	error_log( "User email pramater is missing!" );
	die();
} else {
}

if(isset($_GET['user_hash']) == false) {
	error_log( "User hash pramater is missing!" );
	die();
} else {
}

if(isset($_GET['ticker']) == false) {
	error_log( "Ticker pramater is missing!" );
	die();
} else {
}

if(isset($_GET['vote']) == false) {
	error_log( "Vote pramater is missing!" );
	die();
}  else {
}

$conn = new mysqli($server, $user, $pass, $db);
if ($conn->connect_error) {
	error_log( "Database problem!" );
	die();
}

//TODO Use prepared statments!
//TODO Do a better report for success of failor!
$result = $conn->query( "CALL store_vote('".$_GET['user_email']."','".$_GET['user_hash']."','".$_GET['ticker']."','".$_GET['vote']."');" );

$conn->close();

//TODO echo( Succes flag! );

?>
