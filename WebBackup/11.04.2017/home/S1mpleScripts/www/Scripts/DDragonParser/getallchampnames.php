<?php
	function getLoLVersion(){
		$file = file_get_contents("https://ddragon.leagueoflegends.com/realms/na.js");
		preg_match("/item\":\"[0-9]\.[0-9]+\.*[0-9]*/", $file, $output_array);
		$version = substr($output_array[0], 7);
		return $version;
	}

	$ddragon_raw = file_get_contents("https://ddragon.leagueoflegends.com/cdn/".getLoLVersion()."/data/en_US/champion.json");
	$ddragon_array = json_decode($ddragon_raw,true);

	$data = $ddragon_array["data"];
	foreach($data as $key=>$value){
		$id = $value["id"];
		print_r($id.",");
	}
?>