<?php

error_log("" . $_GET['currency_pair']));
error_log("" . $_GET['vote']));

if(isset($_GET['used_hash']) == false) {
	echo( "Currency pair pramater is missing!" );
} else if($_GET['used_hash'] == '') {
	//TODO Идентификатора на потребителя трябва да се верифицира според данните в базата данни.
} else {
	echo( "Invlid input!" );
}

if(isset($_GET['ticker']) == false) {
	echo( "Currency pair pramater is missing!" );
} else if($_GET['ticker'] == 'EURUSD') {
	//TODO Да се прави проверка за всички валутни двойки, поддържани в базата данни.
	echo( "EUR/USD ..." );
} else {
	echo( "Invlid input!" );
}

if(isset($_GET['vote']) == false) {
	echo( "Vote pramater is missing!" );
} else if($_GET['vote'] == 'up') {
	echo( "Vote Up ..." );
} else if($_GET['vote'] == 'down') {
	echo( "Vote Down ..." );
} else {
	echo( "Invlid input!" );
}

?>
