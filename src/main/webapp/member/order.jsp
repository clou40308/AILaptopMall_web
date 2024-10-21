<%@page import="com.ailaptopmall.entity.OrderStatusLog"%>
<%@page import="java.util.List"%>
<%@page import="com.ailaptopmall.entity.Customer"%>
<%@page import="com.ailaptopmall.entity.OrderItem"%>
<%@page import="com.ailaptopmall.service.OrderService"%>
<%@page import="com.ailaptopmall.entity.Order"%>
<%@page import="com.ailaptopmall.entity.PaymentType"%>
<%@page import="com.ailaptopmall.entity.ShippingType"%>
<%@page import="com.ailaptopmall.entity.CartItem"%>
<%@page import="java.util.Set"%>
<%@page import="com.ailaptopmall.entity.ShoppingCart"%>
<%@page pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>

<head>
	<meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>AI筆電商城 檢視訂單明細</title>
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
    
    	#container-order{
            height: 1000px;
            background-image: url(../images/background-img.jpg);
       }

		#no-order{
	   		display: flex;
            justify-content: center;
	   }
	   
	   #no-order h2{
            width: 300px;
			color: #ea1717;
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
        
        #orderDataDiv{
	        width: 85%;
	        margin: auto;
        }
        
		#orderDataDiv fieldset label{
			display: inline-block; 
			min-width: 3.5em;
		}
		
		#orderDataDiv input{
			color:blue;
		}
			
		.statusSpan{
			display: inline-block;
			width: 70px;
			height: 50px;
			padding-top:1em; 
			font-size: 18px;
			background-color: orange;
			color:white;
			text-align: center;
			border-radius: 1ex;
		}
		
		.notYet{
			background-color:lightgray;
		}
				
		#orderDetails{
			font-family:  Helvetica, Arial, sans-serif;
			font-size:smaller;
			margin:auto;
			border-collapse: collapse;
			width: 98%;
		}
	  
		#orderDetails tr:nth-child(even){
			background-color: #f2f2f2;
		}
			
		#orderDetails tr:hover {
			background-color: #ddd;
		}
			
		#orderDetails caption {
			padding-top: 12px;
			padding-bottom: 12px;		  
			background-color: #ea1717;
			color: white;
			margin-top: 30px;	  
		}
			
		#orderDetails tbody input[type=number]{
			width:5ex;
		}
		
		#orderDetails tfoot{
			text-align: right
		}

		summary{
	   		font-size: 20px;
			margin-top: 40px;
	   }
	   
	   fieldset{
			width: 40%;
			margin-left: 400px;
			padding-left: 50px;
	  }

	    fieldset label{
			font-size: 20px;
	   }

	   fieldset div{
			margin-top: 15px;
	   }
	   
	   #fieldset-name,
	   #fieldset-phone{
			height: 25px;
			width: 200px;
			font-size: 20px;
	   }
	   
	   #fieldset-email{
	   		height: 25px;
			width: 280px;
			font-size: 20px;
	   }
	   
	   #fieldset-shipping-address{
	   		height: 25px;
			width: 565px;
			font-size: 20px;
	   }

	   #recipient{
		font-size: 18px;
	   }
	   
	   #status-area{
	   		margin: auto;
	   		width:500px;
			font-size: 24px;
			font-weight: 550;
	   }
		
	   #shippingTypeSpan,
	   #orderIdSpan{
			font-size: 24px;
	   }
	   
	   #totalAmountWithFee{
			font-size: large;
			font-weight: bolder;
			color:red;
			font-size: 24px;
		}

	   #paymentTypeSpan ,
	   #totalAmountWithFeeSpan,
	   #orderTimeSpan,
	   #orderStatusSpan{
	   		font-size: 24px;
			margin-left: 40px;
	   }

	   #shippingTypeSpan input,
	   #paymentTypeSpan input,
	   #orderStatusSpan input,
	   #orderIdSpan input{
			width:180px;
			height:25px;
			font-size: 20px;
	   }
	   
	   #orderTimeSpan input{
	   		width:230px;
			height:25px;
			font-size: 20px;
	   }
	   
	   #notification-of-transfer{
	   		font-size: 24px;
	   		margin-left: 40px;
	   		color:blue;
	   		text-decoration:underline;
	   }
    </style>
</head>
<body>
	<jsp:include page="/subviews/header.jsp" >
		<jsp:param value="檢視訂單明細" name="subheader"/>
	</jsp:include>
	
		<div id="container-order">
		
			<%@include file="../subviews/nav.jsp" %>

			<%
				Customer member = (Customer)session.getAttribute("member");
				String orderId = request.getParameter("orderId");
				Order order = null;
				List<OrderStatusLog> statusLogList = null;
				OrderService oService = new OrderService();
				if(orderId!=null){
					order = oService.getOrderById(member, orderId);
					if(order!=null){
			             statusLogList = oService.getOrderStatusLog(orderId);
			        }
				}
			%>
			<% if(order==null){%>
			<div id="no-order">
	            <h2>查無此訂單!</h2>
	        </div>	
				
			<%} else{%>
			<div id="orderDataDiv">
				<p>	
					<span id="orderIdSpan">
						<label>訂單編號: </label><input readonly value="<%= order.getId() %>">
					</span>		
					<span id="orderTimeSpan">
						<label>訂購時間: </label><input readonly value="<%= order.getCreatedDate()%>, <%= order.getCreatedTime() %>">	
					</span>
					<span id="orderStatusSpan">
						<label>處理狀態: </label><input readonly value="<%= order.getStatus() %> (<%= order.getStatusDescription()%>)"> 
					</span>		
				</p>
				<p>
					<span id="shippingTypeSpan">
						<label>貨運方式: </label><input readonly value="<%= order.getShippingType().getDescription() %>">
					</span>
					<span id="paymentTypeSpan">
						<label>付款方式: </label>
						<input readonly value="<%= order.getPaymentType().getDescription() %>">
					</span>		
					
					<% if(order.getStatus()==0 && order.getPaymentType()==PaymentType.ATM){ %>
							<a id="notification-of-transfer" href="atm_transfered.jsp?orderId=<%=order.getId()%>">通知已轉帳</a>
					<% } %>
					
					<span id="totalAmountWithFeeSpan"> 
						<label>總金額(含物流費):
							<span id="totalAmountWithFee"><%= order.getTotalAmountWithFee() %></span>元
						</label>
					</span>				
				</p>		
				<div id="status-area">
					<span class='statusSpan' title="<%= order.getCreatedDate()%>, <%= order.getCreatedTime() %>"><%= order.getStatusDescription(0)%></span> > 
					<% if(order.getPaymentType()==PaymentType.ATM || order.getPaymentType()==PaymentType.CARD){%>
					<span class='statusSpan notYet orderStatus1 orderStatus2' title="2024-10-11, 14:05:18"><%= order.getStatusDescription(2)%></span> >
					<% } %>
					<span class='statusSpan notYet orderStatus3'><%= order.getStatusDescription(3)%></span> >					
					<% if(order.getPaymentType()==PaymentType.SHOP || order.getPaymentType()==PaymentType.STORE){%>
					<span class='statusSpan notYet orderStatus4' title="2024-10-11, 14:05:18"><%= order.getStatusDescription(4)%></span> >
					<% } %>
					
					<span class='statusSpan notYet orderStatus5'><%= order.getStatusDescription(5)%></span> >
					<span class='statusSpan notYet orderStatus6 '><%= order.getStatusDescription(6)%></span>
				</div>
							
				<fieldset>
					<legend id="recipient">收件人</legend>
					<div><label>姓名:</label><input id="fieldset-name" value="<%= order.getRecipientName() %>" readonly></div>
					<div><label>手機:</label><input id="fieldset-phone" value="<%= order.getRecipientPhone() %>" readonly></div>
					<div><label>Email:</label><input id="fieldset-email" type="email" value="<%= order.getRecipientEmail() %>" readonly></div>
					<div><label>地址:</label><input id="fieldset-shipping-address" readonly value="<%= order.getShippingAddress() %>"></div>
				</fieldset>

				
				<details>
					<summary>共<%= order.getTotalQuantity() %>件, 總金額: <span id="totalAmount"><%= order.getTotalAmount() %></span>元 (點選即可看到明細)</summary>
					<table id="orderDetails">
						<caption>購物明細</caption>					
						<thead>
							<tr>
								<th>編號</th><th>產品名稱 螢幕尺寸 規格</th>
								<th>售價</th>
								<th>數量</th><th>小計</th>
							</tr>
						</thead>
						<tbody>			
							<% for(OrderItem item:order.getOrderItemsSet()){ %>				
							<tr>
								<td><%= item.getProductId()%></td>
								<td>
									<img style="width:40px;float:left;" src="<%= item.getPhotoUrl()%>">
									<div class='productName'><%= item.getProductName()%></div>									
									<%= item.getSizeName()%> <%= item.getSpecName()%>
								</td>
								<td>
									<span class='price'><%= item.getPrice()%></span>元
								</td>						
								<td><%= item.getQuantity()%></td>
								<td><%=item.getAmount() %></td>							
							</tr>
							<% } %>
						</tbody>
						<tfoot>
							<tr>
								<td colspan="2">共<%= order.size()%>項</td>
								<td colspan="1"><%= order.getTotalQuantity()%>件</td>
								<td colspan="2">總金額: <span id="totalAmount"><%= order.getTotalAmount()%></span>元</td>
							</tr>						
						</tfoot>
					</table>
				</details>
			</div>
			<%} %>
		</div> 
	
	<div id="darken"></div>	 
	
	<%@include file="/subviews/footer.jsp" %>	
</body>
	<script>
        $(setStatus); //帶入狀態log資料
        function setStatus(){
             <% if(statusLogList!=null && statusLogList.size()>0){
                 for(OrderStatusLog log:statusLogList){%>
                 	  //alert(<%= log.getStatus() %>); //for test
                      $(".orderStatus<%= log.getStatus() %>").removeClass("notYet");                      
                      $(".orderStatus<%= log.getStatus() %>").attr("title", "<%= log.getLogTime()%>");
                      if($(".orderStatus<%= log.getStatus()-1 %>").hasClass("notYet")){
                          $(".orderStatus<%= log.getStatus()-1 %>").removeClass("notYet");
                      }
             <%  }}%>
        }
        //自訂的javascript function
    </script>	
</html>