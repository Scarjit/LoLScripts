<?php
	error_reporting(E_ALL);
	ini_set('display_errors', 'On');

	function php_array_to_lua($array, $return,$tabs = 1){	
		
		$tab_str = str_repeat("  ",$tabs);
		$lua_string = "{";
		if($return){
			$lua_string = "return {";
		}
		
		foreach($array as $key => $value){
			if(!is_numeric($key)){
				$lua_string .= "\n".$tab_str."[\"".$key."\"] = ";				
			}
			if(is_array($value) || is_object($value)){
				$lua_string .= php_array_to_lua($value, false, $tabs+1);
			}else{
				$lua_string .= "\"".$value."\",";
			}
		}
		
		$lua_string .= "\n".str_repeat("  ",$tabs-1)."}";
		if($tabs > 1){
			$lua_string .= ",";
		}
		
		return $lua_string;
	}
	
	$ddragon_raw = file_get_contents("https://ddragon.leagueoflegends.com/cdn/6.24.1/data/en_US/champion.json");
	preg_match_all("/id\":\"[A-Z|a-z]+/", $ddragon_raw, $output_array);
	$output_array = $output_array[0];
	$return_array = array();
	$return_array["last_update"] = time();
	foreach ($output_array as $key=>$value){
		$champ = substr($value,5);
		if($champ == "MonkeyKing"){
			$champ = "Wukong";
		}
		$champion_raw = file_get_contents("http://bol-tools.com/api/search/champion/".$champ."/0");
		$champion_array = json_decode($champion_raw,true);
		
		$champ_out_array = array();
				
						
		
		foreach($champion_array as $key => $value){
			if($value["isWorking"] == "1"){
				$update_url = $value["updateUrl"];
				if(strlen($update_url) > 0 && substr($update_url, -3) == "lua"){
					array_push($champ_out_array, $value);
				}
			}
		}
		
		$return_array[$champ] = $champ_out_array;
	}

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
		
		$lua_array = php_array_to_lua($return_array, true);
		
		$sql_update = $conn->prepare("UPDATE scripts SET last_update = :lu, script = :s");
		$time = time();
		$sql_update->bindParam(':lu', $time);
		$sql_update->bindParam(':s', $lua_array);
		$sql_update->execute();
		
		$conn = null;
	}catch(PDOException$ex){
		die("PDOException".$ex->getMessage()."<br>".$ex->getLine());
	}
?>