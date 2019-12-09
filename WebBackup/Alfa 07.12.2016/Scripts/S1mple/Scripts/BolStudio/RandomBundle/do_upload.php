<?php
	$pw = $_POST["pw"];
	if(!isset($_POST["pw"]) || $_POST["pw"] != "8221a4083883b2c99ff65233338b9dbcbf846269"){
		print_r($_POST);
		die();
	}
	$version = $_POST["version"];
	$changelog = $_POST["changelog"];
	$fname = substr($_FILES["fileToUpload"]["name"],0, strlen($_FILES["fileToUpload"]["name"])-4);
	
	$allowed_file_names = array(
		"S1mple_Loader" => "core",
		"S1Ts" => "ts",
		"SLAurelionSol" => "AurelionSol",
		"SLZiggs" => "Ziggs",
		"SLVeigar" => "Veigar",
		"SLSyndra" => "Syndra",
		"SLNami" => "Nami",
		"SLJhin" => "Jhin",
		"SLCorki" => "Corki",
	);
	try{
		$db_entry = $allowed_file_names[$fname];
		$filecontent = file_get_contents($_FILES["fileToUpload"]["tmp_name"]);
		
		$db_user = "web27628762";
        $db_host = "localhost";
        $db_password = "9x7wKi4W";
        $db_name = "usr_web27628762_6";

        $conn = new PDO("mysql:host=$db_host;dbname=$db_name", $db_user, $db_password);
        $conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
        unset($db_user);
        unset($db_host);
        unset($db_password);
        unset($db_name);
		
		$sql_get_Script_id = $conn->prepare("SELECT ID, Version FROM RandomBundle_Versions WHERE Name = :n");
		$sql_get_Script_id->bindParam(':n', $db_entry);
		$sql_get_Script_id->execute();
		$sql_get_Script_id_fetched = $sql_get_Script_id->fetchAll();
		if(sizeof($sql_get_Script_id_fetched) != 1){
			die();
		}
		$sid = $sql_get_Script_id_fetched[0]["ID"];
		$sversion = $sql_get_Script_id_fetched[0]["Version"];
		if($sversion>=$version){
			die();
		}
		
		//Set Changelog for Version
		$sql_insert_changelog = $conn->prepare("INSERT INTO RandomBundle_Changelog (cid, SCRIPT_ID, Version_Number, Changelog) VALUES (NULL, :sid, :svn, :scl)");
		$sql_insert_changelog->bindParam(':sid',$sid);
		$sql_insert_changelog->bindParam(':svn',$version);
		$sql_insert_changelog->bindParam(':scl',$changelog);
		$sql_insert_changelog->execute();
		
		//Change File and Version on RandomBundle_Versions
		$sql_change_version = $conn->prepare("UPDATE RandomBundle_Versions SET Version = :v WHERE ID = :id");
		$sql_change_version->bindParam('v',$version);
		$sql_change_version->bindParam('id',$sid);
		$sql_change_version->execute();
		
		$sql_change_file = $conn->prepare("UPDATE RandomBundle_Versions SET File = :f WHERE ID = :id");
		$sql_change_file->bindParam('f',$filecontent);
		$sql_change_file->bindParam('id',$sid);
		$sql_change_file->execute();
		
		header('Location: renderchangelog.php');		
		
		$conn->null;
	}catch(Exeption $ex){
		print_r("Invalid File Name");
	}
	
	
?>