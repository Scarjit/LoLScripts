<style>
	body {
		background: grey;
	}
	
	.summoner_info {
		position: relative;
		width: 75px;
		height: 75px;
	}
	
	.summoner_icon {
		width: 100%;
		height: 100%;
		border: 1px solid white;
		border-radius: 10px;
	}
	
	.summoner_level {
		color: white;
		position: absolute;
		top: 60px;
		left: 10px;
		border: 1px solid white;
		padding-left: 3px;
		padding-right: 3px;
		font-size: 12px;
		background: rgba(0,0,0,0.5);
	}
</style>

<?php
	$api_key = "?api_key=RGAPI-3f700fd5-62da-4683-8ba3-1a9f6c62fa37";
	
	function getId($summonerName, $apiKey) {
		$infos = getInfos($summonerName, $apiKey);
		$id = $infos;
		return $id->{'id'};
	}
	
	function getInfos($summonerName, $apiKey) {
		$space = str_replace(" ", "%20", $summonerName);
		$nospace = mb_strtolower(str_replace(" ", "", $summonerName), 'UTF-8');
		$request = "https://euw.api.pvp.net/api/lol/euw/v1.4/summoner/by-name/".$space.$apiKey;
		$response = file_get_contents($request);
		$response_decoded = json_decode($response);
		$infos = $response_decoded->{$nospace};
		print('<div class="summoner_info"><img class="summoner_icon" src="https://sk2.op.gg/images/profile_icons/profileIcon'.$infos->{'profileIconId'}.'.jpg"><p class="summoner_level">'.$infos->{'summonerLevel'}.'</p></div>');
		return $infos;
	}
	
	function getMasteries($id, $apiKey) {
		$request = "https://euw.api.pvp.net/championmastery/location/EUW1/player/".$id."/champions".$apiKey;
		$response = file_get_contents($request);
		$response_decoded = json_decode($response);
		return $response_decoded;
	}
	
	function getChampion($id, $apiKey) {
		$request = "https://global.api.pvp.net/api/lol/static-data/euw/v1.2/champion/".$id.$apiKey;
		$response = file_get_contents($request);
		$response_decoded = json_decode($response);
		return $response_decoded;
	}
	
	function getTopChampions($summonerName, $number, $apiKey) {
		$id = getId($summonerName, $apiKey);
		$masteries = getMasteries($id, $apiKey);
		$top_masteries = array_slice($masteries, 0, $number);
		foreach ($top_masteries as $champ) {
			$champ_id = $champ->{'championId'};
			$champ_infos = getChampion($champ_id, $apiKey);
			$champ_name = $champ_infos->{'name'};
			$champ_key = $champ_infos->{'key'};
			$champ_level = $champ->{'championLevel'};
			$champ_points = $champ->{'championPoints'};
			$champ_chest = $champ->{'chestGranted'};
			print '<div>'.PHP_EOL.'	<img class="champ_icon" src="http://ddragon.leagueoflegends.com/cdn/7.3.1/img/champion/'.$champ_key.'.png">'.PHP_EOL.'	<p class="champ_name">'.$champ_name.'</p>'.PHP_EOL.'</div>'.PHP_EOL;
		}
	}
	
	print_r(getInfos("Salty Yi", $api_key));
	// getTopChampions("Salty Yi", 3, $api_key);
?>