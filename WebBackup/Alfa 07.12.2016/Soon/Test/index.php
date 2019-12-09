<!DOCTYPE html>
<html lang="en" xmlns="http://www.w3.org/1999/html">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="icon" href="">
    <title>Xivia index.php
    </title>
    <!-- Bootstrap core CSS -->
    <link href="./css/bootstrap.min.css" rel="stylesheet">
    <!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
    <link href="./css/ie10-viewport-bug-workaround.css" rel="stylesheet">
    <!-- Custom styles for this template -->
    <link href="./css/signin.css" rel="stylesheet">
    <!-- Stylesheet for the TOS Overlay -->
    <link href="./css/overlay-bootstrap.min.css">
    <!-- JQuery and Boostrap JS-->
    <script src="./js/jquery-1.12.3.min.js">
    </script>
    <script src="./js/bootstrap.min.js">
    </script>
    <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
    <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
    <!-- Begin Cookie Consent plugin by Silktide - http://silktide.com/cookieconsent -->
    <script type="text/javascript">
        window.cookieconsent_options = {
            "message": "This website uses cookies to ensure you get the best experience on our website",
            "dismiss": "Got it!",
            "learnMore": "More info",
            "link": null,
            "theme": "dark-floating"
        };
    </script>
    <script type="text/javascript"
            src="//cdnjs.cloudflare.com/ajax/libs/cookieconsent2/1.0.9/cookieconsent.min.js">
    </script>
    <!-- End Cookie Consent plugin -->
</head>
<body>
<div class="container">
    <form class="form-signin" action="do_login.php" method="post">
        <label for="UserName">User Name
        </label>
        <input type="text" class="form-control" name="uname" id="uname" placeholder="User Name">
        <label for="UserName">Password
        </label>
        <input type="password" class="form-control" name="Password" id="Password" placeholder="Password">
        <div class="checkbox">
            <label>
                <input name="tos" type="checkbox" id="tos">I have read and agree to the
                <a data-toggle="modal" data-target="#modalTOS">TOS
                </a>.
            </label>
        </div>
        <button name="submit" value="Submit" type="submit" class="btn btn-lg btn-primary btn-block">Log-In
        </button>
        <button name="register" value="Register" type="submit" class="btn btn-lg btn-primary btn-block">Register
        </button>
    </form>
</div>
<div id="error_container" class="container" style="display: <?php if(isset($_GET) && isset($_GET["error"])&& $_GET["error"]){echo "";}else{echo "none";}?>">
    <div class="modal show" id="modalError" role="dialog">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <button onclick="document.getElementById('error_container').style.display = 'none'" type="button" class="close" data-dismiss="modal">&times;
                    </button>
                    <?php
                    if(isset($_GET) && isset($_GET["error"])){
                        if($_GET["error"] != -2){
                            echo "<h4 class=\"modal-\">An Error occured</h4>";
                        }else{
                            echo "<h4 class=\"modal-\">Awaiting Approval</h4>";
                        }
                    }
                    ?>
                </div>
                <div class="modal-body">
                    <p>
                    <?php
                    if(isset($_GET) && isset($_GET["error"])){
                        switch ($_GET["error"]){
                            case -1:
                                echo "An PDO Exception occured, please contact the Website Administrator";
                                break;
                            case -2:
                                echo "Thanks for registering, your account now awaits registration";
                                break;
                            case 1:
                                echo "Error Code 1, please try again. And remember to accept the TOS";
                                break;
                            case 2:
                                echo "Invalid Username";
                                break;
                            case 3:
                                echo "Invalid Password lenght";
                                break;
                            case 4:
                                echo "User already registered";
                                break;
                            case 5:
                                echo "User not found";
                                break;
                            case 6:
                                echo "<b>You have been banned</b>";
                                break;
                            case 7:
                                if(isset($_GET["wait"])) {
                                    echo "You have triggered the Bruteforce Protection, please wait " . $_GET["wait"] . " Seconds";
                                }else{
                                    echo "You have triggered the Bruteforce Protection, good luck next time.";
                                }
                                break;
                            case 8:
                                echo "Password incorrect";
                                break;
                            case 9:
                                echo "Invalid Post";
                                break;
                            case 10:
                                echo "Invalid Cookie";
                                break;
                            case 11:
                                echo "Unauthorized";
                                break;
                            case 12:
                                echo "You have not yet been unlocked";
                                break;
                        }
                    }
                    ?>
                    </p>
                </div>
                <div class="modal-footer">
                    <button onclick="document.getElementById('error_container').style.display = 'none'" type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="container">
    <div class="modal fade" id="modalTOS" role="dialog">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;
                    </button>
                    <h4 class="modal-title">Terms of Service
                    </h4>
                </div>
                <div class="modal-body">
                    <p>
                    <h2>
                        Web Site Terms and Conditions of Use
                    </h2>
                    <h3>
                        1. Terms
                    </h3>
                    <p>
                        By accessing this web site, you are agreeing to be bound by these
                        web site Terms and Conditions of Use, all applicable laws and regulations,
                        and agree that you are responsible for compliance with any applicable local
                        laws. If you do not agree with any of these terms, you are prohibited from
                        using or accessing this site. The materials contained in this web site are
                        protected by applicable copyright and trade mark law.
                    </p>
                    <h3>
                        2. Use License
                    </h3>
                    <ol type="a">
                        <li>
                            Permission is granted to temporarily download one copy of the materials
                            (information or software) on Xivia's web site for personal,
                            non-commercial transitory viewing only. This is the grant of a license,
                            not a transfer of title, and under this license you may not:
                            <ol type="i">
                                <li>modify or copy the materials;
                                </li>
                                <li>use the materials for any commercial purpose, or for any public display (commercial or non-commercial);
                                </li>
                                <li>attempt to decompile or reverse engineer any software contained on Xivia's web site;
                                </li>
                                <li>remove any copyright or other proprietary notations from the materials; or
                                </li>
                                <li>transfer the materials to another person or "mirror" the materials on any other server.
                                </li>
                            </ol>
                        </li>
                        <li>
                            This license shall automatically terminate if you violate any of these restrictions and may be terminated by Xivia at any time. Upon terminating your viewing of these materials or upon the termination of this license, you must destroy any downloaded materials in your possession whether in electronic or printed format.
                        </li>
                    </ol>
                    <h3>
                        3. Disclaimer
                    </h3>
                    <ol type="a">
                        <li>
                            The materials on Xivia's web site are provided "as is". Xivia makes no warranties, expressed or implied, and hereby disclaims and negates all other warranties, including without limitation, implied warranties or conditions of merchantability, fitness for a particular purpose, or non-infringement of intellectual property or other violation of rights. Further, Xivia does not warrant or make any representations concerning the accuracy, likely results, or reliability of the use of the materials on its Internet web site or otherwise relating to such materials or on any sites linked to this site.
                        </li>
                    </ol>
                    <h3>
                        4. Limitations
                    </h3>
                    <p>
                        In no event shall Xivia or its suppliers be liable for any damages (including, without limitation, damages for loss of data or profit, or due to business interruption,) arising out of the use or inability to use the materials on Xivia's Internet site, even if Xivia or a Xivia authorized representative has been notified orally or in writing of the possibility of such damage. Because some jurisdictions do not allow limitations on implied warranties, or limitations of liability for consequential or incidental damages, these limitations may not apply to you.
                    </p>
                    <h3>
                        5. Revisions and Errata
                    </h3>
                    <p>
                        The materials appearing on Xivia's web site could include technical, typographical, or photographic errors. Xivia does not warrant that any of the materials on its web site are accurate, complete, or current. Xivia may make changes to the materials contained on its web site at any time without notice. Xivia does not, however, make any commitment to update the materials.
                    </p>
                    <h3>
                        6. Links
                    </h3>
                    <p>
                        Xivia has not reviewed all of the sites linked to its Internet web site and is not responsible for the contents of any such linked site. The inclusion of any link does not imply endorsement by Xivia of the site. Use of any such linked web site is at the user's own risk.
                    </p>
                    <h3>
                        7. Site Terms of Use Modifications
                    </h3>
                    <p>
                        Xivia may revise these terms of use for its web site at any time without notice. By using this web site you are agreeing to be bound by the then current version of these Terms and Conditions of Use.
                    </p>
                    <h3>
                        8. Governing Law
                    </h3>
                    <p>
                        Any claim relating to Xivia's web site shall be governed by the laws of the State of Netherlands without regard to its conflict of law provisions.
                    </p>
                    <p>
                        General Terms and Conditions applicable to Use of a Web Site.
                    </p>
                    <h3>
                        9. Responsibility for Available Content
                    </h3>
                    <p>
                        Xivia is in no way responsible for the Content of this Site. This site has only been made to give Users Strings of Data, which they can use as described in this License.
                    </p>
                    <h2>
                        Privacy Policy
                    </h2>
                    <p>
                        Your privacy is very important to us. Accordingly, we have developed this Policy in order for you to understand how we collect, use, communicate and disclose and make use of personal information. The following outlines our privacy policy.
                    </p>
                    <ul>
                        <li>
                            Before or at the time of collecting personal information, we will identify the purposes for which information is being collected.
                        </li>
                        <li>
                            We will collect and use of personal information solely with the objective of fulfilling those purposes specified by us and for other compatible purposes, unless we obtain the consent of the individual concerned or as required by law.
                        </li>
                        <li>
                            We will only retain personal information as long as necessary for the fulfillment of those purposes.
                        </li>
                        <li>
                            We will collect personal information by lawful and fair means and, where appropriate, with the knowledge or consent of the individual concerned.
                        </li>
                        <li>
                            Personal data should be relevant to the purposes for which it is to be used, and, to the extent necessary for those purposes, should be accurate, complete, and up-to-date.
                        </li>
                        <li>
                            We will protect personal information by reasonable security safeguards against loss or theft, as well as unauthorized access, disclosure, copying, use or modification.
                        </li>
                        <li>
                            We will make readily available to customers information about our policies and practices relating to the management of personal information.
                        </li>
                    </ul>
                    <p>
                        We are committed to conducting our business in accordance with these principles in order to ensure that the confidentiality of personal information is protected and maintained.
                    </p>
                    </p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Close
                    </button>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
<script src="./js/ie10-viewport-bug-workaround.js">
</script>
</body>
</html>
