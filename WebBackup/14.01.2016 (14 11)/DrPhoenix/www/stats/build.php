<?php
	$api_key = "?api_key=73467c68ce6c5a38d6fa3ed99a02da13";
	$base_url = "http://api.champion.gg/";
	
	if ($_GET['request'] == "true") {
		if (isset($_GET['champion'])) {
			$items = file_get_contents($base_url."champion/".$_GET['champion']."/items/finished/mostPopular".$api_key);
			$items = str_replace(strstr($items, '"items":[', true).'"items":[', "", $items);
			$items = substr($items, 0, strpos($items, '],"role"'));
			$items = explode(",", $items);
			$return = "{ ";
			foreach ($items as $item) {
				if ($return == "{ ") {
					$return = $return.$item;
				} else {
					$return = $return.", ".$item;
				}
			}
			$return = $return." }";
			print($return);
		}
	} else {
		$patch = file_get_contents("http://champion.gg/");
		$patch = str_replace(array("\n", "\r"), '', $patch);
		$patch = str_replace(strstr($patch, 'Patch                 <strong>', true).'Patch                 <strong>', "", $patch);
		$patch = substr($patch, 0, strpos($patch, '</strong>'));
		
		print("<head><link rel='stylesheet' href='style.css'></head><body><div class='menu'><a href='build.php'><h1 class='title'>Best WinRate Build</h1></a>");
		
		$all_champ_data_raw = file_get_contents($base_url."champion".$api_key);
		$all_champ_data_array = json_decode($all_champ_data_raw);
		sort($all_champ_data_array);

		print("<div class='select-style'>");
		print("<select onchange=".Chr(34)."window.location='build.php?champion='+this.value".Chr(34).">");
		print("<option label='Please choose a champion'>Please choose a champion</option>");
		foreach ($all_champ_data_array as $key => $value) {
			print("<option value=".Chr(34).$value->key.Chr(34).">".$value->key."</option>");
		}
		print("</select>");
		print("</div></div>");
		
		if (isset($_GET['champion'])) {
			$data = file_get_contents($base_url."champion/".$_GET['champion']."/items/finished/mostPopular".$api_key);
			if (strpos($data, '},{') !== false) {
				$subdata = explode("},{", $data);
				foreach($subdata as $sub) {
					$winpercent = str_replace(strstr($sub, '"winPercent":', true).'"winPercent":', "", $sub);
					$items = str_replace(strstr($winpercent, '"items":[', true).'"items":[', "", $winpercent);
					$winpercent = substr($winpercent, 0, strpos($winpercent, ',"items"'));
					$role = str_replace(strstr($items, '"role":"', true).'"role":"', "", $items);
					$role = substr($role, 0, strpos($role, '"'));
					$items = substr($items, 0, strpos($items, '],"role"'));
					$items = explode(",", $items);
					if ($winpercent !== "") {
						print("<div class='item_list'>");
						print("<h3>".$_GET["champion"]." ".$role." (".$winpercent."%)</h3>");
						foreach($items as $item) {
							print("<img class='item_icon' src='http://ddragon.leagueoflegends.com/cdn/6.22.1/img/item/".$item.".png'>");
						}
						print("</div>");
					}
				}
			} else {
				$winpercent = str_replace(strstr($data, '"winPercent":', true).'"winPercent":', "", $data);
				$items = str_replace(strstr($winpercent, '"items":[', true).'"items":[', "", $winpercent);
				$winpercent = substr($winpercent, 0, strpos($winpercent, ',"items"'));
				$role = str_replace(strstr($items, '"role":"', true).'"role":"', "", $items);
				$role = substr($role, 0, strpos($role, '"'));
				$items = substr($items, 0, strpos($items, '],"role"'));
				$items = explode(",", $items);
				print("<div class='item_list'>");
				print("<h3>".$_GET["champion"]." ".$role." (".$winpercent."%)</h3>");
				foreach($items as $item) {
					print("<img class='item_icon' src='http://ddragon.leagueoflegends.com/cdn/6.22.1/img/item/".$item.".png'>");
				}
				print("</div>");
			}
		}
		
		print("<div id='footer'><center><p class='patch'>Site coded and designed by DrPhoenix<br>Updated for patch ".$patch." by champion.gg</p></center></div></body>");
	}
?>