package util;

import entity.CartProduct;
import entity.Product;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class CartProductManager {
    private static List<CartProduct> cartProducts;
    static {
        cartProducts = new ArrayList<>();

    }

    public static double getTotalPrice() {
        double totalPrice = 0;
        for (CartProduct cartProduct: cartProducts) {
            totalPrice += cartProduct.getProductPrice() * cartProduct.getQuantity();
        }
        return totalPrice;
    }

    public static int getCount() {
        return cartProducts.size();
    }

    public CartProductManager() {

    }

    public static void updateCartProducts(String cartProductsString) throws SQLException {
        //clear();
        String[] cartProductsArray = new String[0];
        if (cartProductsString != null && !cartProductsString.equals("")) {
            cartProductsArray = cartProductsString.split(",");
        }
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
            if(ret.equals("")) ret += str;
            else ret+=","+str;
        }
        return ret;
    }

    public static void clear(){
        cartProducts = new ArrayList<>();
    }
    private static void addProduct(int productId, String color, String size, int quantity) throws SQLException {
        for (CartProduct cartProduct : cartProducts) {
            if (productId == cartProduct.getProductId() && color.equals(cartProduct.getProductColor()) && size.equals(cartProduct.getProductSize())) {
                cartProduct.setQuantity(cartProduct.getQuantity() + quantity);
                return;
            }
        }
        CartProduct cp = new CartProduct(productId, color, size, quantity);
        Product p = ProductsManager.getProductById(productId);
        cp.setProductImages(p.getProductImages());
        cp.setProductName(p.getProductName());
        cp.setProductPrice(p.getProductPrice());
        cartProducts.add(cp);
    }

    public static List<CartProduct> getCartProducts() {
        return cartProducts;
    }

    public static void setCartProducts(List<CartProduct> cartProducts) {
        CartProductManager.cartProducts = cartProducts;
    }

    public static void removeProduct(int productId, String productColor, String productSize) {
        for (CartProduct cartProduct: cartProducts){
            if(cartProduct.getProductId()==productId){
                if(cartProduct.hasColor()&&cartProduct.hasSize()&&productColor.equals(cartProduct.getProductColor())&&productSize.equals(cartProduct.getProductSize())) {
                    cartProducts.remove(cartProduct);
                    return;
                }
                if(cartProduct.hasColor()&&!cartProduct.hasSize()&&productColor.equals(cartProduct.getProductColor())) {
                    cartProducts.remove(cartProduct);
                    return;
                }
                if(cartProduct.hasSize()&&!cartProduct.hasColor()&&productSize.equals(cartProduct.getProductSize())) {
                    cartProducts.remove(cartProduct);
                    return;
                }
                if(!cartProduct.hasColor()&&!cartProduct.hasSize()) {
                    cartProducts.remove(cartProduct);
                    return;
                }
            }
        }
    }

    public static void print(){
        System.out.println("print:");
        for (CartProduct cp : cartProducts) {
            System.out.print(cp.getProductId() + "-");
            System.out.print(cp.getProductColor() + "-");
            System.out.print(cp.getProductSize() + "-");
            System.out.print(cp.getQuantity());
            System.out.println();
        }
        System.out.println(getCount());
    }

    public static double updateCartProductQuantity(int productId, String color, String size, int quantity) {
        System.out.println("updatequantity recived: "+productId+" "+color+" "+size+" "+quantity);
        for (CartProduct cp:cartProducts){
            if(cp.getProductId()==productId
                    && (cp.getProductColor().equals(color) || (cp.getProductColor().equals("null")&&color.equals("")))
                    && (cp.getProductSize().equals(size) || (cp.getProductSize().equals("null")&&size.equals("")))
            ){
                cp.setQuantity(quantity);
                System.out.println("updatequantity:"+cp.getProductId()+","+cp.getQuantity());
                return cp.getProductPrice()*cp.getQuantity();
            }
        }
        return -1;
    }
}
