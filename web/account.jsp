<%@ page import="java.util.UUID" %><%--
  Created by IntelliJ IDEA.
  User: lifubao
  Date: 2020/2/18
  Time: 12:13
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>表单重复提交</title>
<%--    <script type="text/javascript">--%>
<%--        // 通过前端js来防止表单重复提交--%>
<%--        var isCommit = false;//false 是第一次提交 否则就是重复提交--%>
<%--        function doSubmit(){--%>
<%--            if (!isCommit){--%>
<%--                isCommit = true;--%>
<%--                // 通过前端禁用提交按钮 防止表单重复提交--%>
<%--                document.getElementById("submit").disabled = true;--%>
<%--                return true;--%>
<%--            }else{--%>
<%--                return false;--%>
<%--            }--%>
<%--        }--%>
<%--    </script>--%>
</head>
<body>
<%--利用session防止表单重复提交--%>
<%--
    String token = UUID.randomUUID().toString();//利用UUID产生Token
    //将token保存到session中
    session.setAttribute("SESSION_TOKEN",token);

--%>
<form action="/account.do" onsubmit="return doSubmit()" method="post">
    <input type="text" value="<%=request.getAttribute("token")%>" name="token">
    转账金额：<input type="text" value="" name="money">
    <input id="submit" type="submit"  value="提交">
</form>
</body>
</html>
