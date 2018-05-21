package util;

import java.sql.*;
import java.util.ArrayList;

import com.alibaba.fastjson.JSON;
import entity.Product;

public class ProductsManager {
    private ProductsManager(){

    }

    public static ArrayList<Product> getProducts() throws SQLException {
        ArrayList<Product> products = new ArrayList<>();
        Connection connection = DBManager.getConnection();
        if (connection != null) {
            Statement statement = connection.createStatement();
            ResultSet resultSet = statement.executeQuery("SELECT * FROM products;");
            while (resultSet.next()) {
                Product product = getProductFromResultSet(resultSet);
                products.add(product);
            }
            return products;
        }
        else return null;
    }

    public static Product getProductById(int productid) throws SQLException{
        Product product = null;
        Connection connection = DBManager.getConnection();
        Statement statement = connection.createStatement();
        ResultSet resultSet = statement.executeQuery("SELECT * FROM products WHERE productid=" + productid + ";");
        if(resultSet.next())
            product = getProductFromResultSet(resultSet);
        return product;
    }

    private static Product getProductFromResultSet(ResultSet resultSet) throws SQLException {
        Product product = new Product();
        product.setProductId(resultSet.getInt("productid"));
        product.setProductName(resultSet.getString("productname"));
        String imageName = resultSet.getString("productimgname");
        int imageCount = resultSet.getInt("productimgcount");
        String imageFormat = resultSet.getString("productimgformat");
        String[] strings = new String[imageCount];
        for (int i = 1 ; i <= imageCount ; i ++) {
            strings[i-1] = imageName + "-" + i + "-s." + imageFormat;
        }
        product.setProductImages(strings);
        product.setProductPrice(resultSet.getDouble("productprice"));
        String colorString = resultSet.getString("productcolor");
        if(colorString!=null && !colorString.equals("")){
            product.setProductColors(colorString.split(","));
        }
        String sizeString = resultSet.getString("productsize");
        if (sizeString!=null && !sizeString.equals(""))
            product.setProductSizes(sizeString.split(","));
        product.setProductDescription(resultSet.getString("productdescription"));
        product.setProductInfo(resultSet.getString("productinfo"));
        product.setProductReturnAndRefeundPolicy(resultSet.getString("productreturn_refeundpolicy"));
        product.setProductShippingInfo(resultSet.getString("productshippinginfo"));
        String tagString = resultSet.getString("producttag");
        if (tagString!=null && !tagString.equals(""))
            product.setProductTag(tagString);
        return product;
    }

    public static void main(String[] args) {
        try {
            ArrayList<Product> products = getProducts();
            for (Product p : products){
                System.out.println(p.toString());
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
