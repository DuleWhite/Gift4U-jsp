package servlet;

import util.DBManager;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Statement;

@WebServlet(name = "ConfirmReceiptAllServlet")
public class ConfirmReceiptAllServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String userid = (String) request.getSession().getAttribute("userid");
        Connection connection = DBManager.getConnection();
        try {
            Statement statement = connection.createStatement();
            int result = statement.executeUpdate("UPDATE orders SET orderstatus='Done' WHERE userid="+userid+" AND orderstatus='Delivery';");
            if(result>0){
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
