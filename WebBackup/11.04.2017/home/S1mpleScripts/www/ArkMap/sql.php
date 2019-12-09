<?php
error_reporting(E_ALL);
ini_set('display_errors', 1);

    function GetConnection(){
        $user = "root";
        $host = "localhost";
        $password = "86ajd63a8092_a";
        $dbname = "arkmap";

        try{
            $conn = new PDO("mysql:host=$host;dbname=$dbname", $user, $password);
            $conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
            unset($host);
            unset($user);
            unset($password);
            unset($dbname);
            return $conn;
        }catch(PDOException $ex){
            throw $ex;
        }
    }

    function GetAllTribes($conn){
        try{
            $sql_getTribes = $conn->prepare("SELECT * FROM Tribes");
    	    $sql_getTribes->execute();
            $sql_getTribes = $sql_getTribes->fetchAll();
            return $sql_getTribes;
        }catch(PDOException $ex){
            throw $ex;
        }
    }

    function GetAllMarkes($conn){
        try{
            $sql_getMarker = $conn->prepare("SELECT * FROM marker");
    	    $sql_getMarker->execute();
            $sql_getMarker = $sql_getMarker->fetchAll();
            return $sql_getMarker;
        }catch(PDOException $ex){
            throw $ex;
        }
    }

    function ToJSON($table)
    {
        return json_encode($table);
    }

    function CloseConn($conn){
        $conn = null;
    }

    function GetTribeByName($name){
        $conn = GetConnection();
        try{
            $sql_get_id = $conn->prepare("SELECT id FROM Tribes WHERE name = :name");
            $sql_get_id->bindParam(":name", $name);
    	    $sql_get_id->execute();
            $tribe = $sql_get_id->fetchAll();
            if(isset($tribe[0])){
                return $tribe[0][0];
            }else{
                return -1;
            }
        }catch(PDOException $ex){
            throw $ex;
        }
        CloseConn($conn);
    }

    function AddMarkerToDB($type, $tribe_id, $player_name, $x, $y, $name, $desc){
        $conn = GetConnection();
        try{
            $sql_add_marker = $conn->prepare("INSERT INTO marker (id, type, tribe_id, player_name, x, y, name, description) VALUES (NULL, :type, :tid, :player, :x, :y, :name, :descr)");
            $sql_add_marker->bindParam(':type', $type);
            $sql_add_marker->bindParam(':tid', $tribe_id);
            $sql_add_marker->bindParam(':player', $player_name);
            $sql_add_marker->bindParam(':x', $x);
            $sql_add_marker->bindParam(':y', $y);
            $sql_add_marker->bindParam(':name', $name);
            $sql_add_marker->bindParam(':descr', $desc);
    	    $sql_add_marker->execute();
        }catch(PDOException $ex){
            throw $ex;
        }
        CloseConn($conn);
    }

    function AddTribeToDB($name){
        $conn = GetConnection();
        try{
            $sql_add_tribe = $conn->prepare("INSERT INTO Tribes (id, name) VALUES (NULL, :name)");
            $sql_add_tribe->bindParam(':name', $name);
    	    $sql_add_tribe->execute();
        }catch(PDOException $ex){
            throw $ex;
        }
        CloseConn($conn);
    }

    function NewMarker($tbl)
    {
        echo "<pre>";
        print_r($tbl);
        echo "</pre>";

        switch ($tbl["type"]) {
            case 'Tribe':{
                $tribe_id = GetTribeByName($tbl["tribe"]);
                if($tribe_id == -1){
                    AddTribeToDB($tbl["tribe"]);
                    $tribe_id = GetTribeByName($tbl["tribe"]);
                }
                AddMarkerToDB(1, $tribe_id, "", $tbl["lat"], $tbl["lon"], $tbl["name"], $tbl["desc"]);
                break;
            }
            case 'Player':{
                AddMarkerToDB(2, -1, $tbl["player"], $tbl["lat"], $tbl["lon"], $tbl["name"], $tbl["desc"]);
                break;
            }
            case 'Lootcrate':{
                AddMarkerToDB(3, -1, "", $tbl["lat"], $tbl["lon"], $tbl["name"], $tbl["desc"]);
                break;
            }
            case 'Other':{
                AddMarkerToDB(4, -1, "", $tbl["lat"], $tbl["lon"], $tbl["name"], $tbl["desc"]);
                break;
            }

            default:
                break;
        }
    }

    if(isset($_GET)){
        if(isset($_GET["Tribe"])){
            $conn = GetConnection();
            echo ToJSON(GetAllTribes($conn));
            CloseConn($conn);
        }elseif(isset($_GET["Marker"])){
            $conn = GetConnection();
            echo ToJSON(GetAllMarkes($conn));
            CloseConn($conn);
        }elseif(isset($_GET["type"])){
            NewMarker($_GET);
        }else{
            $conn = GetConnection();
            echo "<pre>";
            print_r(GetAllTribes($conn));
            echo "<br>";
            print_r(GetAllMarkes($conn));
            echo "</pre>";
            CloseConn($conn);
        }
    }
?>
