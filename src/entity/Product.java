package entity;

import java.util.Arrays;

public class Product {
    private int productId;
    private String productName;
    private String[] productImages;
    private Double productPrice;
    private String[] productColors;
    private String[] productSizes;
    private String productDescription;
    private String productInfo;
    private String productReturnAndRefeundPolicy;
    private String productShippingInfo;
    private String productTag;

    public Product(){

    }

    public int getProductId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public String[] getProductImages() {
        return productImages;
    }

    public void setProductImages(String[] productImages) {
        this.productImages = productImages;
    }

    public Double getProductPrice() {
        return productPrice;
    }

    public void setProductPrice(Double productPrice) {
        this.productPrice = productPrice;
    }

    public String[] getProductColors() {
        return productColors;
    }

    public void setProductColors(String[] productColors) {
        this.productColors = productColors;
    }

    public String[] getProductSizes() {
        return productSizes;
    }

    public void setProductSizes(String[] productSizes) {
        this.productSizes = productSizes;
    }

    public String getProductDescription() {
        return productDescription;
    }

    public void setProductDescription(String productDescription) {
        this.productDescription = productDescription;
    }

    public String getProductInfo() {
        return productInfo;
    }

    public void setProductInfo(String productInfo) {
        this.productInfo = productInfo;
    }

    public String getProductReturnAndRefeundPolicy() {
        return productReturnAndRefeundPolicy;
    }

    public void setProductReturnAndRefeundPolicy(String productReturnAndRefeundPolicy) {
        this.productReturnAndRefeundPolicy = productReturnAndRefeundPolicy;
    }

    public String getProductShippingInfo() {
        return productShippingInfo;
    }

    public void setProductShippingInfo(String productShippingInfo) {
        this.productShippingInfo = productShippingInfo;
    }

    public String getProductTag() {
        return productTag;
    }

    public void setProductTag(String productTag) {
        this.productTag = productTag;
    }

    @Override
    public String toString() {
        return "Product [productId=" + productId +
                ", productName=" + productName +
                ", productImages=" + Arrays.toString(productImages) +
                ", productPrice=" + productPrice +
                ", productColors=" + Arrays.toString(productColors) +
                ", productSizes=" + Arrays.toString(productSizes) +
                ", productDescription=" + productDescription +
                ", productInfo=" + productInfo +
                ", productShippingInfo=" + productShippingInfo +
                ", productTag=" + productTag +
                "]";
    }
}
