<?php
	$api_key = "?api_key=73467c68ce6c5a38d6fa3ed99a02da13";
	$base_url = "http://api.champion.gg/";
	$champion = htmlspecialchars($_GET["champion"]);
	$type = htmlspecialchars($_GET["type"]);

	$all_champ_data_raw = file_get_contents($base_url."champion/".$champion.$api_key);
	$all_champ_data_array = json_decode($all_champ_data_raw);
	$mastery_data = $all_champ_data_array[0]->masteries;
	$mastery_data = json_decode(json_encode($mastery_data),true);
	if($type == "0"){ //Highest Win %
		$mastery_data = $mastery_data["highestWinPercent"]["masteries"];
	}else{
		$mastery_data = $mastery_data["mostGames"]["masteries"];
	}

	$return_string = "";
	
	$fero = $mastery_data[0]["data"];
	$fero_ret = array();
	foreach ($fero as $key => $value) {
		$id = $value["mastery"];
		$points = $value["points"];
		$mod = 0;
		if (substr($id, -1) == "4") {
			$mod = 1;
		}
		$id = intval($id)-6100-$mod;
		array_push($fero_ret, $id."|".$points);
	}
	sort($fero_ret);

	$cunning = $mastery_data[1]["data"];
	$cunning_ret = array();
	foreach ($fero as $key => $value) {
		$id = $value["mastery"];
		$points = $value["points"];
		$mod = 0;
		if (substr($id, -1) == "4") {
			$mod = 1;
		}
		$id = intval($id)-6100-$mod;
		array_push($cunning_ret, $id."|".$points);
	}
	sort($cunning_ret);

	$resolve = $mastery_data[2]["data"];
	$resolve_ret = array();
	foreach ($fero as $key => $value) {
		$id = $value["mastery"];
		$points = $value["points"];
		$mod = 0;
		if (substr($id, -1) == "4") {
			$mod = 1;
		}
		$id = intval($id)-6100-$mod;
		array_push($resolve_ret, $id."|".$points);
	}
	sort($resolve_ret);

	foreach ($fero_ret as $key => $value) {
		$return_string .= $value . ",";
	}
	$return_string .= ":";
	foreach ($cunning_ret as $key => $value) {
		$return_string .= $value . ",";
	}
	$return_string .= ":";
	foreach ($resolve_ret as $key => $value) {
		$return_string .= $value . ",";
	}
	print_r($return_string);
?>