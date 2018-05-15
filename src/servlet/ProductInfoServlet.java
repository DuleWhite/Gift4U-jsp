package servlet;

import com.alibaba.fastjson.JSON;
import entity.Product;
import util.ProductsManager;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;

@WebServlet(name = "ProductInfoServlet")
public class ProductInfoServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String ret = "";
        //设置网页响应类型
        response.setContentType("text/html");
        //实现具体操作
        PrintWriter out = response.getWriter();
        try {
            Product product = ProductsManager.getProductById(Integer.parseInt(request.getParameter("productId")));
            ret = JSON.toJSONString(product);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        out.println(ret);
    }
}
