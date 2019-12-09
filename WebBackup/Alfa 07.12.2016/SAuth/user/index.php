<?php

function LogPDOException(PDOException $ex)
{
    if ($ex) {
        file_put_contents("../pdoexceptions.log", date("d.m.y H:i:s", time()) . " user/index.php: " . $ex->getMessage() . "\r\n", FILE_APPEND);
    }
}

$uname = "";
if(!isset($_POST) || !isset($_POST["inputName"])){
    if(isset($_COOKIE["uname"])){
        $uname = $_COOKIE["uname"];
    }else {
        header('Location: login.php?code=1');
        die("1");
    }
}else{
    setcookie('uname',$_POST["inputName"],time()+36000);
    $uname = $_POST["inputName"];
}

?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="S1mple">
    <title>Shop</title>
    <link href="../.html_files/css/bootstrap.min.css" rel="stylesheet">
    <link href="../.html_files/css/shop_index.css" rel="stylesheet">
</head>

<body>


<nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
    <div class="container">

        <div class="navbar-header">
            <button type="button" class="navbar-toggle" data-toggle="collapse"
                    data-target="#bs-example-navbar-collapse-1">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="../shop/index.php">S1mple Shop</a>
        </div>

        <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
            <ul class="nav navbar-nav">
                <li>
                    <a href="../shop/index.php">Shop</a>
                </li>
                <li>
                    <a href="../shop/redeem.php">Redeem Code</a>
                </li>
                <li>
                    <a onclick="document.cookie = 'uname=;expires=Thu, 01 Jan 1970 00:00:00 UTC';" href="index.php">Log Out</a>
                </li>
            </ul>
        </div>
    </div>
</nav>


<div class="container">
    <div class="row">
        <?php

        try {

            $servername = "localhost";
            $username = "web27628762";
            $password = "9x7wKi4W";
            $conn = new PDO("mysql:host=$servername;dbname=usr_web27628762_4", $username, $password);
            $conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
            unset($servername);
            unset($username);
            unset($password);

            //Get uuid from User Name
            $get_uuid_of_name = $conn->prepare("SELECT UUID FROM users WHERE User_Name = :u");
            $get_uuid_of_name->bindParam(':u', $uname);
            $get_uuid_of_name->execute();
            $get_uuid_of_name_fetched = $get_uuid_of_name->fetchAll();

            if(sizeof($get_uuid_of_name_fetched) == 0){
                header('Location: login.php?code=2');
                die("2");
            }
            $uuid = $get_uuid_of_name_fetched[0]["UUID"];

            //Get all SID's & trial data from UUID
            $get_sidlist_from_UUID = $conn->prepare("SELECT SID, Expires, ExpireDate, Banned, Ban_Reason FROM auths WHERE UUID = :u");
            $get_sidlist_from_UUID->bindParam(':u', $uuid);
            $get_sidlist_from_UUID->execute();
            $get_sidlist_from_UUID_fetched = $get_sidlist_from_UUID->fetchAll();
            $i = 0;
            foreach ($get_sidlist_from_UUID_fetched as $k => $v) {
                //Get Script Data for ID
                $get_sdata_from_id = $conn->prepare("SELECT Name, HTML_Description, HTML_Image_Link FROM scripts WHERE SID = :s");
                $get_sdata_from_id->bindParam(':s', $v["SID"]);
                $get_sdata_from_id->execute();
                $get_sdata_from_id_fetched = $get_sdata_from_id->fetchAll()[0];
                if ($i == 3) {
                    $i = 0;
                }

                if ($k % 3 == 0) {
                    echo "<div class=\"row\">";
                }
                echo "<div class=\"col-sm-4 col-lg-4 col-md-4\">";
                echo "<div class=\"thumbnail\">";
                if(filter_var($get_sdata_from_id_fetched["HTML_Image_Link"], FILTER_VALIDATE_URL)) {
                    echo "<img src=\"" . $get_sdata_from_id_fetched["HTML_Image_Link"] . "\" alt=\"\">";
                }else{
                    echo "<img src=\"../shop" . substr($get_sdata_from_id_fetched["HTML_Image_Link"],1) . "\" alt=\"\">";
                }
                echo "<div class=\"caption\">";
                echo "<h4>" . $get_sdata_from_id_fetched["Name"] . "</h4>";
                echo "<p>" . $get_sdata_from_id_fetched["HTML_Description"] . "</p>";

                if($v["Banned"]){
                    echo "<button type=\"button\" class=\"btn btn-danger\" onclick='alert(\"".$v["Ban_Reason"]."\")'>You have been banned</button>";
                }elseif($v["Expires"] == 0) {
                    echo "<button type=\"button\" class=\"btn btn-success\">Authed</button>";
                }else{
                    if(time() < $v["ExpireDate"]){
                        echo "<button type=\"button\" class=\"btn btn-info\">Trial till: ".date("d.m.y H:i:s",$v["ExpireDate"])."</button>";
                    }else{
                        echo "<button type=\"button\" class=\"btn btn-danger\">Trial Time over</button>";
                    }
                }
                echo "</div>";
                echo "</div>";
                echo "</div>";
                if ($i == 2) {
                    echo "</div>";
                }

                $i++;
            }

            $conn = null;
        } catch (PDOException $ex) {
            LogPDOException($ex);
        }
        ?>
    </div>
</div>

<div class="container">
    <hr>
    <footer>
        <div class="row">
            <div class="col-lg-12">
                <p>Copyright &copy; S1mpleScripts 2016</p>
            </div>
        </div>
    </footer>
</div>


<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>

</body>
</html>