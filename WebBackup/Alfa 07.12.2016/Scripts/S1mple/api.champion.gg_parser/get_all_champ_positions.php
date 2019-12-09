<?php
	$api_key = "?api_key=73467c68ce6c5a38d6fa3ed99a02da13";
	$base_url = "http://api.champion.gg/";

	$all_champ_data_raw = file_get_contents($base_url."champion".$api_key);
	$all_champ_data_array = json_decode($all_champ_data_raw);

	$return_array = array();
	foreach ($all_champ_data_array as $key => $value) {
		$return_string = "";
		$champion = $value->key;
		$return_string .= $champion.":";
		$roles = $value->roles;
		foreach ($roles as $key => $value) {
			$return_string .= $value->name.",";
		}
		array_push($return_array, $return_string);
	}
	sort($return_array);
	foreach ($return_array as $key => $value) {
		print_r($value);
		print_r("\r\n");
	}
?>