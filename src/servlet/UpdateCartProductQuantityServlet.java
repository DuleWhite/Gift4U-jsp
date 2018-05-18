package servlet;

import entity.CartProduct;
import util.CartProductManager;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "UpdateCartProductQuantityServlet")
public class UpdateCartProductQuantityServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int productId = Integer.parseInt(request.getParameter("productId"));
        String productColor = request.getParameter("productColor");
        String productSize = request.getParameter("productSize");
        int quantity = Integer.parseInt(request.getParameter("quantity"));
        double newPrice = CartProductManager.updateCartProductQuantity(productId,productColor,productSize,quantity);
        response.getWriter().write(newPrice + "-" + CartProductManager.getTotalPrice());
        CartProductManager.print();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request,response);
    }
}
