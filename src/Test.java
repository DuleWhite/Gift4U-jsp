import util.DBManager;
import util.SMSManager;

import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Statement;

public class Test {
    public static void main(String[] args) {
        String username = "Dule2";
        String phoneNunber = "11011011011";
        Connection connection = DBManager.getConnection();
        try {
            Statement statement = connection.createStatement();
            //TODO: FINISH SQL STATEMENT
            int rows = statement.executeUpdate("INSERT INTO users(username,userphone) VALUES ('"+username+"','"+phoneNunber+"');");
            System.out.println(rows);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
