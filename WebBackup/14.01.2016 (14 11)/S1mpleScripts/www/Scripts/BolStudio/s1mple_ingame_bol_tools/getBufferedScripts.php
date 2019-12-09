<?php
	error_reporting(E_ALL);
	ini_set('display_errors', 'On');

	$user="root";
	$host="localhost";
	$password="86ajd63a8092_a";
	$dbname="bol-tools_buffer";

	try{
		$conn=new PDO("mysql:host=$host;dbname=$dbname",$user,$password);
		$conn->setAttribute(PDO::ATTR_ERRMODE,PDO::ERRMODE_EXCEPTION);
		unset($host);
		unset($user);
		unset($password);
		unset($dbname);
		
		$sql_get_scripts = $conn->prepare("SELECT script FROM scripts");
		$sql_get_scripts->execute();
		$sql_get_scripts_f = $sql_get_scripts->fetchAll();
		
		$script = base64_encode($sql_get_scripts_f[0]["script"]);
		echo $script;
		
		$sql_get_last_update = $conn->prepare("SELECT last_update FROM scripts");
		$sql_get_last_update->execute();
		$sql_get_last_update_f = $sql_get_last_update->fetchAll();
		
		if(intval($sql_get_last_update_f[0]["last_update"])+1024 < time()){
			exec( 'php getScriptsForChampions.php | /dev/null &' );
		}
	
		$conn = null;
	}catch(PDOException$ex){
		die(base64_encode("PDOException".$ex->getMessage()."\r\n".$ex->getLine()));
	}
?>