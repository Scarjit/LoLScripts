<?php

?>

<!DOCTYPE html>
<html lang="en">
	<head>
		<meta charset="utf-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<title>S1Auth</title>
		<link href="css/bootstrap.min.css" rel="stylesheet">
		<style>
		.vertical-center {
		  height:100%;
		  width:100%;

		  text-align: center;  /* align the inline(-block) elements horizontally */
		  font: 0/0 a;         /* remove the gap between inline(-block) elements */
		}

		.vertical-center:before {    /* create a full-height inline block pseudo=element */
		  content: " ";
		  display: inline-block;
		  vertical-align: middle;    /* vertical alignment of the inline element */
		  height: 100%;
		}

		.vertical-center > .container {
		  max-width: 100%;

		  display: inline-block;
		  vertical-align: middle;  /* vertical alignment of the inline element */
								   /* reset the font property */
		  font: 16px/1 "Helvetica Neue", Helvetica, Arial, sans-serif;
		}
		
		.jumbotron{
			background-color: #FFFFFF;
		}
		</style>
	</head>

	<body onload="load();">

		<div class="jumbotron vertical-center" id="js" style="display: none;">
			<div class="container col-xs-4 col-xs-offset-4">
				<form>
					<div class="form-group">
						<label for="uname">UserName</label>
						<input type="text" class="form-control" id="uname" placeholder="S1mple">
						<br>
						<label for="sel1">Script</label>
						<select class="form-control" id="sel1">
							<option>S1mple_Test_Script (10$)</option>
						</select>
					</div>
					<button type="button" class="btn btn-default" onclick="authcheckajax()">Am I authed</button>
					<button type="button" class="btn btn-default" onclick="buyscript()">Buy Script (PayPal)</button>
				</form>
			</div>
		</div>
		<div class="jumbotron vertical-center" id="nojs">
			You have to enable JavaScript to use this Page
		</div>

		<script async src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
		<script async src="js/bootstrap.min.js"></script>

	</body>
	<script type="text/javascript">
		function load() {
			document.getElementById("nojs").style.display = "none";
			document.getElementById("js").style.display = "block";
		}

		function authcheckajax(){
			$.ajax({
				url: "is_authed_ajax.php",
				type: 'POST',
				data: jQuery.param({username: document.getElementById("uname").value}),
				success: function(result){
		        	if(result == "Not authed"){
		        		alert("You are not authed");
		        	}else{
		        		alert(result);
		        	}
				}
			});
		}

		function buyscript() {
			alert("Buying is currently disabled");
		}
	</script>
</html>