<%@page import="com.ailaptopmall.entity.Customer"%>
<%@page import="java.util.List"%>
<%@page pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>AI筆電商城 註冊</title>
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
			$("input[name=id]").val('<%= request.getParameter("id")%>');
			$("input[name=email]").val('<%= request.getParameter("email")%>');
			$("input[name=phone]").val('<%= request.getParameter("phone")%>');
			$("input[name=name]").val('<%= request.getParameter("name")%>');
			$("input[name=birthday]").val('<%= request.getParameter("birthday")%>');
			$("textarea[name=address]").text('<%= request.getParameter("address")%>');
			
			$("select[name=gender]").val('<%= request.getParameter("gender")%>');
			$("input[name=subscribed]").prop('checked', <%= request.getParameter("subscribed")!=null%>);
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
        #container-register {
            height: 1000px;
            display: flex;
            justify-content: center;
            align-items: center;
            background-image: url(./images/background-img.jpg);
        }

        #register-area {
            background-color: #fff;
            height: 900px;
            width: 500px;
        }

        #register-area-title {
            width: 100%;
            height: 60px;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        #register-area-title p {
            font-size: 22px;
            font-weight: 700;
        }

        #register-area-register {
            width: 100%;
            height: 40px;
            display: flex;
            justify-content: center;
            align-items: center;
            font-size: 14px;
            margin-bottom: 10px;
        }

        #register-area-register a {
            color: #0090eb;
        }

        #register-area-form-account,
        #register-area-form-id,
        #register-area-form-email,
        #register-area-form-phone,
        #register-area-form-name,
        #register-area-form-birthday,
        #register-area-form-gender,
        #register-area-form-captcha {
            width: 100%;
            height: 50px;
            display: flex;
            justify-content: center;
            align-items: center;
            margin-top: 5px;
        }

        #register-area-form-id{
            margin-top:55px;
        }

        #register-area-form-address {
            width: 100%;
            height: 80px;
            display: flex;
            align-items: center;
            margin-top: 5px;
        }

        #register-area-form-subscribed {
            width: 100%;
            height: 50px;
            display: flex;
            align-items: center;
        }
        #register-area-form-subscribed input{
            margin-left: 167px;
        }

        #register-area-form-subscribed label{
            margin-left: 12px;
            font-size: 16px;
            font-weight: bold;
        }

        #register-area-form-account label,
        #register-area-form-id label,
        #register-area-form-email label,
        #register-area-form-phone label,
        #register-area-form-address label,
        #register-area-form-captcha label {
            margin-right: 12px;
            font-size: 18px;
            font-weight: bold;
        }

        #register-area-form-name label{
            margin-right: 12px;
            margin-left: 8px;
            font-size: 18px;
            font-weight: bold;
        }
        
        #register-area-form-birthday label{
        	margin-right: 12px;
            margin-left: 8px;
            font-size: 18px;
            font-weight: bold;
        }
        
		#register-area-form-gender label{
			margin-right: 12px;
            margin-left: 8px;
            font-size: 18px;
            font-weight: bold;
		}
		
        #register-area-form-address label {
            margin-left: 114px;
            margin-right: 12px;
        }

        #register-area-form-account input,
        #register-area-form-id input,
        #register-area-form-email input,
        #register-area-form-phone input,
        #register-area-form-name input,
        #register-area-form-birthday input,
        #register-area-form-captcha input {
            height: 30px;
            width: 200px;
            font-size: 16px;
            border-radius: 4px;
            padding-left: 10px;
            padding-right: 10px;
        }

        #register-area-form-id input {
            margin-right: 50px;
        }

        #register-area-form-email input {
            margin-right: 14px;
        }

        #register-area-form-phone input {
            margin-right: 28px;
        }

        #register-area-form-captcha input {
            margin-right: 17px;
        }

        #register-area-form-gender select {
            height: 33px;
            width: 225px;
            font-size: 16px;
            border-radius: 4px;
            padding-left: 10px;
            padding-right: 10px;
        }

        #register-area-form-address textarea {
            height: 50px;
            width: 230px;
            font-size: 16px;
            border-radius: 4px;
            padding-left: 10px;
            padding-right: 10px;
            padding-top: 5px;
        }

		#register-area-form-password {
            width: 400px;
            height: 50px;
            display: flex;
            justify-content: center;
            align-items: center;
            margin-bottom: 10px;
            position: absolute;
            padding-left: 53px;
        }

        #register-area-form-password label {
            margin-left: 23px;
            margin-right: 12px;
            font-size: 18px;
            font-weight: bold;
        }

        #register-area-form-password input {
            height: 30px;
            width: 170px;
            font-size: 16px;
            border-radius: 4px;
            padding-left: 10px;
            padding-right: 40px;
        }

        #eyes_on {
            width: 25px;
            height: 25px;
            position: relative;
            top: 0px;
            left: -35px;
        }

        #eyes_off {
            width: 25px;
            height: 25px;
            display: none;
            position: relative;
            top: 0px;
            left: -35px;
        }
        #captcha-img {
            width: 100%;
            height: 50px;
            display: flex;
        }

        #captchaImg {
            width: 100px;
            height: 30px;
            margin-left: 165px;
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

        #register-area-btn {
            width: 100%;
            height: 60px;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        #register {
            font-size: 16px;
            width: 200px;
            border-radius: 5px;
            height: 30px;
            background-color: #dc0001;
            border: none;
            color: #fff;
        }

        #register:hover {
            cursor: pointer;
            transform: scale(1.05);
        }

        #register:active {
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
	<jsp:include page="/subviews/header.jsp" >
		<jsp:param value="註冊" name="subheader"/>
	</jsp:include>
	
    <div id="container-register">
        <div id="register-area">
            <div id="register-area-title">
                <p>立即註冊</p>
            </div>
            <div id="register-area-register">
                <p>已經擁有 AI筆電商城帳號嗎？</p>
                <a href="./login.jsp">立即登入</a>
            </div>
            <form action="register.do" method="post">
                <div id="register-area-form">
                    <div id="register-area-form-account">
                        <label for="account">帳號:</label>
                        <input type="text" name="account" id="account" placeholder="請輸入帳號" minlength="6" maxlength="20"
                            required>
                    </div>
                    <div id="register-area-form-password">
                        <label for="password">密碼:</label>
                        <input type="password" name="password" id="password" required placeholder="請輸入密碼">
                        <img src="./images/eyes_on.png" id="eyes_on" onclick="showPwd()">
                        <img src="./images/eyes_off.png" id="eyes_off" onclick="hidePwd()">
                    </div>
                    <div id="register-area-form-id">
                        <label for="id">身分證字號:</label>
                        <input type="text" name="id" id="id" placeholder="請輸入身分證字號" pattern="[A-Z][1289][0-9]{8}"
                            required>
                    </div>
                    <div id="register-area-form-email">
                        <label for="email">E-mail:</label>
                        <input type="text" name="email" id="email" placeholder="請輸入E-mail" required>
                    </div>
                    <div id="register-area-form-phone">
                        <label for="phone">電話號碼:</label>
                        <input type="text" name="phone" id="phone" placeholder="請輸入電話號碼" required>
                    </div>
                    <div id="register-area-form-name">
                        <label for="name">姓名:</label>
                        <input type="text" name="name" id="name" placeholder="請輸入姓名" minlength="2" maxlength="20"
                            required>
                    </div>
                    <div id="register-area-form-birthday">
                        <label for="birthday">生日:</label>
                        <input type="date" name="birthday" id="birthday" placeholder="請輸入生日" required max="<%= LocalDate.now().plusYears(-Customer.MIN_AGE)  %>">
                    </div>
                    <div id="register-area-form-gender">
                        <label for="gender">性別:</label>
                        <select name="gender" id="gender" required>
                            <option value="">請選擇性別</option>
                            <option value="<%= Customer.MALE %>">男</option>
                            <option value="<%= Customer.FEMALE %>">女</option>
                            <option value="<%= Customer.OTHERS %>">不願透漏</option>
                        </select>
                    </div>
                    <div id="register-area-form-address">
                        <label for="address">地址:</label>
                        <textarea name="address" id="address" rows="2" cols=30></textarea>
                    </div>
                    <div id="register-area-form-subscribed">
                        <input type="checkbox" name="subscribed" id="subscribed"><label for="subscribed">是否訂閱電子報</label>
                    </div>
                    <div id="register-area-form-captcha">
                        <label for="captcha">驗證碼:</label>
                        <input type="text" name="captcha" id="captcha" required placeholder="請輸入驗證碼">
                    </div>
                    <div id="captcha-img">
                        <img src="./images/captcha.png" alt="" id="captchaImg">
                        <img src="./images/refresh.png" alt="" id="refreshImg" onclick="refreshCaptcha()">
                    </div>
                    <%
 		 					List<String> errors = (List<String>)request.getAttribute("errors");		
					%>
					<div id="theErrorsDiv">	<%= (errors!=null?errors:"")%></div>
                    <div id="register-area-btn">
                        <input type="submit" id="register" value="註冊">
                    </div>
                </div>
            </form>
        </div>
    </div>
    
	<%@include file="/subviews/footer.jsp" %>	
</body>

</html>