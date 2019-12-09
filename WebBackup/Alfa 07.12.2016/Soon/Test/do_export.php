<?php
    if(!isset($_POST) || !isset($_POST["usr"]) || !isset($_POST["auth"]) || !isset($_POST["region"])){
        die("Unauthorized (Error Code 11)");
    }

//DB Login
$servername = "localhost";
$username = "web27628762";
$password = "9x7wKi4W";
$dbname = "usr_web27628762_3";
try {
    //Open connection to DB
    $conn = new PDO("mysql:host=$servername;dbname=$dbname", $username, $password);
    $conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    $conn->setAttribute(PDO::ATTR_EMULATE_PREPARES, false);

    //Unset Login var's
    unset($servername);
    unset($username);
    unset($password);
    unset($dbname);

    $sql_is_admin = $conn->prepare("SELECT user_level,session_token FROM users WHERE user_name = :usr");
    $sql_is_admin->bindParam(':usr', $_POST["usr"]);
    $sql_is_admin->execute();
    $admin = $sql_is_admin->fetchAll();
    unset($sql_is_admin);
    if(sizeof($admin) != 1){
        die("Unauthorized (Error Code 11)");
    }
    if($admin[0]["session_token"] != $_POST["auth"]){
        die("Unauthorized (Error Code 11)");
    }
    if($admin[0]["user_level"] != 1){
        die("Unauthorized (Error Code 11)");
    }
    unset($admin);
    
    $sql_get_all_account_in_region = $conn->prepare("SELECT login_name, password FROM accounts WHERE region = :r AND state = :s");
    $region = $_POST["region"];
    if($region != "EUW" && $region != "NA"){
        die("Wrong Region");
    }
    $sql_get_all_account_in_region->bindParam(':r', $region);
    if($_POST["state"] == "PW") {
        $state = 1;
    }else{
        $state = 0;
    }
    $sql_get_all_account_in_region->bindParam(':s', $state);
    $sql_get_all_account_in_region->execute();
    $allaccounts_in_region = $sql_get_all_account_in_region->fetchAll();

    $allaccounts_string = "";
    foreach ($allaccounts_in_region as $k=>$v){
        $allaccounts_string .= base64_decode($v["login_name"]).":".base64_decode($v["password"])."\r\n";
    }
    echo $allaccounts_string;

    $conn = null;
    die();
}catch(PDOException $ex){
    unset($servername);
    unset($username);
    unset($password);
    unset($dbname);
    die("Unauthorized (Error Code -1)");
}
?>