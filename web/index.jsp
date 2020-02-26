<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %><%--
  Created by IntelliJ IDEA.
  User: lifubao
  Date: 2020/2/18
  Time: 9:25
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
  <head>
    <title>session</title>
  </head>
  <body>
<%--  &lt;%&ndash;获取session&ndash;%&gt;--%>
<%--<%--%>
<%--  HttpSession session1 = request.getSession();--%>
<%--%>--%>
<%--  内置对象的session<%=session.getId()%><br>--%>
<%--  自主获取的session<%=session1.getId()%>--%>

  <%
    session.setMaxInactiveInterval(60*5);
  %>
<%--  判断是否是新建的session--%>
  isNew:<%=session.isNew()%><br>
<%--  获取sessionId--%>
  sessionId:<%=session.getId()%><br>
<%--  获取session创建时间--%>
  createTime:<%=new SimpleDateFormat("yyyy-MM-dd hh:mm:ss").format(new Date(session.getCreationTime()))%><br>
<%--  获取session最近访问时间--%>
  lastAccess:<%=new SimpleDateFormat("yyyy-MM-dd hh:mm:ss").format(new Date(session.getLastAccessedTime()))%><br>
<%--  获取session的最大保持时间--%>
  MaxAge:<%=session.getMaxInactiveInterval()%><br>
<%--url重写--%>
<form action="<%=response.encodeUrl("home.jsp") %>" method="post">
<%--  <form action="/home.jsp" method="post">--%>

    用户名:<input type="text" value="" name="username">
    <input type="submit" value="提交">
  </form>
  </body>
</html>
