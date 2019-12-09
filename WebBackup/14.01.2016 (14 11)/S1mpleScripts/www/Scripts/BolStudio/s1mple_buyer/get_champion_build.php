<?php

	function php_array_to_lua($array, $return,$tabs = 1){	
		
		$tab_str = str_repeat("  ",$tabs);
		$lua_string = "{";
		if($return){
			$lua_string = "return {";
		}
		
		foreach($array as $key => $value){
			$lua_string .= "\n".$tab_str."[\"".$key."\"] = ";
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
	
	if(!isset($_GET["champion"])){
	    die("No champion");
    }
	
    $champion = $_GET["champion"];

    if(preg_match('/[^A-z]/',$champion)){
        die("Invalid Char");
    }

    $opgg = file_get_contents("http://api.champion.gg/champion/".$champion."?api_key=73467c68ce6c5a38d6fa3ed99a02da13");
    $opgg = json_decode($opgg)[0];

    $damage_comp = $opgg->dmgComposition;

    $ad = $damage_comp->physicalDmg;
    $ap = $damage_comp->magicDmg;
	
	$type = "";
	if($ad > $ap){
		$type = "AD";
	}else{
		$type = "AP";
	}
	
	$item_set = $opgg->items;
	if($item_set->highestWinPercent->games > 500){
		$item_set = $item_set->highestWinPercent;
	}else{
		$item_set = $item_set->mostGames;
	}
	
	$champ_info = $item_set;
	$champ_info->type = $type;
	
	//Get last update
	$opgg = file_get_contents("http://api.champion.gg/champion?api_key=73467c68ce6c5a38d6fa3ed99a02da13");
	$opgg = json_decode($opgg);
	
	$champ_generic_info;
	foreach($opgg as $key => $value){
		if($value->key == $champion){
			$champ_generic_info = $opgg[$key];
			break;
		}
	}
	
	foreach($champ_generic_info as $key=>$value){
		$champ_info->$key = $value;
	}
	
	$lua_string = php_array_to_lua($champ_info, true);	
	
	print_r($lua_string);
?>