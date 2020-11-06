<!DOCTYPE html>
<html lang="bg">

<head>
<meta charset="UTF-8">
<meta name="author" content="Тодор Балабанов">
<meta name="keywords" content="финансово прогнозиране, FOREX, система за гласуване">
<meta name="description" content="Разпределена система за финансово прогнозиране, чрез гласуване на множество потребители.">

<title>Distributed Voting Financial Forecasting</title>

<link rel="stylesheet" href="style.css">
<!-- <script src=""> -->
</head>

<body>
<h1>Distributed Voting Financial Forecasting</h1>
<hr/>

<div>
	<div>
		<!-- Зона за показване на вече изчислени прогнози. --->
	</div>

	<div class="field">
		<form action="accept_vote.php" method="get">
			<!-- TODO Идентификатора на потребителя да се взема от базата данни при поискване на страницата. -->
			<input type="hidden" name="used_id" value="">

			<!-- TODO Валутите трябва да се попълнят от базата данни. -->
			<p>
			Какво е вашето очакване за промяната на курса
 			<select id="currency_pair" name="currency_pair">
				<option value="EURUSD">EUR/USD</option>
			</select>
			?
			</p>

			<br/>
			<button id="vote_up" name="vote" value="up">Увеличение</button> 
			<button id="vote_down" name="vote" value="down">Намаление</button>
		</form>
	</div>
</div>

<hr/>
<footer>
&copy; 2020 "Информационно обслужване" АД
</footer>

</body>
</html>
