<?php
function LogPDOException(PDOException $ex)
{
    if ($ex) {
        file_put_contents("../pdoexceptions.log", date("d.m.y H:i:s", time()) . " shop/index.php: " . $ex->getMessage() . "\r\n", FILE_APPEND);
    }
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
                    <a href="../user/index.php">User Login</a>
                </li>
                <li>
                    <a href="redeem.php">Redeem Code</a>
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

            $sql_get_scripts = $conn->prepare("SELECT Name, Price, HTML_Description, HTML_Image_Link FROM scripts");
            $sql_get_scripts->execute();
            $sql_get_scripts_fetched = $sql_get_scripts->fetchAll();
            $i = 0;
            foreach ($sql_get_scripts_fetched as $k => $v) {
                if ($i == 3) {
                    $i = 0;
                }
                if ($k % 3 == 0) {
                    echo "<div class=\"row\">";
                }
                echo "<div class=\"col-sm-4 col-lg-4 col-md-4\">";
                echo "<div class=\"thumbnail\">";
                echo "<img src=\"" . $v["HTML_Image_Link"] . "\" alt=\"\">";
                echo "<div class=\"caption\">";
                echo "<h4 class=\"pull-right\">" . $v["Price"] . " €</h4>";
                echo "<h4>" . $v["Name"] . "</h4>";
                echo "<p>" . $v["HTML_Description"] . "</p>";
                echo "<button type=\"button\" data-toggle='modal' data-target='#".md5($v["Name"])."' class=\"btn btn-success\">Buy now</button>";
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

<!-- Some nice modals here -->
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

    $sql_get_scripts = $conn->prepare("SELECT Name, Price, HTML_Description, HTML_Image_Link FROM scripts");
    $sql_get_scripts->execute();
    $sql_get_scripts_fetched = $sql_get_scripts->fetchAll();

    foreach ($sql_get_scripts_fetched as $k=>$v) {
        echo "<div id=\"".md5($v["Name"])."\" class=\"modal fade\" role=\"dialog\">";
        echo "<div class=\"modal-dialog\">";
        echo "<div class=\"modal-content\">";
        echo "<div class=\"modal-header\">";
        echo "<button type=\"button\" class=\"close\" data-dismiss=\"modal\">&times;</button>";
        echo "<h4 class=\"modal-title pull-right\">" . $v["Price"] . " €  </h4>";
        echo "<h4 class=\"modal-title\">".$v["Name"]."</h4>";
        echo "</div>";
        echo "<div class=\"modal-body\">";
        echo "<p>".$v["HTML_Description"]."</p>";
        echo "<hr>";
        echo "<p><form class='form'><div class='form-group'><label for='bolname'>BoL Name (Required):</label><input type='text' class='form-control' id='bolname".md5($v["Name"])."' placeholder='S1mple'></div></form></p>";
        echo "<p><form class='form'><div class='form-group'><label for='mail'>E-Mail (Required):</label><input type='email' class='form-control' id='mail".md5($v["Name"])."' placeholder='sauth@s1mplescripts.de'></div></form></p>";
        echo "<p><form class='form'><div class='form-group'><label for='vcode'>Voucher Code (Optional):</label><input type='text' class='form-control' id='vcode".md5($v["Name"])."' placeholder='XXXX-XXXX-XXXX-XXXX'></div></form></p>";
        echo "</div>";
        echo "<div class=\"modal-footer\">";
        echo "<button type=\"button\" class=\"btn btn-info\" onclick='do_payment(\"".md5($v["Name"])."\",\"PayPal\",\"".$v["Name"]."\");'>Paypal</button>";
        echo "<button type=\"button\" class=\"btn btn-info\" onclick='do_payment(\"".md5($v["Name"])."\",\"PayGoL\",\"".$v["Name"]."\");'>PayGoL</button>";
        echo "<button type=\"button\" class=\"btn btn-info\" onclick='do_payment(\"".md5($v["Name"])."\",\"PMW\",\"".$v["Name"]."\");'>Payment Wall</button>";
        echo "<button type=\"button\" class=\"btn btn-default\" data-dismiss=\"modal\">Close</button>";
        echo "</div></div></div></div>";
    }
        $conn = null;
    } catch (PDOException $ex) {
        LogPDOException($ex);
    }
?>

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
<script>
    function do_payment(mid,paymenttype,scriptname) {
        var vcode = document.getElementById('vcode'+mid).value;
        var uname = document.getElementById('bolname'+mid).value;
        var mail = document.getElementById('mail'+mid).value;
        if(uname.length == 0 ){
            alert("You have to enter your BoL Name");
        }else {
            window.location = "do_pay.php?pmt=" + btoa(paymenttype) + "&sn=" + btoa(scriptname) + "&vc=" + btoa(vcode) + "&bn=" + btoa(uname)+"&mail="+btoa(mail)+"&ip="+<?php echo "\"".base64_encode($_SERVER['REMOTE_ADDR'])."\"";?>;
        }
    }
</script>
</body>
</html>