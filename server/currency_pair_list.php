<?php
header("Content-Type: application/json; charset=UTF-8");

include "database.php";

$valuse = array();

$conn = new mysqli($server, $user, $pass, $db);

if ($conn->connect_error) {
	echo( json_encode($values) );
	die();
}

$result = $conn->query( "SELECT ticker, name FROM currency_pair" );
while($row = $result->fetch_assoc()) {
	$values[] = $row; 
}

echo( json_encode($values) );

$conn->close();
?>

