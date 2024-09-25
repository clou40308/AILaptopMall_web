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
    <meta http-equiv="refresh" content="5;url=./">
    <style>
        #container-register-success {
            height: 750px;
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
    </style>
</head>

<body>
	<jsp:include page="./subviews/header.jsp" />

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

	<%@include file="./subviews/footer.jsp" %>	
</body>

</html>