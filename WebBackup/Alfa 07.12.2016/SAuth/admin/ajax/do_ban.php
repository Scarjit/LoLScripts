<?php
    function LogPDOException(PDOException $ex){
        if($ex){
            file_put_contents("../../pdoexceptions.log",date("d.m.y H:i:s",time())." admin/ajax/do_ban: ".$ex->getMessage()."\r\n",FILE_APPEND);
        }
    }
    if(!isset($_GET["user"])){
        die("Invalid GET");
    }
    if(sha1($_COOKIE["pw"]) != "fb17f13ad7e83059d4ae74965ca2c2ff19fad994"){
        die("Invalid Cookie");
    }

    $uname = $_GET["user"];
    if(strlen($uname) == 0){
        die("Invalid GET");
    }

try{
    $servername = "localhost";
    $username = "web27628762";
    $password = "9x7wKi4W";
    $conn = new PDO("mysql:host=$servername;dbname=usr_web27628762_4", $username, $password);
    $conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    unset($servername);
    unset($username);
    unset($password);

    //Get UUID
    $sql_get_uuid = $conn->prepare("SELECT UUID FROM users WHERE User_Name = :uname");
    $sql_get_uuid->bindParam(':uname',$uname);
    $sql_get_uuid->execute();
    $sql_get_uuid_fetched = $sql_get_uuid->fetchAll();
    if(sizeof($sql_get_uuid_fetched) == 0){
        die("Invalid User Name");
    }
    $uuid = $sql_get_uuid_fetched[0]["UUID"];

    $sql_ban_on_all_scripts = $conn->prepare("UPDATE auths SET Banned = 1 WHERE UUID = :uuid");
    $sql_ban_on_all_scripts->bindParam(':uuid',$uuid);
    $sql_ban_on_all_scripts->execute();

    $conn = null;
    die("User Banned");
}catch (PDOException $ex){
    LogPDOException($ex);
}