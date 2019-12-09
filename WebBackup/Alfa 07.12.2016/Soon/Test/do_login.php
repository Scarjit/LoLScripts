<?php


    if(!isset($_POST) || !isset($_POST["uname"]) || !isset($_POST["Password"]) || !isset($_POST["tos"]) || (isset($_POST["tos"]) && isset($_POST["tos"]) != "on")){
        header('Location: index.php?error=1');
        die("Error Code 1");
    }

    //Check if legit
    if(strlen($_POST["uname"]) < 3 or strlen($_POST["uname"]) > 255){
        header('Location: index.php?error=2');
        die("Invalid Username (Error Code 2)");
    }
    if(strlen($_POST["Password"]) < 6){
        header('Location: index.php?error=3');
        die("Invalid Password lenght (Error Code 3)");
    }


    //DB Login
    $servername = "localhost";
    $username = "web27628762";
    $password = "9x7wKi4W";
    $dbname = "usr_web27628762_3";
    if(isset($_POST["register"])){
        try{
            //Open connection to DB
            $conn = new PDO("mysql:host=$servername;dbname=$dbname", $username, $password);
            $conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
            $conn->setAttribute(PDO::ATTR_EMULATE_PREPARES, false);

            //Unset Login var's
            unset($servername);
            unset($username);
            unset($password);
            unset($dbname);

            //Check if user name is already registered
            $sql_user_is_already_registered = $conn->prepare("SELECT UUID FROM users WHERE user_name = :uname");
            $sql_user_is_already_registered->bindParam(':uname', $_POST["uname"]);
            $sql_user_is_already_registered->execute();
            $sql_user_is_already_registered->setFetchMode(PDO::FETCH_ASSOC);
            if(sizeof($sql_user_is_already_registered->fetchAll()) != 0){
                header('Location: index.php?error=4');
                die("User already registered (Error Code 4)");
            }
            unset($sql_user_is_already_registered);

            //Check if IP is already registered
            $sql_ip_is_already_registered = $conn->prepare("SELECT registration_ip FROM users WHERE registration_ip = :ip");
            $sql_ip_is_already_registered->bindParam(':ip', $_SERVER['REMOTE_ADDR']);
            $sql_ip_is_already_registered->execute();
            $sql_ip_is_already_registered->setFetchMode(PDO::FETCH_ASSOC);
            if(sizeof($sql_ip_is_already_registered->fetchAll()) != 0){
                header('Location: index.php?error=4');
                die("User already registered (Error Code 4)");
            }
            unset($sql_ip_is_already_registered);

            //Add new user to Database :)
            $sql_add_new_user = $conn->prepare("INSERT INTO users (UUID, user_name, password_hash, last_retrival, registration_ip, registration_time, user_level) VALUES (NULL, :uname, :pwhash, :t, :ip, :cdate, -1)");
            $b64uname = base64_encode($_POST["uname"]);
            $pwhash = password_hash($_POST["Password"] , PASSWORD_DEFAULT);
            $sql_add_new_user->bindParam(':uname', $b64uname);
            $sql_add_new_user->bindParam(':pwhash', $pwhash);
            $cdate = date("d.m.Y H:i:s");
            $sql_add_new_user->bindParam(':cdate', $cdate);
            $ip = $_SERVER['REMOTE_ADDR'];
            $sql_add_new_user->bindParam(':ip', $ip);
            $time = time()-172800;
            $sql_add_new_user->bindParam(':t', $time); //Substract 48 Hours
            $sql_add_new_user->execute();
            unset($sql_add_new_user);

            //echo "Inserted new User in DB";

            //Close DB Connection
            $conn = null;

            //Forward to thankyou_for_register.php
            header('Location: index.php?error=-2');
            die("New user registered (Error Code -2)");

        }catch (PDOException $ex){
            header('Location: index.php?error=-1');
            die($ex->getMessage());
        }
    }else if(isset($_POST["submit"])){
        try {
            //Open connection to DB
            $conn = new PDO("mysql:host=$servername;dbname=$dbname", $username, $password);
            $conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

            //Unset Login var's
            unset($servername);
            unset($username);
            unset($password);
            unset($dbname);

            //Get User
            $sql_get_user = $conn->prepare("SELECT * FROM users WHERE user_name = :uname");
            $b64uname = base64_encode($_POST["uname"]);
            $sql_get_user->bindParam(':uname', $b64uname);
            $sql_get_user->setFetchMode(PDO::FETCH_ASSOC);
            $sql_get_user->execute();
            $user_array = $sql_get_user->fetchAll();
            unset($sql_get_user);
            if(sizeof($user_array) == 0){
                header('Location: index.php?error=5');
                die("User not found (Error Code 5)");
            }

            if($user_array[0]["user_level"] == -2){
                header('Location: index.php?error=6');
                die("You have been banned (Error Code 6)");
            }

            if($user_array[0]["user_level"] == -1){
                header('Location: index.php?error=12');
                die("You are not yet unlocked (Error Code 12)");
            }

            //Bruteforce protection
            if($user_array[0]["last_login_attempt"] <= time()+$user_array[0]["login_attempts"]*150 && $user_array[0]["login_attempts"] > 3){
                //echo "You have to wait: ".date("H : i : s",$user_array[0]["last_login_attempt"]-(time()-$user_array[0]["login_attempts"]*300)). " before trying to login again<br>";
                header('Location: index.php?error=7&wait='.date("H : i : s",$user_array[0]["last_login_attempt"]-(time()-$user_array[0]["login_attempts"]*300)));
                die("Please wait until you will be able to login again (Error Code 7)");
            }

            if(!password_verify($_POST["Password"], $user_array[0]["password_hash"])){
                $sql_increase_login_attempts = $conn->prepare("UPDATE users SET last_login_attempt = :time, login_attempts = login_attempts+1 WHERE user_name = :uname");
                $tx = time();
                $sql_increase_login_attempts->bindParam(':time', $tx);
                $b64uname = base64_encode($_POST["uname"]);
                $sql_increase_login_attempts->bindParam(':uname', $b64uname);
                $sql_increase_login_attempts->execute();
                unset($sql_increase_login_attempts);
                header('Location: index.php?error=8');
                die("Password incorrect (Error Code 8)");
            }

            //Reset last login attempt and set last_login_ip
            $sql_reset_login_attempts = $conn->prepare("UPDATE users SET last_login_ip = :ip, last_login_attempt = 0, login_attempts = 0 WHERE user_name = :uname");
            $b64uname = base64_encode($_POST["uname"]);
            $sql_reset_login_attempts->bindParam(':uname', $b64uname);
            $ip = $_SERVER['REMOTE_ADDR'];
            $sql_reset_login_attempts->bindParam(':ip', $ip);
            $sql_reset_login_attempts->execute();
            unset($sql_reset_login_attempts);


            //Create Login Token.
            $length = mt_rand(30,80);
            $randomString = md5(substr(str_shuffle("0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"), 0, $length));

            $sql_set_session_token = $conn->prepare("UPDATE users SET session_token = :token WHERE user_name = :uname");
            $sql_set_session_token->bindParam(':token', $randomString);
            $b64uname = base64_encode($_POST["uname"]);
            $sql_set_session_token->bindParam(':uname', $b64uname);
            $sql_set_session_token->execute();
            unset($sql_set_session_token);

            setcookie("Session_Token", $randomString,time()+3600);
            setcookie("User_Name", base64_encode($_POST["uname"]), time()+3600);
            unset($randomString);
            $conn = null;
            header('Location: dashboard.php');
            die("success");

        }catch (PDOException $ex){
            unset($servername);
            unset($username);
            unset($password);
            unset($dbname);
            $conn = null;
            header('Location: index.php?error=-1');
            die($ex->getMessage());
        }
    }else{

        //Unset Login var's
        unset($servername);
        unset($username);
        unset($password);
        unset($dbname);
        $conn = null;
        header('Location: index.php?error=9');
        die("Invalid Post (Error Code 9)");
    }
?>