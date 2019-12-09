<?php
    if(!isset($_POST) || !isset($_POST["usr"]) || !isset($_POST["authusr"]) || !isset($_POST["auth"]) || !isset($_POST["newstatus"]) || $_POST["newstatus"] > 0){
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
    $sql_is_admin->bindParam(':usr', $_POST["authusr"]);
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

    $sql_change_auth_status = $conn->prepare("UPDATE users SET user_level = :usrlvl WHERE UUID = :uuid");
    $newlevel = $_POST["newstatus"];
    $sql_change_auth_status->bindParam(':usrlvl', $newlevel);
    $uuid = $_POST["usr"];
    $sql_change_auth_status->bindParam(':uuid', $uuid);
    $sql_change_auth_status->execute();
    unset($sql_change_auth_status);

    echo "OK";
    $conn = null;
}catch(PDOException $ex){
    unset($servername);
    unset($username);
    unset($password);
    unset($dbname);
    die("Unauthorized (Error Code -1)");
}
?>