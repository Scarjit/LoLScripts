<?php
    function JSONToAccounts($JSON){

        $res = json_decode($JSON, true);
        $ret = array();
        foreach ($res as $key=>$value){
            $account = array();
            $username = $value["Username"];
            $password = $value["Password"];
            $level = $value["Level"];
            $region = $value["Region"];
            if($region == 1){
                $region = "EUW";
            }else{
                $region = "NA";
            }
            $champsraw = $value["ChampionList"];
            $champs = array();
            foreach ($champsraw as $k=>$v){
                array_push($champs, $v["Name"]);
            }
            $account["username"] = base64_encode($username);
            $account["password"] = base64_encode($password);
            $account["level"] = $level;
            $account["region"] = $region;
            $account["champions"] = json_encode($champs);
            array_push($ret, $account);
        }
        return $ret;
    }

    if(!isset($_POST) || !isset($_POST["usr"]) || !isset($_POST["json"]) || !isset($_POST["auth"])){
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

    $accounts = JSONToAccounts($_POST["json"]);

    $sql_insert_or_update = $conn->prepare("INSERT INTO accounts (UUID, login_name, password, InUseTill, c_user, account_level, champion_json, region, state) VALUES (NULL, :login, :password, 0, 0, :level, :champion, :r, :s) ON DUPLICATE KEY UPDATE account_level = :level2, champion_json = :champion2, state = :s2");
    foreach ($accounts as $key=>$account){
        $sql_insert_or_update->bindParam(':login', $account["username"]);
        $sql_insert_or_update->bindParam(':password', $account["password"]);
        $sql_insert_or_update->bindParam(':level', $account["level"]);
        $sql_insert_or_update->bindParam(':level2', $account["level"]);
        $sql_insert_or_update->bindParam(':champion', $account["champions"]);
        $sql_insert_or_update->bindParam(':champion2', $account["champions"]);
        $sql_insert_or_update->bindParam(':r', $account["region"]);
        if($_POST["state"] == "private"){
            $one = 1;
            $sql_insert_or_update->bindParam(':s', $one);
            $sql_insert_or_update->bindParam(':s2', $one);
        }else{
            $one = 0;
            $sql_insert_or_update->bindParam(':s', $one);
            $sql_insert_or_update->bindParam(':s2', $one);
        }
        $sql_insert_or_update->execute();
    }
    echo "Inserted or updated: ".sizeof($accounts). " Accounts";

    $conn = null;
}catch(PDOException $ex){
    unset($servername);
    unset($username);
    unset($password);
    unset($dbname);
    die($ex->getMessage());
}
?>