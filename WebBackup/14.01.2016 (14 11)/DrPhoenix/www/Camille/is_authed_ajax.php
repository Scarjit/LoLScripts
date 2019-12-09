<?php
	if(!isset($_POST["username"])){
		die("Not authed");
	}

	$user = "root";
	$host = "localhost";
	$password = "86ajd63a8092_a";
	$dbname = "usr_web27628762_5";

	try{
	    $conn = new PDO("mysql:host=$host;dbname=$dbname", $user, $password);
	    $conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
	    unset($host);
	    unset($user);
	    unset($password);
	    unset($dbname);

	    $sql_get_uid = $conn->prepare("SELECT uid FROM users WHERE UserName = :uname");
	    $sql_get_uid->bindParam(':uname', $_POST["username"]);
	    $sql_get_uid->execute();

	    $sql_get_uid_fetch = $sql_get_uid->fetchAll();

	    if(sizeof($sql_get_uid_fetch) == 0){
	    	echo "Not authed";
	    	die();
	    }


	    $uid = $sql_get_uid_fetch[0][0];

	    $sql_get_authed_ids = $conn->prepare("SELECT script_id FROM auths WHERE user_id = :uid AND Is_Banned = 0 AND Is_Authed = 1");
	    $sql_get_authed_ids->bindParam(':uid', $uid);
	    $sql_get_authed_ids->execute();

	    $sql_get_authed_ids_fetched = $sql_get_authed_ids->fetchAll();

	    if(sizeof($sql_get_authed_ids_fetched) == 0){
	    	echo "Not authed";
	    	die();
	    }

	    $authed_scripts = "You are authed for the following Scripts:\n";
	    foreach ($sql_get_authed_ids_fetched as $key => $value) {
	    	$sid = $value[0];
	    	$sql_get_script_name = $conn->prepare("SELECT script_name FROM scripts WHERE script_id = :sid");
	    	$sql_get_script_name->bindParam(':sid', $sid);
	    	$sql_get_script_name->execute();
	    	$sql_get_script_name_fetched = $sql_get_script_name->fetchAll();
	    	$authed_scripts .= $sql_get_script_name_fetched[0][0]."\n";
	    }

	    echo $authed_scripts;
	    die();


	}catch (PDOException $ex){
	    die("PDOException".$ex->getMessage());
	}
?>