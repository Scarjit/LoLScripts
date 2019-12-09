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
		
		$perccorebuild_str = strpos($championgg, "Highest Win % Core Build")+57;
		$championgg = substr($championgg, $perccorebuild_str);
		
		$div = strpos($championgg, "<div class=\"build-text\">");
		$championgg = substr($championgg,0, $div);
		
		$items = explode("<small>></small>",$championgg);
		
		
		$return_string = "return {";
		foreach($items as $k=>$v){
			$sitems = strpos($v, "/item/")+6;
			$v = substr($v,$sitems);
			$v = substr($v,0,4);		
			$return_string = insertintoluatable($return_string, $v);
		}				
		$return_string .= "}";
		print_r($return_string);
	}
?>