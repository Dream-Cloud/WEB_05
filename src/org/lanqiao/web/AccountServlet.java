package org.lanqiao.web;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/account.do")
public class AccountServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            Thread.sleep(1000);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }

        String money = req.getParameter("money");
        //请求参数中的token
        String paramToken = req.getParameter("token");
        HttpSession session = req.getSession();
        //获取session中保存的token
        String sessionToken = (String) req.getAttribute("SESSION_TOKEN");

        if (paramToken.equals(sessionToken)){//两个token一致 认为是第一次提交
            System.out.println("您此次的转账金额是"+money);//处理请求
            //移除session中的token
            session.removeAttribute("SESSION_TOKEN");
        }else {//重复提交
            System.out.println("您的手速太快。。。。。。");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req, resp);
    }
}
