<%--
  Created by IntelliJ IDEA.
  User: duulewhite
  Date: 5/13/18
  Time: 6:36 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="SHORTCUT ICON" href="../img/logo2.ico" />
    <!-- Bootstrap -->
    <link href="../css/bootstrap.css" rel="stylesheet">
    <!-- JQuery -->
    <script src="../js/jquery-2.1.4.min.js"></script>
    <!-- Bootstrap -->
    <script src="../js/bootstrap.min.js"></script>
    <title>Sign Up | Gift4U</title>
    <link rel="stylesheet" type="text/css" href="../css/font.css">
    <link rel="stylesheet" type="text/css" href="../css/common.css">
    <link rel="stylesheet" type="text/css" href="../css/account.css">
    <script type="text/javascript" src="../js/common.js"></script>
    <script type="text/javascript" src="../js/toast.js"></script>
    <script type="text/javascript" src="../js/account.js"></script>
</head>

<body>
<!-- .logo -->
<div class="logo container">
    <a href="../index.jsp">
        <img src="../img/logo2.jpg" width="120px" height="120px">
    </a>
</div>
<!-- /.logo -->
<!-- .navbar -->
<nav class="navbar navbar-default">
    <div class="container">
        <!-- Brand and toggle get grouped for better mobile display -->
        <div class="navbar-header">
            <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
                <span class="sr-only">Menu</span>
                <span class="icon-bar">M</span>
            </button>
        </div>
        <!-- Collect the nav links, forms, and other content for toggling -->
        <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
            <ul class="nav navbar-nav">
                <li><a href="../index.jsp">Home <span class="sr-only">(current)</span></a></li>
                <li><a href="products.jsp">Products</a></li>
            </ul>
        </div>
        <!-- /.navbar-collapse -->
    </div>
    <!-- /.container -->
</nav>
<!-- /.navbar -->
<!-- .signupin -->
<div class="signupin">
    <div class="panel">
        <h2>Sign up</h2>
        <div class="content">
            <div class="left">
                <img src="../img/logo4.png">
            </div>
            <div class="right">
                <label>Username</label>
                <div>
                    <input id="username" type="text" maxlength=12 minlength=12 name="username">
                </div>
                <label>Phone number</label>
                <div>
                    <input id="phone" type="number" maxlength=11 minlength=11 name="phoneNumber">
                    <button id="getCode1">Send</button>
                </div>
                <label>Verification code</label>
                <div>
                    <input id="code" type="number" maxlength=6 minlength=6 name="verificationCode">
                    <button id="signUp">Sign Up</button>
                </div>
                <span class="hint">hint:</span>
                <span class="have-account">
                        Already have account?  <a href="login.jsp">Login</a>
                    </span>
            </div>
        </div>
    </div>
</div>
<!-- / .signupin -->
<footer>
    <div class="copyright container">
        <p>© 2018 by Gift4U</p>
    </div>
</footer>
</body>

</html>