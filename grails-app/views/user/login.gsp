<%--
  Created by IntelliJ IDEA.
  User: ykn
  Date: 17-9-20
  Time: 下午1:50
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>登录</title>
</head>

<body>
    <div>
        <g:form controller="login" action="doLogin" method="post">
            <input type="text" id="name" name="name" placeholder="请输入帐号" maxlength="8">
            <input type="password" id="password" name="password" placeholder="请输入密码" maxlength="8">
            <input class="button" type="submit" value="登录">
        </g:form>
        <span style="color:red">${params.errorMsg}</span>
    </div>
</body>
</html>