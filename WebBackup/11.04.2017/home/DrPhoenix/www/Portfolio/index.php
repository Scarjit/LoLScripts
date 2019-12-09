<?php
function getUserIP()
{
    $client  = @$_SERVER['HTTP_CLIENT_IP'];
    $forward = @$_SERVER['HTTP_X_FORWARDED_FOR'];
    $remote  = $_SERVER['REMOTE_ADDR'];
    if(filter_var($client, FILTER_VALIDATE_IP))
    {
        $ip = $client;
    }
    elseif(filter_var($forward, FILTER_VALIDATE_IP))
    {
        $ip = $forward;
    }
    else
    {
        $ip = $remote;
    }
    return $ip;
}

//Get Visitor IP
$user_ip = getUserIP();

//Unset Visitor Time Cookie
if(isset($_COOKIE["t0"])){
    unset($_COOKIE["t0"]);
    setcookie("t0",null,-1,"/");
}
//Set Visitor Time Cookie to time()
setcookie("t0", time()*1000);
?>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>DrPhoenix Portfolio</title>
		<link rel="icon" type="image/png" href="../img/icon.png" />
		<link rel="stylesheet" href="../style.css">
		<link rel="stylesheet" href="../fonts.css">
		<link rel="stylesheet" href="style.css">
	</head>
	
	<body onbeforeunload="do_update()">
		<div class="content">
			<div class="nav">
				<?php include("../menu.php"); ?>
			</div>
			
			<div class="main">
				<h1 class="portfolio_title">My Portfolio</h1>
				<h1 class="portfolio_title" style="font-size: 20px !important;">(click each icon to see my work)</h1>
				
				<center>
					<a href="http://s1mplescripts.de/DrPhoenix/Portfolio/DrPhoenix/" class="portfolio_user">
						<div class="contributor">
							<img src="DrPhoenix.png" class="portfolio_user_logo">
							<p class="portfolio_user_text">DrPhoenix</p>
						</div>
					</a>
					
					<a href="http://s1mplescripts.de/DrPhoenix/Portfolio/JaiKor/" class="portfolio_user">
						<div class="staff">
							<img src="JaiKor.png" class="portfolio_user_logo">
							<p class="portfolio_user_text">JaiKor</p>
						</div>
					</a>
					
					<a href="http://s1mplescripts.de/DrPhoenix/Portfolio/Identity/" class="portfolio_user">
						<div class="staff">
							<img src="Identity.gif" class="portfolio_user_logo">
							<p class="portfolio_user_text">Identity</p>
						</div>
					</a>
					
					<a href="http://s1mplescripts.de/DrPhoenix/SAC/" class="portfolio_user">
						<div class="developer">
							<img src="Sida.png" class="portfolio_user_logo">
							<p class="portfolio_user_text">Sida</p>
						</div>
					</a>
					
					<a href="http://s1mplescripts.de/DrPhoenix/Portfolio/S1mple/" class="portfolio_user">
						<div class="scripter">
							<img src="S1mple.png" class="portfolio_user_logo">
							<p class="portfolio_user_text">S1mple</p>
						</div>
					</a>
					
					<a href="http://s1mplescripts.de/DrPhoenix/Portfolio/spyk/" class="portfolio_user">
						<div class="scripter">
							<img src="spyk.png" class="portfolio_user_logo">
							<p class="portfolio_user_text">spyk</p>
						</div>
					</a>
					
					<a href="http://s1mplescripts.de/DrPhoenix/Portfolio/Izsha/" class="portfolio_user">
						<div class="contributor">
							<img src="Izsha.png" class="portfolio_user_logo">
							<p class="portfolio_user_text">Izsha</p>
						</div>
					</a>
					
					<a href="http://s1mplescripts.de/DrPhoenix/Portfolio/HeRoBaNd/" class="portfolio_user">
						<div>
							<img src="HeRoBaNd.png" class="portfolio_user_logo">
							<p class="portfolio_user_text">HeRoBaNd</p>
						</div>
					</a>
					
					<a href="http://s1mplescripts.de/DrPhoenix/Portfolio/Navimus/" class="portfolio_user">
						<div>
							<img src="Navimus.png" class="portfolio_user_logo">
							<p class="portfolio_user_text">Navimus</p>
						</div>
					</a>
					
					<a href="http://s1mplescripts.de/DrPhoenix/Portfolio/Katsuke/" class="portfolio_user">
						<div>
							<img src="Katsuke.png" class="portfolio_user_logo">
							<p class="portfolio_user_text">Katsuke</p>
						</div>
					</a>
					
					<a href="http://s1mplescripts.de/DrPhoenix/Portfolio/STR8FROMDAH00d/" class="portfolio_user">
						<div>
							<img src="STR8FROMDAH00d.png" class="portfolio_user_logo">
							<p class="portfolio_user_text">STR8FROMDAH00d</p>
						</div>
					</a>
					
					<a href="http://s1mplescripts.de/DrPhoenix/Portfolio/Luffy/" class="portfolio_user">
						<div>
							<img src="Luffy.png" class="portfolio_user_logo">
							<p class="portfolio_user_text">Monkey D. Luffy</p>
						</div>
					</a>
				</center>
			</div>
			
			<div class="push"></div>
		</div>
		
		<div class="footer">
			<p>2016 © Doctor Phoenix</p>
			<p>Site coded and designed by <a href="http://www.s1mplescripts.de/DrPhoenix/">Doctor Phoenix</a></p>
		</div>
		
		<script>
			function do_update() {
				var xhttp = new XMLHttpRequest();
				var d = new Date();
				var currentTime = d.getTime();
				var entryTime = getCookie("t0");
				var siteTime = currentTime-entryTime;
				xhttp.open("GET", "http://s1mplescripts.de/WebTracker/do_updateTracker.php?ip=<?php echo $user_ip?>&time="+siteTime, true);
				xhttp.send();
			}

			function getCookie(name) {
				var value = "; " + document.cookie;
				var parts = value.split("; " + name + "=");
				if (parts.length == 2) return parts.pop().split(";").shift();
			}
		</script>
	</body>
</html>