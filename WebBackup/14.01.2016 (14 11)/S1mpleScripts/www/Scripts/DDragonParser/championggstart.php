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
	
	if(!isset($_GET["champion"])){
		die("return nil");
	}else{
		$championgg = file_get_contents("http://champion.gg/champion/".$_GET["champion"]);
		
		$perccorebuild_str = strpos($championgg, "Highest Win % Starters")+57;
		$championgg = substr($championgg, $perccorebuild_str);
		
		
		$div = strpos($championgg, "<div class=\"build-text\">");
		$championgg = substr($championgg,0, $div);
		
		$return_string = "return {";
		
		preg_match_all("/[0-9]+\.png/", $championgg, $output_array);
		foreach ($output_array[0] as $k => $v) {
			$x = (substr($v,0,4));
			$return_string .= $x.",";
		}
		$return_string .= "}";
		
		print_r($return_string);
	}
?>