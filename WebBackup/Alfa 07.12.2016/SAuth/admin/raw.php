<?php

function LogPDOException(PDOException $ex)
{
    if ($ex) {
        file_put_contents("../pdoexceptions.log", date("d.m.y H:i:s", time()) . " user/index.php: " . $ex->getMessage() . "\r\n", FILE_APPEND);
}
}

$pw = "";
if(!isset($_POST) || !isset($_POST["inputPW"])){
if(isset($_COOKIE["pw"])){
$pw = $_COOKIE["pw"];
}else {
header('Location: login.php?code=1');
die("1");
}
}else{
setcookie('pw',$_POST["inputPW"],time()+36000);
$pw = $_POST["inputPW"];
}

if(sha1($pw) != "fb17f13ad7e83059d4ae74965ca2c2ff19fad994"){
header('Location: login.php?code=2');
die("2");
}

?>
<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>SAuth ACP</title>

    <!-- Bootstrap Core CSS -->
    <link href="../.html_files/css/bootstrap.min.css" rel="stylesheet">

    <!-- MetisMenu CSS -->
    <link href="../.html_files/css/metisMenu.min.css" rel="stylesheet">

    <!-- Custom CSS -->
    <link href="../.html_files/css/sb-admin-2.css" rel="stylesheet">

    <!-- Custom Fonts -->
    <link href="../.html_files/css/font-awesome.min.css" rel="stylesheet" type="text/css">
</head>

<body>
    <div id="wrapper">

        <!-- Navigation -->
        <nav class="navbar navbar-default navbar-static-top" role="navigation" style="margin-bottom: 0">
            <div class="navbar-header">
                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <a class="navbar-brand" href="#">SAuth Admin Control Panel</a>
            </div>
            <!-- /.navbar-header -->

            <ul class="nav navbar-top-links navbar-right">
                <li><a onclick="document.cookie = 'pw=;expires=Thu, 01 Jan 1970 00:00:00 UTC';" href="login.php">
                    <i class="fa fa-sign-out fa-fw"></i>
                    </a>
                </li>
            </ul>
            <!-- /.navbar-top-links -->

            <div class="navbar-default sidebar" role="navigation">
                <div class="sidebar-nav navbar-collapse">
                    <ul class="nav" id="side-menu">
                        <li>
                            <a href="index.php"><i class="fa fa-dashboard fa-fw"></i> Dashboard</a>
                        </li>
                        <li>
                            <a href="scripts.php"><i class="fa fa-file-code-o fa-fw"></i> Scripts</a>
                        </li>
                        <li>
                            <a href="users.php"><i class="fa fa-users fa-fw"></i> Users</a>
                        </li>
                        <li>
                            <a href="shop.php"><i class="fa fa-shopping-cart fa-fw"></i> Shop</a>
                        </li>
                        <li>
                            <a href="raw.php"><i class="fa fa-database fa-fw"></i> Raw Data</a>
                        </li>
                    </ul>
                </div>
                <!-- /.sidebar-collapse -->
            </div>
            <!-- /.navbar-static-side -->
        </nav>

        <!-- Page Content -->
        <div id="page-wrapper">
            <div class="container-fluid">
                <div class="row">
                    <div class="col-lg-12">
                        <h1 class="page-header">Soon (tm)</h1>
                    </div>
                </div>
            </div>
        </div>
        <!-- /#page-wrapper -->

    </div>
    <!-- /#wrapper -->


    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
    <script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>

    <!-- Metis Menu Plugin JavaScript -->
    <script src="../.html_files/js/metisMenu.min.js"></script>

    <!-- Custom Theme JavaScript -->
    <script src="../.html_files/js/sb-admin-2.js"></script>

</body>
</html>
