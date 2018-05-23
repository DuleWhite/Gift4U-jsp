<%@ page import="entity.Product" %>
<%@ page import="util.ProductsManager" %>
<%@ page import="java.util.List" %>
<%@ page import="java.sql.SQLException" %><%--
  Created by IntelliJ IDEA.
  User: duulewhite
  Date: 5/12/18
  Time: 7:00 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="SHORTCUT ICON" href="img/logo2.ico" />
  <!-- Bootstrap -->
  <link href="css/bootstrap.css" rel="stylesheet">
  <!-- Slick -->
  <link rel="stylesheet" type="text/css" href="css/slick.css" />
  <link rel="stylesheet" type="text/css" href="css/slick-theme.css" />
  <!-- artModal -->
  <link rel="stylesheet" type="text/css" href="css/artModal.css">
  <!-- JQuery -->
  <script src="js/jquery-2.1.4.min.js"></script>
  <!-- Bootstrap -->
  <script src="js/bootstrap.min.js"></script>
  <!-- Slick -->
  <script type="text/javascript" src="js/slick.js"></script>
  <!-- artModal -->
  <script type="text/javascript" src="js/artModal.js"></script>
  <!-- magicZoom -->
  <script type="text/javascript" src="js/magicZoom.js"></script>
  <title>Home | Gift4U</title>
  <link rel="stylesheet" type="text/css" href="css/font.css">
  <link rel="stylesheet" type="text/css" href="css/common.css">
  <link rel="stylesheet" type="text/css" href="css/productDetails.css">
  <link rel="stylesheet" type="text/css" href="css/style.css">
  <script type="text/javascript" src="js/common.js"></script>
  <script type="text/javascript" src="js/toast.js"></script>
  <script type="text/javascript" src="js/productDetails.js"></script>
  <script type="text/javascript" src="js/script.js"></script>
</head>

<body>
<%
  session.setAttribute("prevpage","index");
%>
<!-- .logo -->
<div class="logo container">
  <a href="index.jsp">
    <img src="img/logo2.jpg" width="120px" height="120px">
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
        <li class="active"><a>Home</a></li>
        <li><a href="pages/products.jsp">Products</a></li>
      </ul>
      <ul class="nav navbar-nav navbar-right">
        <%
          String username = (String) session.getAttribute("username");
          String userid = (String) session.getAttribute("userid");
          if(userid==null||userid.equals("")){
        %>
        <li ><a href="pages/login.jsp">Login</a></li>
        <%
          }
          else{
        %>
        <li class="dropdown">
          <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false"><%=username%><span class="caret"></span></a>
          <ul class="dropdown-menu">
            <li><a href="pages/orders.jsp">Orders</a></li>
            <li><a href="pages/cart.jsp">Cart</a></li>
            <li role="separator" class="divider"></li>
            <li><a href="pages/login.jsp">Logout</a></li>
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
<!-- .carousel -->
<div id="carousel-example-generic" class="carousel slide" data-ride="carousel">
  <!-- Indicators -->
  <ol class="carousel-indicators">
    <li data-target="#carousel-example-generic" data-slide-to="0" class="active"></li>
    <li data-target="#carousel-example-generic" data-slide-to="1"></li>
    <li data-target="#carousel-example-generic" data-slide-to="2"></li>
  </ol>
  <!-- Wrapper for slides -->
  <div class="carousel-inner" role="listbox">
    <h1>4 SOMEONE YOU LOVE MOST</h1>
    <div class="item active">
      <img src="img/banner1.jpg" alt="banner1">
    </div>
    <div class="item">
      <img src="img/banner2.jpg" alt="banner2">
    </div>
    <div class="item">
      <img src="img/banner3.jpg" alt="banner2">
    </div>
  </div>
</div>
<!-- /.carousel -->
<!-- .minigallery -->
<div class="slick container">
    <%
        List<Product> products = null;
        try {
            products = ProductsManager.getProducts();
            for (Product p : products) {
                if(p.getProductTag()!=null && p.getProductTag()!=""){
                    String[] productImages = p.getProductImages();
    %>
    <div class="product-item">
        <span style="display: none; ">id=<%=p.getProductId()%></span>
        <div class="product-panel">
            <div class="image">
                <a href="pages/product.jsp?id=<%=p.getProductId()%>">
                    <img src="img/<%=productImages[0]%>">
                </a>
                <span class="product-tag"><%=p.getProductTag()%></span>
                <button class="product-qwbtn">QUICK VIEW</button>
            </div>
            <a href="pages/product.jsp?id=<%=p.getProductId()%>">
                <div class="product-info" class="container">
                    <h3><%=p.getProductName()%></h3>
                    <div class="dividers">
                        <hr />
                    </div>
                    <h5>$<%=p.getProductPrice()%></h5>
                </div>
            </a>
        </div>
    </div>
    <%
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    %>
</div>
<!-- /.minigallery -->
<!-- .faq -->
<div class="faq" class="container">
  <img src="img/banner8.png" alt="">
  <h2>EXQUISITE GIFT BOX</h2>
  <p>
    For each special gift we carefully selected the perfect gift box for it. Not only can you express your love for your friends or loved ones, but it can also make your gift more loving.
  </p>
</div>
<!-- /.faq -->
<!-- .aboutus -->
<div class="aboutus">
  <div class="cd-fixed-bg cd-bg-1">
    <div class="rect">
      <h1>ABOUT GIFT4U</h1>
    </div>
  </div>
  <div class="cd-scrolling-bg cd-color-1">
    <div class="cd-container">
      <p>Our Online Gift Store was founded by like-minded shopaholics, a group of professionals dedicated to building innovative, smart and easy online shopping solutions. At Gift4U, we guarantee that every single purchase you make will be a seamless process from start to finish. Take a look at our store and get in touch with questions or concerns.</p>
    </div>
  </div>
</div>
<!-- /.aboutus -->
<footer>
  <div class="copyright container">
    <p>© 2018 by Gift4U</p>
  </div>
</footer>
<!-- .product-quick-view-modal -->
<div class="product-quick-view-modal artModal fade" id="product-quick-view-modal">
  <div class="artModal-dialog">
    <button class="btn-close" data-dismiss="artModal">x</button>
    <div class="artModal-content">
      <div class="product-details modal-body">
        <div class="product-details-right">
          <div class="product-picture">
            <i class="zoom-hint"></i>
            <img id="zoom-img" src="img/product-1-1-s.jpg">
          </div>
          <div id="productImages" class="product-picture-guide">
          </div>
        </div>
        <div class="product-details-left">
          <div class="product-name">
            <h1 id="productName"></h1>
          </div>
          <div class="product-price">
            <h3 id="productPrice"></h3>
          </div>
          <a>View Full Details</a>
          <div class="color" id="color">
            <h4>Color</h4>
            <div id="color-tip" class="tooltip right" role="tooltip">
              <div class="tooltip-arrow"></div>
              <div class="tooltip-inner">Select-color</div>
            </div>
            <ul></ul>
          </div>
          <div id="size">
            <h4>Size</h4>
            <div id="selected-size">
              <span></span>
              <b></b>
            </div>
            <div id="size-list">
              <ul></ul>
            </div>
          </div>
          <div class="quantity">
            <h4>Quantity</h4>
              <div class="input-group input-postfix">
                <input id="quantity-input" type="number" name="quantity" min=1>
                <div class="spinner-arrows">
                    <span id="up-arrow" class="up-arrow glyphicon-arrow_up" role="button"></span>
                    <span id="down-arrow" class="down-arrow glyphicon-arrow_down" role="button"></span>
                </div>
              </div>
          </div>
          <span style="display: none;" id="productId"></span>
          <button id="btn-add-to-cart" class="gift4u-button" data-loading-text="ADDING..." autocomplete="off">ADD TO CART</button>
          <div id="add-success" class="alert alert-success fade in" style="display: none;">
            <button type="button" class="close">&times;</button>
            <p>Add Successfully!</p>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>
<!-- /.product-quick-view-modal -->
</body>

</html>
