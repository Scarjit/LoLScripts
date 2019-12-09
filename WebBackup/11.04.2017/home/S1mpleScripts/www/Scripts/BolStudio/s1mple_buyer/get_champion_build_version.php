<?php
	if(!isset($_GET["champion"])){
	    die("No champion");
    }
	
    $champion = $_GET["champion"];

    if(preg_match('/[^A-z]/',$champion)){
        die("Invalid Char");
    }
	
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

	print_r($champ_generic_info->lastUpdated);
?>