<%--
  Created by IntelliJ IDEA.
  User: lifubao
  Date: 2020/2/18
  Time: 10:27
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>logout</title>
</head>
<body>
    <%
//        销毁session
        session.invalidate();
        response.sendRedirect("/index.jsp");
    %>

</body>
</html>
