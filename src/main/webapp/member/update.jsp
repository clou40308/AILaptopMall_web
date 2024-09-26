<%@page import="com.ailaptopmall.entity.Customer"%>
<%@page import="java.util.List"%>
<%@page pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>AI筆電商城 更新會員資料</title>
    <link rel="stylesheet" type="text/css" href="../style/ailm.css">
    <link rel="stylesheet" type="text/css" href="../style/header.css">
    <link rel="stylesheet" type="text/css" href="../style/footer.css">
    <script src="https://code.jquery.com/jquery-3.0.0.js"
        integrity="sha256-jrPLZ+8vDxt2FnE1zvZXCkCcebI/C8Dt5xyaQBjxQIo=" crossorigin="anonymous"></script>
     <script>
   		//$(document).ready(init);
		$(init);

		function init(){
			//alert("init");
			<% if(request.getMethod().equals("POST")){ %>
			//修改失敗要呼叫[repopulateFormData()];
			repopulateFormData();
		}
		
		function repopulateFormData(){  //帶入剛才輸入的form data
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
			
			<% }else{%>
			
			$("input[name=account]").val('${sessionScope.member.getAccount()}');
			$("input[name=password]").val('${sessionScope.member.getPassword()}');
			$("input[name=id]").val('${sessionScope.member.getId()}');
			$("input[name=email]").val('${sessionScope.member.getEmail()}');
			$("input[name=phone]").val('${sessionScope.member.getPhone()}');
			$("input[name=name]").val('${sessionScope.member.getName()}');
			$("input[name=birthday]").val('${sessionScope.member.getBirthday()}');
			$("textarea[name=address]").text('${sessionScope.member.getAddress()}');
			
			$("select[name=gender]").val('${sessionScope.member.getGender()}');
			$("input[name=subscribed]").prop('checked', ${sessionScope.member.isSubscribed()});
			
			<% } %>
		}
        function refreshCaptcha() {
            //更新驗證碼
            captchaImg.src = "images/captcha.png?renew=" + new Date();
        }
    </script>
    <style>
        #container-update {
            height: 1000px;
            display: flex;
            justify-content: center;
            align-items: center;
            background-image: url(../images/background-img.jpg);
        }

        #update-area {
            background-color: #fff;
            height: 900px;
            width: 500px;
        }

        #update-area-title {
            width: 100%;
            height: 60px;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        #update-area-title p {
            font-size: 22px;
            font-weight: 700;
        }

        #update-area-form-account,
        #update-area-form-password,
        #update-area-form-id,
        #update-area-form-email,
        #update-area-form-phone,
        #update-area-form-name,
        #update-area-form-birthday,
        #update-area-form-gender,
        #update-area-form-captcha {
            width: 100%;
            height: 50px;
            display: flex;
            justify-content: center;
            align-items: center;
            margin-top: 5px;
        }

        #update-area-form-address {
            width: 100%;
            height: 80px;
            display: flex;
            align-items: center;
            margin-top: 5px;
        }

        #update-area-form-subscribed {
            width: 100%;
            height: 50px;
            display: flex;
            align-items: center;
        }
        #update-area-form-subscribed input{
            margin-left: 167px;
        }

        #update-area-form-subscribed label{
            margin-left: 12px;
            font-size: 16px;
            font-weight: bold;
        }

        #update-area-form-account label,
        #update-area-form-password label,
        #update-area-form-id label,
        #update-area-form-email label,
        #update-area-form-phone label,
        #update-area-form-name label,
        #update-area-form-birthday label,
        #update-area-form-gender label,
        #update-area-form-address label,
        #update-area-form-captcha label {
            margin-right: 12px;
            font-size: 18px;
            font-weight: bold;
        }

        #update-area-form-address label {
            margin-left: 104px;
            margin-right: 20px;
        }

        #update-area-form-account input,
        #update-area-form-password input,
        #update-area-form-id input,
        #update-area-form-email input,
        #update-area-form-phone input,
        #update-area-form-name input,
        #update-area-form-birthday input,
        #update-area-form-captcha input {
            height: 30px;
            width: 200px;
            font-size: 16px;
            border-radius: 4px;
            padding-left: 10px;
            padding-right: 10px;
        }

        #update-area-form-id input {
            margin-right: 50px;
        }

        #update-area-form-email input {
            margin-right: 14px;
        }

        #update-area-form-phone input {
            margin-right: 28px;
        }

        #update-area-form-name input,
        #update-area-form-birthday input {
            margin-left: 8px;
        }

        #update-area-form-captcha input {
            margin-right: 17px;
        }

        #update-area-form-gender select {
            height: 33px;
            width: 225px;
            font-size: 16px;
            border-radius: 4px;
            padding-left: 10px;
            padding-right: 10px;
            margin-left: 8px;
        }

        #update-area-form-address textarea {
            height: 50px;
            width: 230px;
            font-size: 16px;
            border-radius: 4px;
            padding-left: 10px;
            padding-right: 10px;
            padding-top: 5px;
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

        #update-area-btn {
            width: 100%;
            height: 60px;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        #update {
            font-size: 16px;
            width: 200px;
            border-radius: 5px;
            height: 30px;
            background-color: #dc0001;
            border: none;
            color: #fff;
        }

        #update:hover {
            cursor: pointer;
            transform: scale(1.05);
        }

        #update:active {
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
	<jsp:include page="../subviews/header.jsp" />
	
    <div id="container-update">
        <div id="update-area">
            <div id="update-area-title">
                <p>更新會員資料</p>
            </div>
            <form action="update.do" method="post">
                <div id="update-area-form">
                    <div id="update-area-form-account">
                        <label for="account">帳號:</label>
                        <input type="text" name="account" id="account" placeholder="請輸入帳號" minlength="6" maxlength="20"
                             >
                    </div>
                    <div id="update-area-form-password">
                        <label for="password">密碼:</label>
                        <input type="password" name="password" id="password" placeholder="請輸入密碼" minlength="6"
                            maxlength="20" required>
                    </div>
                    <div id="update-area-form-id">
                        <label for="id">身分證字號:</label>
                        <input type="text" name="id" id="id" placeholder="請輸入身分證字號" pattern="[A-Z][1289][0-9]{8}"
                            required>
                    </div>
                    <div id="update-area-form-email">
                        <label for="email">E-mail:</label>
                        <input type="text" name="email" id="email" placeholder="請輸入E-mail" required>
                    </div>
                    <div id="update-area-form-phone">
                        <label for="phone">電話號碼:</label>
                        <input type="text" name="phone" id="phone" placeholder="請輸入電話號碼" required>
                    </div>
                    <div id="update-area-form-name">
                        <label for="name">姓名:</label>
                        <input type="text" name="name" id="name" placeholder="請輸入姓名" minlength="2" maxlength="20"
                            required>
                    </div>
                    <div id="update-area-form-birthday">
                        <label for="birthday">生日:</label>
                        <input type="date" name="birthday" id="birthday" placeholder="請輸入生日" required max="<%= LocalDate.now().plusYears(-Customer.MIN_AGE)  %>">
                    </div>
                    <div id="update-area-form-gender">
                        <label for="gender">性別:</label>
                        <select name="gender" id="gender" required>
                            <option value="">請選擇性別</option>
                            <option value="<%= Customer.MALE %>">男</option>
                            <option value="<%= Customer.FEMALE %>">女</option>
                            <option value="<%= Customer.OTHERS %>">不願透漏</option>
                        </select>
                    </div>
                    <div id="update-area-form-address">
                        <label for="address">地址:</label>
                        <textarea name="address" id="address" rows="2" cols=30></textarea>
                    </div>
                    <div id="update-area-form-subscribed">
                        <input type="checkbox" name="subscribed" id="subscribed"><label for="subscribed">是否訂閱電子報</label>
                    </div>
                    <div id="update-area-form-captcha">
                        <label for="captcha">驗證碼:</label>
                        <input type="text" name="captcha" id="captcha" required placeholder="請輸入驗證碼">
                    </div>
                    <div id="captcha-img">
                        <img src="../images/captcha.png" alt="" id="captchaImg">
                        <img src="../images/refresh.png" alt="" id="refreshImg" onclick="refreshCaptcha()">
                    </div>
                    <%
 		 					List<String> errors = (List<String>)request.getAttribute("errors");		
					%>
					<div id="theErrorsDiv">	<%= (errors!=null?errors:"")%></div>
                    <div id="update-area-btn">
                        <input type="submit" id="update" value="送出">
                    </div>
                </div>
            </form>
        </div>
    </div>
    
	<%@include file="../subviews/footer.jsp" %>	
</body>

</html>