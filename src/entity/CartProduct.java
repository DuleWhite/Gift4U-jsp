package entity;

public class CartProduct {
    private int productId;
    private String productColor;
    private String productSize;
    private int quantity;
    private String[] productImages;
    private String productName;
    private double productPrice;

    public CartProduct() {

    }

    public CartProduct(int productId, String productColor, String productSize, int quantity) {
        this.productId = productId;
        this.productColor = productColor;
        this.productSize = productSize;
        this.quantity = quantity;
    }

    public boolean hasColor(){
        return productColor != null && !productColor.equals("") && !productColor.equals("null");
    }

    public boolean hasSize(){
        return productSize != null && !productSize.equals("") && !productSize.equals("null");
    }

    public String[] getProductImages() {
        return productImages;
    }

    public void setProductImages(String[] productImages) {
        this.productImages = productImages;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public double getProductPrice() {
        return productPrice;
    }

    public void setProductPrice(double productPrice) {
        this.productPrice = productPrice;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public int getProductId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }

    public String getProductColor() {
        return productColor;
    }

    public void setProductColor(String productColor) {
        this.productColor = productColor;
    }

    public String getProductSize() {
        return productSize;
    }

    public void setProductSize(String productSize) {
        this.productSize = productSize;
    }
}
