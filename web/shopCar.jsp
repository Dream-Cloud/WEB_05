<%@ page import="java.util.Map" %>
<%@ page import="org.lanqiao.domain.Product" %><%--
  Created by IntelliJ IDEA.
  User: lifubao
  Date: 2020/2/20
  Time: 11:05
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>购物车</title>
</head>
<body>
<%
    Map<Product,Integer> shopCar = (Map<Product, Integer>) session.getAttribute("SHOP_CAR");
    Double totalPrice = 0.0;
%>
<table>
    <thead>
    <tr>
        <th>商品名称</th>
        <th>商品价格</th>
        <th>购买数量</th>
    </tr>
    </thead>
    <tbody>
    <%
        for (Map.Entry<Product,Integer> entry : shopCar.entrySet() ){
    %>
        <tr>
            <td><%=entry.getKey().getName()%></td>
            <td><%=entry.getKey().getPrice()%></td>
            <td><%=entry.getValue()%></td>
        </tr>
    <%
            Double prototalPrice = entry.getKey().getPrice()*entry.getValue();
            totalPrice += prototalPrice;
        }
    %>
    <tr>
        <td>总计</td>
        <td colspan="2"><%=totalPrice%></td>
    </tr>
    </tbody>
</table>
</body>
</html>
