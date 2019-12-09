<?php
	if(!isset($_GET["us"]) || !isset($_GET["u"])){
		die();
	}
	
	$user = "web27628762";
	$host = "localhost";
	$password = "9x7wKi4W";
	$dbname = "usr_web27628762_5";

	try{
	    $conn = new PDO("mysql:host=$host;dbname=$dbname", $user, $password);
	    $conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
	    unset($host);
	    unset($user);
	    unset($password);
	    unset($dbname);
		
		$sql_insert_log = $conn->prepare("INSERT INTO telemtrylog (log_id, log_message, user_name) VALUES ('', :lmsg, :uname)");
		$sql_insert_log->bindParam(":lmsg", $_GET["us"]);
		$sql_insert_log->bindParam(":uname", $_GET["u"]);
		
		print("Success");
	}catch (PDOException $ex){
	    die("PDOException".$ex->getMessage());
	}
?>