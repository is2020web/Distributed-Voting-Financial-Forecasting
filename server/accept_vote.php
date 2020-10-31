<!DOCTYPE html>
<html lang="bg">

<body>
<?php

if(isset($_GET['used_id']) == false){
	echo( "Currency pair pramater is missing!" );
} else if($_GET['used_id'] == ''){
	//TODO Идентификатора на потребителя трябва да се верифицира според данните в базата данни.
} else {
	echo( "Invlid input!" );
}

if(isset($_GET['currency_pair']) == false){
	echo( "Currency pair pramater is missing!" );
} else if($_GET['currency_pair'] == 'EURUSD'){
	//TODO Да се прави проверка за всички валутни двойки, поддържани в базата данни.
	echo( "EUR/USD ..." );
} else {
	echo( "Invlid input!" );
}

if(isset($_GET['vote']) == false){
	echo( "Vote pramater is missing!" );
} else if($_GET['vote'] == 'up'){
	echo( "Vote Up ..." );
} else if($_GET['vote'] == 'down'){
	echo( "Vote Down ..." );
} else {
	echo( "Invlid input!" );
}

?>
</body>
</html>