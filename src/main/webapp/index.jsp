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
    
    <!-- favicon icon 網頁的icon -->
    <link rel="apple-touch-icon" sizes="180x180" href="./favicon_package/apple-touch-icon.png">
	<link rel="icon" type="image/png" sizes="32x32" href="./favicon_package/favicon-32x32.png">
	<link rel="icon" type="image/png" sizes="16x16" href="./favicon_package/favicon-16x16.png">
	<link rel="manifest" href="./favicon_package/site.webmanifest">
	<link rel="mask-icon" href="./favicon_package/safari-pinned-tab.svg" color="#5bbad5">
	<meta name="msapplication-TileColor" content="#da532c">
	<meta name="theme-color" content="#ffffff">
	
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