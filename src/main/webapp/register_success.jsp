<%@page import="com.ailaptopmall.entity.Customer"%>
<%@page pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>AI筆電商城 註冊成功</title>
    <link rel="stylesheet" type="text/css" href="style/ailm.css">
    <link rel="stylesheet" type="text/css" href="style/header.css">
    <link rel="stylesheet" type="text/css" href="style/footer.css">
    <script src="https://code.jquery.com/jquery-3.0.0.js"
    integrity="sha256-jrPLZ+8vDxt2FnE1zvZXCkCcebI/C8Dt5xyaQBjxQIo=" crossorigin="anonymous"></script>
    <meta http-equiv="refresh" content="5;url=./">
    
    <!-- favicon icon 網頁的icon -->
    <link rel="apple-touch-icon" sizes="180x180" href="./favicon_package/apple-touch-icon.png">
	<link rel="icon" type="image/png" sizes="32x32" href="./favicon_package/favicon-32x32.png">
	<link rel="icon" type="image/png" sizes="16x16" href="./favicon_package/favicon-16x16.png">
	<link rel="manifest" href="./favicon_package/site.webmanifest">
	<link rel="mask-icon" href="./favicon_package/safari-pinned-tab.svg" color="#5bbad5">
	<meta name="msapplication-TileColor" content="#da532c">
	<meta name="theme-color" content="#ffffff">
	<script>
		$(document).ready(function init() {
			$("#search-bar-keyword").focus(focusHandler).blur(blurHandler);
		});
        function focusHandler() {
            $("#darken").show();
        }
        function blurHandler() {
            $("#darken").hide();
        }
	</script>
    <style>
        #container-register-success {
            height: 900px;
            display: flex;
            justify-content: center;
            align-items: center;
            background-image: url(./images/background-img.jpg);
        }
        #register-success-area{
            display: flex;
            justify-content: center;
            align-items: center;
            width: 700px;
            height: 100px;
        }
        #register-success-area p{
            font-size: 20px;
            font-weight: 700;
        }
        #register-success-area a{
            color: #0090eb;
        }
        #darken {
            height: 100vh;
            width: 100vw;
            background-color: rgba(0, 0, 0, 0.7);
            position: fixed;
            top: 0px;
            left: 0px;
            display: none;
        }
    </style>
</head>

<body>
	<jsp:include page="/subviews/header.jsp" >
		<jsp:param value="註冊成功" name="subheader"/>
	</jsp:include>

    <div id="container-register-success">
        <div id="register-success-area">
            <p>
            <%				
				Customer member = (Customer)session.getAttribute("member");
			%>
			<%= member!=null?member.getName():"" %>您好! 註冊成功，5秒後自動轉址至<a href="./">首頁</a>
            </p>
        </div>
    </div>

	<div id="darken"></div>
	
	<%@include file="/subviews/footer.jsp" %>	
</body>

</html>