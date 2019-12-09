<?php
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

    $Cookie_user = $_COOKIE["User_Name"];
    
    //Set session token in DB to null
    $sql_delete_session_token = $conn->prepare("UPDATE users SET session_token = NULL WHERE user_name = :uname");
    $sql_delete_session_token->bindParam(':uname', $Cookie_user);
    $sql_delete_session_token->execute();
    unset($sql_delete_session_token);

    setcookie("User_Name", "", 0);
    setcookie("Session_Token", "", 0);
    $conn = null;
    header('Location: index.php');
    die("Logout");

}catch(PDOException $ex){
    header('Location: index.php?error=-1');
    die($ex->getMessage());
}
?>