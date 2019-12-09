<?php
    function LogPDOException(PDOException $ex){
        if($ex){
            file_put_contents("../pdoexceptions.log",date("d.m.y H:i:s",time())." shop/do_pay: ".$ex->getMessage()."\r\n",FILE_APPEND);
        }
    }

    function dieandredirect($code){
        header('Location: index.php?c='.$code);
        die($code);
    }

    if (!isset($_GET["pmt"]) || !isset($_GET["sn"]) || !isset($_GET["vc"]) || !isset($_GET["bn"])){
        dieandredirect("1");
    }

    //You can disable payment types globally here.
    $payment_types = array(
        "PayPal" => true,
        "PayGoL" => true,
        "PMW" => true,
    );

    $payment_type = base64_decode($_GET["pmt"]);
    $script_name = base64_decode($_GET["sn"]);
    $voucher_code = base64_decode($_GET["vc"]);
    $bol_name = base64_decode($_GET["bn"]);
    $ip = $_GET["ip"];
    $mail = $_GET["mail"];
    $has_voucher_code = (bool) preg_match('/([A-Z]|[0-9]){4}-([A-Z]|[0-9]){4}-([A-Z]|[0-9]){4}-([A-Z]|[0-9]){4}/', $voucher_code);

    if(strlen($bol_name) == 0){
        dieandredirect("2");
    }

    if(!in_array($payment_type, $payment_types)){
        dieandredirect("3");
    }

    if(!$payment_types[$payment_type]){
        dieandredirect("4");
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

        //Get UUID for UserName
        $sql_get_uuid = $conn->prepare("SELECT UUID FROM users WHERE User_Name = :u");
        $sql_get_uuid->bindParam(':u',$bol_name);
        $sql_get_uuid->execute();
        $sql_get_uuid_fetched = $sql_get_uuid->fetchAll();
        if(sizeof($sql_get_uuid_fetched) == 0){
            //Create New User
            $sql_insert_new_user = $conn->prepare("INSERT INTO users (UUID, User_Name) VALUES (NULL , :u)");
            $sql_insert_new_user->bindParam(':u',$bol_name);
            $sql_insert_new_user->execute();

            //Get UUID for New User
            $sql_get_uuid = $conn->prepare("SELECT UUID FROM users WHERE User_Name = :u");
            $sql_get_uuid->bindParam(':u',$bol_name);
            $sql_get_uuid->execute();
            $sql_get_uuid_fetched = $sql_get_uuid->fetchAll();
        }
        $uuid = $sql_get_uuid_fetched[0]["UUID"];

        //Get Script Data
        $sql_get_sid = $conn->prepare("SELECT SID, Price FROM scripts WHERE Name = :n");
        $sql_get_sid->bindParam(':n', $script_name);
        $sql_get_sid->execute();
        $sql_get_sid_fetched = $sql_get_sid->fetchAll();
        if(sizeof($sql_get_sid_fetched) == 0){
            dieandredirect("6");
        }
        $sql_get_sid_fetched = $sql_get_sid_fetched[0];
        $script_price = $sql_get_sid_fetched["Price"];
        $script_id = $sql_get_sid_fetched["SID"];

        //Is Authed for SID ?
        $sql_get_auth_data = $conn->prepare("SELECT * FROM auths WHERE UUID = :u AND SID = :s");
        $sql_get_auth_data->bindParam(':u',$uuid);
        $sql_get_auth_data->bindParam(':s',$script_id);
        $sql_get_auth_data->execute();
        $sql_get_auth_data_fetched = $sql_get_auth_data->fetchAll();
        if(sizeof($sql_get_auth_data_fetched) != 0){
            if($sql_get_auth_data_fetched[0]["Expires"] == 0) {
                dieandredirect("5");
            }
            if($sql_get_auth_data_fetched[0]["Banned"] == 1) {
                dieandredirect("14");
            }
        }

        //Reduce price if valid Voucher code
        if($has_voucher_code){
            //Check if Valid and get Data.
            $sql_get_vcode_data = $conn->prepare("SELECT * FROM voucher_codes WHERE CODE = :c");
            $sql_get_vcode_data->bindParam(':c',$voucher_code);
            $sql_get_vcode_data->execute();
            $sql_get_vcode_data_fetched = $sql_get_vcode_data->fetchAll();
            if(sizeof($sql_get_vcode_data_fetched) == 0){
                dieandredirect("7");
            }else{
                $sql_get_vcode_data_fetched = $sql_get_vcode_data_fetched[0];
                //Check if SID Specic and SID Match
                if($sql_get_vcode_data_fetched["SID_Specific"] == 1 && $sql_get_vcode_data_fetched["Valid_for_SID"] != $script_id){
                    dieandredirect("8");
                }
                //Check if uses left
                if($sql_get_vcode_data_fetched["uses_left"] < 1){
                    dieandredirect("9");
                }
                //Check expired
                if($sql_get_vcode_data_fetched["till_time"] < time()){
                    dieandredirect("10");
                }
                //Check UUID Specific and UUID Match
                if($sql_get_vcode_data_fetched["UUID_Specific"] == 1 && $sql_get_vcode_data_fetched["UUID"] != $uuid){
                    dieandredirect("11");
                }
                //Check if locked (prevent users from using the key and waiting on pp, to multiuse singleuse keys.
                if($sql_get_vcode_data_fetched["LOCKED"] >= $sql_get_vcode_data_fetched["uses_left"]){
                    dieandredirect("12");
                }

                //Lock Code until Payment done or aborted
                $sql_increase_lock = $conn->prepare("UPDATE voucher_codes SET LOCKED = LOCKED+1 WHERE VIC = :v");
                $sql_increase_lock->bindParam(':v', $sql_get_vcode_data_fetched["VIC"]);
                $sql_increase_lock->execute();

                //Nice, we got a valid code :)
                if($sql_get_vcode_data_fetched["Reduction_Type"] == 1){
                    $script_price -= $sql_get_vcode_data_fetched["AMOUNT"];
                    if($script_price <= 0){
                        dieandredirect("13");
                    }
                }else{
                    $script_price = round($script_price*((100-$sql_get_vcode_data_fetched["AMOUNT"])/100),2);
                }
/*
                echo "Payment Provider: ".$payment_type."<br>";
                echo "Script Name: ".$script_name."<br>";
                echo "Script Price: ".$script_price."<br>";
                echo "Script ID: ".$script_id."<br>";
                echo "Voucher Code: ".$voucher_code."<br>";
                echo "BoL Name: ".$bol_name."<br>";
                echo "UUID: ".$uuid."<br>";
                echo "Has Voucher Code: ".$has_voucher_code."<br><br>";

                print_r($sql_get_vcode_data_fetched);*/
            }
        }

        $cdata = array($payment_type,$script_name,$script_price,$script_id,$voucher_code,$bol_name,$uuid,$has_voucher_code,$mail,$ip);
        $cdata = json_encode($cdata);
        $cdata = base64_encode($cdata);

        switch ($payment_type){
            case "PayPal":
                break;
            case "PayGoL":
                $loc = 'Location: https://www.paygol.com/pay?pg_serviceid=355163&pg_currency=EUR&pg_name=SAuth&pg_custom="'.$cdata.'"&pg_price='.$script_price.'&pg_return_url=http://sauth.s1mplescripts.de/shop?p=true$pg_cancel_url=http://sauth.s1mplescripts.de/shop?p=false';
                header($loc);
                break;
            case "PMW":
                break;
            default:
                print_r($payment_type);
        }
    
        $conn = null;
    }catch (PDOException $ex){
        LogPDOException($ex);
    }
?>