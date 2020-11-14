<?php
header("Content-Type: application/json; charset=UTF-8");

include "database.php";

$valuse = array();

$conn = new mysqli($server, $user, $pass, $db);

if ($conn->connect_error) {
	echo( json_encode($values) );
	die();
}

//TODO Да няма SQL заявки в PHP, а да се викат процедури или изгледи.
$result = $conn->query( "SELECT ticker, name FROM currency_pair ORDER BY ticker" );
while($row = $result->fetch_assoc()) {
	$values[] = $row; 
}

echo( json_encode($values) );

$conn->close();
?>

