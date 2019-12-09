<?php
/**
 * Created by PhpStorm.
 * Copyright 2016 by S1mpleScripts
 * sauth@s1mplescripts.de
 *
 * Code List:
 * 1: Invalid Get Request
 * 2: Invalid SID
 * 3: Begun Trial
 * 4: Banned
 * 5: Trial Expired
 * 6: In Trial
 * 7: Success
 * 8: PDO Exception
 *
 * Example Request:
 *
 */

function is_base64($s)
{
    return (bool) preg_match('/^[a-zA-Z0-9\/\r\n+]*={0,2}$/', $s);
}

function LogPDOException(PDOException $ex){
    if($ex){
        file_put_contents("../pdoexceptions.log",date("d.m.y H:i:s",time())." api/is_authed: ".$ex->getMessage()."\r\n",FILE_APPEND);
    }
}

function DLC(PDO $conn, $code, $uuid, $uname, $authed, $IsTrial, $HWID, $sid){
    $Date = date("d.m.y H:i:s",time());
    $IP = $_SERVER['REMOTE_ADDR'];

    $sql_log = $conn->prepare("INSERT INTO log (LID, UUID, SID, Authed, IsTrial, HWID, User_Name, Code, IP, Date) VALUES (NULL, :uuid, :sid, :authed, :istrial, :hwid, :uname, :code, :ip, :t)");
    $sql_log->bindParam(':uuid', $uuid);
    $sql_log->bindParam(':sid', $sid);
    $sql_log->bindParam(':authed', $authed);
    $sql_log->bindParam(':istrial', $IsTrial);
    $sql_log->bindParam(':hwid', $HWID);
    $sql_log->bindParam(':uname', $uname);
    $sql_log->bindParam(':code', $code);
    $sql_log->bindParam(':ip', $IP);
    $sql_log->bindParam(':t', $Date);
    $sql_log->execute();
    $conn = null;
    $ret = base64_encode("Code".$code);
    die($ret);
}

if (!isset($_GET["username"])
    || !isset($_GET["SID"])
    || !isset($_GET["HWID"])
    || (isset($_GET["username"]) && sizeof($_GET["username"])>64)
    || !is_base64($_GET["username"])
    || !is_base64($_GET["SID"])
    || !is_base64($_GET["HWID"])
    || !is_numeric(base64_decode($_GET["SID"]))){

        die("Q29kZSAx");
}

$guser = base64_decode($_GET["username"]);
$gsid = base64_decode($_GET["SID"]);
$ghwid = $_GET["HWID"];

echo $guser." || ".$gsid." || ".$ghwid."<br>";

try{
    $servername = "localhost";
    $username = "web27628762";
    $password = "9x7wKi4W";
    $conn = new PDO("mysql:host=$servername;dbname=usr_web27628762_4", $username, $password);
    $conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    unset($servername);
    unset($username);
    unset($password);

    //Is Valid SID
    $sql_is_sid = $conn->prepare("SELECT * FROM scripts WHERE SID = :s");
    $sql_is_sid->bindParam(':s',$gsid);
    $sql_is_sid->execute();
    $sql_is_sid_fetched = $sql_is_sid->fetchAll();
    if(sizeof($sql_is_sid_fetched) == 0){
        DLC($conn,"2",$uuid,$guser,0,0,$ghwid,$gsid);
    }

    //Get UUID for UserName
    $sql_get_uuid = $conn->prepare("SELECT UUID FROM users WHERE User_Name = :u");
    $sql_get_uuid->bindParam(':u',$guser);
    $sql_get_uuid->execute();
    $sql_get_uuid_fetched = $sql_get_uuid->fetchAll();
    if(sizeof($sql_get_uuid_fetched) == 0){
        //Create New User
        $sql_insert_new_user = $conn->prepare("INSERT INTO users (UUID, User_Name) VALUES (NULL , :u)");
        $sql_insert_new_user->bindParam(':u',$guser);
        $sql_insert_new_user->execute();

        //Get UUID for New User
        $sql_get_uuid = $conn->prepare("SELECT UUID FROM users WHERE User_Name = :u");
        $sql_get_uuid->bindParam(':u',$guser);
        $sql_get_uuid->execute();
        $sql_get_uuid_fetched = $sql_get_uuid->fetchAll();
    }
    $uuid = $sql_get_uuid_fetched[0]["UUID"];
    
    //Is Authed for SID ?
    $sql_get_auth_data = $conn->prepare("SELECT * FROM auths WHERE UUID = :u AND SID = :s");
    $sql_get_auth_data->bindParam(':u',$uuid);
    $sql_get_auth_data->bindParam(':s',$gsid);
    $sql_get_auth_data->execute();
    $sql_get_auth_data_fetched = $sql_get_auth_data->fetchAll();
    if(sizeof($sql_get_auth_data_fetched) == 0){
        //Begin Trial
        $sql_begin_trial = $conn->prepare("INSERT INTO auths (AID, UUID, SID, Expires, ExpireDate, Banned, Ban_Reason) VALUES (NULL , :uuid, :sid, 1, :expdate, 0, '')");
        $sql_begin_trial->bindParam(':uuid',$uuid);
        $sql_begin_trial->bindParam(':sid', $gsid);
        $exptime = time()+259200;
        $sql_begin_trial->bindParam(':expdate', $exptime);
        $sql_begin_trial->execute();
        DLC($conn,"3",$uuid,$guser,1,1,$ghwid,$gsid);
    }else{
        //Only the first is interesting
        $sql_get_auth_data_fetched = $sql_get_auth_data_fetched[0];
        //Check IsBanned
        if($sql_get_auth_data_fetched["Banned"] == 1){
            DLC($conn,"4: ".$sql_get_auth_data_fetched["Ban_Reason"],$uuid,$guser,0,0,$ghwid,$gsid);
        }

        //Check Trial
        if($sql_get_auth_data_fetched["Expires"] == 1){
            if(time() > $sql_get_auth_data_fetched["ExpireDate"]){
                DLC($conn,"5",$uuid,$guser,0,1,$ghwid,$gsid);
            }else{
                DLC($conn,"6: ".($sql_get_auth_data_fetched["ExpireDate"]-time()),$uuid,$guser,1,1,$ghwid,$gsid);
            }
        }
        DLC($conn,"7",$uuid,$guser,1,0,$ghwid,$gsid);
    }
}catch (PDOException $ex){
    LogPDOException($ex);
    DLC($conn,"8",-1,$guser,0,0,$ghwid,$gsid);
}