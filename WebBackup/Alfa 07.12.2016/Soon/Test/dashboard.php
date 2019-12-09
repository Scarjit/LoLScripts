<?php
    function secondsToTime($seconds)
    {
        // extract hours
        $hours = floor($seconds / (60 * 60));

        // extract minutes
        $divisor_for_minutes = $seconds % (60 * 60);
        $minutes = floor($divisor_for_minutes / 60);

        // extract the remaining seconds
        $divisor_for_seconds = $divisor_for_minutes % 60;
        $seconds = ceil($divisor_for_seconds);

        // return the final array
        $obj = array(
            "h" => (int) $hours,
            "m" => (int) $minutes,
            "s" => (int) $seconds,
        );
        return $obj;
    }

    if(!isset($_COOKIE) || !isset($_COOKIE["User_Name"]) || !isset($_COOKIE["Session_Token"])){
        header('Location: index.php?error=10');
        die("Error Code 10");
    }
//DB Login
$servername = "localhost";
$username = "web27628762";
$password = "9x7wKi4W";
$dbname = "usr_web27628762_3";
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

        $sql_get_user = $conn->prepare("SELECT * FROM users WHERE user_name = :uname");
        $sql_get_user->bindParam(':uname', $_COOKIE["User_Name"]);
        $sql_get_user->setFetchMode(PDO::FETCH_ASSOC);
        $sql_get_user->execute();
        $user_array = $sql_get_user->fetchAll();
        if($user_array[0]["session_token"] != $_COOKIE["Session_Token"]){
            header('Location: index.php?error=11&code='.$user_array[0]["session_token"]);
            die("Unauthorized (Error Code 11)");
        }
        
        //print_r($user_array[0]);
        $time = 172800; //48 Hours
        $secs = $time-(time()-$user_array[0]["last_retrival"]);

        $t = secondsToTime($secs);
        if($t["h"] < 0 || $t["m"] < 0 || $t["s"] < 0){
            $formated_time = "00:00:00"; //Prevent negative Numbers
        }else {
            $h = $t["h"]."";
            $m = $t["m"]."";
            $s = $t["s"]."";
            if(strlen($t["h"]) == 1){
                $h = "0".$h;
            }
            if(strlen($t["m"]) == 1){
                $m = "0".$m;
            }
            if(strlen($t["s"]) == 1){
                $s = "0".$s;
            }
            $formated_time = $h . ":" . $m . ":" . $s;
        }

        $conn = null;
    }catch (PDOException $ex) {
        unset($servername);
        unset($username);
        unset($password);
        unset($dbname);
        header('Location: index.php?error=-1');
        die($ex->getMessage());
    }
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
    <meta name="author" content="S1mple">

    <title>Dashboard</title>

    <!-- Bootstrap core CSS -->
    <link href="./css/bootstrap.min.css" rel="stylesheet">

    <!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
    <link href="./css/ie10-viewport-bug-workaround.css" rel="stylesheet">

    <!-- Custom styles for this template -->
    <link href="./css/dashboard.css" rel="stylesheet">

    <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
    <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
</head>

<body onload="load()">

<nav class="navbar navbar-inverse navbar-fixed-top">
    <div class="container-fluid">
        <div class="navbar-header">
            <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar"
                    aria-expanded="false" aria-controls="navbar">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="#">xDatabase</a>
        </div>
        <div id="navbar" class="navbar-collapse collapse">
            <ul class="nav navbar-nav navbar-right">
                <li><a href="do_logout.php">Log-Out</a></li>
            </ul>
        </div>
    </div>
</nav>

<div class="container-fluid">
    <div class="row">

        <div id="timer" class="col-xs-push-10 main">
            <div class="row placeholders">
                <p id="time" style="font-size: 15vw" "><?php echo $formated_time; ?></p>
            </div>
        </div>
        <div id="getaccounts" class="col-xs-push-10 main" style="display: none">
            <div class="row placeholders">
                <button onclick="getNewAccount()" class="btn btn-success" style="font-size: 5vw">Get free Account</button>
                <br>
                <br>
                <div>
                    <button id="euw" value="1" onclick="switchRegion('euw')" class="btn btn-info">EUW</button>
                    <button id="nasucks" value="0" onclick="switchRegion('na')" class="btn">NA</button>
                </div>
            </div>
        </div>

        <div class="main">
            <h2 class="sub-header">Your Account</h2>
            <div class="table-responsive">
                <table class="table table-striped">
                    <thead>
                    <tr>
                        <th>#</th>
                        <th>Region</th>
                        <th>Login Name</th>
                        <th>Password</th>
                        <th>Available for</th>
                        <th>Champions</th>
                        <th>Account Level</th>
                        <th> </th>
                    </tr>
                    </thead>
                    <tbody>
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

                        //Unset Login var's
                        unset($servername);
                        unset($username);
                        unset($password);
                        unset($dbname);

                        $sql_get_user_accounts = $conn->prepare("SELECT * FROM accounts WHERE c_user = :user AND InUseTill > :x");
                        $sql_get_user_accounts->bindParam(':user', $user_array[0]["UUID"]);
                        $tim = time();
                        $sql_get_user_accounts->bindParam(':x', $tim);
                        $sql_get_user_accounts->execute();
                        $account = $sql_get_user_accounts->fetchAll();
                        unset($sql_get_user_accounts);

                        if(sizeof($account)>0){
                            $account = $account[0];
                            if($account["InUseTill"]-time() > 0) {

                                echo "<tr id='CurrentAccount'>";
                                echo "<td id='AccountUUID'>" . $account["UUID"] . "</td>";
                                echo "<td id='AccountRegion'>".$account["region"]."</td>";
                                echo "<td id='AccountLoginName'>" . base64_decode($account["login_name"]) . "</td>";
                                echo "<td id='AccountPassword'>" . base64_decode($account["password"]) . "</td>";
                                $t = secondsToTime($account["InUseTill"]-time());
                                $h = $t["h"] . "";
                                $m = $t["m"] . "";
                                $s = $t["s"] . "";
                                if (strlen($t["h"]) == 1) {
                                    $h = "0" . $h;
                                }
                                if (strlen($t["m"]) == 1) {
                                    $m = "0" . $m;
                                }
                                if (strlen($t["s"]) == 1) {
                                    $s = "0" . $s;
                                }
                                echo "<td id='AccountTimer'>" . $h . ":" . $m . ":" . $s . "</td>";
                                $champs = json_decode($account["champion_json"],true);
                                $nchamps = sizeof($champs);
                                if(!isset($nchamps)){
                                    $nchamps = 0;
                                }
                                echo "<td id='AccountChampions'><a onclick=\"document.getElementById('champ_table').style.display = \"\" data-toggle=\"modal\" data-target=\"#modalChamps\" onmouseover=\"nhpup.popup($('#champ_table').html(), {'width': 400});\">".$nchamps."</a></td>";
                                echo "<td id='AccountLevel'>".$account["account_level"]."</td>";
                                echo "</tr>";
                            }else{
                                echo "<tr id='CurrentAccount'>";
                                echo "<td id='AccountUUID'>-</td>";
                                echo "<td id='AccountRegion'>-</td>";
                                echo "<td id='AccountLoginName'>--</td>";
                                echo "<td id='AccountPassword'>---</td>";
                                echo "<td id='AccountTimer'>42:00:00</td>";
                                echo "<td id='AccountChampions'><a onclick=\"document.getElementById('champ_table').style.display = \"\" data-toggle=\"modal\" data-target=\"#modalChamps\" onmouseover=\"nhpup.popup($('#champ_table').html(), {'width': 400});\">".$nchamps."</a></td>";
                                echo "<td id='AccountLevel'>0</td>";
                                echo "</tr>";
                            }
                        }else{
                            echo "<tr id='CurrentAccount' style='display: none'>";
                            echo "<td id='AccountUUID'>-</td>";
                            echo "<td id='AccountRegion'>-</td>";
                            echo "<td id='AccountLoginName'>--</td>";
                            echo "<td id='AccountPassword'>---</td>";
                            echo "<td id='AccountTimer'>31:00:00</td>";
                            echo "<td id='AccountChampions'><a onclick=\"document.getElementById('champ_table').style.display = \"\" data-toggle=\"modal\" data-target=\"#modalChamps\" onmouseover=\"nhpup.popup($('#champ_table').html(), {'width': 400});\">".$nchamps."</a></td>";
                            echo "<td id='AccountLevel'>0</td>";
                            echo "</tr>";
                        }

                    }catch (PDOException $ex){
                        unset($servername);
                        unset($username);
                        unset($password);
                        unset($dbname);
                        header('Location: index.php?error=-1');
                        die($ex->getMessage());
                    }
                    ?>
                    </tbody>
                </table>
            </div>
        </div>
        <div id="champ_table" style="display:none;">
            <table border="1" width="400">
                <tr>
                    <th>Champion Name</th>
                </tr>
                <?php
                if (isset($champs)) {
                    foreach ($champs as $k=>$v){
                        echo "<tr><td>".$v."</tr></td>";
                    }
                }
                ?>
            </table>
        </div>
        <div class="container">
            <div class="modal fade" id="modalChamps" role="dialog">
                <div class="modal-dialog modal-lg">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal">&times;
                            </button>
                            <h4 class="modal-title">Champions
                            </h4>
                        </div>
                        <div class="modal-body">
                            <div class="table-responsive">
                                <table class="table table-striped">
                                    <?php
                                    if (isset($champs)) {
                                        foreach ($champs as $k=>$v){
                                            echo "<tr><td>".$v."</tr></td>";
                                        }
                                    }
                                    ?>
                                </table>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-default" data-dismiss="modal">Close
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <?php
        if($user_array[0]["user_level"] == 1) {
            /*
             * Manage Users
             */
            echo "<div class=\"main\">";
            echo "<h2 class=\"sub-header\">Admin CP</h2>";
            echo "<h3 class=\"sub-header\">Users <a id='usrctrlbtn' onclick=\"if(document.getElementById('usrctr').style.display=='none'){document.getElementById('usrctr').style.display='';document.getElementById('usrctrlbtn').innerHTML='Hide';}else{document.getElementById('usrctr').style.display='none';document.getElementById('usrctrlbtn').innerHTML='Show';}\">Hide</a></h3>";
            echo "<div id=\"usrctr\">";
            echo "<ul class=\"nav nav-tabs\">";
            echo "<li class=\"active\"><a data-toggle=\"tab\" href=\"#alluser\">All Users</a></li>";
            echo "<li><a data-toggle=\"tab\" href=\"#vuser\">Verified Users</a></li>";
            echo "<li><a data-toggle=\"tab\" href=\"#uvuser\">Unverified Users</a></li>";
            echo "<li><a data-toggle=\"tab\" href=\"#buser\">Banned User</a></li>";
            echo "</ul>";
            echo "<div class=\"tab-content\">";

            //All users
            echo "<div id=\"alluser\" class=\"tab-pane fade in active\">";
            echo "<div class=\"table-responsive\">";
            echo "<table class=\"table table-striped\">";
            echo "<thead>";
            echo "<tr>";
            echo "<th>#</th>";
            echo "<th>User Name</th>";
            echo "<th>Last IP</th>";
            echo "<th>Registration IP</th>";
            echo "</tr>";
            echo "</thead>";
            echo "<tbody>";

            $sql_get_all_users = $conn->prepare("SELECT UUID, user_name, registration_ip, last_login_ip FROM users");
            $sql_get_all_users->execute();
            $allusers = $sql_get_all_users->fetchAll();
            unset($sql_get_all_users);

            foreach ($allusers as $key => $value) {
                echo "<tr>";
                echo "<td>" . $key . "</td>";
                echo "<td>" . base64_decode($value["user_name"]) . "</td>";
                if($value["last_login_ip"] == $value["registration_ip"]) {
                    echo "<td>" . $value["last_login_ip"] . "</td>";
                    echo "<td>" . $value["registration_ip"] . "</td>";
                }else{
                    echo "<td class='danger'>" . $value["last_login_ip"] . "</td>";
                    echo "<td class='danger'>" . $value["registration_ip"] . "</td>";
                }
                echo "</tr>";
            }

            echo "</tbody>";
            echo "</table>";
            echo "</div>";
            echo "</div>";

            //Verified users
            echo "<div id=\"vuser\" class=\"tab-pane fade\">";
            echo "<div class=\"table-responsive\">";
            echo "<table class=\"table table-striped\">";
            echo "<thead>";
            echo "<tr>";
            echo "<th>#</th>";
            echo "<th>User Name</th>";
            echo "<th>Last IP</th>";
            echo "<th>Registration IP</th>";
            echo "<th> </th>";
            echo "</tr>";
            echo "</thead>";
            echo "<tbody>";

            $sql_get_all_users = $conn->prepare("SELECT UUID, user_name, registration_ip, last_login_ip, user_level FROM users WHERE user_level >= 0");
            $sql_get_all_users->execute();
            $verifiedusers = $sql_get_all_users->fetchAll();
            unset($sql_get_all_users);

            foreach ($verifiedusers as $key => $value) {
                echo "<tr>";
                echo "<td>" . $key . "</td>";
                echo "<td>" . base64_decode($value["user_name"]) . "</td>";
                if($value["last_login_ip"] == $value["registration_ip"]) {
                    echo "<td>" . $value["last_login_ip"] . "</td>";
                    echo "<td>" . $value["registration_ip"] . "</td>";
                }else{
                    echo "<td class='danger'>" . $value["last_login_ip"] . "</td>";
                    echo "<td class='danger'>" . $value["registration_ip"] . "</td>";
                }
                if($value["user_level"] != 1){
                    echo "<td><button class='btn btn-sm btn-danger' onclick='changestatus(\"".$value["UUID"]."\",\"-2\")'>BAN</button></td>";
                }
                echo "</tr>";
            }

            echo "</tbody>";
            echo "</table>";
            echo "</div>";
            echo "</div>";

            //Unverified Users
            echo "<div id=\"uvuser\" class=\"tab-pane fade\">";
            echo "<div class=\"table-responsive\">";
            echo "<table class=\"table table-striped\">";
            echo "<thead>";
            echo "<tr>";
            echo "<th>#</th>";
            echo "<th>User Name</th>";
            echo "<th>Registration IP</th>";
            echo "<th>Registration Date</th>";
            echo "<th> </th>";
            echo "<th> </th>";
            echo "</tr>";
            echo "</thead>";
            echo "<tbody>";

            $sql_get_all_users = $conn->prepare("SELECT UUID, user_name,registration_ip,registration_time FROM users WHERE user_level = -1");
            $sql_get_all_users->execute();
            $allusers = $sql_get_all_users->fetchAll();
            unset($sql_get_all_users);

            foreach ($allusers as $key => $value) {
                echo "<tr>";
                echo "<td>" . $key . "</td>";
                echo "<td>" . base64_decode($value["user_name"]) . "</td>";
                echo "<td>" . $value["registration_ip"] . "</td>";
                
                echo "<td>" . $value["registration_time"] . "</td>";
                echo "<td><button class='btn btn-sm btn-success' onclick='changestatus(\"".$value["UUID"]."\",\"0\")'>Verify</button></td>";
                echo "<td><button class='btn btn-sm btn-danger' onclick='changestatus(\"".$value["UUID"]."\",\"-2\")'>BAN</button></td>";
                echo "</tr>";
            }

            echo "</tbody>";
            echo "</table>";
            echo "</div>";
            echo "</div>";

            //Banned Users
            echo "<div id=\"buser\" class=\"tab-pane fade\">";
            echo "<div class=\"table-responsive\">";
            echo "<table class=\"table table-striped\">";
            echo "<thead>";
            echo "<tr>";
            echo "<th>#</th>";
            echo "<th>User Name</th>";
            echo "<th>Last IP</th>";
            echo "<th>Registration IP</th>";
            echo "<th> </th>";
            echo "</tr>";
            echo "</thead>";
            echo "<tbody>";

            $sql_get_all_users = $conn->prepare("SELECT UUID, user_name,last_login_ip,registration_ip FROM users WHERE user_level = -2");
            $sql_get_all_users->execute();
            $allusers = $sql_get_all_users->fetchAll();
            unset($sql_get_all_users);

            foreach ($allusers as $key => $value) {
                echo "<tr>";
                echo "<td>" . $key . "</td>";
                echo "<td>" . base64_decode($value["user_name"]) . "</td>";
                if($value["last_login_ip"] == $value["registration_ip"]) {
                    echo "<td>" . $value["last_login_ip"] . "</td>";
                    echo "<td>" . $value["registration_ip"] . "</td>";
                }else{
                    echo "<td class='danger'>" . $value["last_login_ip"] . "</td>";
                    echo "<td class='danger'>" . $value["registration_ip"] . "</td>";
                }
                echo "<td><button class='btn btn-sm btn-success' onclick='changestatus(\"".$value["UUID"]."\",\"0\")'>Unban</button></td>";
                echo "</tr>";
            }

            echo "</tbody>";
            echo "</table>";
            echo "</div>";
            echo "</div>";
            echo "</div></div></div>";


            /*
             * Add new Accounts
             *
             */

            echo "<div class=\"main\">";
            echo "<h3 class=\"sub-header\">Accounts <a id='accctrlbtn' onclick=\"if(document.getElementById('accctrl').style.display=='none'){document.getElementById('accctrl').style.display='';document.getElementById('accctrlbtn').innerHTML='Hide';}else{document.getElementById('accctrl').style.display='none';document.getElementById('accctrlbtn').innerHTML='Show';}\">Hide</a></h3>";
            echo "<div id=\"accctrl\">";
            echo "<div class=\"form-horizontal\">";
            echo "<div class=\"form-group\">";
            echo "<div class=\"col-md-6\">";
            echo "<textarea id=\"AccountJSON\" class=\"form-control\" rows=\"3\" placeholder=\"Account JSON String\" required></textarea>";
            echo "<br>";
            echo "<button class=\"btn btn-primary\" onclick=\"update_accounts_from_json('public')\">Submit</button>";
            echo "<button class=\"btn btn-danger\" onclick=\"document.getElementById('AccountJSON').value = ''\">Clear</button>";
            echo "</div>";
            echo "</div>";
            echo "<button class=\"btn btn-info\" onclick=\"exp('EUW','PP')\">Export EUW Accounts</button><p></p>";
            echo "<button class=\"btn btn-info\" onclick=\"exp('NA','PP')\">Export NA Accounts</button>";
            echo "<p></p><textarea id='exptxt' class='form-control' style='display: none'></textarea>";
            echo "</div>";
            echo "</div>";
            echo "</div>";
            echo "</div>";
            echo "</div>";

            echo "<div class=\"main\">";
            echo "<h3 class=\"sub-header\">Accounts (Private) <a id='accctrlbtn2' onclick=\"if(document.getElementById('accctrl2').style.display=='none'){document.getElementById('accctrl2').style.display='';document.getElementById('accctrlbtn2').innerHTML='Hide';}else{document.getElementById('accctrl2').style.display='none';document.getElementById('accctrlbtn2').innerHTML='Show';}\">Hide</a></h3>";
            echo "<div id=\"accctrl2\">";
            echo "<div class=\"form-horizontal\">";
            echo "<div class=\"form-group\">";
            echo "<div class=\"col-md-6\">";
            echo "<textarea id=\"AccountJSON\" class=\"form-control\" rows=\"3\" placeholder=\"Account JSON String\" required></textarea>";
            echo "<br>";
            echo "<button class=\"btn btn-primary\" onclick=\"update_accounts_from_json('private')\">Submit</button>";
            echo "<button class=\"btn btn-danger\" onclick=\"document.getElementById('AccountJSON').value = ''\">Clear</button>";
            echo "</div>";
            echo "</div>";
            echo "<button class=\"btn btn-info\" onclick=\"exp('EUW','PW')\">Export EUW Accounts</button><p></p>";
            echo "<button class=\"btn btn-info\" onclick=\"exp('NA','PW')\">Export NA Accounts</button>";
            echo "<p></p><textarea id='exptxt2' class='form-control' style='display: none'></textarea>";
            echo "</div>";
            echo "</div>";
            echo "</div>";
            echo "</div>";
            echo "</div>";

            /*
             * Search Account by Champion
             */

            echo "<div class=\"main\">";
            echo "<h3 class=\"sub-header\">Search Accounts</h3>";
            echo "<div class=\"form-horizontal\">";
            echo "<div class=\"form-group\">";
            echo "<div class=\"col-md-6\">";
            echo "<input id=\"SearchAccount\" class=\"form-control\" placeholder=\"Champion Name\" required>";
            echo "<br>";
            echo "<button class=\"btn btn-primary\" onclick=\"search_account()\">Search</button>";
            echo "</div>";
            echo "</div>";
            echo "</div>";
            echo "</div>";
            echo "</div>";
            echo "</div>";
        }
        ?>

        <div class="main" id="searchresults" style="display: none">
             <div class="tab-pane">
             <div class=table-responsive>
                 <table id="tableSearch" class="table table-striped">
                 <thead>
                 <tr>
                     <th>#</th>
                     <th>User Name</th>
                     <th>Password</th>
                     <th>Account Level</th>
                     <th>Champions</th>
                     <th>In Use</th>
                     <th>Region</th>
                     <th>Private Account</th>
                     </tr>
                 </thead>
                 <tbody>
                 </tbody>
                 </table>
             </div>
             </div>
        </div>
    </div>
</div>

<!-- Bootstrap core JavaScript
================================================== -->
<!-- Placed at the end of the document so the pages load faster -->
<script src="./js/jquery-1.12.3.min.js"></script>
<script>window.jQuery || document.write('<script src="./js/jquery-1.12.3.min.js"><\/script>')</script>
<script src="./js/bootstrap.min.js"></script>
<!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
<script src="./js/ie10-viewport-bug-workaround.js"></script>
<script src="./js/nhpup_1.1.js"></script>
</body>
<script>
    function switchRegion(id) {
        if(id == "euw"){
            document.getElementById('euw').value = "1";
            document.getElementById('euw').className = "btn btn-info";
            document.getElementById('nasucks').value = "0";
            document.getElementById('nasucks').className = "btn";
        }else{
            document.getElementById('euw').value = "0";
            document.getElementById('euw').className = "btn";
            document.getElementById('nasucks').value = "1";
            document.getElementById('nasucks').className = "btn btn-info";
        }
    }
    function getNewAccount() {
        var xhttp = new XMLHttpRequest();
        xhttp.onreadystatechange = function() {
            if (xhttp.readyState == 4 && xhttp.status == 200) {
                var resp = xhttp.responseText;
                if(resp.substr(0,1) == "{"){
                    //alert(resp);
                    var json = JSON.parse(resp);
                    document.getElementById('AccountUUID').innerHTML = json.uuid;
                    document.getElementById('AccountLoginName').innerHTML = window.atob(json.login_name);
                    document.getElementById('AccountPassword').innerHTML = window.atob(json.password);
                    document.getElementById('AccountTimer').innerHTML = json.time;
                    document.getElementById('AccountLevel').innerHTML = json.level;
                    location.reload();

                }else{
                    alert(resp);
                }

            }
        };
        var region = "EUW";
        if(document.getElementById('nasucks').value == 1){
            region = "NA";
        }
        xhttp.open("POST", 'do_get_new_account.php', true);
        xhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
        xhttp.send("region="+region+"&usr=<?php echo $_COOKIE["User_Name"];?>&auth=<?php echo $_COOKIE["Session_Token"];?>");
    }

    function load() {
        OnLoadAccount();
        OnLoadMain();
    }

    function OnLoadMain() {
        var interval_Main = setInterval(function () {
            var timer = document.getElementById("time").innerHTML;
            var H1 = parseInt(timer.substr(0, 1));
            var H2 = parseInt(timer.substr(1, 2));
            var M1 = parseInt(timer.substr(3, 4).substr(0, 1));
            var M2 = parseInt(timer.substr(4, 5));
            var S1 = parseInt(timer.substr(6, 7).substr(0, 1));
            var S2 = parseInt(timer.substr(7, 8));

            //alert(H1 + " " + H2 + " : " + M1 + " " + M2 + " : " + S1 + " " + S2);
            //alert(H1 + H2 + M1 + M2 + S1 + S2);
            if (H1 + H2 + M1 + M2 + S1 + S2 > 0) {
                if (S2 != 0) {
                    S2 = S2 - 1;
                } else {
                    S2 = 9;
                    if (S1 != 0) {
                        S1 = S1 - 1;
                    } else {
                        S1 = 5;
                        if (M2 != 0) {
                            M2 = M2 - 1;
                        } else {
                            M2 = 9;
                            if (M1 != 0) {
                                M1 = M1 - 1;
                            } else {
                                M1 = 5;
                                if (H2 != 0) {
                                    H2 = H2 - 1;
                                } else {
                                    H2 = 9;
                                    if (H1 != 0) {
                                        H1 = H1 - 1;
                                    }
                                }
                            }
                        }
                    }
                }

                document.getElementById("time").innerHTML = H1 + "" + H2 + ":" + M1 + "" + M2 + ":" + S1 + "" + S2;
            } else {
                clearInterval(interval_Main);
                $("#time").fadeOut("slow");
                setTimeout(function () {
                    $("#getaccounts").fadeIn("slow");
                }, 600);

            }
        }, 1000);
    }
    function OnLoadAccount() {
        var interval_Account = setInterval(function () {
            var timer = document.getElementById("AccountTimer").innerHTML;
            var H1 = parseInt(timer.substr(0, 1));
            var H2 = parseInt(timer.substr(1, 2));
            var M1 = parseInt(timer.substr(3, 4).substr(0, 1));
            var M2 = parseInt(timer.substr(4, 5));
            var S1 = parseInt(timer.substr(6, 7).substr(0, 1));
            var S2 = parseInt(timer.substr(7, 8));


            //alert(H1 + " " + H2 + " : " + M1 + " " + M2 + " : " + S1 + " " + S2);
            if (H1 + H2 + M1 + M2 + S1 + S2 > 0) {
                if (S2 != 0) {
                    S2 = S2 - 1;
                } else {
                    S2 = 9;
                    if (S1 != 0) {
                        S1 = S1 - 1;
                    } else {
                        S1 = 5;
                        if (M2 != 0) {
                            M2 = M2 - 1;
                        } else {
                            M2 = 9;
                            if (M1 != 0) {
                                M1 = M1 - 1;
                            } else {
                                M1 = 5;
                                if (H2 != 0) {
                                    H2 = H2 - 1;
                                } else {
                                    H2 = 9;
                                    if (H1 != 0) {
                                        H1 = H1 - 1;
                                    }
                                }
                            }
                        }
                    }
                }

                document.getElementById("AccountTimer").innerHTML = H1 + "" + H2 + ":" + M1 + "" + M2 + ":" + S1 + "" + S2;
            } else {
                clearInterval(interval_Account);
                $("#time").fadeOut("slow");
                document.getElementById("CurrentAccount").style.display = "none";

            }
        }, 1000);
    }

    function exp(str,state) {
        var xhttp = new XMLHttpRequest();
        xhttp.onreadystatechange = function() {
            if (xhttp.readyState == 4 && xhttp.status == 200) {
                var resp = xhttp.responseText;
                if(state == "PW") {
                    document.getElementById('exptxt2').style.display = "";
                    document.getElementById('exptxt2').innerHTML = resp;
                }else{
                    document.getElementById('exptxt').style.display = "";
                    document.getElementById('exptxt').innerHTML = resp;
                }
            }
        };

        xhttp.open("POST", 'do_export.php', true);
        xhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
        xhttp.send("region="+str+"&state="+state+"&usr=<?php echo $_COOKIE["User_Name"];?>&auth=<?php echo $_COOKIE["Session_Token"];?>");
    }


    <?php
        //Admin only JS
        if($user_array[0]["user_level"] == 1){
            //Cause js has to be delivered with some Tab's :)
            echo "function search_account() {";
            echo "\t\tvar searchstring = document.getElementById('SearchAccount').value;";
            echo "\t\tvar xhttp = new XMLHttpRequest();";
            echo "\t\txhttp.onreadystatechange = function() {";
            echo "\t\t\tif (xhttp.readyState == 4 && xhttp.status == 200) {";
            echo "\t\t\t\tvar resp = xhttp.responseText;";
            echo "\t\t\t\tvar json_resp = JSON.parse(resp);";
            echo "\t\t\t\tvar table = document.getElementById('tableSearch');";
            echo "\t\t\t\tvar n = 0;";
            echo "\t\t\t\tfor (i=50;i>=0;i--){";
            echo "\t\t\t\t\tvar current_account = json_resp[\"Account\"+i];";
            echo "\t\t\t\t\tif(current_account){";
            echo "\t\t\t\t\t\tn++;";
            echo "\t\t\t\t\t\tvar row = table.insertRow(-1);";
            echo "\t\t\t\t\t\tvar cell, text;";
            echo "\t\t\t\t\t\tcell = row.insertCell(-1);";
            echo "\t\t\t\t\t\ttext = n;";
            echo "\t\t\t\t\t\tcell.appendChild(document.createTextNode(text));";
            echo "\t\t\t\t\t\tcell = row.insertCell(-1);";
            echo "\t\t\t\t\t\ttext = atob(current_account[\"login_name\"]);";
            echo "\t\t\t\t\t\tcell.appendChild(document.createTextNode(text));";
            echo "\t\t\t\t\t\tcell = row.insertCell(-1);";
            echo "\t\t\t\t\t\ttext = atob(current_account[\"password\"]);";
            echo "\t\t\t\t\t\tcell.appendChild(document.createTextNode(text));";
            echo "\t\t\t\t\t\tcell = row.insertCell(-1);";
            echo "\t\t\t\t\t\ttext = current_account[\"account_level\"];";
            echo "\t\t\t\t\t\tcell.appendChild(document.createTextNode(text));";
            echo "\t\t\t\t\t\tcell = row.insertCell(-1);";
            echo "\t\t\t\t\t\ttext = current_account[\"champion_json\"].replaceAll(\"[\",\"\").replaceAll('\"',\"\").replaceAll(\",\",\", \").replaceAll(\"]\",\"\");";
            echo "\t\t\t\t\t\tcell.appendChild(document.createTextNode(text));";
            echo "\t\t\t\t\t\tcell = row.insertCell(-1);";
            echo "\t\t\t\t\t\ttext = current_account[\"InUse\"];";
            echo "\t\t\t\t\t\tcell.appendChild(document.createTextNode(text));";
            echo "\t\t\t\t\t\tcell = row.insertCell(-1);";
            echo "\t\t\t\t\t\ttext = current_account[\"region\"];";
            echo "\t\t\t\t\t\tcell.appendChild(document.createTextNode(text));";
            echo "\t\t\t\t\t\tcell = row.insertCell(-1);";
            echo "\t\t\t\t\t\ttext = current_account[\"state\"];";
            echo "\t\t\t\t\t\tcell.appendChild(document.createTextNode(text));";
            echo "\t\t\t\t\t}";
            echo "\t\t\t\t}";
            echo "\t\t\t\tdocument.getElementById('searchresults').style.display = \"\";";
            echo "\t\t\t}";
            echo "\t\t};";
            echo "\t\txhttp.open(\"POST\", 'do_search.php', true);";
            echo "\t\txhttp.setRequestHeader(\"Content-type\", \"application/x-www-form-urlencoded\");";
            echo "\t\txhttp.send(\"searchstr=\"+searchstring+\"&usr=".$_COOKIE["User_Name"]."&auth=". $_COOKIE["Session_Token"]."\");";
            echo "\t}";
            
            echo "function update_accounts_from_json(str) {";
            echo "\t\tvar json = document.getElementById('AccountJSON').value;";
            echo "\t\tif(json.length > 0){";
            echo "\t\t\tvar xhttp = new XMLHttpRequest();";
            echo "\t\t\txhttp.onreadystatechange = function() {";
            echo "\t\t\t\tif (xhttp.readyState == 4 && xhttp.status == 200) {";
            echo "\t\t\t\t\tvar resp = xhttp.responseText;";
            echo "\t\t\t\t\tif(resp == \"OK\"){";
            echo "\t\t\t\t\t\talert(\"Successfully added accounts\");";
            echo "\t\t\t\t\t}else{";
            echo "\t\t\t\t\t\talert(resp);";
            echo "\t\t\t\t\t}";
            echo "\t\t\t\t}";
            echo "\t\t\t};";
            echo "\t\t\txhttp.open(\"POST\", 'do_update_accounts.php', true);";
            echo "\t\t\txhttp.setRequestHeader(\"Content-type\", \"application/x-www-form-urlencoded\");";
            echo "\t\t\txhttp.send(\"json=\"+json+\"&state=\"+str+\"&usr=".$_COOKIE["User_Name"]."&auth=". $_COOKIE["Session_Token"]."\");";
            echo "\t\t}";
            echo "\t};";

            echo "function changestatus(uuid, newstatus) {";
            echo "\t\tvar xhttp = new XMLHttpRequest();";
            echo "\t\txhttp.onreadystatechange = function() {";
            echo "\t\t\tif (xhttp.readyState == 4 && xhttp.status == 200) {";
            echo "\t\t\t\tvar resp = xhttp.responseText;";
            echo "\t\t\t\tif(resp == \"OK\"){";
            echo "\t\t\t\t\talert(\"User state changed\");";
            echo "\t\t\t\t}else{";
            echo "\t\t\t\t\talert(resp);";
            echo "\t\t\t\t}";
            echo "\t\t\t}";
            echo "\t\t};";
            echo "\t\txhttp.open(\"POST\", 'do_change_auth_status.php', true);";
            echo "\t\txhttp.setRequestHeader(\"Content-type\", \"application/x-www-form-urlencoded\");";
            echo "\t\txhttp.send(\"newstatus=\"+newstatus+\"&usr=\"+uuid+\"&authusr=".$_COOKIE["User_Name"]."&auth=".$_COOKIE["Session_Token"]."\");";
            echo "\t}";
        }
    ?>

    String.prototype.replaceAll = function(search, replacement) {
        search = escapeRegExp(search);
        var target = this;
        return target.replace(new RegExp(search, 'g'), replacement);
    };
    function escapeRegExp(str) {
        return str.replace(/[.*+?^${}()|[\]\\]/g, "\\$&"); // $& means the whole matched string
    };
</script>
</html>
<?php
$conn = null;
?>