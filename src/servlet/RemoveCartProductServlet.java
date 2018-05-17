package servlet;

import util.CartProductManager;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "RemoveCartProductServlet")
public class RemoveCartProductServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int productId = Integer.parseInt(request.getParameter("productId"));
        String productColor = request.getParameter("productColor");
        String productSize = request.getParameter("productSize");
        CartProductManager.removeProduct(productId,productColor,productSize);
        if(CartProductManager.getCount()==0)response.getWriter().write("empty");
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request,response);
    }
}
