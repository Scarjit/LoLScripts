<?php

    if(!isset($_POST) || !isset($_POST["usr"]) || !isset($_POST["auth"]) || !isset($_POST["searchstr"])){
        die("There was an error while requestion your Data (Error Code 12)");
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

    //print_r($_POST);

    $sql_get_accounts = $conn->prepare("SELECT login_name,password,account_level,champion_json,InUseTill,region, state FROM accounts");
    $sql_get_accounts->execute();
    $accounts = $sql_get_accounts->fetchAll();
    $valid_accounts = array();
    $valid_accounts_used = array();
    $i = 0;
    $n = 0;
    foreach ($accounts as $k=>$account){
        if($i < 50) {
            $champs = json_decode($account["champion_json"], true);
            if (sizeof($champs) > 0) {
                if (in_array($_POST["searchstr"], $champs)) {
                    $na = array();
                    $na["login_name"] = $account["login_name"];
                    $na["password"] = $account["password"];
                    $na["account_level"] = $account["account_level"];
                    $na["champion_json"] = $account["champion_json"];
                    $na["region"] = $account["region"];
                    $na["state"] = $account["state"];
                    if($account["InUseTill"]-time() > 0) {
                        $na["InUse"] = 1;
                        $valid_accounts_used["Account".$n] = $na;
                        $n++;
                    }else{
                        $na["InUse"] = 0;
                        $valid_accounts["Account".$n] = $na;
                        $i++;
                        $n++;
                    }
                }
            }
        }
    }
    if(sizeof($valid_accounts) < 10){
        $i = 0;
        if($i < 40) {
            foreach ($valid_accounts_used as $k => $v) {
                $valid_accounts[$k] = $v;
                $i++;
            }
        }
    }
    //print_r($valid_accounts);
    print_r(json_encode($valid_accounts));

    $conn = null;
}catch(PDOException $ex){
    unset($servername);
    unset($username);
    unset($password);
    unset($dbname);
    die($ex->getMessage());
}
?>