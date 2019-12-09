<table>
  <tr>
    <th>Champion</th>
    <th>#Scripts</th> 
    <th>Paid</th>
    <th>Free & Working</th>
  </tr>
  
<?php

	$ddragon_raw = file_get_contents("https://ddragon.leagueoflegends.com/cdn/6.18.1/data/en_US/champion.json");
	preg_match_all("/id\":\"[A-Z|a-z]+/", $ddragon_raw, $output_array);
	$output_array = $output_array[0];
	foreach ($output_array as $key=>$value){
		$champ = substr($value,5);
		if($champ == "MonkeyKing"){
			$champ = "Wukong";
		}
		$bol_tool_raw = file_get_contents("http://bol-tools.com/api/search/champion/".$champ."/0");
		preg_match_all("/id\":[0-9]+/", $bol_tool_raw, $out_count);
		$out_count = $out_count[0];
		$count = sizeof($out_count);
		
		preg_match_all("/isPaid\":true/", $bol_tool_raw, $out_payed);
		$out_payed = $out_payed[0];
		$payed = sizeof($out_payed);
		
		preg_match_all("/isPaid\":false,\"isWorking\":true/", $bol_tool_raw, $out_free_and_working);
		$out_free_and_working = $out_free_and_working[0];
		$free_and_working = sizeof($out_free_and_working);
		
		print("<tr>");
		print("<td>".$champ."</td>");
		print("<td>".$count."</td>");
		print("<td>".$payed."</td>");
		print("<td>".$free_and_working."</td>");
		print("</tr>");
	}
?>
  
</table>