<%@page import="com.ailaptopmall.entity.Customer"%>
<%@page import="com.ailaptopmall.entity.PaymentType"%>
<%@page import="com.ailaptopmall.service.OrderService"%>
<%@page import="com.ailaptopmall.entity.Order"%>
<%@page pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>通知已轉帳</title>
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
        #container-atm-transfered {
            height: 800px;
            display: flex;
            justify-content: center;
            align-items: center;
            background-image: url(../images/background-img.jpg);
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
        
        #no-atm-transfered{
            display: flex;
            justify-content: center;
        }

        #no-atm-transfered h2{
            width: 500px;
			color: #ea1717;
        }
        
        form p label:first-child {
	        display: inline-block;
	        min-width: 5em;
        }
        
        #theErrorsDiv{
        	color: darkred;
        }
        
        #back-orders-history{
        	color: blue;
        	text-decoration:underline;
        }
    </style>
</head>

<body>
	<jsp:include page="/subviews/header.jsp" >
		<jsp:param value="通知已轉帳" name="subheader"/>
	</jsp:include>
	
    <div id="container-atm-transfered">
		
		<%  
			Customer member = (Customer)session.getAttribute("member");
	        String orderId = request.getParameter("orderId");
	        Order order = null;
	        OrderService oService = new OrderService();
	        if(member!=null && orderId!=null){
	            order = oService.getOrderById(member, orderId);
	        }
    	%>

   <article>
	    <% if(order==null || !(PaymentType.ATM==order.getPaymentType() && order.getStatus()==0)){%>
	          	<div id="no-atm-transfered">
            		<h2>查無需通知轉帳的訂單資料，回<a id="back-orders-history" href='orders_history.jsp'>歷史訂單</a></h2>
        		</div>	
	    <% }else{%>
			    <form action='atm_transfered.do' method='POST' style='width: 20em;margin: auto;'>
			    	<div id="theErrorsDiv">	${errors}</div>
			        <p>
			            <label>訂單編號:</label>
			            <input type='hidden' name='orderId' value='<%= orderId%>' readonly>
			            <input value='<%= order.getId()%>' readonly>
			        </p>
			        <p>
			            <label>轉帳銀行:</label>
			            <input name='bank' required placeholder='請輸入轉帳銀行名稱'>
			        </p>
			        <p>
			            <label>帳號後5碼:</label>
			            <input name='last5Code' required placeholder='請輸入轉帳帳號後5碼'>
			        </p>
			        <p>
			            <label>轉帳金額:</label>
			            <input name='amount' name='amount' required value='<%= order.getTotalAmountWithFee() %>' >
			        </p>
			        <p>
			            <label>轉帳時間:</label>
			            <input type='date' name='transDate' required min='<%= order.getCreatedDate()%>' max='<%= LocalDate.now()%>'>
			            <input type='time' name='transTime' required>
			        </p>
			
			        <p style='text-align:right'>
			            <input type="reset" value='Reset'>
			            <input type="submit" value='確定'>
			        </p>
			    </form>
   		<% } %>
   </article>
    </div>
    
    <div id="darken"></div>
    
    <%@include file="/subviews/footer.jsp" %>	
    
</body>

</html>