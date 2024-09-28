<%@page import="com.ailaptopmall.entity.Customer"%>
<%@page pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>AI筆電商城 修改會員成功</title>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/style/ailm.css">
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/style/header.css">
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/style/footer.css">
    <meta http-equiv="refresh" content="5;url=../">
    <style>
        #container-login-success {
            height: 750px;
            display: flex;
            justify-content: center;
            align-items: center;
            background-image: url(../images/background-img.jpg);
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
		<jsp:param value="修改會員成功" name="subheader"/>
	</jsp:include>

    <div id="container-login-success">
        <div id="login-success-area">
            <p>
            <%				
				Customer member = (Customer)session.getAttribute("member");
			%>
			<%= member!=null?member.getName()+"，" : "" %>您好! 修改成功，5秒後自動轉址至<a href="../">首頁</a>
            </p>
        </div>
    </div>

	<%@include file="/subviews/footer.jsp" %>	
</body>

</html>