<?php
	if(!isset($_GET["v"]) || !isset($_GET["fn"])){
		die(base64_encode("Invalid Request"));
	}
	
	try {
        $db_user = "root";
        $db_host = "localhost";
        $db_password = "86ajd63a8092_a";
        $db_name = "usr_web27628762_6";

        $conn = new PDO("mysql:host=$db_host;dbname=$db_name", $db_user, $db_password);
        $conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
        unset($db_user);
        unset($db_host);
        unset($db_password);
        unset($db_name);
		
		$sql_get_latest_version = $conn->prepare("SELECT Version, File FROM RandomBundle_Versions WHERE Name = :name");
        $sql_get_latest_version->bindParam(':name', $_GET["fn"]);
        $sql_get_latest_version->execute();
		$sql_get_latest_version_fetched = $sql_get_latest_version->fetchAll();
		if(sizeof($sql_get_latest_version_fetched)==0){
			die(base64_encode("Invalid Request"));
		}
		$sql_get_latest_version_fetched = $sql_get_latest_version_fetched[0];
				
		if((float) $_GET["v"] < (float)$sql_get_latest_version_fetched["Version"]){
			if(!isset($_GET["b64"]) || !$_GET["b64"] == "false"){
				echo(base64_encode($sql_get_latest_version_fetched["File"]));
			}else{
				header('Content-Disposition: attachment; filename="S1mple_Loader.lua"');
				header('Content-Type: text/plain');
				header('Content-Length: ' . strlen($sql_get_latest_version_fetched["File"]));
				echo $sql_get_latest_version_fetched["File"];
				die();
			}
		}else{
			echo(base64_encode("No_new_version"));
		}
		
	} catch (PDOException $ex) {
        die(base64_encode("MYSQL Error"));
    }
	
?>