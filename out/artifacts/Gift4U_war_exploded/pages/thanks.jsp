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
    <title>Thank You | Gift4U</title>
    <link rel="stylesheet" type="text/css" href="../css/font.css">
    <link rel="stylesheet" type="text/css" href="../css/common.css">
    <link rel="stylesheet" type="text/css" href="../css/thanks.css">
    <script type="text/javascript" src="../js/common.js"></script>
</head>

<body>
<%
    String orderId = request.getParameter("orderId");
    String totalPrice = request.getParameter("totalPrice");
    String shippingTo1 = request.getParameter("shippingTo1");
    String shippingTo2 = request.getParameter("shippingTo2");
%>
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
                <li><a href="../index.jsp">Home</a></li>
                <li><a href="products.jsp">Products</a></li>
            </ul>
            <ul class="nav navbar-nav navbar-right">
                <%
                    String username = (String) session.getAttribute("username");
                    String userid = (String) session.getAttribute("userid");
                    if(userid==null||userid.equals("")){
                %>
                <li ><a href="login.jsp">Login</a></li>
                <%
                }
                else{
                %>
                <li class="dropdown">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false"><%=username%><span class="caret"></span></a>
                    <ul class="dropdown-menu">
                        <li><a href="orders.jsp">Orders</a></li>
                        <li><a href="cart.jsp">Cart</a></li>
                        <li role="separator" class="divider"></li>
                        <li><a href="login.jsp">Logout</a></li>
                    </ul>
                </li>
                <%
                    }
                %>
            </ul>
        </div>
        <!-- /.navbar-collapse -->
    </div>
    <!-- /.container -->
</nav>
<!-- /.navbar -->
<div class="thanks">
    <!-- .thanks-header -->
    <div class="thanks-header">
        <h2> Thank you for shopping with us, <%=(String)session.getAttribute("username")%>.</h2>
        <span>Hope to see you again soon!</span>
    </div>
    <!-- /.thanks-header -->
    <!-- .thanks-body -->
    <div class="thanks-body">
        <ul>
            <li>
                <span>Order No.</span>
                <span><%=orderId%></span>
            </li>
            <li>
                <span>Total</span>
                <span>$<%=totalPrice%></span>
            </li>
            <li>
                <span>Shipping to</span>
                <div>
                    <span>Adress</span>
                    <span><%=shippingTo2%></span>
                    <span><%=shippingTo1%></span>
                </div>
            </li>
        </ul>
    </div>
    <!-- /.thanks-body -->
    <!-- .continue-shopping -->
    <div class="continue-shopping">
        <a href="products.jsp">Continue Shopping</a>
    </div>
    <!-- /.continue-shopping -->
</div>
<footer>
    <div class="copyright container">
        <p>© 2018 by Gift4U</p>
    </div>
</footer>
</body>

</html>