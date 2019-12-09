<script>
	function PrintChallenge() {
		var challenge = [
			["CAML LESSON","Comment définir une fonction récursive ?"],
			["PYTHON LESSON","Quels sont les deux types de boucles et comment les utiliser ?"],
			["C# LESSON","Que signifie le mot clé 'void' ?"],
			["CAML TEST","Écrire une fonction find_power qui, avec deux entiers x et n, retourne la première puissance de x supérieure ou égale à n."],
			["PYTHON TEST","Écrire une fonction qui détermine si un entier strictement supérieur à 1 est premier ou non (avec des boucles)."],
			["C# TEST","Écrire une fonction qui calcule x × y en n’utilisant que des additions, des multiplications par 2 et des divisions par 2."],
			["CAML TIME TRIAL","Écrire une fonction qui, avec deux entiers x et y, retourne leur produit. Vous n'avez le droit d'utiliser que des additions.", "Temps : 4 minutes"],
			["PYTHON TIME TRIAL","Inverser tous les caractères d'une string.", "Temps : 3 minutes"],
			["C# TIME TRIAL","Afficher dans une console, 'Hello {{ nom }}' avec nom une variable rentrée par l'utilisateur.", "Temps : 2 minutes"]
			];
		var random = Math.floor(Math.random() * challenge.length)
		document.getElementById("main").innerHTML = challenge[random][0];
		document.getElementById("sub").innerHTML = challenge[random][1];
		if (challenge[random][2]) {
			document.getElementById("sub2").innerHTML = challenge[random][2];
		} else {
			document.getElementById("sub2").innerHTML = "";
		}
	}
</script>

<style>
	body {
		background: #404040;
		color: #191919;
		text-align: center;
		font-family: Arial;
		padding: 50px;
	}
	
	input {
		width: 220px;
		height: 105px;
		font-weight: bold;
		padding: 20px;
		background: #464646;
		color: #191919;
		border: 3px solid black;
		font-size: 20px;
	}
	
	h1, h3 {
		font-weight: normal;
	}
	
	h1 {
		font-size: 40px;
	}
</style>

<body>
	<h1 id="main"></h1>
	<h3 id="sub"></h3>
	<h3 id="sub2"></h3>
	
	<input type="button" onclick="PrintChallenge()" value="NEW CHALLENGE" />
</body>