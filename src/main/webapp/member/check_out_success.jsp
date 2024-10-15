<%@page pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>AI筆電商城 結帳成功</title>
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
        #container-check-out-success {
           	height: 900px;
            display: flex;
            justify-content: center;
            align-items: center;
            background-image: url(../images/background-img.jpg);
        }

        #area-check-out-success {
            width: 1000px;
            height: 500px;
            display: flex;
        }

        #area-check-out-success img {
            width: 500px;
            height: 500px;
        }

        #area-text-check-out-success{
            padding-top: 50px;
        }

        #area-text-check-out-success h2{
            font-weight: bold;
            font-size: 2rem;
            width: 460px;
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
            margin-top: 30px;
            display: block;
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
		<jsp:param value="結帳成功" name="subheader"/>
	</jsp:include>
	
    <div id="container-check-out-success">
        <div id="area-check-out-success">
            <img src="<%=request.getContextPath() %>/images/Shopping bag-pana.png" alt="">
            <div id="area-text-check-out-success">
                <h2>已經收到訂單，感謝您的訂購。</h2>
                <h2>將盡快為您安排出貨!</h2>
                <a href="<%=request.getContextPath() %>/member/orders_history.jsp">
                    <button id="btn">歷史訂單</button>
                </a>
                <a href="<%=request.getContextPath() %>/member/order.jsp?orderId=${order.getId()}">
                    <button id="btn">檢視訂單</button>
                </a>
            </div>
        </div>
    </div>
    
    <div id="darken"></div>
    <%@include file="/subviews/footer.jsp" %>	
    
</body>

</html>