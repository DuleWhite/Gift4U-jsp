package util;

import java.sql.*;

public class DBManager {

    private static final String URL = "jdbc:mysql://127.0.0.1:3306/Gift4U?useSSL=false";
    private static final String USERNAME = "root";
    private static final String PASSWORD = "mysqlroot";
    private static Connection connection = null;
    private   Statement statement = null;
    static {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            connection = DriverManager.getConnection(URL,USERNAME,PASSWORD);
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }

    }

    public static Connection getConnection(){
        return connection;
    }

    public static void main(String[] args) throws Exception {

        Statement statement = connection.createStatement();
        ResultSet resultSet = statement.executeQuery("SELECT * FROM products; ");
        while(resultSet.next()){
            System.out.print(resultSet.getInt("productid") + ",");
            System.out.print(resultSet.getString("productdescription"));
            System.out.println();
        }
    }
}
