package servlet;

import util.DBManager;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

@WebServlet(name = "ConfirmReceiptServlet")
public class ConfirmReceiptServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String orderid = request.getParameter("orderid");
        Connection connection = DBManager.getConnection();
        String sql = "";
        try {
            Statement statement = connection.createStatement();
            sql = "UPDATE orders SET orderstatus='Done' WHERE orderid="+orderid+";";
            System.out.println(sql);
            int result = statement.executeUpdate(sql);
            if(result!=0){
                response.getWriter().write("true");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request,response);
    }
}
