<?php
    function LogPDOException(PDOException $ex){
        if($ex){
            file_put_contents("../../pdoexceptions.log",date("d.m.y H:i:s",time())." admin/ajax/do_searchUser: ".$ex->getMessage()."\r\n",FILE_APPEND);
        }
    }

    if(!isset($_GET["user"])){
        die("No user");
    }

    if(sha1($_COOKIE["pw"]) != "fb17f13ad7e83059d4ae74965ca2c2ff19fad994"){
        die("Invalid Cookie");
    }

    $uname = $_GET["user"];
    if(strlen($uname) == 0){
        die("No user");
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

    $get_all_users = $conn->prepare("SELECT * FROM users");
    $get_all_users->bindParam(':s', $uname);
    $get_all_users->execute();
    $get_all_users_fetched = $get_all_users->fetchAll();

    $matched_users = array();
    foreach ($get_all_users_fetched as $k=>$v){
        if(strpos($v["User_Name"], $uname) !== false) {
            array_push($matched_users, $v);
        }
    }

    if(sizeof($matched_users) == 1){
        die($matched_users[0]["User_Name"]);
    }else{
        $unamearray = "";
        foreach ($matched_users as $k=>$v) {
            $unamearray .= $v["User_Name"]."\r\n";
        }
        print_r($unamearray);
    }

    $conn = null;
}catch (PDOException $ex){
    LogPDOException($ex);
}