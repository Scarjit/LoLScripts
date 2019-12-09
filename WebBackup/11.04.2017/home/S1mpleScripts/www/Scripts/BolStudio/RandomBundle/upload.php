<?php
	if(!isset($_GET["pw"]) || $_GET["pw"] != "8221a4083883b2c99ff65233338b9dbcbf846262"){
		die();
	}
?>
<!DOCTYPE html>
<html>
<!-- Latest compiled and minified CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">

<!-- Optional theme -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" integrity="sha384-rHyoN1iRsVXV4nD0JutlnGaslCJuC7uwjduW9SVrLvRYooPp2bWYgmgJQIXwl/Sp" crossorigin="anonymous">

<!-- Latest compiled and minified JavaScript -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>
<style>
div.editable {
    width: 360px;
    height: 200px;
    border: 1px solid #ccc;
    padding: 5px;
}
</style>
<body>
<br><br>
<div class="container">
<form action="do_upload.php" method="post" enctype="multipart/form-data" autocomplete="off">
    Select file to upload:<br>
    <input type="file" name="fileToUpload" id="fileToUpload">
	<br>Changelog:<br>
	<textarea  type="text" name="changelog" id="changelog" rows="6" cols="50" onkeyup="update()"></textarea>
	<br>Version:<br>
	<input type="number" name="version" id="version" step="0.1">	
	<br><br>
	<input type="hidden" value="8221a4083883b2c99ff65233338b9dbcbf846269" name="pw" id="pw">
    <input type="submit" value="Upload File" name="submit">
</form>
</div>
<br><br>
<div class="container">
<div class="editable" contenteditable="true" id="preview"></div>
</div>
</body>
<script>
function update(){
	var cl = document.getElementById("changelog").value;
	document.getElementById("preview").innerHTML = replaceAll(cl, "\n", "<br>")
}

function escapeRegExp(str) {
    return str.replace(/([.*+?^=!:${}()|\[\]\/\\])/g, "\\$1");
}

function replaceAll(str, find, replace) {
  return str.replace(new RegExp(escapeRegExp(find), 'g'), replace);
}
</script>
</html>