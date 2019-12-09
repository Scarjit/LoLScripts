<?php
function LogPDOException(PDOException $ex)
{
    if ($ex) {
        file_put_contents("../pdoexceptions.log", date("d.m.y H:i:s", time()) . " api/do_redeem.php: " . $ex->getMessage() . "\r\n", FILE_APPEND);
    }
}

function dieandredirect($code){
    header('Location: /redeem.php?code='.$code);
    die($code);
}

if(!isset($_POST["uname"]) || !isset($_POST["mail"]) || !isset($_POST["code"]) || strlen($_POST["code"]) != 19){
    dieandredirect("1");
}

$uname = $_POST["uname"];
$mail = $_POST["mail"];
$code = strtoupper($_POST["code"]);

if(!(bool) preg_match('/([A-Z]|[0-9]){4}-([A-Z]|[0-9]){4}-([A-Z]|[0-9]){4}-([A-Z]|[0-9]){4}/', $code)){
    dieandredirect("2");
}



try {
    $servername = "localhost";
    $username = "web27628762";
    $password = "9x7wKi4W";
    $conn = new PDO("mysql:host=$servername;dbname=usr_web27628762_4", $username, $password);
    $conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    unset($servername);
    unset($username);
    unset($password);

    //Get Code data from Code
    $sql_get_sid_by_code = $conn->prepare("SELECT GID, SID, uses_left FROM gift_codes WHERE CODE = :c");
    $sql_get_sid_by_code->bindParam(':c', $code);
    $sql_get_sid_by_code->execute();
    $sql_get_sid_by_code_fetched = $sql_get_sid_by_code->fetchAll();
    if(sizeof($sql_get_sid_by_code_fetched) != 1){
        dieandredirect("3");
    }
    $sql_get_sid_by_code_fetched = $sql_get_sid_by_code_fetched[0];
    if($sql_get_sid_by_code_fetched["uses_left"] == 0){
        dieandredirect("4");
    }
    $sid = $sql_get_sid_by_code_fetched["SID"];

    //Get UUID for UserName
    $sql_get_uuid = $conn->prepare("SELECT UUID FROM users WHERE User_Name = :u");
    $sql_get_uuid->bindParam(':u',$uname);
    $sql_get_uuid->execute();
    $sql_get_uuid_fetched = $sql_get_uuid->fetchAll();
    if(sizeof($sql_get_uuid_fetched) == 0){
        //Create New User
        $sql_insert_new_user = $conn->prepare("INSERT INTO users (UUID, User_Name) VALUES (NULL , :u)");
        $sql_insert_new_user->bindParam(':u',$uname);
        $sql_insert_new_user->execute();

        //Get UUID for New User
        $sql_get_uuid = $conn->prepare("SELECT UUID FROM users WHERE User_Name = :u");
        $sql_get_uuid->bindParam(':u',$uname);
        $sql_get_uuid->execute();
        $sql_get_uuid_fetched = $sql_get_uuid->fetchAll();
    }
    $uuid = $sql_get_uuid_fetched[0]["UUID"];

    //Is Authed for SID ?
    $sql_get_auth_data = $conn->prepare("SELECT * FROM auths WHERE UUID = :u AND SID = :s");
    $sql_get_auth_data->bindParam(':u',$uuid);
    $sql_get_auth_data->bindParam(':s',$sid);
    $sql_get_auth_data->execute();
    $sql_get_auth_data_fetched = $sql_get_auth_data->fetchAll();
    $is_trial = 0;
    if(sizeof($sql_get_auth_data_fetched) != 0){
        if($sql_get_auth_data_fetched[0]["Expires"] == 0) {
            dieandredirect("5");
        }else{
            $is_trial = 1;
        }
    }

    //Is Valid SID
    $sql_is_sid = $conn->prepare("SELECT * FROM scripts WHERE SID = :s");
    $sql_is_sid->bindParam(':s',$sid);
    $sql_is_sid->execute();
    $sql_is_sid_fetched = $sql_is_sid->fetchAll();
    if(sizeof($sql_is_sid_fetched) == 0){
        dieandredirect("6");
    }
    $sname = $sql_is_sid_fetched[0]["Name"];

    //Reduce uses
    if($sql_get_sid_by_code_fetched["uses_left"] > 1) {
        $sql_set_uses = $conn->prepare("UPDATE gift_codes SET uses_left = :u WHERE GID = :g");
        $uses = $sql_get_sid_by_code_fetched["uses_left"] - 1;
        $gid = $sql_get_sid_by_code_fetched["GID"];
        $sql_set_uses->bindParam(':u', $uses);
        $sql_set_uses->bindParam(':g', $gid);
        $sql_set_uses->execute();
    }else{
        //Delete if no uses left
        $sql_delete_outdated_code = $conn->prepare("DELETE FROM gift_codes WHERE GID = :g");
        $gid = $sql_get_sid_by_code_fetched["GID"];
        $sql_delete_outdated_code->bindParam(':g', $gid);
        $sql_delete_outdated_code->execute();
    }

    //Add to payment log
    $sql_add_to_payment_log = $conn->prepare("INSERT INTO payments (PID, Service, SID, UUID, Success, Transaction_ID, Date, Payment_IP, Payment_Mail) VALUES (NULL, 'GIFT_CODE', :sid, :uuid, 1, :gc, :t, :ip, :mail)");
    $sql_add_to_payment_log->bindParam(':sid', $sid);
    $sql_add_to_payment_log->bindParam(':uuid',$uuid);
    $sql_add_to_payment_log->bindParam(':gc',$code);
    $Date = date("d.m.y H:i:s",time());
    $sql_add_to_payment_log->bindParam(':t',$Date);
    $IP = $_SERVER['REMOTE_ADDR'];
    $sql_add_to_payment_log->bindParam(':ip',$IP);
    $sql_add_to_payment_log->bindParam(':mail',$mail);
    $sql_add_to_payment_log->execute();

    //Auth user
    if($is_trial == 1){
        //Update trial user
        $sql_update_auth = $conn->prepare("UPDATE auths SET Expires = 0 WHERE UUID = :u AND SID = :s");
        $sql_update_auth->bindParam(':u', $uuid);
        $sql_update_auth->bindParam(':s', $sid);
        $sql_update_auth->execute();
    }else{
        //Insert new Auth
        $sql_insert_auth = $conn->prepare("INSERT INTO auths (AID,UUID,SID,Expires,ExpireDate,Banned,Ban_Reason) VALUES (NULL, :uuid, :sid, 0, 0, 0, '')");
        $sql_insert_auth->bindParam(':uuid', $uuid);
        $sql_insert_auth->bindParam(':sid', $sid);
        $sql_insert_auth->execute();
    }

    $conn = null;

    //Send E-Mail Confirmation
    $to = $mail;
    $subject = "SAuth Code Redeemed";
    $message = '<!DOCTYPE html>
                <html lang="en">
                <head>
                    <meta charset="UTF-8">
                    <title>SAuth Code Redeemed</title>
                    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1q8mTJOASx8j1Au+a5WDVnPi2lkFfwwEAa8hDDdjZlpLegxhjVME1fgjWPGmkzs7" crossorigin="anonymous">
                </head>
                <body>
                <div class="container">
                    <h1>You now have permanent Access to the following Script:</h1>
                    <table class="table">
                        <thead>
                            <th>BoL Name</th>
                            <th>Key</th>
                            <th>Script</th>
                        </thead>
                        <tbody>
                            <td>';
    $message .=$uname.'</td>
                            <td>';
    $message .= $code.'</td>
                            <td>';
    $message .= $sname.'</td>
                        </tbody>
                    </table>
                    <p>If you have any Questions regarding SCRIPT_NAME or the Authentification,
                    feel free to contact my on the Forum, or add me on Skype.</p>
                    <a href="http://hatscripts.com/addskype?S1mpleScripts" target="_blank"><img src="http://hatscripts.com/addskype/rand/S1mpleScripts.png"></a>
                </div>
                </body>
                </html>';
    $headers = 'MIME-Version: 1.0'."\r\n";
    $headers .= 'Content-type: text/html; charset=iso-8859-1' . "\r\n";
    $headers .= 'From: SAuth <sauth@s1mplescripts.de>' . "\r\n";
    mail($to, $subject, $message, $headers);

    dieandredirect("0");
} catch (PDOException $ex) {
    LogPDOException($ex);
    dieandredirect("-1");
}