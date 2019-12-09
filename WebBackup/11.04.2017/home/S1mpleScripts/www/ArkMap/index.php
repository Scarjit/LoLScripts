<?php

?>

<html lang="en">

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="Cache-control" content="no-cache">
    <meta http-equiv="Expires" content="-1">
    <meta name="author" content="Scarjit">

    <title>Ark Map</title>

    <!-- Bootstrap core CSS -->
    <link href="./css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom styles for this template -->
    <link href="./css/cover.css" rel="stylesheet">

</head>

<body>
    <div class="site-wrapper">
        <div class="site-wrapper-inner">
            <div class="cover-container">
                <div class="masthead clearfix">
                    <div class="inner">
                        <h3 class="masthead-brand">Ark Map</h3>
                        <nav>
                            <ul class="nav masthead-nav">
                                <li class="active"><a href="#">Home</a></li>
                                <li><a href="sql.php">Visit Raw Data</a></li>
                            </ul>
                        </nav>
                    </div>
                </div>

                <div>
                    <p class="img_center">
                        <img id="map_img" src="./res/The_Center.jpg" class="coords">
                    </p>
                    <p id="info" class="popup" onmouseout="MarkerOnOut();">
                        TEST TEST TEST
                    </p>
                </div>

                <div class="mastfoot">
                    <div class="inner">
                        <p>Map made by Scarjit</p>
                    </div>
                </div>
            </div>
        </div>

        <!-- Modal -->
        <div class="modal fade" id="myModal" role="dialog">
            <div class="modal-dialog">

                <!-- Modal content-->
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title">Add new Marker</h4>
                    </div>
                    <div class="modal-body">
                        <form>
                            <div class="form-group">
                                <label for="name">Name</label>
                                <input type="text" class="form-control" id="name" placeholder="Name">

                                <label for="desc">Description:</label>
                                <textarea class="form-control" rows="5" id="desc"></textarea>

                                <label for="type">Type:</label>
                                <select class="form-control" id="type" onchange="ChangeModal();">
                                    <option>Tribe</option>
                                    <option>Player</option>
                                    <option>Lootcrate</option>
                                    <option>Other</option>
                                </select>

                                <!-- TRIBE -->
                                <label id="lbltribe" for="tribe">Tribe:</label>
                                <input class="form-control" id="tribe" list="tribelist">
                                <datalist id="tribelist">
                                </datalist>
                                <!-- END TRIBE -->

                                <!-- PLAYER -->
                                <label style="display:none" id="lblplayer" for="player">Tribe:</label>
                                <input style="display:none" type="text" class="form-control" id="player" placeholder="Player Name">
                                <!-- END PLAYER -->


                                <div class="form-group">
                                    <label for="x">Longitude</label>
                                    <input type="number" class="form-control" id="x">
                                </div>
                                <div class="form-group">
                                    <label for="y">Latitude</label>
                                    <input type="number" class="form-control" id="y">
                                </div>
                            </div>
                        </form>
                    </div>
                    <div class="modal-footer">
                        <button type="submit" class="btn btn-info" onclick="SubmitNewMarker()">Submit</button>
                        <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
                    </div>
                </div>
            </div>
        </div>

    </div>

    <!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
    <script>
        window.jQuery || document.write('<script src="./js/jquery-3.1.1.min.js"><\/script>')
    </script>
    <script src="./js/bootstrap.min.js"></script>

    <!-- Map Marker Script-->
    <script>
        var base_X;
        var base_Y;
        var tribe_data;
        var marker_data;

        function SubmitNewMarker() {
            var name = document.getElementById("name").value;
            var desc = document.getElementById("desc").value;
            var type = document.getElementById("type");
            var tribe = document.getElementById("tribe").value;
            var player = document.getElementById("player").value;
            var lat = document.getElementById("x").value;
            var lon = document.getElementById("y").value;
            type = type.options[type.selectedIndex].text;

            console.log(name);
            console.log(desc);
            console.log(type);
            console.log(tribe);
            console.log(player);
            console.log(lat);
            console.log(lon);

            var get_request = "sql.php";
            get_request += "?name="+encodeURI(name);
            get_request += "&desc="+encodeURI(desc);
            get_request += "&type="+encodeURI(type);
            get_request += "&tribe="+encodeURI(tribe);
            get_request += "&player="+encodeURI(player);
            get_request += "&lat="+encodeURI(lat);
            get_request += "&lon="+encodeURI(lon);

            console.log(get_request);

            $.get(get_request, function(data, status) {
                if (status == "success") {
                    location.reload(true);
                }else{
                    alert(status + "\r\n" + data);
                }
            });
        }

        function ChangeModal() {
            var type = $('#type').find(":selected").text();
            document.getElementById('lbltribe').style.display = "none";
            document.getElementById('tribe').style.display = "none";
            document.getElementById('lblplayer').style.display = "none";
            document.getElementById('player').style.display = "none";
            switch (type) {
                case "Tribe":
                    document.getElementById('lbltribe').style.display = "block";
                    document.getElementById('tribe').style.display = "block";

                    break;
                case "Player":
                    document.getElementById('lblplayer').style.display = "block";
                    document.getElementById('player').style.display = "block";

                    break;
                default:

            }
        }

        function SetBaseValue() {
            var img = document.getElementById('map_img');
            rect = img.getBoundingClientRect();
            base_X = rect.left + $(window).scrollLeft();
            base_Y = rect.top + $(window).scrollTop();
        }

        function OnImageLoad() {
            SetBaseValue();
            GetDataFromDB();
        }

        function OnImageClick(evt) {
            pos_x = evt.offsetX?(evt.offsetX):evt.pageX-document.getElementById("map_img").offsetLeft;
            pos_y = evt.offsetY?(evt.offsetY):evt.pageY-document.getElementById("map_img").offsetTop;
            var img = document.getElementById('map_img');
            var width = img.clientWidth;
            var height = img.clientHeight;

            var realX = (pos_x/width*100).toFixed(2);
            var realY = (pos_y/height*100).toFixed(2);

            document.getElementById("x").value = realX;
            document.getElementById("y").value = realY;
            $('#myModal').modal('show');
        }

        function OnLoad() {
            var img = document.getElementById('map_img');
            img.addEventListener("load", OnImageLoad);
            img.addEventListener("click", OnImageClick);
        }

        function GetDataFromDB() {
            $.get("sql.php?Tribe", function(data, status) {
                if (status == "success") {
                    tribe_data = JSON.parse(data);
                    var select_element = document.getElementById('tribe');
                    for (var i = 0; i < tribe_data.length; i++) {
                        var current = tribe_data[i];
                        var tribe_name = current.name;
                        var tribe_id = current.id;
                        $('#tribelist').append($('<option>', {
                            value: tribe_name,
                            text: tribe_name
                        }));
                    }
                } else {
                    alert("There was an error while loading the Tribe Data, please reload the page");
                }
            });
            $.get("sql.php?Marker", function(data, status) {
                if (status == "success") {
                    marker_data = JSON.parse(data);
                    var img = document.getElementById('map_img');
                    var width = img.clientWidth;
                    var height = img.clientHeight;

                    for (var i = 0; i < marker_data.length; i++) {
                        //Maker Data:
                        var current = marker_data[i];
                        var id = current["id"];
                        var description = current["description"];
                        var type = current["type"];
                        var tribe_id = current["tribe_id"];
                        var player_name = current["player_name"];
                        var x = current["x"];
                        var y = current["y"];
                        var name = current["name"];
                        var description = current["description"];

                        var realX = width / 100 * x;
                        var realY = height / 100 * y;

                        CSSx = parseInt(realX) + parseInt(base_X);
                        CSSy = parseInt(realY) + parseInt(base_Y);

                        marker_data[i].cssx = CSSx;
                        marker_data[i].cssy = CSSy;

                        var marker = $('<div class="marker">').appendTo('body')[0];
                        $(marker).text("").css({
                            left: CSSx,
                            top: CSSy
                        }).show();

                        $(marker).attr('id', i);
                        $(marker).on('mouseover', function(evt) {
                            MarkerOnHover(this.id);
                        })

                        type = parseInt(type)
                        switch (type) {
                            case 1: //Tribe
                                $(marker).css({
                                    background: "#ff0000"
                                })
                                break;

                            case 2: //Player owned
                                $(marker).css({
                                    background: "#f2ff00"
                                })
                                break;

                            case 3: //Lootcrate
                                $(marker).css({
                                    background: "#000aff"
                                })
                                break;

                            default:
                                break;
                        }
                    }
                } else {
                    alert("There was an error while loading the Marker Data, please reload the page");
                }
            });

        }

        function GetTribeById(id) {
            for (var i = 0; i < tribe_data.length; i++) {
                var current = tribe_data[i];
                if (current.id == id) {
                    return current
                }
            }
        }

        function MarkerOnHover(id) {
            var current = marker_data[id];
            var tribe_id = current["tribe_id"];
            var tribe = "";
            if(tribe_id > 0){
                tribe = GetTribeById(tribe_id);
            }
            var x = current.cssx
            var y = current.cssy
            var info = document.getElementById('info');
            info.style.display = "block";
            info.style.left = x;
            info.style.top = y;

            info.innerHTML = " << " + current.name + " >><br><br>";

            info.innerHTML += current.description;

            var type = parseInt(current["type"]);
            switch (type) {
                case 1: //Tribe
                    info.innerHTML += "<br><br>Tribe: " + tribe.name;
                    break;

                case 2: //Player owned
                    info.innerHTML += "<br><br>Player: " + current.player_name;
                    break;

                case 3: //Lootcrate

                    break;

                default:
                    break;
            }

            info.innerHTML += "<br>Lon: " + current.x  + " : Lat: " + current.y;
        }

        function MarkerOnOut() {
            var info = document.getElementById('info');
            info.style.display = "none";
        }

        $(document).ready(OnLoad());

    </script>
</body>

</html>
