<html>
	<head>
		<title>Test PHP</title>      
	</head>   

	<style>
		
	</style>
	
	<body>
		<?php
			$authkey = $_GET['authkey'];
			$authkey = preg_replace("/[^0-9]/", "", $authkey);
			
			$HSM = array(99, 86, 78, 64, 63, 41, 58, 62, 24);
			$HS = $HSM[$authkey[0] - 1];
			
			$authkey = substr($authkey, 1);
			
			$HHM = array(88, 74, 82, 51, 17, 80, 13, 95, 55);
			$HH = $HHM[$authkey[0] - 1];
			
			$authkey = substr($authkey, 1);
			
			$HMM = array(45, 36, 34, 61, 73, 12, 29, 42, 48);
			$HM = $HMM[$authkey[0] - 1];
			
			$authkey = substr($authkey, 1);
			
			$M = substr($authkey, 0, 4) / $HM;
			$authkey = substr($authkey, 4);
			
			$H = substr($authkey, 0, 4) / $HH;
			$authkey = substr($authkey, 4);
			
			$S = substr($authkey, 0, 4) / $HS;
			
			echo '<p>' . $H . 'h ' . $M . 'm ' . $S . 's</p>';
		?>
	</body>
</html>