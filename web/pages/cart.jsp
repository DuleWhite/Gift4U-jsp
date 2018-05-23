<%@ page import="java.util.Dictionary" %>
<%@ page import="entity.Product" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="util.ProductsManager" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="util.CartProductManager" %>
<%@ page import="java.util.List" %>
<%@ page import="entity.CartProduct" %><%--
  Created by IntelliJ IDEA.
  User: duulewhite
  Date: 5/13/18
  Time: 6:18 AM
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
    <!-- distpicker -->
    <script type="text/javascript" src="../js/distpicker.min.js"></script>
    <title>Cart | Gift4U</title>
    <link rel="stylesheet" type="text/css" href="../css/font.css">
    <link rel="stylesheet" type="text/css" href="../css/common.css">
    <link rel="stylesheet" type="text/css" href="../css/cart.css">
    <script type="text/javascript" src="../js/common.js"></script>
    <script type="text/javascript" src="../js/toast.js"></script>
    <script type="text/javascript" src="../js/cart.js"></script>
    <!-- distpicker : https://github.com/fengyuanchen/distpicker -->
</head>
<%
    String prevPage = (String) session.getAttribute("prevpage");
    prevPage = prevPage.split("-")[0] + "-cart";
    session.setAttribute("prevpage",prevPage);
%>
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
<!-- .cart-list -->
<div class="cart-list">
    <%
        String cartProductsString = (String) session.getAttribute("cartProducts");
        try {
            if(cartProductsString!=null&&!cartProductsString.equals(""))
                CartProductManager.updateCartProducts(cartProductsString);
            List<CartProduct> cartProducts = CartProductManager.getCartProducts();
            session.removeAttribute("cartProducts");
            //session.setAttribute("cartProducts",CartProductManager.getLastesCartProductsString());
        } catch (SQLException e) {
            e.printStackTrace();
        }
        List<CartProduct> cartProducts = CartProductManager.getCartProducts();
    %>
    <!-- .continue-shopping -->
    <div class="continue-shopping">
        <a href="products.jsp">
                <span>
                    <svg width="1em" height="1em" viewBox="0 0 7 12">
                        <g>
                            <path d="M6.572 1.354L5.865.646.293 6.218l5.585 5.585.707-.707-4.878-4.878z" fill="currentColor" fill-rule="nonzero"></path>
                        </g>
                    </svg>
                </span>Continue Shopping</a>
        <%
            if(CartProductManager.getCount()>0){
        %>
        <button class="checkout">
                <span>
                    <svg width="1em" height="1em" viewBox="0 0 11 14">
                        <g>
                            <g fill="currentColor" fill-rule="evenodd">
                                <path d="M0 12.79c0 .558.445 1.01.996 1.01h9.008A1 1 0 0 0 11 12.79V6.01c0-.558-.445-1.01-.996-1.01H.996A1 1 0 0 0 0 6.01v6.78z"></path>
                                <path d="M9.5 5v-.924C9.5 2.086 7.696.5 5.5.5c-2.196 0-4 1.586-4 3.576V5h1v-.924c0-1.407 1.33-2.576 3-2.576s3 1.17 3 2.576V5h1z" fill-rule="nonzero"></path>
                            </g>
                        </g>
                    </svg>
                    Checkout
                </span>
        </button>
        <%
            }
        %>
    </div>
    <!-- /.continue-shopping -->
    <!-- .item-list -->
    <div class="item-list">
        <div class="list-header">
            <div class="list-title">
                <h2>My Cart</h2>
                <%if(CartProductManager.getCount()>0){%>
                <span>(<%=CartProductManager.getCount()%>)</span>
                <%}%>
            </div>
            <%if(CartProductManager.getCount()>0){%>
            <div class="list-parameters">
                <div>Price</div>
                <div>Qty</div>
                <div class="item-total">Total</div>
            </div>
            <%}%>
        </div>
        <!-- .empty-cart -->
        <%
            String emptyCartDisplay;
            if(CartProductManager.getCount()==0) emptyCartDisplay = "block";
            else emptyCartDisplay = "none";
        %>
        <div class="empty-cart" style="display: <%=emptyCartDisplay%>;">
            <span>Cart is empty</span>
            <div>
                <a href="products.jsp">Continue Shopping</a>
            </div>
        </div>
        <!-- /.empty-cart -->
        <%
            if(CartProductManager.getCount()>0){
        %>
        <div class="list-body">
            <%
                for(CartProduct cp : cartProducts){
            %>
            <div class="item">
                <div class="item-left">
                    <a class="item-picture-preview" href="product.jsp?id=<%=cp.getProductId()%>">
                        <img src="../img/<%=cp.getProductImages()[0]%>">
                    </a>
                    <div class="item-info">
                        <h3><%=cp.getProductName()%></h3>
                        <div class="item-property">
                            <span>PID: <%=cp.getProductId()%></span>
                            <%
                                if(cp.hasColor()){%>
                            <span>Color: <%=cp.getProductColor()%></span>
                            <%
                                }
                                if(cp.hasSize()){
                            %>
                            <span>Size: <%=cp.getProductSize()%></span>
                            <%}%>
                            <span>$<%=cp.getProductPrice()%></span>
                        </div>
                        <button class="btn-remove">
                            <span>Remove</span>
                        </button>
                    </div>
                </div>
                <div class="item-right">
                    <div><span>$<%=cp.getProductPrice()%></span></div>
                    <div>
                        <div class="input-group input-postfix">
                            <input class="quantity-input" type="number" name="quantity" min="1" value="<%=cp.getQuantity()%>">
                            <div class="spinner-arrows">
                                <span class="up-arrow glyphicon-arrow_up" role="button"></span>
                                <span class="down-arrow glyphicon-arrow_down" role="button"></span>
                            </div>
                        </div>
                    </div>
                    <div class="item-total"><span>$<%=cp.getProductPrice()*cp.getQuantity()%></span></div>
                </div>
            </div>
            <%
                }
            %>
        </div>
        <%
            }
        %>
    </div>
    <!-- /.item-list -->
    <!-- .summary -->
    <%
        if(CartProductManager.getCount()>0){
    %>
    <div class="summary">
        <div class="summary-left">
            <button class="btn-add-note">
                <svg width="1em" height="1em" viewBox="0 0 12 13">
                    <g>
                        <g fill="none" fill-rule="evenodd">
                            <path d="M.5.5h7.778L11.5 3.737V12.5H.5V.5z" stroke="currentColor"></path>
                            <path d="M10.793 3.5H8.5V1.207L10.793 3.5z" stroke="currentColor"></path>
                            <path fill="currentColor" d="M3 3h3v1H3zM3 6h6v1H3zM3 9h6v1H3z"></path>
                        </g>
                    </g>
                </svg>
                <span>Add a note</span>
            </button>
            <div id="cart-note" class="cart-note">
                <textarea maxlength="250" class="_32uvq" placeholder="Instructions? Special requests? Add them here." aria-label="Instructions? Special requests? Add them here."></textarea>
            </div>
            <div class="secure-shopping">
                <img src="../img/secure-shopping.png">
            </div>
        </div>
        <div class="summary-right">
            <div class="summary-list">
                <div class="summary-item">
                    <dl>
                        <div class="summary-item-subtotal">
                            <dt>Subtotal</dt>
                            <dd id="subtotal">$<%=CartProductManager.getTotalPrice()%></dd>
                        </div>
                        <div class="summary-item-shipping">
                            <dt>
                                <div>
                                    <span>Shipping</span>
                                    <div>
                                        <button id="shipping-dist">Inner Mongolia, Hohhot, Saihan</button>
                                    </div>
                                </div>
                            </dt>
                            <dd>FREE</dd>
                        </div>
                    </dl>
                </div>
                <div class="summary-total">
                    <dl>
                        <dt>Total</dt>
                        <dd id="total-price">$<%=CartProductManager.getTotalPrice()%></dd>
                    </dl>
                </div>
            </div>
            <button class="checkout">
                    <span>
                        <svg width="1em" height="1em" viewBox="0 0 11 14">
                            <g>
                                <g fill="currentColor" fill-rule="evenodd">
                                    <path d="M0 12.79c0 .558.445 1.01.996 1.01h9.008A1 1 0 0 0 11 12.79V6.01c0-.558-.445-1.01-.996-1.01H.996A1 1 0 0 0 0 6.01v6.78z"></path>
                                    <path d="M9.5 5v-.924C9.5 2.086 7.696.5 5.5.5c-2.196 0-4 1.586-4 3.576V5h1v-.924c0-1.407 1.33-2.576 3-2.576s3 1.17 3 2.576V5h1z" fill-rule="nonzero"></path>
                                </g>
                            </g>
                        </svg>
                        Checkout
                    </span>
            </button>
        </div>
    </div>
    <%
        }
    %>
    <!-- .summary -->
</div>
<!-- /.cart-list -->
<footer>
    <div class="copyright container">
        <p>©️ 2018 by Gift4U</p>
    </div>
</footer>
<!-- .distpicker -->
<div id="distpicker" class="distpicker artModal fade">
    <div class="artModal-dialog">
        <button class="btn-close" data-dismiss="artModal">x</button>
        <div class="artModal-content" data-toggle="distpicker">
            <h3>Select Destination</h3>
            <label>Province</label>
            <select id="select-province" data-province="Inner Mongolia"></select>
            <label>City</label>
            <select id="select-city" data-city="Hohhot"></select>
            <label>Area</label>
            <select id="select-area" data-district="Saihan"></select>
            <button id="btn-update" class="btn-update">Update</button>
        </div>
    </div>
</div>
<!-- /.distpicker -->
</body>

</html>