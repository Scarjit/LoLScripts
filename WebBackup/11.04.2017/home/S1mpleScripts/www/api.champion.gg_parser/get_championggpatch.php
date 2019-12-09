<?php
	$championggsource = file_get_contents("http://champion.gg/");
	preg_match("/css\?v=\d\.\d\d/",$championggsource,$match);
	$match = substr($match[0],6);
	print_r($match);
?>