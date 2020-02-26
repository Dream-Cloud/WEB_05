<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %><%--
  Created by IntelliJ IDEA.
  User: lifubao
  Date: 2020/2/18
  Time: 10:02
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>home</title>
</head>
<body>
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

<%
    //处理form表单的数据 相当于servlet的作用
    String username = request.getParameter("username");
    if (username != null){
        session.setAttribute("username",username);
    }
%>
欢迎您：<%=session.getAttribute("username")%>
<a href="<%=response.encodeURL("/logout.jsp")%>">安全退出</a>
</body>
</html>
