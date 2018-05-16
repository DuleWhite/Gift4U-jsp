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

@WebServlet(name = "LoginServlet")
public class LoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String phone = request.getParameter("phone");
        String username = "";
        String userid = "";
        Connection connection = DBManager.getConnection();
        try {
            Statement statement = connection.createStatement();
            ResultSet resultSet = statement.executeQuery("SELECT username,userid FROM users WHERE userphone='"+phone+"';");
            if(resultSet.next()){
                username = resultSet.getString("username");
                userid = resultSet.getString("userid");
                request.getSession().setAttribute("userid",userid);
                request.getSession().setAttribute("username",username);
                response.getWriter().write("true");
            }
            else{
                response.getWriter().write("false(1)");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.getWriter().write("false(2)");
        }

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request,response);
    }
}
