<?php
header("Content-Type: application/json; charset=UTF-8");

include "database.php";

if(isset($_GET['used_email']) == false) {
	error_log( "User email pramater is missing!" );
	die();
} else {
	error_log( "Invlid input!" );
	die();
}

if(isset($_GET['used_hash']) == false) {
	error_log( "User hash pramater is missing!" );
	die();
} else {
	error_log( "Invlid input!" );
	die();
}

if(isset($_GET['ticker']) == false) {
	error_log( "Ticker pramater is missing!" );
	die();
} else {
	error_log( "Invlid input!" );
	die();
}

if(isset($_GET['vote']) == false) {
	error_log( "Vote pramater is missing!" );
	die();
}  else {
	error_log( "Invlid input!" );
	die();
}

$conn = new mysqli($server, $user, $pass, $db);
if ($conn->connect_error) {
	error_log( "Database problem!" );
	die();
}

$result = $conn->query( "CALL store_vote();" );
while($row = $result->fetch_assoc()) {
}

$conn->close();

//TODO echo( Succes flag! );

?>
