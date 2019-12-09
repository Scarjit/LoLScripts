<!DOCTYPE html>
<html lang="en">
  <head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
	<meta name="author" content="S1mple">

	<title>S1mpleScripts.de</title>

	<!-- Include css, js and other cool stuff -->
	<link href="css/animate.css" rel="stylesheet">
	<!-- Latest compiled and minified CSS -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css" integrity="sha384-1q8mTJOASx8j1Au+a5WDVnPi2lkFfwwEAa8hDDdjZlpLegxhjVME1fgjWPGmkzs7" crossorigin="anonymous">
	<!-- Optional theme -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap-theme.min.css" integrity="sha384-fLW2N01lMqjakBkx3l/M9EahuwpSfeNvV63J5ezn3uZzapT0u7EYsXMjQV+0En5r" crossorigin="anonymous">


	<!-- JQuery -->
	<script src="//code.jquery.com/jquery-2.2.0.min.js"></script>

	<!-- Latest compiled and minified JavaScript -->
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js" integrity="sha384-0mSbJDEHialfmuBBQP6A4Qrprq5OVfW37PRR3j5ELqxss1yVqOtnepnHVP9aJ7xS" crossorigin="anonymous"></script>
	<link href="css/carousel.css" rel="stylesheet">

	<!-- Bootstrap Notify -->
	<script src="javascript/bootstrap-notify.min.js"></script>
	<!-- Custom functions -->
	<script>
	function get_browser_info(){
		var ua=navigator.userAgent,tem,M=ua.match(/(opera|chrome|safari|firefox|msie|trident(?=\/))\/?\s*(\d+)/i) || []; 
		if(/trident/i.test(M[1])){
			tem=/\brv[ :]+(\d+)/g.exec(ua) || []; 
			return {name:'IE',version:(tem[1]||'')};
			}   
		if(M[1]==='Chrome'){
			tem=ua.match(/\bOPR\/(\d+)/)
			if(tem!=null)   {return {name:'Opera', version:tem[1]};}
			}   
		M=M[2]? [M[1], M[2]]: [navigator.appName, navigator.appVersion, '-?'];
		if((tem=ua.match(/version\/(\d+)/i))!=null) {M.splice(1,1,tem[1]);}
		return {
			name: M[0],
			version: M[1]
		};
	}

	function setCookie(cname, cvalue, exdays) {
	    var d = new Date();
	    d.setTime(d.getTime() + (exdays*24*60*60*1000));
	    var expires = "expires="+d.toUTCString();
	    document.cookie = cname + "=" + cvalue + "; " + expires;
	}

	function checkCookie(name) {
		var username=getCookie(name);
	    if (username!=""&&username!=null) {
	        return true;
	    }else{
	        return false;
	    }
	}

	function getCookie(cname) {
	    var name = cname + "=";
	    var ca = document.cookie.split(';');
	    for(var i=0; i<ca.length; i++) {
	        var c = ca[i];
	        while (c.charAt(0)==' ') c = c.substring(1);
	        if (c.indexOf(name) == 0) return c.substring(name.length, c.length);
	    }
	    return "";
	}

	$( document ).ready(function() {
		var browser=get_browser_info();
		if(browser.name == 'IE' && parseInt(browser.version) < 11){
			alert("Browser incomplatible");
		}
		if(checkCookie("cnoteshown")){

		}else{
			$.notify({
				title: 'Cookie-Policy: ',
				message: 'By using this Website you agree with our Cookie & Privacy Policy',
				url: 'privacy.php',
				target: '_blank'
			},{
				element: 'body',
				position: null,
				allow_dismiss: true,
				newest_on_top: false,
				showProgressbar: false,
				placement: {
					from: "top",
					align: "center"
				},
				offset: 20,
				spacing: 10,
				z_index: 1031,
				delay: 2000,
				timer: 1000,
				url_target: '_blank',
				mouse_over: 'pause',
				animate: {
					enter: 'animated fadeInDown',
					exit: 'animated fadeOutUp'
				},
				onShow: null,
				onShown: null,
				onClose: null,
				onClosed: null,
				icon_type: 'class',
				template: '<div data-notify="container" class="col-xs-11 col-sm-3 alert alert-{0}" role="alert">' +
					'<button type="button" aria-hidden="true" class="close" data-notify="dismiss">×</button>' +
					'<span data-notify="icon"></span> ' +
					'<span data-notify="title">{1}</span> ' +
					'<span data-notify="message">{2}</span>' +
					'<div class="progress" data-notify="progressbar">' +
						'<div class="progress-bar progress-bar-{0}" role="progressbar" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100" style="width: 0%;"></div>' +
					'</div>' +
					'<a href="{3}" target="{4}" data-notify="url"></a>' +
				'</div>' 
			})
			setCookie("cnoteshown", true);
		}
	});


	</script>
  </head>
<!-- NAVBAR
================================================== -->
  <body>
	<div class="navbar-wrapper">
	  <div class="container">

		<nav class="navbar navbar-inverse navbar-static-top">
		  <div class="container">
			<div class="navbar-header">
			  <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
				<span class="sr-only">Toggle navigation</span>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
			  </button>
			  <a class="navbar-brand" href="#">S1mple Scripts</a>
			</div>
			<div id="navbar" class="navbar-collapse collapse">
			  <ul class="nav navbar-nav">
				<li class="active"><a href="#">Home</a></li>
				<li><a href="about.php">About</a></li>
				<li><a href="contact.php">Contact</a></li>
				<li class="dropdown">
				  <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Bot of Legends<span class="caret"></span></a>
				  <ul class="dropdown-menu">
					<li class="dropdown-header">BoL Studio</li>
					<li><a href="Scripts/BolStudio/OrbWalker/S1mpleOrbWalker.lua">S1mple OrbWalker</a></li>
					<li><a href="Scripts/BolStudio/Ziggs/S1mple_Ziggs.lua">S1mple Ziggs</a></li>
					<li><a href="Scripts/BolStudio/Veigar/S1mple_Veigar.lua">S1mple Veigar</a></li>
					<li><a href="Scripts/BolStudio/Other/S1mple_SPACEINVADERS.lua">S1mple Space Invader</a></li>
					<li><a href="Scripts/BolStudio/Other/S1mple_MineSweeper.lua">S1mple Mine Sweeper</a></li>
					<li role="separator" class="divider"></li>
					<li class="dropdown-header">Cloudrop</li>
					<li><a href="Scripts/Cloudrop/Ziggs/Ziggs.zip">S1mple Ziggs</a></li>
					<li><a href="Scripts/Cloudrop/Veigar/Veigar.zip">S1mple Veigar</a></li>
					<li><a href="Scripts/Cloudrop/Activator/Activator.zip">S1mple Activator</a></li>
					<li><a href="Scripts/Cloudrop/AntiAFK/AntiAFK.zip">S1mple AntiAFK</a></li>
				  </ul>
				</li>
				<li class="dropdown">
				  <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Secret<span class="caret"></span></a>
				  <ul class="dropdown-menu">
					<li><a href="#">???</a></li>
				  </ul>
				</li>
				<li><a href="login.php">Login</a></li>
			  </ul>
			</div>
		  </div>
		</nav>

	  </div>
	</div>

	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	
	<!-- Marketing messaging and featurettes
	================================================== -->
	<!-- Wrap the rest of the page in another container to center all the content. -->

	<div class="container marketing">

	  <!-- Three columns of text below the carousel -->
	  <div class="row">
		<div class="col-lg-4">
		  <img class="img-circle" src="images/Ziggs.jpg" alt="Generic placeholder image" width="140" height="140">
		  <h2>S1mple_Ziggs</h2>
		  <p>My first ever Script, made for Ziggs.</p>
		  <p><a class="btn btn-default" href="Scripts/BolStudio/Ziggs/S1mple_Ziggs.lua" role="button">Download</a></p>
		</div><!-- /.col-lg-4 -->
		<div class="col-lg-4">
		  <img class="img-circle" src="images/Veigar.jpg" alt="Generic placeholder image" width="140" height="140">
		  <h2>S1mple_Veigar</h2>
		  <p>My Veigar Script for BoL.</p>
		  <p><a class="btn btn-default" href="Scripts/BolStudio/Veigar/S1mple_Veigar.lus" role="button">Download</a></p>
		</div><!-- /.col-lg-4 -->
		<div class="col-lg-4">
		  <img class="img-circle" src="data:image/gif;base64,R0lGODlhAQABAIAAAHd3dwAAACH5BAAAAAAALAAAAAABAAEAAAICRAEAOw==" alt="Generic placeholder image" width="140" height="140">
		  <h2>S1mple_OrbWalker</h2>
		  <p>My OpenSource OrbWalker</p>
		  <p><a class="btn btn-default" href="Scripts/BolStudio/OrbWalker/S1mpleOrbWalker.lua" role="button">Download OrbWalker</a>
		  <a class="btn btn-default" href="Scripts/BolStudio/OrbWalker/S1Loader.lua" role="button">Download Loader</a></p>
		</div><!-- /.col-lg-4 -->
		<div class="col-lg-4">
		  <img class="img-circle" src="data:image/gif;base64,R0lGODlhAQABAIAAAHd3dwAAACH5BAAAAAAALAAAAAABAAEAAAICRAEAOw==" alt="Generic placeholder image" width="140" height="140">
		  <h2>S1mple_MineSweeper</h2>
		  <p>Play Minesweeper in League of Legends</p>
		  <p><a class="btn btn-default" href="Scripts/BolStudio/Other/S1mple_MineSweeper.lua" role="button">Download</a></p>
		</div><!-- /.col-lg-4 -->
		<div class="col-lg-4">
		  <img class="img-circle" src="data:image/gif;base64,R0lGODlhAQABAIAAAHd3dwAAACH5BAAAAAAALAAAAAABAAEAAAICRAEAOw==" alt="Generic placeholder image" width="140" height="140">
		  <h2>S1mple_Spaceinvaders</h2>
		  <p>Play Spaceinvaders in League of Legends</p>
		  <p><a class="btn btn-default" href="Scripts/BolStudio/Other/S1mple_SPACEINVADERS.lua" role="button">Download</a></p>
		</div><!-- /.col-lg-4 -->
		<div class="col-lg-4">
		  <img class="img-circle" src="data:image/gif;base64,R0lGODlhAQABAIAAAHd3dwAAACH5BAAAAAAALAAAAAABAAEAAAICRAEAOw==" alt="Generic placeholder image" width="140" height="140">
		  <h2>S1mple_Syndra</h2>
		  <p>--Not Yet Released--</p>
		  <p><a class="btn btn-default" href="#" role="button">This Button is not yet released</a></p>
		</div><!-- /.col-lg-4 -->
	  </div><!-- /.row -->

	  <!-- FOOTER -->
	  <footer>
		<p class="pull-right"><a href="#">Back to top</a></p>
		<p>&copy; 2015 S1mple &middot; <a href="privacy.php">Privacy</a></p>
	  </footer>
	</div><!-- /.container -->
  </body>
</html>
