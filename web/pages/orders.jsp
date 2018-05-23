<%@ page import="java.sql.Connection" %>
<%@ page import="util.DBManager" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="entity.Product" %>
<%@ page import="util.ProductsManager" %><%--
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
    <title>Orders | Gift4U</title>
    <link rel="stylesheet" type="text/css" href="../css/font.css">
    <link rel="stylesheet" type="text/css" href="../css/common.css">
    <link rel="stylesheet" type="text/css" href="../css/orders.css">
    <script type="text/javascript" src="../js/common.js"></script>
    <script type="text/javascript" src="../js/toast.js"></script>
    <script type="text/javascript" src="../js/orders.js"></script>
</head>
<%
    String prevPage = (String) session.getAttribute("prevpage");
    prevPage = prevPage.split("-")[0] + "-orders";
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
<div class="orders-body">
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
        <button id="btn-confirm-all" class="btn-confirm-all">
            <span>Confirm All</span>
        </button>
    </div>
    <!-- /.continue-shopping -->
    <!-- .order-list -->
    <%
        Connection connection = DBManager.getConnection();
        Statement statement = null;
        try {
            statement = connection.createStatement();
            ResultSet resultSet = statement.executeQuery("SELECT * FROM orders WHERE userid='"+userid+"'");
            int count = 0 ;
            while(resultSet.next()){
                count++;
            }
    %>
    <div class="order-list">
        <div class="list-title">
            <h2>My Orders</h2>
            <span>(<%=count%>)</span>
        </div>
        <!-- .empty-cart -->
        <%
            if(count==0){
        %>
        <div class="no-order" style="display: block;">
        <%
            }
            else{
        %>
        <div class="no-order" style="display: none">
        <%
            }
        %>
            <span>No order</span>
            <div>
                <a href="products.jsp">Continue Shopping</a>
            </div>
        </div>
        <!-- /.empty-cart -->
        <%
            if(count>0){
                resultSet = statement.executeQuery("SELECT * FROM orders WHERE userid='"+userid+"' ORDER BY orderdate DESC;");
        %>
        <div class="list-body">
            <%
                while(resultSet.next()){
                    String orderid = resultSet.getString("orderid");
                    String orderDate = resultSet.getString("orderdate");
                    String totalPrice = resultSet.getString("totalprice");
                    String shippingTo = resultSet.getString("shippingto");
                    String orderStatus = resultSet.getString("orderstatus");
                    String orderNote = resultSet.getString("ordernote");
            %>
            <div class="item">
                <div class="item-left">
                    <h3>Order No.: <%=orderid%></h3>
                    <div class="order-property">
                        <span>Order date: <%=orderDate%></span>
                        <span>Total: $<%=totalPrice%></span>
                        <span>Shipping to: <%=shippingTo%></span>
                        <span>Status: <%=orderStatus%></span>
                        <%
                            if(orderNote!=null && !orderNote.equals("")){
                        %>
                        <span>Note: <%=orderNote%></span>
                        <%
                            }
                        %>
                    </div>
                    <%
                        if(orderStatus.equals("Delivery")){
                    %>
                    <button class="btn-confirm">
                        <span>Confirm receipt</span>
                    </button>
                    <%
                        }
                    %>
                </div>
                <div class="item-right">
                <%
                    Statement statement1 = connection.createStatement();
                    ResultSet resultSet1 = statement1.executeQuery("SELECT * FROM order_product WHERE orderid = '"+orderid+"'");
                    while(resultSet1.next()){
                        String productId = resultSet1.getString("productid");
                        String quantity = resultSet1.getString("quantity");
                        String color = resultSet1.getString("selectedcolor");
                        String size = resultSet1.getString("selectedsize");
                        Product product = ProductsManager.getProductById(Integer.parseInt(productId));
                %>
                    <div class="products-in-order">
                        <a class="item-picture-preview" href="product.jsp?id=<%=productId%>">
                            <img src="../img/<%=product.getProductImages()[0]%>">
                        </a>
                        <div class="item-info">
                            <h3><%=product.getProductName()%></h3>
                            <div class="item-property">
                                <span>PID: <%=productId%></span>
                                <span>Price: $<%=product.getProductPrice()%></span>
                                <%
                                    if(color!=null&&!color.equals("")){
                                %>
                                <span>Color: <%=color%></span>
                                <%
                                    }
                                    if(size!=null&&!size.equals("")){
                                        System.out.println(size);
                                %>
                                <span>Size: <%=size%></span>
                                <%
                                    }
                                %>
                                <span>Quantity: <%=quantity%></span>
                            </div>
                        </div>
                    </div>
                    <%
                        }
                    %>
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
    <%
        } catch (SQLException e) {
            e.printStackTrace();
        }
    %>
    <!-- /.order-list -->
</div>
<footer>
    <div class="copyright container">
        <p>© 2018 by Gift4U</p>
    </div>
</footer>
</body>

</html>