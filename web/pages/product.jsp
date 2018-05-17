<%@ page import="entity.Product" %>
<%@ page import="util.ProductsManager" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.util.List" %><%--
  Created by IntelliJ IDEA.
  User: duulewhite
  Date: 5/13/18
  Time: 6:35 AM
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
    <!-- magicZoom -->
    <script type="text/javascript" src="../js/magicZoom.js"></script>
    <title>I'm a product | Gift4U</title>
    <link rel="stylesheet" type="text/css" href="../css/font.css">
    <link rel="stylesheet" type="text/css" href="../css/common.css">
    <link rel="stylesheet" type="text/css" href="../css/productDetails.css">
    <link rel="stylesheet" type="text/css" href="../css/product.css">
    <script type="text/javascript" src="../js/common.js"></script>
    <script type="text/javascript" src="../js/toast.js"></script>
    <script type="text/javascript" src="../js/productDetails.js"></script>
    <script type="text/javascript" src="../js/product.js"></script>
</head>

<body>
<%
    try {
        Product p = ProductsManager.getProductById(Integer.parseInt(request.getParameter("id")));
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
<!-- .navigation -->
<div class="navigation container">
    <ul>
        <li><a href="../index.jsp">Home</a></li>
        <li><a style="opacity: .5">I'm a product</a></li>
    </ul>
</div>
<!-- /.navigation -->
<!-- .product-details -->
<%
    String[] imagePaths = p.getProductImages();
    String tag = p.getProductTag();
%>
<div class="product-details">
    <div class="product-details-right">
        <div class="product-picture">
            <i class="zoom-hint"></i>
            <img id="zoom-img" src="../img/<%=imagePaths[0]%>">
        </div>
        <div class="product-picture-guide">
            <img class="guide-img selected" src="../img/<%=imagePaths[0]%>">
            <%
                for (int i =1; i < imagePaths.length; i++){
            %>
            <img class="guide-img" src="../img/<%=imagePaths[i]%>">
            <%
                }
            %>
        </div>
        <div class="product-description">
            <p><%=p.getProductDescription()%></p>
        </div>
    </div>
    <div class="product-details-left">
        <div class="product-name">
            <h1><%=p.getProductName()%></h1>
        </div>
        <div class="product-price">
            <h3>$<%=p.getProductPrice()%></h3>
        </div>
        <%
            String[] colors = p.getProductColors();
            if(colors!=null && colors.length>0){
        %>
        <div class="color">
            <h4>Color</h4>
            <div id="color-tip" class="tooltip right" role="tooltip">
                <div class="tooltip-arrow"></div>
                <div class="tooltip-inner">
                    Select-color
                </div>
            </div>
            <ul>
                <%
                    for (String color : colors) {
                %>
                <li>
                    <div class="color-label" style="background-color: <%=color%>;" id="<%=color%>"></div>
                </li>
                <%
                    }
                %>
            </ul>
        </div>
        <%
            }
            String[] sizes = p.getProductSizes();
            if(sizes!=null && sizes.length>0){
        %>
        <div id="size">
            <h4>Size</h4>
            <div id="selected-size">
                <span><%=sizes[0]%></span>
                <b></b>
            </div>
            <div id="size-list">
                <ul>
                    <%
                        for (String size : sizes) {
                    %>
                    <li><span><%=size%></span></li>
                    <%
                        }
                    %>
                </ul>
            </div>
        </div>
        <%
            }
        %>
        <div class="quantity">
            <h4>Quantity</h4>
            <input id="quantity-input" type="number" name="quantity" min=1>
        </div>
        <span style="display: none">id=<%=p.getProductId()%></span>
        <button id="btn-add-to-cart" class="gift4u-button" data-loading-text="ADDING..." autocomplete="off">ADD TO CART</button>
        <div id="add-success" class="alert alert-success fade in" style="display: none;">
            <button type="button" class="close">
                &times;
            </button>
            <p>Add Successfully!</p>
        </div>
        <ul class="product-parameters">
            <li>
                <button><h3 class="on">PRODUCT INFO</h3></button>
                <p><%=p.getProductInfo()%></p>
            </li>
            <li>
                <button><h3 class="off">RETURN & REFUND POLICY</h3></button>
                <p><%=p.getProductReturnAndRefeundPolicy()%></p>
            </li>
            <li>
                <button><h3 class="off">SHIPPING INFO</h3></button>
                <p><%=p.getProductShippingInfo()%></p>
            </li>
        </ul>
    </div>
</div>
<%
    } catch (SQLException e) {
        e.printStackTrace();
    }
%>
<!-- /.product-details -->
<footer>
    <div class="copyright container">
        <p>© 2018 by Gift4U</p>
    </div>
</footer>
</body>

</html>