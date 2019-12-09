<?php
	function getLoLVersion(){
		$file = file_get_contents("https://ddragon.leagueoflegends.com/realms/na.js");
		preg_match("/item\":\"[0-9]\.[0-9]+\.*[0-9]*/", $file, $output_array);
		$version = substr($output_array[0], 7);
		return $version;
	}

	function insertintoluatable($table, $key, $value = "", $newline = false, $tabs = 0, $comma = true){
		$table .= "";
		if($value != ""){
			$table .= str_repeat("\t",$tabs).$key . " = " . $value;
			if($comma){
				$table .= ",";
			}
		}else{
			$table .= str_repeat("\t",$tabs).$key;
			if($comma){
				$table .= ",";
			}
		}
		if($newline){
			$table .= "\n";
		}
		return $table;
	}
	$ddragon_raw = file_get_contents("https://ddragon.leagueoflegends.com/cdn/".getLoLVersion()."/data/en_US/item.json");
	$ddragon_array = json_decode($ddragon_raw,true);
	
	$lua_table = "{\n";
	$server_version = $ddragon_array["version"];
	$lua_table = insertintoluatable($lua_table, "Version", "\"".$server_version."\"", true, 1);
	
	//echo("Server Version: ".$server_version."<br><br><br>");
	
	//Get Item Data
	$data = $ddragon_array["data"];
	foreach($data as $key=>$value){
		$current_table = "{\n";
		
		$name = $value["name"];
		$gold = $value["gold"]["base"];
		$gold_total = $value["gold"]["total"];
		if(!is_numeric($gold)){
			$gold = 0;
		}
		if(!is_numeric($gold_total)){
			$gold_total = $gold;
		}
		
		$from_tbl = "{";
		
		$i = 0;
		if(array_key_exists("from", $value)){
			$from = $value["from"];
			if(isset($from)){
				$from_tbl .= "\n";
				foreach($from as $v=>$k){
					$from_tbl = insertintoluatable($from_tbl, $k, null, true,3);	
					$i .= 1;
				}
			}
		}
		
		if($i > 0){
			$from_tbl = insertintoluatable($from_tbl, "},", null,true,2, false);
		}else{
			$from_tbl = insertintoluatable($from_tbl, "},", null,true,0, false);
		}
		
		$item_id = $key;
		
		$current_table = insertintoluatable($current_table, "item_name", "\"".$name."\"",true,2);
		$current_table = insertintoluatable($current_table, "cost", $gold."",true,2);
		$current_table = insertintoluatable($current_table, "cost_total", $gold_total."",true,2);		
		$current_table = insertintoluatable($current_table, "from", $from_tbl,false,2, false);
		$current_table = insertintoluatable($current_table, "},", null,true,1, false);
		
	$lua_table = insertintoluatable($lua_table, "[".$item_id."]", $current_table, true,1,false);
	}
	
	$lua_table .= "}";
	
	$ret_str = "return ".$lua_table;
	print_r($ret_str);
	
?>