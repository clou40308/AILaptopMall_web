<%@page pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>AI筆電商城 首頁</title>
    <link rel="stylesheet" type="text/css" href="style/ailm.css">
    <link rel="stylesheet" type="text/css" href="style/header.css">
    <link rel="stylesheet" type="text/css" href="style/footer.css">
    <style>
        /* site-logo css */
        #site-logo {
            height: 60px;
            background-color: black;
            display: flex;
            justify-content: center;
            align-items: center;
        }
        /* site-logo css */
    </style>
</head>

<body>
	<jsp:include page="/subviews/header.jsp" />
	
    <div id="site-logo">
        <div>
            <img src="./images/logo-ai.png" alt="">
        </div>
    </div>
    
	<%@include file="/subviews/footer.jsp" %>	
</body>

</html>