<?php
    //Get LoL Version from ddragon
    $version_raw = file_get_contents("https://ddragon.leagueoflegends.com/realms/na.js");
    preg_match_all("/dd\":\"(\\d\\.*)+/", $version_raw, $version_regexed);
    $version = substr($version_regexed[0][0],5);

    //Get Champions
    $champ_data_raw = file_get_contents("https://ddragon.leagueoflegends.com/cdn/".$version."/data/en_US/champion.json");
    $champ_data = json_decode($champ_data_raw, true)["data"];



    //GET BOL SCRIPTS
    $bol_scripts = array();
    foreach ($champ_data as $key=>$value){
        $champ = $value["id"];
        if($champ == "MonkeyKing"){
            $champ = "Wukong";
        }
        $bol_tool_raw = file_get_contents("http://bol-tools.com/api/search/champion/".$champ."/0");
        preg_match_all("/id\":[0-9]+/", $bol_tool_raw, $out_count);
        $out_count = $out_count[0];
        $count = sizeof($out_count);

        preg_match_all("/isPaid\":true/", $bol_tool_raw, $out_payed);
        $out_payed = $out_payed[0];
        $payed = sizeof($out_payed);

        preg_match_all("/isPaid\":false,\"isWorking\":true/", $bol_tool_raw, $out_free_and_working);
        $out_free_and_working = $out_free_and_working[0];
        $free_and_working = sizeof($out_free_and_working);

        $c = array();
        $c["payed"] = $payed;
        $c["free"] = $free_and_working;
        $champ = str_replace(" ", "",$champ);
        $champ = strtolower($champ);
        $bol_scripts[$champ] = $c;
    }

    //Get GoS Scripts
    $gos_scripts = array();
    $gos_raw = file_get_contents("http://gos-db.com/");
    preg_match_all("/champion-title\\\">\\w+(\\s*|\\w*|\\.*)*<\\/span>\\n\\t+<span class=\"card-title white-text scripts-number\\\">\\d/",$gos_raw,$gos_form1);
    $gos_form1 = $gos_form1[0];


    foreach ($gos_form1 as $key=>$value){
        $value = str_replace(" ", "",$value);
        $value = str_replace(".", "",$value);
        preg_match("/champion-title\\\">\\w+(\\s*|\\w*|\\.*)*/",$value,$champ_r);
        preg_match("/scripts-number\">\\w+/",$value,$numb_r);

        $champ = substr($champ_r[0],16);
        $number = substr($numb_r[0],16);
        $c = array();
        $c["scripts"] = $number;
        $champ = strtolower($champ);
        $gos_scripts[$champ] = $c;
    }



    //Get EB Scripts
    $eb_scripts = array();
    $eb_raw = file_get_contents("https://raw.githubusercontent.com/Sicryption/EloBuddyDatabase/gh-pages/ChampionAddons.html");
    $eb_raw1 = htmlspecialchars($eb_raw);
    preg_match_all("/var championNames(.+|\\r|\\n)+/",$eb_raw1, $eb_raw2);
    $eb_raw2 = $eb_raw2[0][0];
    $pop = strpos($eb_raw2, "populating");
    $eb_raw3 = substr($eb_raw2,21, $pop-29);

    preg_match_all("/\\w+.+/", $eb_raw3, $eb_raw4);
    $eb_raw4 = $eb_raw4[0];
    $eb_raw4 = str_replace("'", "", $eb_raw4);

    foreach ($eb_raw4 as $key=>$value){
        $value = str_replace(".", "",$value);
        preg_match("/quot;\\w+(\\s*)+\\w*/",$value,$champ_r);
        preg_match_all("/##/",$value,$script_r);
        $champ = substr($champ_r[0], 5);
        $number = sizeof($script_r[0]);

        $c = array();
        $c["scripts"] = $number;
        $champ = str_replace(" ", "",$champ);
        $champ = strtolower($champ);
        $eb_scripts[$champ] = $c;
    }
?>


<!DOCTYPE html>
<html lang="en">
<head>
    <title>Script Amount Comparision</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</head>
<body>

<div class="container">
    <table class="table table-striped">
        <thead>
            <tr>
                <th>Champion</th>
                <th>BoL (free | paid)</th>
                <?php
                    if($_GET["hidden"]){
                    }else{
                        echo "<th>GoS</th>";
                        echo "<th>Elobuddy</th>";
                    }
                ?>
            </tr>
        </thead>
        <tbody>
        <?php
            foreach ($champ_data as $key=>$value){
                $champ = $value["id"];
                if($champ == "MonkeyKing"){
                    $champ = "Wukong";
                }
                echo "<tr>";
                echo "<td>".$champ."</td>";

                $champ = strtolower($champ);

                $bol_sf = intval($bol_scripts[$champ]["free"]);
                $gos_s = intval($gos_scripts[$champ]["scripts"]);
                $eb_s = intval($eb_scripts[$champ]["scripts"]);


                if($bol_sf == 0){
                    echo "<td><span style='color: darkred; font-weight: bold'> " . $bol_scripts[$champ]["free"] . " </span>";
                }else {
                    echo "<td>" . $bol_scripts[$champ]["free"];
                }
                echo " | ";
                echo $bol_scripts[$champ]["payed"] ."</td>";

        if($_GET["hidden"]){}else{
                if($gos_s == 0){
                    echo "<td><span style='color: darkred; font-weight: bold'> ".$gos_scripts[$champ]["scripts"]."</span></td>";
                }else{
                    echo "<td>".$gos_scripts[$champ]["scripts"]."</td>";
                }

                if($eb_s == 0){
                    echo "<td><span style='color: darkred; font-weight: bold'> ".$eb_scripts[$champ]["scripts"]."</span></td>";
                }else{
                    echo "<td>".$eb_scripts[$champ]["scripts"]."</td>";
                }
        }

                echo "</tr>";
            }
        ?>
        </tbody>
    </table>
</div>
</body>
</html>
