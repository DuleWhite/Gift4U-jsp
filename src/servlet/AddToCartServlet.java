package servlet;

import com.alibaba.fastjson.JSONArray;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(name = "AddToCartServlet")
public class AddToCartServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String productId = request.getParameter("productId");
        String color = request.getParameter("color");
        String size = request.getParameter("size");
        String quantity = request.getParameter("quantity");
        HttpSession session = request.getSession();
        String cartProduct = productId + "-" + color + "-" + size + "-" + quantity;
        String cartProducts = (String) session.getAttribute("cartProducts");
        String userid = (String) session.getAttribute("userid");
        if(userid==null||userid.equals("")){
            response.getWriter().write("noLogin");
            return;
        }
        if(cartProducts!=null && !cartProducts.equals("")){
            cartProducts += ",";
            cartProducts += cartProduct;
        }
        else cartProducts = cartProduct;
        session.setAttribute("cartProducts",cartProducts);
        response.getWriter().write("true");
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request,response);
    }
}
