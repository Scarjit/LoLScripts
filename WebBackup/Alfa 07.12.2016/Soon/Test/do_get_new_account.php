<?php
function secondsToTime($seconds)
{
    // extract hours
    $hours = floor($seconds / (60 * 60));

    // extract minutes
    $divisor_for_minutes = $seconds % (60 * 60);
    $minutes = floor($divisor_for_minutes / 60);

    // extract the remaining seconds
    $divisor_for_seconds = $divisor_for_minutes % 60;
    $seconds = ceil($divisor_for_seconds);

    // return the final array
    $obj = array(
        "h" => (int) $hours,
        "m" => (int) $minutes,
        "s" => (int) $seconds,
    );
    return $obj;
}

    if(!isset($_POST) || !isset($_POST["usr"]) || !isset($_POST["auth"]) || !isset($_POST["region"])){
        die("There was an error while requestion your Data (Error Code 12)");
    }

//DB Login
$servername = "localhost";
$username = "web27628762";
$password = "9x7wKi4W";
$dbname = "usr_web27628762_3";
try {
    //
    $time = 172800; //48 Hours

    //Open connection to DB
    $conn = new PDO("mysql:host=$servername;dbname=$dbname", $username, $password);
    $conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    $conn->setAttribute(PDO::ATTR_EMULATE_PREPARES, false);

    //Unset Login var's
    unset($servername);
    unset($username);
    unset($password);
    unset($dbname);
    
    //Check login
    $sql_check_login = $conn->prepare("SELECT * FROM users WHERE user_name = :usr");
    $sql_check_login->bindParam(':usr', $_POST["usr"]);
    $sql_check_login->execute();
    $user_account = $sql_check_login->fetchAll();
    if(sizeof($user_account) == 0){
        die("Unauthorized (Error Code 11)");
    }
    if($user_account[0]["session_token"] != $_POST["auth"]){
        die("Unauthorized (Error Code 11)");
    }
    if($user_account[0]["last_retrival"]+$time > time()){
        die("Unauthorized (Error Code 11)");
    }
    $state = 0;
    if($user_account[0]["user_level"] == 1){
        $state = 1;
    }
    unset($sql_check_login);


    //Get all free or expired accounts
    $sql_get_all_free_accounts = $conn->prepare("SELECT * FROM accounts WHERE (c_user = 0 OR InUseTill < :t) AND region = :r AND state = :s");
    $tt = time();
    $region = $_POST["region"];
    $sql_get_all_free_accounts->bindParam(':r', $region);
    $sql_get_all_free_accounts->bindParam(':t', $tt);
    $sql_get_all_free_accounts->bindParam(':s', $state);
    $sql_get_all_free_accounts->execute();
    $allaccounts = $sql_get_all_free_accounts->fetchAll();

    if(sizeof($allaccounts) == 0 && $user_account[0]["user_level"] == 1){
        $state = 0;
        $sql_get_all_free_accounts->bindParam(':s', $state);
        $sql_get_all_free_accounts->execute();
        $allaccounts = $sql_get_all_free_accounts->fetchAll();
    }

    unset($sql_get_all_free_accounts);
    $allaccounts_size = sizeof($allaccounts);
    if($allaccounts_size > 0){
        $randacc = rand(0, $allaccounts_size-1);

        $UUID = $allaccounts[$randacc]["UUID"];
        $login_name = $allaccounts[$randacc]["login_name"];
        $password= $allaccounts[$randacc]["password"];
        $Champions = "{".$allaccounts[$randacc]["champion_json"]."}";
        $Level = $allaccounts[$randacc]["account_level"];
        $time = 172800; //48 Hours
        $InUseTill = time()+$time;
        $c_user = $user_account[0]["UUID"];

        //write back account DB
        $sql_set_account_in_use = $conn->prepare("UPDATE accounts SET c_user = :usr, InUseTill = :tmr WHERE UUID = :uuid");
        $sql_set_account_in_use->bindParam(':usr', $c_user);
        $sql_set_account_in_use->bindParam(':tmr', $InUseTill);
        $sql_set_account_in_use->bindParam(':uuid', $UUID);
        $sql_set_account_in_use->execute();
        unset($sql_set_account_in_use);

        //write back to user DB
        $sql_set_last_retrival = $conn->prepare("UPDATE users SET last_retrival = :la WHERE UUID = :uuid");
        $tt = time();
        $sql_set_last_retrival->bindParam(':la', $tt);
        $sql_set_last_retrival->bindParam(':uuid', $c_user);
        $sql_set_last_retrival->execute();
        unset($sql_set_last_retrival);

        $t = secondsToTime($time);
        $h = $t["h"]."";
        $m = $t["m"]."";
        $s = $t["s"]."";
        if(strlen($t["h"]) == 1){
            $h = "0".$h;
        }
        if(strlen($t["m"]) == 1){
            $m = "0".$m;
        }
        if(strlen($t["s"]) == 1){
            $s = "0".$s;
        }
        $formated_time = $h . ":" . $m . ":" . $s;
        echo "{\"uuid\":\"$UUID\",\"login_name\":\"$login_name\",\"password\":\"$password\",\"time\":\"$formated_time\",\"level\":\"$Level\"}";

    }else{
        echo "No Account available";
    }
    $conn = null;
    
}catch(PDOException $ex){
    unset($servername);
    unset($username);
    unset($password);
    unset($dbname);
    $conn = null;
    die($ex->getMessage());
}
?>