<?php
    /*
     * ID, url_b64, user_count, geoip-json, time_on_page_per_visitor
     */

    if(!isset($_GET["Authcode"]) || $_GET["Authcode"] != "42a1ba123e6ea6fc93e286ed97c7018"){
        echo "Invalid Auth Code";
        die();
    }

//DB Login
$servername = "localhost";
$username = "web27628762";
$password = "9x7wKi4W";
$dbname = "usr_web27628762_2";

//Open Conn
try {
    $conn = new PDO("mysql:host=$servername;dbname=$dbname", $username, $password);
    $conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

//Prepare SQL Statement
    $b64code = base64_encode($_GET["website"]);

    $sql_isAlreadyRegistered = $conn->prepare("SELECT url_b64 FROM WebTracker WHERE url_b64 = :b64");
    $sql_isAlreadyRegistered->bindParam(':b64', $b64code);
    $sql_isAlreadyRegistered->execute();
    foreach ($sql_isAlreadyRegistered->fetchAll() as $k=>$v){
        foreach ($v as $k2=>$v2){
            if($v2 == $b64code){
                echo "Website already registered";
                die();
            }
        }
    }

    $sql_RegisterNewSite = $conn->prepare("INSERT INTO WebTracker (ID, url_b64, user_count, geoip_json, time_on_page_per_visitor) VALUES (NULL, :b64, 0, '{}', 0)");
    $sql_RegisterNewSite->bindParam(':b64', $b64code);
    $sql_RegisterNewSite->execute();
    $sql_RegisterNewSite->setFetchMode(PDO::FETCH_ASSOC);

    echo "Inserted: ".$_GET["website"]. " to the Tracker DB";

}catch(PDOException $ex){
    echo $ex->getMessage();
}
$conn = null;
?>