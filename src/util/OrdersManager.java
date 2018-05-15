package util;

import entity.Order;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class OrdersManager {
    private OrdersManager(){

    }

    public static ArrayList<Order> getOrdersById(int userid) throws SQLException {
        ArrayList<Order> orders = new ArrayList<>();
        Connection connection = DBManager.getConnection();
        Statement statement = connection.createStatement();
        ResultSet resultSet = statement.executeQuery("SELECT * FROM orders WHERE userid = " + userid + ";" );
        while (resultSet.next()){
            Order order = new Order();
            order.setOrderId(resultSet.getInt("orderid"));
            Statement statement1 = connection.createStatement();
            ResultSet resultSet1 = statement1.executeQuery("SELECT * FROM order_product WHERE orderid="+order.getOrderId()+";" );
            List<Order.ProductParam> products = new ArrayList<>();
            while (resultSet1.next()){
                Order.ProductParam productParam = new Order.ProductParam();
                productParam.quantity = resultSet1.getInt("quantity");
                productParam.selectedColor = resultSet1.getString("selectedcolor");
                productParam.selectedSize = resultSet1.getString("selectedsize");
                products.add(productParam);
            }
            order.setProducts(products);
            order.setTotalPrice(resultSet.getDouble("totalprice"));
            order.setShippingTo(resultSet.getString("shippingto"));
            order.setOrderDate(resultSet.getDate("orderDate"));
            order.setOrderStatus(resultSet.getString("orderstatus"));
            orders.add(order);
        }
        return orders;
    }

//    public static void main(String[] args) {
//        try {
//            ArrayList<Order> orders = getOrdersById(10000000);
//            for (Order o:orders) {
//                System.out.print(o.getOrderId()+", ");
//                System.out.print(o.getTotalPrice()+", ");
//                System.out.print(o.getShippingTo()+", ");
//                System.out.print(o.getOrderDate()+", ");
//                List<Order.ProductParam> products = o.getProducts();
//                System.out.print("[ ");
//                for (Order.ProductParam product : products ){
//                    System.out.print("{ ");
//                    System.out.print(product.quantity+", ");
//                    System.out.print(product.selectedColor+", ");
//                    System.out.print(product.selectedSize+", ");
//                    System.out.print("}, ");
//                }
//                System.out.print("], ");
//                System.out.print(o.getOrderStatus()+", ");
//                System.out.println();
//            }
//        } catch (SQLException e) {
//            e.printStackTrace();
//        }
//    }
}