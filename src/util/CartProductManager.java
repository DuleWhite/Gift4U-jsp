package util;

import entity.CartProduct;
import entity.Product;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class CartProductManager {
    private static List<CartProduct> cartProducts;
    static {
        totalPrice=0;
        count=0;
        cartProducts = new ArrayList<>();

    }
    private static double totalPrice;

    public static double getTotalPrice() {
        return totalPrice;
    }

    public static void setTotalPrice(double totalPrice) {
        CartProductManager.totalPrice = totalPrice;
    }

    public static int getCount() {
        return count;
    }

    public static void setCount(int count) {
        CartProductManager.count = count;
    }

    private static int count;

    public CartProductManager() {

    }

    public static void updateCartProducts(String cartProductsString) throws SQLException {
        clear();
        System.out.println("updateCartProducts received ;"+cartProductsString);
        String[] cartProductsArray = new String[0];
        if (cartProductsString != null && !cartProductsString.equals("")) {
            cartProductsArray = cartProductsString.split(",");
        }
        System.out.println("updateCartProducts: after split: ");
        for (String str: cartProductsArray){
            System.out.print(str+",");
        }
        System.out.println();
        for (String cp : cartProductsArray){
            String[] cartProductDetails = cp.split("-");
            addProduct(Integer.parseInt(cartProductDetails[0]),cartProductDetails[1],cartProductDetails[2],Integer.parseInt(cartProductDetails[3]));
        }
    }
    public static String getLastesCartProductsString(){
        String ret = "" ;
        for (CartProduct cp : cartProducts){
            String str = "";
            str += String.valueOf(cp.getProductId());
            str += "-";
            str += cp.getProductColor();
            str += "-";
            str += cp.getProductSize();
            str += "-";
            str += String.valueOf(cp.getQuantity());
            System.out.println("getLastesCartProductsString: " + str);
            if(ret.equals("")) ret += str;
            else ret+=","+str;
        }
        System.out.println(ret);
        return ret;
    }

    public static void clear(){
        totalPrice=0;
        count=0;
        cartProducts = new ArrayList<>();
    }
    private static void addProduct(int productId, String color, String size, int quantity) throws SQLException {
        System.out.println("addProduct received: "+productId+","+color+","+size+","+quantity);
        for (CartProduct cartProduct : cartProducts) {
            if (productId == cartProduct.getProductId() && color.equals(cartProduct.getProductColor()) && size.equals(cartProduct.getProductSize())) {
                cartProduct.setQuantity(cartProduct.getQuantity() + quantity);
                totalPrice += cartProduct.getProductPrice()*quantity;
                return;
            }
        }
        CartProduct cp = new CartProduct(productId, color, size, quantity);
        Product p = ProductsManager.getProductById(productId);
        cp.setProductImages(p.getProductImages());
        cp.setProductName(p.getProductName());
        cp.setProductPrice(p.getProductPrice());
        cartProducts.add(cp);
        count++;
        totalPrice += cp.getProductPrice()*cp.getQuantity();
    }

    public static List<CartProduct> getCartProducts() {
        return cartProducts;
    }

    public static void setCartProducts(List<CartProduct> cartProducts) {
        CartProductManager.cartProducts = cartProducts;
    }
}
