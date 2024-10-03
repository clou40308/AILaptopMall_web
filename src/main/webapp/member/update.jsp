<%@page import="com.ailaptopmall.entity.Customer"%>
<%@page import="java.util.List"%>
<%@page pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>AI筆電商城 修改會員</title>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/style/ailm.css">
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/style/header.css">
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/style/footer.css">
    <script src="https://code.jquery.com/jquery-3.0.0.js"
        integrity="sha256-jrPLZ+8vDxt2FnE1zvZXCkCcebI/C8Dt5xyaQBjxQIo=" crossorigin="anonymous"></script>
        
   	<!-- favicon icon 網頁的icon -->
    <link rel="apple-touch-icon" sizes="180x180" href="<%=request.getContextPath() %>/favicon_package/apple-touch-icon.png">
	<link rel="icon" type="image/png" sizes="32x32" href="<%=request.getContextPath() %>/favicon_package/favicon-32x32.png">
	<link rel="icon" type="image/png" sizes="16x16" href="<%=request.getContextPath() %>/favicon_package/favicon-16x16.png">
	<link rel="manifest" href="<%=request.getContextPath() %>/favicon_package/site.webmanifest">
	<link rel="mask-icon" href="<%=request.getContextPath() %>/favicon_package/safari-pinned-tab.svg" color="#5bbad5">
	<meta name="msapplication-TileColor" content="#da532c">
	<meta name="theme-color" content="#ffffff">
	
     <script>
   		//$(document).ready(init);
		$(init);

		function init(){
			//alert("init");
			$("input[name=changePwd]").on("change", changePwd);
            $("img[name=eyes_on]").on("click", showPwd);
            $("img[name=eyes_off]").on("click", hidePwd);
			<% if(request.getMethod().equals("POST")){ %>
			//修改失敗要呼叫[repopulateFormData()];
			repopulateFormData();
		}
		
		function repopulateFormData(){ //帶入剛才輸入的form data
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
			//進入修改時帶入已登入的會員資料	
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

        function hideNewPwd() {
            //隱藏密碼
            $("#theNewEyes_on").css("display", "inline");
            $("#theNewEyes_off").css("display", "none");
            $("#theNewPassword").attr("type", "password");
        }
        
        function showNewPwd() {
            //顯示密碼
            $("#theNewEyes_on").css("display", "none");
            $("#theNewEyes_off").css("display", "inline");
            $("#theNewPassword").attr("type", "text");
        }

        function changePwd(){ 
        	var isChecked = $(this).prop("checked");
        	$("#theNewPassword").prop("required", $(this).prop("checked"));
      		$("#theNewPassword").prop("disabled", !$(this).prop("checked"));
            //$("#password").prop("disabled", $(this).prop("checked"));
      		//$("#password").prop("required", !$(this).prop("checked"));
      		if($("#theNewPassword").prop("disabled")) theNewPassword.value="";  
            if(isChecked){		
        		$("img[name=theNewEyes_on]").on("click", showNewPwd);
            	$("img[name=theNewEyes_off]").on("click", hideNewPwd);
                $("img[name=eyes_on]").off("click", showPwd);
            	$("img[name=eyes_off]").off("click", hidePwd);
        	}else{
        		 $("img[name=theNewEyes_on]").off("click", showNewPwd);
        	     $("img[name=theNewEyes_off]").off("click", hideNewPwd);
                 $("img[name=eyes_on]").on("click", showPwd);
            	$("img[name=eyes_off]").on("click", hidePwd);
        	}	 
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
            height: 950px;
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
        #update-area-form-id label,
        #update-area-form-email label,
        #update-area-form-phone label,
        #update-area-form-address label,
        #update-area-form-captcha label {
            margin-right: 12px;
            font-size: 18px;
            font-weight: bold;
        }

        #update-area-form-name label{
            margin-right: 12px;
            margin-left: 8px;
            font-size: 18px;
            font-weight: bold;
        }
        
        #update-area-form-birthday label{
        	margin-right: 12px;
            margin-left: 8px;
            font-size: 18px;
            font-weight: bold;
        }
        
		#update-area-form-gender label{
			margin-right: 12px;
            margin-left: 8px;
            font-size: 18px;
            font-weight: bold;
		}
		
        #update-area-form-address label {
            margin-left: 114px;
            margin-right: 12px;
        }

        #update-area-form-account input,
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

		#update-area-form-password {
            width: 400px;
            height: 50px;
            display: flex;
            justify-content: center;
            align-items: center;
            margin-bottom: 10px;
            position: absolute;
            padding-left: 53px;
        }

		#update-area-form-new-password{
			width: 490px;
            height: 85px;
            display: flex;
            justify-content: center;
            align-items: center;
            margin-top: 50px;
            padding-left: 7px;
		}
		
        #update-area-form-password label {
            margin-left: 2px;
            margin-right: 12px;
            font-size: 18px;
            font-weight: bold;
        }
        
       	#theNewPasswordLabel {
            margin-left: 5px;
            margin-right: 9px;
            font-size: 18px;
            font-weight: bold;
        }

        #update-area-form-password input {
            height: 30px;
            width: 170px;
            font-size: 16px;
            border-radius: 4px;
            padding-left: 10px;
            padding-right: 40px;
        }
        
        #theNewPassword {
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
        #theNewEyes_on{
            width: 25px;
            height: 25px;
            position: relative;
            top: 7px;
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

        #theNewEyes_off{
            width: 25px;
            height: 25px;
            display: none;
            position: relative;
            top: 7px;
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
	<jsp:include page="/subviews/header.jsp" >
		<jsp:param value="修改會員" name="subheader"/>
	</jsp:include>
	
    <div id="container-update">
        <div id="update-area">
            <div id="update-area-title">
                <p>修改會員</p>
            </div>
            <form action="update.do" method="POST">
                <div id="update-area-form">
                    <div id="update-area-form-account">
                        <label for="account">帳號:</label>
                        <input type="text" name="account" id="account" placeholder="請輸入帳號" minlength="6" maxlength="20"
                            readonly>
                    </div>
                    <div id="update-area-form-password">
                        <label for="password">原密碼:</label>
                        <input type="password" name="password" id="password" required placeholder="請輸入密碼" minlength="6" maxlength="20">
                        <img src="../images/eyes_on.png" name="eyes_on"  id="eyes_on" >
                        <img src="../images/eyes_off.png" name="eyes_off" id="eyes_off" >
                    </div>
                    <div id="update-area-form-new-password">
                        <fieldset>
                            <legend><input type="checkbox"  name="changePwd" >要修改密碼</legend>
                            <label for="theNewPassword" id="theNewPasswordLabel">新密碼:</label>
                            <input type="password" name="theNewPassword" id="theNewPassword" disabled placeholder="請輸入密碼" minlength="6" maxlength="20">
                            <img src="../images/eyes_on.png" name="theNewEyes_on" id="theNewEyes_on" >
                            <img src="../images/eyes_off.png" name="theNewEyes_off" id="theNewEyes_off">
                        </fieldset>
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
    
	<%@include file="/subviews/footer.jsp" %>	
</body>

</html>