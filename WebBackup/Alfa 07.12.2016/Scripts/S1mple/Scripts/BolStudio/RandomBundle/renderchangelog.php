<?php
require_once('html2_pdf_lib/html2pdf.class.php');
$content = "";

try{		
	$db_user = "web27628762";
	$db_host = "localhost";
	$db_password = "9x7wKi4W";
	$db_name = "usr_web27628762_6";

	$conn = new PDO("mysql:host=$db_host;dbname=$db_name", $db_user, $db_password);
	$conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
	unset($db_user);
	unset($db_host);
	unset($db_password);
	unset($db_name);
	
	$scripts = array(
		"1" => "core",
		"2" => "AurelionSol",
		"3" => "ts",
		"4" => "Ziggs",
		"5" => "Veigar",
		"6" => "Syndra",
		"7" => "Nami",
		"8" => "Jhin",
		"9" => "Corki",
	);
	
	$script_names = array(
		"1" => "Core",
		"2" => "AurelionSol",
		"3" => "TargetSelector",
		"4" => "Ziggs",
		"5" => "Veigar",
		"6" => "Syndra",
		"7" => "Nami",
		"8" => "Jhin",
		"8" => "Corki",
	);
	
	
	$sql_get_changelog = $conn->prepare("SELECT * FROM RandomBundle_Changelog ORDER BY cid DESC");
	$sql_get_changelog->execute();
	$sql_get_changelog_fetched = $sql_get_changelog->fetchAll();
	
	
	$text = "";
	foreach($sql_get_changelog_fetched as $changelog){
		$icon = "./icons/".$scripts[$changelog["SCRIPT_ID"]].".png";
		$version_number = $changelog["Version_Number"];
		$changelog_text = $changelog["Changelog"];
		
		$changelog_text_formated = str_replace("\r","<br>",$changelog_text);
		$changelog_text_formated = str_replace("*"," *",$changelog_text_formated);
		$changelog_text_formated = str_replace("+"," +",$changelog_text_formated);
		$changelog_text_formated = str_replace("-"," -",$changelog_text_formated);
		
		$text .= "<fieldset>";
		$text .= "<img height='42' width='42' src='".$icon."'>";
		$text .= "\t\t<strong>".$script_names[$changelog["SCRIPT_ID"]]."</strong> Version: ".$version_number;
		$text .= "<br><br>";
		$text .= "<div><strong>".$changelog_text_formated."</strong></div><br>";
		$text .= "</fieldset>";
		$text .= "<br><br>";
	}
	
	echo $text;
		
}catch(Exeption $ex){
	print_r("Error");
}

/*
try
    {
		$html2pdf = new HTML2PDF('P', 'A2', 'en');
		$html2pdf->setDefaultFont('courier');
		$html2pdf->writeHTML($text);
		$file = $html2pdf->Output('temp.pdf','F');
		//pdf creation
		
		$im = new imagick();
		
		$im->readImage('temp.pdf');
		$im->setImageBackgroundColor('#ffffff');
		$im->setImageFormat('jpeg');
		$im->setImageCompression(imagick::COMPRESSION_JPEG);
		$im = $im->flattenImages();
		$im->setImageCompressionQuality(100);
		//$im->cropImage(5000,5000,0,0);
		$im->setResolution(800,400);
		
		$im->writeImage("changelog.png");
		$im->clear();
		$im->destroy();
		
		//Delete temp file
		unlink('temp.pdf');
		
    }
	catch(HTML2PDF_exception $e) {
        echo $e;
        exit;
    }
	
	//header('Location: changelog.png');

*/	
?>