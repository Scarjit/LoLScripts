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

    <style>
        .ajax_loading {
            -webkit-animation-name: spinning;
            -webkit-animation-duration: 1s;
            -webkit-animation-iteration-count: infinite;
            animation-name: spinning;
            animation-duration: 1s;
            animation-iteration-count: infinite;
        }

        /* Standard syntax */
        @keyframes spinning {
            0% {
                transform: rotate(0.0deg);
            }
            1% {
                transform: rotate(3.6deg);
            }
            2% {
                transform: rotate(7.2deg);
            }
            3% {
                transform: rotate(10.8deg);
            }
            4% {
                transform: rotate(14.4deg);
            }
            5% {
                transform: rotate(18.0deg);
            }
            6% {
                transform: rotate(21.6deg);
            }
            7% {
                transform: rotate(25.2deg);
            }
            8% {
                transform: rotate(28.8deg);
            }
            9% {
                transform: rotate(32.4deg);
            }
            10% {
                transform: rotate(36.0deg);
            }
            11% {
                transform: rotate(39.6deg);
            }
            12% {
                transform: rotate(43.2deg);
            }
            13% {
                transform: rotate(46.8deg);
            }
            14% {
                transform: rotate(50.4deg);
            }
            15% {
                transform: rotate(54.0deg);
            }
            16% {
                transform: rotate(57.6deg);
            }
            17% {
                transform: rotate(61.2deg);
            }
            18% {
                transform: rotate(64.8deg);
            }
            19% {
                transform: rotate(68.4deg);
            }
            20% {
                transform: rotate(72.0deg);
            }
            21% {
                transform: rotate(75.6deg);
            }
            22% {
                transform: rotate(79.2deg);
            }
            23% {
                transform: rotate(82.8deg);
            }
            24% {
                transform: rotate(86.4deg);
            }
            25% {
                transform: rotate(90.0deg);
            }
            26% {
                transform: rotate(93.6deg);
            }
            27% {
                transform: rotate(97.2deg);
            }
            28% {
                transform: rotate(100.8deg);
            }
            29% {
                transform: rotate(104.4deg);
            }
            30% {
                transform: rotate(108.0deg);
            }
            31% {
                transform: rotate(111.6deg);
            }
            32% {
                transform: rotate(115.2deg);
            }
            33% {
                transform: rotate(118.8deg);
            }
            34% {
                transform: rotate(122.4deg);
            }
            35% {
                transform: rotate(126.0deg);
            }
            36% {
                transform: rotate(129.6deg);
            }
            37% {
                transform: rotate(133.2deg);
            }
            38% {
                transform: rotate(136.8deg);
            }
            39% {
                transform: rotate(140.4deg);
            }
            40% {
                transform: rotate(144.0deg);
            }
            41% {
                transform: rotate(147.6deg);
            }
            42% {
                transform: rotate(151.2deg);
            }
            43% {
                transform: rotate(154.8deg);
            }
            44% {
                transform: rotate(158.4deg);
            }
            45% {
                transform: rotate(162.0deg);
            }
            46% {
                transform: rotate(165.6deg);
            }
            47% {
                transform: rotate(169.2deg);
            }
            48% {
                transform: rotate(172.8deg);
            }
            49% {
                transform: rotate(176.4deg);
            }
            50% {
                transform: rotate(180.0deg);
            }
            51% {
                transform: rotate(183.6deg);
            }
            52% {
                transform: rotate(187.2deg);
            }
            53% {
                transform: rotate(190.8deg);
            }
            54% {
                transform: rotate(194.4deg);
            }
            55% {
                transform: rotate(198.0deg);
            }
            56% {
                transform: rotate(201.6deg);
            }
            57% {
                transform: rotate(205.2deg);
            }
            58% {
                transform: rotate(208.8deg);
            }
            59% {
                transform: rotate(212.4deg);
            }
            60% {
                transform: rotate(216.0deg);
            }
            61% {
                transform: rotate(219.6deg);
            }
            62% {
                transform: rotate(223.2deg);
            }
            63% {
                transform: rotate(226.8deg);
            }
            64% {
                transform: rotate(230.4deg);
            }
            65% {
                transform: rotate(234.0deg);
            }
            66% {
                transform: rotate(237.6deg);
            }
            67% {
                transform: rotate(241.2deg);
            }
            68% {
                transform: rotate(244.8deg);
            }
            69% {
                transform: rotate(248.4deg);
            }
            70% {
                transform: rotate(252.0deg);
            }
            71% {
                transform: rotate(255.6deg);
            }
            72% {
                transform: rotate(259.2deg);
            }
            73% {
                transform: rotate(262.8deg);
            }
            74% {
                transform: rotate(266.4deg);
            }
            75% {
                transform: rotate(270.0deg);
            }
            76% {
                transform: rotate(273.6deg);
            }
            77% {
                transform: rotate(277.2deg);
            }
            78% {
                transform: rotate(280.8deg);
            }
            79% {
                transform: rotate(284.4deg);
            }
            80% {
                transform: rotate(288.0deg);
            }
            81% {
                transform: rotate(291.6deg);
            }
            82% {
                transform: rotate(295.2deg);
            }
            83% {
                transform: rotate(298.8deg);
            }
            84% {
                transform: rotate(302.4deg);
            }
            85% {
                transform: rotate(306.0deg);
            }
            86% {
                transform: rotate(309.6deg);
            }
            87% {
                transform: rotate(313.2deg);
            }
            88% {
                transform: rotate(316.8deg);
            }
            89% {
                transform: rotate(320.4deg);
            }
            90% {
                transform: rotate(324.0deg);
            }
            91% {
                transform: rotate(327.6deg);
            }
            92% {
                transform: rotate(331.2deg);
            }
            93% {
                transform: rotate(334.8deg);
            }
            94% {
                transform: rotate(338.4deg);
            }
            95% {
                transform: rotate(342.0deg);
            }
            96% {
                transform: rotate(345.6deg);
            }
            97% {
                transform: rotate(349.2deg);
            }
            98% {
                transform: rotate(352.8deg);
            }
            99% {
                transform: rotate(356.4deg);
            }
            100% {
                transform: rotate(360.0deg);
            }
        }
    </style>
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
                        <h1 class="page-header">User Admin Panel</h1>
                    </div>
                    <div class="col-lg-12">
                        <form role="form">
                            <div class="form-group input-group has-warning" id="search_form">
                                <input id="user_search_input" onkeyup="do_search();" type="text" class="form-control" placeholder="S1mple">
                                <span class="input-group-btn">
                                    <button class="btn btn-default" type="button">
                                        <i class="fa fa-search"></i>
                                    </button>
                                </span>
                            </div>
                        </form>
                        <table class="table table-striped">
                            <thead>
                            <tr>
                                <th>User Name</th>
                                <th>Reset Trial</th>
                                <th>Ban User</th>
                                <th>Get User Info</th>
                            </tr>
                            </thead>
                            <tbody id="search_tbody">
                            <tr>
                                <td>No User</td>
                            </tr>
                            </tbody>
                        </table>
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
    <script>
        function do_search() {
            var user = document.getElementById('user_search_input').value;
            var xhttp = new XMLHttpRequest();
            xhttp.onreadystatechange = function() {
                if (xhttp.readyState == 4 && xhttp.status == 200) {
                    var resp = xhttp.responseText;
                    var tbody = document.getElementById('search_tbody');
                    var new_tbody = document.createElement('tbody');
                    new_tbody.id = 'search_tbody';
                    var lines = resp.split('\r\n');
                    for (var i = 0; i < lines.length; i++) {
                        var line = lines[i];
                        if (line.length > 0) {
                            var new_tr = document.createElement('tr');

                            var new_td_uname = document.createElement('td');
                            new_td_uname.innerHTML = line;
                            new_tr.appendChild(new_td_uname);

                            if(line.indexOf("No user") == -1) {
                                var new_td_reset_trial = document.createElement('td');
                                new_td_reset_trial.innerHTML = "<a onclick='do_reset_trial(\"" + line + "\")'><i id='"+line+"_trial_reset_icon' class='fa fa-times'></i><div style='all:unset;' id='"+line+"_trial_reset_div'> Reset all trials</div></a>";
                                new_tr.appendChild(new_td_reset_trial);

                                var new_td_ban_user = document.createElement('td');
                                new_td_ban_user.innerHTML = "<a onclick='do_ban(\"" + line + "\")'><i id='"+line+"_ban_icon' class='fa fa-flag'></i><div style='all:unset;' id='"+line+"_ban_div'> Ban User</div></a>";
                                new_tr.appendChild(new_td_ban_user);
                            }

                            new_tbody.appendChild(new_tr);
                        }
                    }
                    tbody.parentNode.replaceChild(new_tbody, tbody);

                    if(resp == "No user"){
                        document.getElementById('search_form').className = "form-group input-group has-error";
                    }else if(lines.length == 1){
                        document.getElementById('search_form').className = "form-group input-group has-success";
                    }else{
                        document.getElementById('search_form').className = "form-group input-group has-warning";
                    }
                }
            };
            xhttp.open("GET", "ajax/do_searchUser.php?user="+user, true);
            xhttp.send();
        }

        function do_reset_trial(arg) {
            var xhttp = new XMLHttpRequest();
            xhttp.onreadystatechange = function() {
                var icon = document.getElementById(arg+'_trial_reset_icon');
                var txt = document.getElementById(arg+'_trial_reset_div');
                txt.innerHTML = "";
                if (xhttp.readyState == 4 && xhttp.status == 200) {
                    icon.className = "fa fa-check";
                }else{
                    icon.className = "fa fa-spinner ajax_loading";
                }
            };
            xhttp.open("GET", "ajax/do_resetalltrials.php?user="+arg, true);
            xhttp.send();
        }

        function do_ban(arg) {
            var xhttp = new XMLHttpRequest();
            xhttp.onreadystatechange = function() {
                var icon = document.getElementById(arg+'_ban_icon');
                var txt = document.getElementById(arg+'_ban_div');
                txt.innerHTML = "";
                if (xhttp.readyState == 4 && xhttp.status == 200) {
                    var resp = xhttp.responseText;
                    icon.className = "fa fa-lock";
                    alert(resp);
                }else{
                    icon.className = "fa fa-spinner ajax_loading";
                }
            };
            xhttp.open("GET", "ajax/do_ban.php?user="+arg, true);
            xhttp.send();
        }
    </script>
</body>
</html>
