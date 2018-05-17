package servlet;

import entity.CartProduct;
import util.CartProductManager;
import util.DBManager;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.swing.plaf.nimbus.State;
import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@WebServlet(name = "CheckoutServlet")
public class CheckoutServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String userid = (String) request.getSession().getAttribute("userid");
        double totalPrice = CartProductManager.getTotalPrice();
        String shippingTo = request.getParameter("shippingTo");
        Date date = new Date();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String dateString = sdf.format(date);
        String orderStatus = "Paid";
        List<CartProduct> products = CartProductManager.getCartProducts();
        String orderid="";
        String sql = "";

        Connection connection = DBManager.getConnection();
        try {
            Statement statement = connection.createStatement();
            sql = "INSERT INTO orders(userid,totalprice,shippingto,orderdate,orderstatus) VALUES("+userid+","+totalPrice+",'"+shippingTo+"','"+dateString+"','"+orderStatus+"');";
            int result = statement.executeUpdate(sql);
            if(result<=0){
                response.getWriter().write("false");
                return;
            }
            sql="SELECT orderid FROM orders WHERE userid="+userid+" AND orderdate='"+dateString+"'";
            ResultSet resultSet = statement.executeQuery(sql);
            resultSet.next();
            orderid = resultSet.getString("orderid");
            for (CartProduct cartProduct:products){
                String productColor = cartProduct.getProductColor().equals("null")?"":cartProduct.getProductColor();
                String productSize = cartProduct.getProductSize().equals("null")?"":cartProduct.getProductSize();
                sql = "INSERT INTO order_product(orderid,productid,quantity,selectedcolor,selectedsize) VALUES("+orderid+","+cartProduct.getProductId()+","+cartProduct.getQuantity()+",'"+productColor+"','"+productSize+"');";
                result = statement.executeUpdate(sql);
                if(result<=0){
                    response.getWriter().write("false");
                    return;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.getWriter().write("false");
            return;
        }
        CartProductManager.clear();
        response.getWriter().write(orderid+"-"+totalPrice);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request,response);
    }
}
