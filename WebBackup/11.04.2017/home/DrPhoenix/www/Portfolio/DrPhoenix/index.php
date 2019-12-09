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
		<link rel="icon" type="image/png" href="../../img/icon.png" />
		<link rel="stylesheet" href="../../style.css">
		<link rel="stylesheet" href="../../fonts.css">
		<link rel="stylesheet" href="style.css">
	</head>
	
	<body onbeforeunload="do_update()">
		<div class="content">
			<div class="nav">
				<?php include("../../menu.php"); ?>
			</div>
			
			<div class="main">
				<h1 class="portfolio_title contributor">DrPhoenix</h1>
				<center><a href="https://forum.botoflegends.com/user/828841-drphoenix/" class="download_link">DrPhoenix BoL profile</a></center>
				
				<h2 class="sub_title">Logo</h2>
				<img class="portfolio_img" src="logo.png" width="150px">
				
				<h2 class="sub_title">Signature n°1 (outdated)</h2>
				<img class="portfolio_img" src="signature1.png">
				
				<h2 class="sub_title">Signature n°2 (outdated)</h2>
				<img class="portfolio_img" src="signature2.png">
				
				<h2 class="sub_title">Signature n°3</h2>
				<img class="portfolio_img" src="signature3.png">
				
				<h2 class="sub_title">Banner</h2>
				<img class="portfolio_img" src="banner.png">
				
				<h2 class="sub_title">Thread Design : Doctor Yi (outdated)</h2>
				<img class="portfolio_img" src="DrYi1.png">
				
				<h2 class="sub_title">Thread Design : Doctor Sentences</h2>
				<img class="portfolio_img" src="DrSentences.png">
				
				<h2 class="sub_title">Thread Design : Doctor Toxic</h2>
				<img class="portfolio_img" src="DrToxic.png">
				
				<h2 class="sub_title">Thread Design : Doctor Streaming</h2>
				<img class="portfolio_img" src="DrStreaming.png">
				
				<h2 class="sub_title">Thread Design : Doctor KogMaw</h2>
				<img class="portfolio_img" src="DrKogMaw.png">
				
				<h2 class="sub_title">#1 Fan Art contest</h2>
				<img class="portfolio_img" src="fanart.png">
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