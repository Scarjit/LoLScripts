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

<body class="<?php
if(isset($_GET["code"])){
    echo "modal-open";
}
?>">


<nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
    <div class="container">

        <div class="navbar-header">
            <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
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
                    <a href="index.php">Shop</a>
                </li>
            </ul>
        </div>
    </div>
</nav>


<div class="container">
    <div class="row">
        <form role="form" action="do_redeem.php" method="post">
            <div class="form-group">
                <label for="uname">User Name:</label>
                <input name="uname" type="text" class="form-control" id="uname" placeholder="S1mple">
            </div>
            <div class="form-group">
                <label for="mail">E-Mail Address:</label>
                <input name="mail" type="email" class="form-control" id="mail" placeholder="contact@s1mplescripts.de">
            </div>
            <div class="form-group">
                <label for="pwd">Code:</label>
                <input name="code" type="text" class="form-control" id="code" placeholder="XXXX-XXXX-XXXX-XXXX">
            </div>
            <button type="submit" class="btn btn-default">Submit</button>
        </form>
    </div>

    <div id="redeemModal" class="modal fade <?php
    if(isset($_GET["code"])){
            echo "in";
        }
    ?>" role="dialog" style="display: <?php
        if(isset($_GET["code"])){
            echo "block;";
        }else{
            echo "none;";
        }
    ?>">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" onclick="document.getElementById('redeemModal').style.display = ''; document.getElementById('divbg').style.display = 'none';">&times;</button>
                    <h4 class="modal-title">
                        <?php
                            if(isset($_GET["code"]) && is_numeric($_GET["code"])) {
                                if($_GET["code"] != 0) {
                                    echo "Error Code: " . $_GET["code"];
                                }else{
                                    echo "Success";
                                }
                            }
                        ?>
                    </h4>
                </div>
                <div class="modal-body">
                    <p>
                        <?php
                        if(isset($_GET["code"]) && is_numeric($_GET["code"])) {
                            switch ($_GET["code"]) {
                                case "1":
                                    echo "Invalid POST request";
                                    break;
                                case "2":
                                    echo "Invalid Code (Format is: XXXX-XXXX-XXXX-XXXX)";
                                    break;
                                case "3":
                                    echo "Invalid Code (Code not found)";
                                    break;
                                case "4":
                                    echo "No uses left for this code";
                                    break;
                                case "5":
                                    echo "You are already authed for this Script";
                                    break;
                                case "6":
                                    echo "Script ID is wrong, please contact me to fix this error (<a href='mailto:sauth@s1mplescripts.de'>sauth@s1mplescripts.de</a>)<br>and provide the following:<br>Entered Code, Your BoL Name, Where you got the Code from";
                                    break;
                                case "0":
                                    echo "You are now verified for that Script.";
                                    break;
                                case "-1":
                                    echo "Something went wrong, please contact me to fix this error (<a href='mailto:sauth@s1mplescripts.de'>sauth@s1mplescripts.de</a>)<br>and provide the following:<br>Entered Code, Your BoL Name, Where you got the Code from";
                                    break;
                                default:
                                    echo "There is no error Message for this Code";
                                    break;
                            }
                        }
                        ?>
                    </p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal" onclick="document.getElementById('redeemModal').style.display = ''; document.getElementById('divbg').style.display = 'none';">Close</button>
                </div>
            </div>
        </div>
    </div>

    <?php
    if(isset($_GET["code"])){
        echo "<div id='divbg' class=\"modal-backdrop fade in\"></div>";
    }
    ?>
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