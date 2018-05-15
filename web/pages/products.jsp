<%@ page import="util.ProductsManager" %>
<%@ page import="entity.Product" %>
<%@ page import="java.util.List" %>
<%@ page import="java.sql.SQLException" %><%--
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
    <!-- artModal -->
    <link rel="stylesheet" type="text/css" href="../css/artModal.css">
    <!-- JQuery -->
    <script src="../js/jquery-2.1.4.min.js"></script>
    <!-- Bootstrap -->
    <script src="../js/bootstrap.min.js"></script>
    <!-- artModal -->
    <script type="text/javascript" src="../js/artModal.js"></script>
    <!-- magicZoom -->
    <script type="text/javascript" src="../js/magicZoom.js"></script>
    <title>Products | Gift4U</title>
    <link rel="stylesheet" type="text/css" href="../css/font.css">
    <link rel="stylesheet" type="text/css" href="../css/common.css">
    <link rel="stylesheet" type="text/css" href="../css/productDetails.css">
    <link rel="stylesheet" type="text/css" href="../css/products.css">
    <script type="text/javascript" src="../js/common.js"></script>
    <script type="text/javascript" src="../js/productDetails.js"></script>
    <script type="text/javascript" src="../js/products.js"></script>
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
                <li class="active"><a>Products</a></li>
            </ul>
            <ul class="nav navbar-nav navbar-right">
                <li class="hidden"><a href="login.jsp">Login</a></li>
                <li class="dropdown">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Dule<span class="caret"></span></a>
                    <ul class="dropdown-menu">
                        <li><a href="orders.jsp">Orders</a></li>
                        <li><a href="cart.jsp">Cart</a></li>
                        <li role="separator" class="divider"></li>
                        <li><a href="login.jsp">Logout</a></li>
                    </ul>
                </li>
            </ul>
        </div>
        <!-- /.navbar-collapse -->
    </div>
    <!-- /.container -->
</nav>
<!-- /.navbar -->
<!-- .list -->
<div class="list container row">
    <%
        try {
            List<Product> products = ProductsManager.getProducts();
            for (Product p : products){
                String[] imagePaths = p.getProductImages();
                String tag = p.getProductTag();
    %>
    <div class="product-item col-lg-3 col-md-4 col-sm-6 col-xs-12">
        <span style="display: none; ">id=<%=p.getProductId()%></span>
        <div class="product-panel">
            <div class="image">
                <a href="product.jsp?id=<%=p.getProductId()%>">
                    <img src="../img/<%=imagePaths[0]%>">
                </a>
                <%
                    if(tag!=null && tag!=""){
                %>
                <span class="product-tag"><%=tag%></span>
                <%
                    }
                %>
                <button class="product-qwbtn">QUICK VIEW</button>
            </div>
            <a href="product.jsp">
                <div class="product-info" class="container">
                    <h3><%=p.getProductName()%></h3>
                    <h5>$<%=p.getProductPrice()%></h5>
                </div>
            </a>
        </div>
    </div>
    <%
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    %>
</div>
<!-- /.list -->
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
                        <img id="zoom-img" src="../img/product-1-1-s.jpg">
                    </div>
                    <div id="modal-productImages" class="product-picture-guide">
                        <img class="guide-img selected" src="../img/product-1-1-s.jpg">
                        <img class="guide-img" src="../img/product-1-2-s.jpg">
                    </div>
                </div>
                <div class="product-details-left">
                    <div class="product-name">
                        <h1 id="modal-productName">I'm a Product</h1>
                    </div>
                    <div class="product-price">
                        <h3 id="modal-productPrice">$88.88</h3>
                    </div>
                    <a>View Full Details</a>
                    <div class="color" id="modal-color">
                        <h4>Color</h4>
                        <div id="color-tip" class="tooltip right" role="tooltip">
                            <div class="tooltip-arrow"></div>
                            <div class="tooltip-inner">
                                Select-color
                            </div>
                        </div>
                        <ul>
                            <li>
                                <div class="color-label" style="background-color: rgb(0,0,0);"></div>
                            </li>
                            <li>
                                <div class="color-label" style="background-color: Brown;"></div>
                            </li>`
                        </ul>
                    </div>
                    <div id="size">
                        <h4>Size</h4>
                        <div id="selected-size">
                            <span>Small</span>
                            <b></b>
                        </div>
                        <div id="size-list">
                            <ul>
                                <li><span>Small</span></li>
                                <li><span>Medium</span></li>
                                <li><span>Large</span></li>
                            </ul>
                        </div>
                    </div>
                    <div class="quantity">
                        <h4>Quantity</h4>
                        <input id="quantity-input" type="number" name="quantity" min=1>
                    </div>
                    <span style="display: none;" id="modal-productId"></span>
                    <button id="btn-add-to-cart" class="gift4u-button" data-loading-text="ADDING..." autocomplete="off">ADD TO CART</button>
                    <div id="add-success" class="alert alert-success fade in" style="display: none;">
                        <button type="button" class="close">
                            &times;
                        </button>
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