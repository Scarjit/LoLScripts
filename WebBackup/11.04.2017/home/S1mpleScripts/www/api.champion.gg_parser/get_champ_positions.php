<?php
	$api_key = "?api_key=73467c68ce6c5a38d6fa3ed99a02da13";
	$base_url = "http://api.champion.gg/";
	$champion = htmlspecialchars($_GET["champion"]);

	$all_champ_data_raw = file_get_contents($base_url."champion".$api_key);
	$all_champ_data_array = json_decode($all_champ_data_raw);

	$play_able_roles = "";
	foreach ($all_champ_data_array as $key => $value) {
		$c = $value->key;
		if ($c == $champion) {
			$roles = ($value->roles);
			foreach ($roles as $key => $value) {
				$play_able_roles .= $value->name.",";
			}
		}
	}
	print_r($play_able_roles);
?>