<?php
    /*
     * ID, url_b64, user_count, geoip-json, time_on_page_per_visitor
     *
     * GEO IP: 2cb1976591e46a33f9b64e9a38af516e1f792d3423147dfa9b75e6d0471fb58a
     */

if(!isset($_GET["time"]) || !isset($_GET["ip"])){
    die();
}

$raw_info = file_get_contents('http://api.ipinfodb.com/v3/ip-country/?key=2cb1976591e46a33f9b64e9a38af516e1f792d3423147dfa9b75e6d0471fb58a&format=raw&ip='.$_GET["ip"]);
$exploded_info = explode(";", $raw_info);

$visitor_time = $_GET["time"];
$visitor_nation = $exploded_info[sizeof($exploded_info)-1];

if(!isset($exploded_info)){
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
    $sql_isWebSiteAlreadyRegistered = $conn->prepare("SELECT * FROM WebTracker WHERE url_b64 = :b64");
    $b64code = base64_encode($_SERVER["HTTP_REFERER"]);
    $sql_isWebSiteAlreadyRegistered->bindParam(':b64', $b64code);
    $sql_isWebSiteAlreadyRegistered->execute();

    $sql_isWebSiteAlreadyRegistered->setFetchMode(PDO::FETCH_ASSOC);

    $result_isWebSiteAlreadyRegistered = $sql_isWebSiteAlreadyRegistered->fetchAll();
    if(count($result_isWebSiteAlreadyRegistered) == 0){
        echo "Website not registered";
        die();
    }

    $id = 0;
    $url_b64 = "";
    $user_count = 0;
    $geoip_json = "";
    $time_on_page_per_visitor = 0;

    foreach ($result_isWebSiteAlreadyRegistered as $key=>$value){
        $id = $value["ID"];
        $url_b64 = $value["url_b64"];
        $user_count = $value["user_count"];
        $geoip_json = $value["geoip_json"];
        $time_on_page_per_visitor = $value["time_on_page_per_visitor"];
    }

    //Generate Data to post back
    $decoded_json = json_decode($geoip_json,true);
    if(isset($decoded_json)){
        if(isset($decoded_json[$visitor_nation])){
            $decoded_json[$visitor_nation] = $decoded_json[$visitor_nation]+1;
        }else{
            $decoded_json[$visitor_nation] = 1;
        }
    }else{
        $decoded_json = array();
        $decoded_json[$visitor_nation] = 1;
    }

    $reencoded_json = json_encode($decoded_json);
    $time_on_page_per_visitor = (($user_count*$time_on_page_per_visitor)+$visitor_time)/($user_count+1);
    $user_count++;

    $sql_updatestuff = $conn->prepare("UPDATE WebTracker SET user_count = :user_count, geoip_json = :geoip_json, time_on_page_per_visitor = :time_on_page_per_visitor WHERE url_b64 = :b64");
    $sql_updatestuff->bindParam(':b64',$b64code);
    $sql_updatestuff->bindParam(':user_count',$user_count);
    $sql_updatestuff->bindParam(':geoip_json',$reencoded_json);
    $sql_updatestuff->bindParam(':time_on_page_per_visitor',$time_on_page_per_visitor);
    $sql_updatestuff->execute();
    echo "Success";

}catch(PDOException $ex){
    echo $ex->getMessage();
}
$conn = null;

?>