var exchange_array = [];
function getCookie(cname) {
	var name = cname + "=";

	var ca = document.cookie.split(';');
	for(var i = 0; i <ca.length; i++) {
		var c = ca[i];

		while (c.charAt(0) == ' ') {
			c = c.substring(1);
		}

		if (c.indexOf(name) == 0) {
			return c.substring(name.length, c.length);
		}
	}

	return "";
}

function setCookie(cname, cvalue, exdays) {
	var d = new Date();
	d.setTime(d.getTime() + (exdays*24*60*60*1000));
	var expires = "expires="+ d.toUTCString();
	document.cookie = cname + "=" + cvalue + ";" + expires + ";path=/;SameSite=Strict";
}

/**
 */
function loadCurrencyPairs() {
	var xhttp = new XMLHttpRequest();

	xhttp.onreadystatechange = function() {
		if(this.readyState != 4) {
			return;
		}
		
		if(this.status != 200) {
			return;
		}

		var select = document.getElementById("currency_pair");
		for(value of JSON.parse( this.responseText )){
			var option = document.createElement('option')
		
			option.value = value["ticker"];
			option.innerHTML = value["pair"];
			exchange_array.push(value["pair"]);
			
			select.appendChild(option);
		}
	exchangerate();
	}
	
	xhttp.open("GET", "currency_pair_list.php", true);
	xhttp.send();
}

function loadForecast(currencyPair) {
	//TODO Load already calculated forecast.
}

function storeSelectedCurrencyPair() {
	setCookie("ticker", document.getElementById("currency_pair").value, 100);
}

function selectCurrencyPairs() {
	//TODO document.getElementById("currency_pair").value = getCookie("ticker");
}

function userRemoteCheck(user, pass, hash) {
	var xhttp = new XMLHttpRequest();

	xhttp.onreadystatechange = function() {
		if(this.readyState != 4) {
			return;
		}
		
		if(this.status != 200) {
			return;
		}

		//setCookie("user_email", "todor.balabanov@gmail.com", 100);
		//setCookie("user_hash", ""+(1000 + Math.floor(Math.random() * 9000)), 100);
		//TODO selectUser();
	}
console.log("user_check.php?user="+user+"&pass="+pass+"&hash="+hash+"");
	
	xhttp.open("GET", "user_check.php?user="+user+"&pass="+pass+"&hash="+hash+"", true);
	xhttp.send();
}

function selectUser() {
//	if(getCookie("user_email") !== "" && getCookie("user_hash") !== "") {
//		var user = document.getElementById("user_email").value = getCookie("user_email");
//		var hash = document.getElementById("user_hash").value = getCookie("user_hash");
//		var pass = "";
//		userRemoteCheck(user, pass, hash);
//	} else {
		var user = prompt("Имейл", "");
		var pass = prompt("Парола", "");
		var hash = getCookie("user_hash");

		if(hash === "") {
			hash = "" + (1000 + Math.floor(Math.random() * 9000));
		}

		userRemoteCheck(user, pass, hash);
//	}
}

function sendVote(direction) {
	if(direction!=="up" && direction!=="down") {
		return;
	}

	var xhttp = new XMLHttpRequest();

	xhttp.onreadystatechange = function() {
		if(this.readyState != 4) {
			return;
		}
		
		if(this.status != 200) {
			return;
		}
		//TODO Better voting result reporting to be implemented!.
		//window.alert("Voting was done ..."+this.responseText);
		var flag = this.responseText;
		if (flag == 1) {
			document.getElementById("flag").src = "check.png";
			$(".flag").fadeIn(100);
			$(".flag").fadeOut(900);
		} 
		else{
			document.getElementById("flag").src = "cross.png";
			$(".flag").fadeIn(100);
			$(".flag").fadeOut(900);
		}
	}
	
	var ticker = document.getElementById("currency_pair").value;
	var userHash = document.getElementById("user_hash").value;
	var userEmail = document.getElementById("user_email").value;

	xhttp.open("GET", "accept_vote.php?ticker="+ticker+"&vote="+direction+"&user_hash=userHash"+"&user_email=userEmail", true);
	xhttp.send();
}

function exchangerate() {
	var tsplit = [];
	var promises = [];
		for (var i = 0; i < exchange_array.length; i++) {
		tsplit = exchange_array[i].split("/");
		var url = 'https://api.exchangerate.host/latest?&source=ecb&base=' + tsplit[0] + '&symbols=' + tsplit[1];
		promises.push(fetch(url));
		}
	Promise.all(promises)
	.then( res =>{
		res.forEach(res=>{
		process(res.json());
		})
	})
	var process = (prom) =>{
		prom.then(data=>{
		document.querySelector(".date").textContent = data.date.split("-").reverse().join(".");
		document.querySelector(".exchangerate").textContent += (data.base) + '/' + JSON.stringify(data.rates).slice(2,5) + ' : ' + JSON.stringify(data.rates).slice(7,13) + ' | ';
		})
	}
}

