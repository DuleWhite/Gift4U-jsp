package servlet;

import com.mysql.cj.protocol.ResultListener;
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

@WebServlet(name = "SignUpServlet")
public class SignUpServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String phoneNunber = request.getParameter("phone");
        Connection connection = DBManager.getConnection();
        try {
            Statement statement = connection.createStatement();
            //TODO: FINISH SQL STATEMENT
            int rows = statement.executeUpdate("INSERT INTO users(username,userphone) VALUES ('"+username+"','"+phoneNunber+"');");
            if(rows>0) {
                response.getWriter().write("true");
                request.getSession().setAttribute("username",username);
                ResultSet resultSet = statement.executeQuery("SELECT userid FROM users WHERE username='"+username+"';");resultSet.next();
                request.getSession().setAttribute("userid",resultSet.getString("userid"));
            }
            else response.getWriter().write("false");
        } catch (SQLException e) {
            e.printStackTrace();
        }

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request,response);
    }
}
