<%@page pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>404</title>
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
        #container-404 {
            height: 900px;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        #area-404 {
            width: 860px;
            height: 500px;
            display: flex;
        }

        #area-404 img {
            width: 500px;
            height: 500px;
        }

        #area-text-404 h1 {
            font-size: 7.5em;
            margin: 15px 0px;
            font-weight: bold;
        }

        #area-text-404 h2{
            font-weight: bold;
            font-size: 2rem;
            width: 300px;
        }

        #btn{
            margin-top: 30px;
            margin-left: 30px;
            width: 180px;
            height: 50px;
            font-size: 1rem;    
            cursor: pointer;
            border: 4px #2ccf6d solid;
            border-radius: 30px;
            background-color: #fff;
        }

        #btn:hover {
            cursor: pointer;
            transform: scale(1.05);
        }

        #btn:active {
            transform: scale(0.95);  
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
		<jsp:param value="404" name="subheader"/>
	</jsp:include>
	
	<p>找不到檔案: <%= request.getAttribute("javax.servlet.error.request_uri")  %></p>
    <div id="container-404">
        <div id="area-404">
            <img src="<%=request.getContextPath() %>/images/Oops! 404 Error with a broken robot-cuate.png" alt="">
            <div id="area-text-404">
                <h1>404</h1>
                <h2>UH OH! 頁面丟失</h2>
                <p>您所尋找的頁面不存在，您可以點及下方的按鈕，返回主頁。</p>
                <a href="<%=request.getContextPath() %>/index.jsp">
                    <button id="btn">返回首頁</button>
                </a>
            </div>
        </div>
    </div>
    
    <div id="darken"></div>
    
    <%@include file="/subviews/footer.jsp" %>	
    
</body>

</html>