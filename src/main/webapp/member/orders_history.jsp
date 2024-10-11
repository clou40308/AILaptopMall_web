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
            height:800px;
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
        
        form{
        	text-align:center;
        }
        					
		ul{
			width:90%;margin: auto; box-shadow: gray 2px 2px 5px;padding: 1ex;
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
	</style>
</head>
<body>
	<jsp:include page="/subviews/header.jsp" >
		<jsp:param value="歷史訂單" name="subheader"/>
	</jsp:include>
	
	<div id="container-orders-history">
	
		<%@include file="../subviews/nav.jsp" %>
		
		<article >
			<form>
				查詢範圍: 
					<input type="radio" value="1" name="range" required checked><label>1個月</label>
					<input type="radio" value="2" name="range" required><label>2個月</label>
					<input type="radio" value="6" name="range" required><label>半年</label>
					<input type="radio" value="24" name="range" required><label>2年</label> 內
					<input type='submit' value="查詢訂單">
			</form>	
			
			<%
				String range = request.getParameter("range");
				if(range == null || range.length()==0) range="1";
				
				Customer member =(Customer)session.getAttribute("member"); //這裡不須宣告 已經在nav.jsp子網頁宣告
				List <Order> list = null;
				OrderService oService = new OrderService();
				list = oService.getOrdersHistory(member);
			%>
			
			<% if(list == null || list.size() == 0) {%>	
			
				<p>指定日期範圍(1個月)內，查無歷史訂單!</p>
				
			<% }else{%>	
			
			<ul type=none>
				<h3>歷史訂單</h3>
				<% for(Order order :list){%>
				<li>
					<div><%=order.getId() %></div><div><%=order.getCreatedDate() %>,<%=order.getCreatedTime() %></div>
					<div><%=order.getStatus() %></div><div><%=order.getShippingType().getDescription() %> <%=order.getPaymentType().getDescription() %></div>
					<div><%=order.getTotalAmount() %></div><div> 總金額(含手續費)<%=order.getTotalAmountWithFee()%>元</div>
					<a href="order.jsp?orderId=<%=order.getId() %>">檢視明細</a>
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