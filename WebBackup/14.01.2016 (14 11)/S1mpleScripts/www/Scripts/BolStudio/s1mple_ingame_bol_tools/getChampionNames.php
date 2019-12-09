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
			if(is_array($value) || is_object($value)){
				$lua_string .= php_array_to_lua($value, false, $tabs+1);
			}else{
				$lua_string .= "\"".$value."\",\r\n";
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
	
	foreach ($output_array as $key=>$value){
		$champ = substr($value,5);
		if($champ == "MonkeyKing"){
			$champ = "Wukong";
		}
		array_push($return_array, $champ);
	}
	
	echo php_array_to_lua($return_array, true);
?>