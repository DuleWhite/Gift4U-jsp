package servlet;

import util.SMSManager;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Random;

@WebServlet(name = "MessageServlet")
public class MessageServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String phone=request.getParameter("phone");
        response.setCharacterEncoding("UTF-8");
        //获取验证码
        String code = getCode(request);
        //发送短信
        String result = SMSManager.send(phone,code);
        response.getWriter().write(result);
        response.flushBuffer();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request,response);
    }

    //获取验证码
    private String getCode(HttpServletRequest request) {
        Random rand =new Random();
        String code = "";
        for(int i=0;i<4;i++) {
            code += rand.nextInt(10);
        }
        request.getSession().setAttribute("code",code);
        return code;
    }
}
