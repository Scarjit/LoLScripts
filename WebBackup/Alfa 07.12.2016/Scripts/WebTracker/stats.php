<!DOCTYPE html><html><head><meta charset="UTF-8"><title>S1mple Stats</title><link rel="icon" href="img/favicon.ico" /><link rel="icon" type="image/png" href="img/favicon.png" /><link rel="stylesheet" href="style.css"></head><body><div class="content"><h1>S1mple Stats</h1><center>
<?php
//DB Login
$servername = "localhost";
$username = "web27628762";
$password = "9x7wKi4W";
$dbname = "usr_web27628762_2";

try{
    $conn = new PDO("mysql:host=$servername;dbname=$dbname", $username, $password);
    $conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

//Prepare SQL Statement
    $sql_getAll = $conn->prepare("SELECT ID,url_b64,user_count,geoip_json,time_on_page_per_visitor FROM WebTracker");
    $sql_getAll->execute();
    echo "<table>";
    echo "<tr>";
    echo "<th>ID</th><th>URL</th><th>User's</th><th>Geo IP</th><th>Time on Page per Visitor (Seconds)</th>";
    echo "</tr>";
    foreach ($sql_getAll as $key=>$value){
        echo "<tr>";
        foreach ($value as $k=>$v){
            if(gettype($k) != "integer") {
                if($k == "url_b64") {
                    echo "<td>" . base64_decode($v) . "</td>";
                }else if($k == "time_on_page_per_visitor"){
                    echo "<td>" . ($v/1000) . "</td>";
                }else{
                    echo "<td>" . $v . "</td>";
                }
            }
        }
        echo "</tr>";
    }
    echo "</table>";
    $conn = null;
}catch(PDOException $ex){
    echo $ex->getMessage();
}
?>
</center><div class="push"></div></div><div class="footer"><p>2016 © S1mple Stats</p><p>Site coded and designed with ♥ by <a href="http://www.scarjit.de/DrPhoenix/">Doctor Phoenix</a></p></div></body></html>