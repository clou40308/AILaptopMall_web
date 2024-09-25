<%@page import="java.util.List"%>
<%@page pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>AI筆電商城 登入</title>
    <link rel="stylesheet" type="text/css" href="style/ailm.css">
    <link rel="stylesheet" type="text/css" href="style/header.css">
    <link rel="stylesheet" type="text/css" href="style/footer.css">
    <script src="https://code.jquery.com/jquery-3.0.0.js"
        integrity="sha256-jrPLZ+8vDxt2FnE1zvZXCkCcebI/C8Dt5xyaQBjxQIo=" crossorigin="anonymous"></script>
    <script>
		//$(document).ready(init);
		$(init);

		function init(){
			//alert("init");
			<% if(request.getMethod().equals("POST")){ %>
			repopulateFormData();
		}
		
		function repopulateFormData(){
			$("input[name=account]").val('<%= request.getParameter("account")%>');
			$("input[name=password]").val('<%= request.getParameter("password")%>');
			<% } %>
		}
		
        function refreshCaptcha() {
            //更新驗證碼
            captchaImg.src = "images/captcha.png?renew=" + new Date();
        }
        function hidePwd() {
            //隱藏密碼
            $("#eyes_on").css("display", "inline");
            $("#eyes_off").css("display", "none");
            $("#password").attr("type", "password");
        }
        function showPwd() {
            //顯示密碼
            $("#eyes_on").css("display", "none");
            $("#eyes_off").css("display", "inline");
            $("#password").attr("type", "text");
        }
    </script>
    <style>
        #container-login {
            height: 800px;
            display: flex;
            justify-content: center;
            align-items: center;
            background-image: url(./images/background-img.jpg);
        }

        #login-area {
            background-color: #fff;
            height: 500px;
            width: 400px;
            border-radius: 15px;
        }

        #login-area-title {
            width: 100%;
            height: 60px;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        #login-area-title p {
            font-size: 22px;
            font-weight: 700;
        }

        #login-area-register {
            width: 100%;
            height: 40px;
            display: flex;
            justify-content: center;
            align-items: center;
            font-size: 14px;
            margin-bottom: 10px;
        }

        #login-area-register a {
            color: #0090eb;
        }

        #login-area-form-account {
            width: 100%;
            height: 50px;
            display: flex;
            justify-content: center;
            align-items: center;
            margin-bottom: 10px;
        }

        #login-area-form-account label {
            margin-right: 12px;
            font-size: 18px;
            font-weight: bold;
        }

        #login-area-form-account input {
            height: 30px;
            width: 200px;
            font-size: 16px;
            border-radius: 4px;
            padding-left: 10px;
            padding-right: 10px;
        }

        #login-area-form-password {
            width: 400px;
            height: 50px;
            display: flex;
            justify-content: center;
            align-items: center;
            margin-bottom: 10px;
            position: absolute;
        }

        #login-area-form-password label {
            margin-left: 23px;
            margin-right: 12px;
            font-size: 18px;
            font-weight: bold;
        }

        #login-area-form-password input {
            height: 30px;
            width: 164px;
            font-size: 16px;
            border-radius: 4px;
            padding-left: 10px;
            padding-right: 40px;
        }

        #eyes_on {
            width: 25px;
            width: 25px;
            position: relative;
            top: 0px;
            left: -35px;
        }

        #eyes_off {
            width: 25px;
            width: 25px;
            display: none;
            position: relative;
            top: 0px;
            left: -35px;
        }

        #login-area-form-captcha {
            margin-top: 80px;
            width: 100%;
            height: 50px;
            display: flex;
        }

        #login-area-form-captcha label {
            margin-right: 12px;
            font-size: 18px;
            font-weight: bold;
            margin-left: 44px;
        }

        #login-area-form-captcha input {
            height: 30px;
            width: 200px;
            font-size: 16px;
            border-radius: 4px;
            padding-left: 10px;
            padding-right: 10px;
        }

        #captcha-img {
            width: 100%;
            height: 50px;
            display: flex;
        }

        #captchaImg {
            width: 100px;
            height: 30px;
            margin-left: 115px;
        }

        #refreshImg {
            margin-left: 5px;
            width: 30px;
            height: 30px;
        }

        #refreshImg:hover {
            cursor: pointer;
            transform: scale(1.1);
            transition: transform 0.3s ease;
        }

        #refreshImg:active {
            transform: scale(0.9);
            transition: transform 0.1s ease;
        }

        #forget-password{
            color: #0090eb;
            margin-left: 25px;
            font-weight: 600;
        }

        #login-area-btn {
            width: 100%;
            height: 60px;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        #login {
            font-size: 16px;
            width: 200px;
            border-radius: 5px;
            height: 30px;
            background-color: #dc0001;
            border: none;
            color: #fff;
        }

        #login:hover {
            cursor: pointer;
            transform: scale(1.05);
        }

        #login:active {
            transform: scale(0.95);  
        }
        
        #theErrorsDiv{
        	width: 100%;
            height: 10px;
            display: flex;
            justify-content: center;
            align-items: center;
            margin-bottom: 10px;
            color: #dc0001;
        }
        
    </style>
</head>

<body>
	<% request.setCharacterEncoding("UTF-8"); %>
	
	<jsp:include page="./subviews/header.jsp" >
		<jsp:param value="登入" name="subheader"/>
	</jsp:include>
	
    <div id="container-login">
        <div id="login-area">
            <div id="login-area-title">
                <p>歡迎光臨</p>
            </div>
            <div id="login-area-register">
                <p>沒有 AI筆電商城帳號？</p>
                <a href="./register.jsp">立即註冊</a>
            </div>
            <form action="login.do" method="post">
                <div id="login-area-form">
                    <div id="login-area-form-account">
                        <label for="account">帳號:</label>
                        <input type="text" name="account" id="account" placeholder="請輸入帳號" required>
                    </div>
                    <div id="login-area-form-password">
                        <label for="password">密碼:</label>
                        <input type="password" name="password" id="password" required placeholder="請輸入密碼">
                        <img src="./images/eyes_on.png" id="eyes_on" onclick="showPwd()">
                        <img src="./images/eyes_off.png" id="eyes_off" onclick="hidePwd()">
                    </div>
                    <div id="login-area-form-captcha">
                        <label for="captcha">驗證碼:</label>
                        <input type="text" name="captcha" id="captcha" required placeholder="請輸入驗證碼">
                    </div>
                    <div id="captcha-img">
                        <img src="./images/captcha.png" alt="" id="captchaImg" >
                        <img src="./images/refresh.png" alt="" id="refreshImg" onclick="refreshCaptcha()">
                        <a href="" id="forget-password">忘記密碼</a>
                    </div>
                    <%
		 					List<String> errors =  (List<String>)request.getAttribute("errors");		
					%>
					<div id="theErrorsDiv">
						<%= errors!=null?errors:"" %>		
					</div>
                    <div id="login-area-btn">
                        <input type="submit" id="login" value="登入">
                    </div>
                </div>
            </form>
        </div>
    </div>
    
	<%@include file="./subviews/footer.jsp" %>	
</body>

</html>