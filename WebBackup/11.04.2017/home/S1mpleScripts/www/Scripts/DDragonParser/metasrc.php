<?php
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
	
	if(!isset($_GET["champion"]) or !isset($_GET["region"])){
		die("return nil");
	}else{
		//http://www.metasrc.com/na/aram/current/champion/aatrox
		$metasrc = file_get_contents("http://www.metasrc.com/".$_GET["region"]."/aram/current/champion/".$_GET["champion"]);
		
		$metasrc_start = $metasrc;
		$metasrc_start_start_div = strpos($metasrc_start, "Best Starting Items");
		$metasrc_start = substr($metasrc_start,$metasrc_start_start_div);
		$metasrc_start_end_div = strpos($metasrc_start, "Best Item Build");
		$metasrc_start = substr($metasrc_start,0,$metasrc_start_end_div);

		$metasrc_start_array;
		preg_match_all("/.{4}\.png/", $metasrc_start, $metasrc_start_array);
		$return_string = "return {\r\nstarting = {";
		$metasrc_start_array = $metasrc_start_array[0];
		foreach ($metasrc_start_array as $key => $value) {
			$return_string .= substr($value,0,4).",";
		}
		$return_string .= "},\r\n";


		$metasrc_core = $metasrc;
		$metasrc_core_start_div = strpos($metasrc_core, "Best Starting Items");
		$metasrc_core = substr($metasrc_core,$metasrc_core_start_div);
		$metasrc_core_end_div = strpos($metasrc_core, "Best Skill Order");
		$metasrc_core = substr($metasrc_core,0,$metasrc_core_end_div);		
		$metasrc_core_start_div = strpos($metasrc_core, "Best Item Build Order");
		$metasrc_core = substr($metasrc_core,$metasrc_core_start_div);

		$metasrc_core_array;
		preg_match_all("/.{4}\.png/", $metasrc_core, $metasrc_core_array);
		$return_string .= "core = {";
		$metasrc_core_array = $metasrc_core_array[0];
		foreach ($metasrc_core_array as $key => $value) {
			$return_string .= substr($value,0,4).",";
		}
		$return_string .= "},\r\n";


		$metasrc_skill = $metasrc;
		$metasrc_skill_start_div = strpos($metasrc_skill, "Best Skill Order");
		$metasrc_skill = substr($metasrc_skill,$metasrc_skill_start_div);
		$metasrc_skill_end_div = strpos($metasrc_skill, "Best Runes");
		$metasrc_skill = substr($metasrc_skill,0,$metasrc_skill_end_div);

		$metasrc_skill_array;
		preg_match_all("/nei.{4}/", $metasrc_skill, $metasrc_skill_array);
		$metasrc_skill_array = $metasrc_skill_array[0];

		$q_row = "";
		$w_row = "";
		$e_row = "";
		$r_row = "";

		foreach ($metasrc_skill_array as $key => $value) {
			$int = intval($key)-19;
			if (intval($key) > 19) {
				//echo $key-19;
				if ($value == "nei\"></") {
					if ($int < 19) {
						$q_row .= "0";
					}elseif ($int > 19 && $int < 38) {
						$w_row .= "0";
					}elseif ($int > 38 && $int < 57) {
						$e_row .= "0";
					}elseif ($int > 57 && $int < 76) {
						$r_row .= "0";
					}
				}elseif ($value == "nei _w7") {
					if ($int < 19) {
						$q_row .= "1";
					}elseif ($int > 19 && $int < 38) {
						$w_row .= "1";
					}elseif ($int > 38 && $int < 57) {
						$e_row .= "1";
					}elseif ($int > 57 && $int < 76) {
						$r_row .= "1";
					}
				}
			}
		}

		$skill_order = "";
		for ($i=0; $i < 18; $i++) { 
			if ($q_row[$i] == "1"){
				$skill_order .= "Q";
			}elseif ($w_row[$i] == "1") {
				$skill_order .= "W";
			}elseif ($e_row[$i] == "1") {
				$skill_order .= "E";
			}elseif ($r_row[$i] == "1") {
				$skill_order .= "R";
			}
		}

		$return_string .= "skillorder = {\"".$skill_order."\"}}";
		printf($return_string);
	}
?>