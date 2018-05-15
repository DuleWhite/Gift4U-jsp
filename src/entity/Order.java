package entity;

import java.util.Date;
import java.util.List;

public class Order {
    public static class ProductParam{
        public int quantity;
        public String selectedColor;
        public String selectedSize;
        public ProductParam(){

        }
    }
    private int orderId;
    private Double totalPrice;
    private String shippingTo;
    private Date orderDate;
    private String OrderStatus;
    private List<ProductParam> products;
    public Order(){

    }

    public int getOrderId() {
        return orderId;
    }

    public void setOrderId(int orderId) {
        this.orderId = orderId;
    }

    public Double getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(Double totalPrice) {
        this.totalPrice = totalPrice;
    }

    public String getShippingTo() {
        return shippingTo;
    }

    public void setShippingTo(String shippingTo) {
        this.shippingTo = shippingTo;
    }

    public Date getOrderDate() {
        return orderDate;
    }

    public void setOrderDate(Date orderDate) {
        this.orderDate = orderDate;
    }

    public String getOrderStatus() {
        return OrderStatus;
    }

    public void setOrderStatus(String orderStatus) {
        OrderStatus = orderStatus;
    }

    public List<ProductParam> getProducts() {
        return products;
    }

    public void setProducts(List<ProductParam> products) {
        this.products = products;
    }
}
