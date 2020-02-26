# 1、Session概述

服务端创建  并保存在服务端  

客户端需要保存与自己相对应的session的id

Session的常用的方法：

```jsp
<%--判断session是否是新建的--%>
isNew:<%=session.isNew()%><br/>

<%--获取sessionID--%>
sessionID:<%=session.getId()%><br/>

<%--获取session的创建时间--%>
createTime:<%= new SimpleDateFormat("yyyy-MM-dd hh:mm:ss").format(new Date(session.getCreationTime()))%><br/>

<%--获取session的最后一次的访问时间--%>
lastAccessTime:<%=new SimpleDateFormat("yyyy-MM-dd hh:mm:ss").format(new Date(session.getLastAccessedTime()))%><br/>

<%--获取session的最大保持时间--%>
MaxAge: <%=session.getMaxInactiveInterval()%>
```

session域中可以保存一些需要的数据：

**session中的保存的数据将在整个会话中都是有效的**

  可以使用session来保存登录之后的用户信息 这样可以方便在其他的页面或者servelt中来使用用户信息

```java
//销毁session
session.invalidate();
```



# 2、session的生命周期

### session的创建：

1. jsp：jsp是当前应用的第一个访问的web资源（jsp/servlet）此时会创建session

**Q:如果第一次访问的是jsp 那么jsp一定会创建session吗？**

**A:不一定。**

![img](E:\YouDaoYun\m15234512314@163.com\a48315d0ba1a46b7bbd2c27410f79b01\clipboard.png)

2. sevlet  如果第一次访问的是servlet

```java
//false 表示在getSession时 不会创建session对象
//true 会创建session对象  req.getSession() 相当于  req.getSession(true);
HttpSession session = req.getSession(true);
System.out.println(session.isNew());
System.out.println(session.getId());
```

### session的销毁：

1. 调用session的invalidate（） 可以销毁session

2. 当整个应用从服务器卸载时  服务器重启  也会销毁session

3. 最大的有效时限 到达 则session也会失效

tomcat默认的session的有效时限为30分钟  web.xml

```xml
<session-config>
    <session-timeout>30</session-timeout>
</session-config>
```

4. 并不是关闭了浏览器就销毁了 HttpSession. 

## 2.1 当cookie被禁用时 如何来进行会话保持：

### URL重写

HttpServletResponse接口中定义了两个用于完成URL重写方法：

- encodeURL方法 
- encodeRedirectURL方法

　encodeURL () 及 encodeRedirectedURL () 方法首先判断 cookies 是否被浏览器支持；如果支持，则参数 URL 被原样返回，session ID 将通过 cookies 来维持。

```jsp
<form action=<%=response.encodeURL("/home.jsp" )%>method="post">
    用户名：<input type="text" value="" name="username">
    <input type="submit" value="提交">
</form>
```

# 3、session典型应用：防止表单重复提交

## 3.1、通过前端js来防止表单重复提交

```html
<script type="text/javascript">
  var isCommit = false; // 如果为false 则认为是第一次提交  否则为重复提交
  function  doSubmit() {
    if(!isCommit){
      isCommit = true;
       return true;
    }else{
      return false;
    }
  }

</script>
```

## 3.2、通过前端禁用提交按钮 防止表单重复提交

```javascript
document.getElementById("submit").disabled = true;
```

## 3.3、利用session防止表单重复提交

​        当进入表单页面时，产生一个token（令牌），将产生的token同时保存在session中 并保存在当前页面的请求参数中 当到达servlet的时候  对session中保存的token和页面的请求参数中的token进行对比 如果两个token值一致 则认为是第一次提交  否则认为是重复提交

IndexServlet.java

```java
@WebServlet("/index.do")
public class IndexServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        //将产生UUID的方法放在初始Servlet中
        String token = UUID.randomUUID().toString();
        HttpSession session = req.getSession();
        session.setAttribute("SESSION_TOKEN",token);
        req.setAttribute("token",token);
        req.getRequestDispatcher("account.jsp").forward(req,resp);
    }
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req,resp);
    }
}
```

jsp页面

```jsp
<%@ page contentType="text/html;charset=UTF-8" language="java" session="true" %>
<html>
  <head>
    <title>表单重复提交</title>
  </head>
  <body>
  <form action="/account.do"   method="post">
    <input type="hidden" value='<%=request.getAttribute("token")%>' name="token">
        转账金额：<input type="text" value="" name="money">
   <input id="submit" type="submit" value="提交">
  </form>
  </body>
</html>
```

AccountServlet.java

```java
@WebServlet("/account.do")
public class AccountServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            Thread.sleep(5000);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
        String money = req.getParameter("money");
        //请求参数中的Token
        String paramToken = req.getParameter("token");
        HttpSession session = req.getSession();
        //获取session中保存的Token
        String sessionToken = (String) session.getAttribute("SESSION_TOKEN");
        if(paramToken.equals(sessionToken)){//两个token一致 认为是第一次提交
            System.out.println("您此次的转账金额为：" + money);//处理请求
            //移除session中的Token
            session.removeAttribute("SESSION_TOKEN");
        }else{//重复提交
            System.out.println("您的手速过快 。。。。。");
        }
    }
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req,resp);
    }
}
```



