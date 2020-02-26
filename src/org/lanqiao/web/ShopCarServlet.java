package org.lanqiao.web;

import org.lanqiao.domain.Product;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/car.do")
public class ShopCarServlet extends HttpServlet {

    private static List<Product> list = new ArrayList<Product>();

    // 只会执行一次，当类的字节码被加载到jvm的时候，只会执行一次
    static {
        list.add(new Product(1,"小米5",1999));   //1
        list.add(new Product(2,"海尔冰箱",2999)); //2
        list.add(new Product(3,"vivo8",3999)); //3
        list.add(new Product(4,"iphon9",6999));
        list.add(new Product(5,"联想鼠标垫",50));
    }
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String method = req.getParameter("_method");
        switch (method){
            case "list":
                list(req, resp);
                break;
            case "add":
                addPro2Car(req, resp);
                break;

        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req, resp);
    }

    //闪频列表
    public void list(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setAttribute("proList",list);
        req.getRequestDispatcher("/list.jsp").forward(req,resp);
    }

    //添加商品到购物车
    public void addPro2Car(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        Map<Product,Integer> shopCar = null;
        HttpSession session = req.getSession();
        shopCar = (Map<Product, Integer>) session.getAttribute("SHOP_CAR");
        if (shopCar == null){//表示第一次访问 还没有购物车
            shopCar = new HashMap<>();//创建购物车
            session.setAttribute("SHOP_CAR",shopCar);
        }
        //给购物车添加商品
        String idStr = req.getParameter("id");
        Integer id = 0;
        if (idStr != null){
            id = Integer.valueOf(idStr);
        }
        Product product = list.get(id - 1);//当前要加入购物车的商品
        if (shopCar.containsKey(product)){//判断购物车中是否有该商品 如果包含 则直接给购买的数量加一
            shopCar.put(product,shopCar.get(product)+1);
        }else {
            shopCar.put(product,1);
        }
        session.setAttribute("SHOP_CAR",shopCar);
        resp.sendRedirect("shopCar.jsp");

    }
}
