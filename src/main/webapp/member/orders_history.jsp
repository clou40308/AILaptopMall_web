<%@page import="com.ailaptopmall.entity.Customer"%>
<%@page import="com.ailaptopmall.service.OrderService"%>
<%@page import="com.ailaptopmall.entity.Order"%>
<%@page import="java.util.List"%>
<%@page pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>

<head>
	<meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>AI筆電商城 歷史訂單</title>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/style/ailm.css">
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/style/header.css">
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/style/footer.css">
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/style/nav.css">
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
			$('#hover-container').hover(
	    	      function() {
	    	        $('#hover-div').stop(true, true).fadeIn();  // 滑鼠移入
	    	      },
	    	      function() {
	    	        $('#hover-div').stop(true, true).fadeOut(); // 滑鼠移出
	    	      }
	   	    );
		});
	    function focusHandler() {
	        $("#darken").show();
	    }
	    function blurHandler() {
	        $("#darken").hide();
	    }
	</script>
	<style>
		#container-orders-history{
            background-image: url(../images/background-img.jpg);
            height:1000px;
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
           					
		ul{
			width:90%;
			margin: auto; 
			box-shadow: gray 2px 2px 5px;
			padding: 1ex;
			background-color: #fff;
			font-size: 18px;
		}
		
		ul h3{
			text-align: center;
		}
		
		li div:nth-child(odd){
			display: inline-block;
			width:10em;
		}
		
		li div:nth-child(even){
			display: inline-block;
			width:15em;
		}
		
		li div:first-child{
			display: inline-block;
			width:2em;
		}
		
		li{
			padding:0px 80px;
		}

		#no-orders-history{
            display: flex;
            justify-content: center;
        }

        #no-orders-history h2{
            width: 500px;
			color: #ea1717;
        }
        
		#form-orders-history{
			padding-bottom: 1em;
			margin-top: 20px;
			font-size: 24px;
			height: 25px;
			display: flex;
			justify-content: center;
			align-items: center;
		}

		#order-submit{
			margin-left: 20px;
			background-color: #ea1717;
			color: #fff;
			width: 85px;
			height: 30px;
			border: 0px;
			border-radius: 5px;
		}
		
		#order-submit:hover {
            cursor: pointer;
            transform: scale(1.05);
        }

		#order-submit:active {
            transform: scale(0.95);  
        }
	
		#a-order{
			color:blue;
		}
	</style>
</head>
<body>
	<jsp:include page="/subviews/header.jsp" >
		<jsp:param value="歷史訂單" name="subheader"/>
	</jsp:include>
	
	<div id="container-orders-history">
	
		<%@include file="../subviews/nav.jsp" %>
		
		<article >
			<form >
				<div id="form-orders-history">
						查詢範圍: 
							<input type="radio" value="1" name="range" id="1month" required checked><label for="1month">1個月</label>
							<input type="radio" value="2" name="range" id="2months" required><label for="2months">2個月</label>
							<input type="radio" value="6" name="range" id="6months" required><label for="6months">半年</label>
							<input type="radio" value="24" name="range" id="24months" required><label for="24months">2年內</label> 
							<input id="order-submit" type='submit' value="查詢訂單">
				</div>
			</form>
			
			<%
					String range = request.getParameter("range");	
					if(range==null) range="1";
					int rangeNum=1;				
					switch(range){
						case "1":
						case "2":
						case "6":
						case "24":
							rangeNum = Integer.parseInt(range);
					}
					
					Customer member = (Customer)session.getAttribute("member"); //這裡不須宣告 已經在nav.jsp子網頁宣告
					List<Order> list = null;
					OrderService oService = new OrderService();
					list = oService.getOrdersHistory(member, rangeNum);	
			%>
			
			<% if(list == null || list.size() == 0) {%>	
			
				<div id="no-orders-history">
		            <h2>指定日期範圍(<%=rangeNum %>個月)內，查無歷史訂單!</h2>
		        </div>	
				
			<% }else{%>	
			
			<ul type=none>
				<h3>歷史訂單</h3>
				<% for(Order order:list) {%>
				<li>
					<div><%=order.getId() %></div><div><%= order.getCreatedDate() %>, <%= order.getCreatedTime() %></div>
					<div><%= order.getStatusDescription() %></div><div><%= order.getShippingType().getDescription() %> <%= order.getPaymentType().getDescription() %></div>
					<div><%= order.getTotalAmount() %>元</div><div> 總金額(含手續費)<%= order.getTotalAmountWithFee() %>元</div>
					<a id="a-order" href="order.jsp?orderId=<%=order.getId() %>">檢視明細</a>
					<hr>
				</li>
				<% } %>
			</ul>
			<% }%>
		</article>
	</div>  

	<div id="darken"></div>
   
    <%@include file="/subviews/footer.jsp" %>	
    
</body>
</html>