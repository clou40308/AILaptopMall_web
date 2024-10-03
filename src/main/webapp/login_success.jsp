<%@page import="com.ailaptopmall.entity.Customer"%>
<%@page pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>AI筆電商城 登入成功</title>
    <link rel="stylesheet" type="text/css" href="style/ailm.css">
    <link rel="stylesheet" type="text/css" href="style/header.css">
    <link rel="stylesheet" type="text/css" href="style/footer.css">
    <meta http-equiv="refresh" content="5;url=${requestScope.previous_uri==null?"./":previous_uri}">
    
    <!-- favicon icon 網頁的icon -->
    <link rel="apple-touch-icon" sizes="180x180" href="./favicon_package/apple-touch-icon.png">
	<link rel="icon" type="image/png" sizes="32x32" href="./favicon_package/favicon-32x32.png">
	<link rel="icon" type="image/png" sizes="16x16" href="./favicon_package/favicon-16x16.png">
	<link rel="manifest" href="./favicon_package/site.webmanifest">
	<link rel="mask-icon" href="./favicon_package/safari-pinned-tab.svg" color="#5bbad5">
	<meta name="msapplication-TileColor" content="#da532c">
	<meta name="theme-color" content="#ffffff">
	
    <style>
        #container-login-success {
            height: 750px;
            display: flex;
            justify-content: center;
            align-items: center;
            background-image: url(./images/background-img.jpg);
        }
        #login-success-area{
            display: flex;
            justify-content: center;
            align-items: center;
            width: 700px;
            height: 100px;
        }
        #login-success-area p{
            font-size: 20px;
            font-weight: 700;
        }
        #login-success-area a{
            color: #0090eb;
        }
    </style>
</head>

<body>
	<jsp:include page="/subviews/header.jsp" >
		<jsp:param value="登入成功" name="subheader"/>
	</jsp:include>

    <div id="container-login-success">
        <div id="login-success-area">
            <p>
            <%				
				Customer member = (Customer)session.getAttribute("member");
			%>
			<%= member!=null?member.getName()+"，" : "" %>您好! 登入成功，5秒後自動轉址至<a href="${previous_uri==null?"./":previous_uri}">指定的網頁或首頁</a>
            </p>
        </div>
    </div>

	<%@include file="/subviews/footer.jsp" %>	
</body>

</html>