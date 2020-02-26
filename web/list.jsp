<%@ page import="java.util.List" %>
<%@ page import="org.lanqiao.domain.Product" %><%--
  Created by IntelliJ IDEA.
  User: lifubao
  Date: 2020/2/20
  Time: 10:35
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>list</title>
</head>
<body>
<table>
    <%
        List<Product> proList = (List<Product>) request.getAttribute("proList");
    %>
    <thead>
    <tr>
        <th>商品ID</th>
        <th>商品名称</th>
        <th>商品价格</th>
        <th>操作</th>
    </tr>

    </thead>
    <tbody>
    <%
        for (Product product : proList) {
    %>
    <tr>
        <td><%=product.getId()%></td>
        <td><%=product.getName()%></td>
        <td><%=product.getPrice()%></td>
        <td><a href="/car.do?_method=add&id=<%=product.getId()%>">加入购物车</a></td>
    </tr>
    <%
        }
    %>

    </tbody>
</table>
</body>
</html>
