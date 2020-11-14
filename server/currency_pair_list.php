<?php
header("Content-Type: application/json; charset=UTF-8");
//TODO Load information from the database.
echo( json_encode(array("EURUSD","GBPUSD","USDJPY")) );
?>

