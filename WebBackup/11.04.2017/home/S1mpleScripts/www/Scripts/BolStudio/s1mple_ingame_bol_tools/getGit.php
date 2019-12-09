<?php
	error_reporting(E_ALL);
	ini_set('display_errors', 'On');
	
	if(!isset($_GET["url"])){
		die();
	}
	
	function get_http_response_code($url) {
		$headers = get_headers($url);
		return substr($headers[0], 9, 3);
	}
	
	$path = base64_decode($_GET["url"]);	
	$path = filter_var($path, FILTER_SANITIZE_URL);
	$path = htmlspecialchars($path, ENT_QUOTES);
	if(filter_var($path, FILTER_VALIDATE_URL) === FALSE){
		die();
	}
	if(get_http_response_code($path) != "200"){
		echo base64_encode("error");
	}else{
		$x = file_get_contents($path);
		echo base64_encode($x);
	}
?>