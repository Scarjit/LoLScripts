<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="author" content="S1mpleScripts">
    <title>User Login</title>
    <link href="../.html_files/css/bootstrap.min.css" rel="stylesheet">
    <link href="../.html_files/css/user_signin.css" rel="stylesheet">
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
        </ul>
      </div>
    </div>
  </nav>

    <div class="container">
      <form class="form-signin" action="index.php" method="post">
        <h2 class="form-signin-heading">Please sign in</h2>
        <label for="inputPW" class="sr-only">BoL Name</label>
        <input name="inputPW" type="password" id="inputPW" class="form-control" required autofocus>
        <br>
        <button class="btn btn-lg btn-primary btn-block" type="submit">Sign in</button>
      </form>
    </div>

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
    <script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>
  </body>
</html>
