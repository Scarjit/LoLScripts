<?php
	$list = file_get_contents("http://unicode.org/emoji/charts/full-emoji-list.html");
	echo $list;
?>