<%@page import="com.ailaptopmall.entity.CartItem"%>
<%@page import="java.util.Set"%>
<%@page import="com.ailaptopmall.entity.ShoppingCart"%>
<%@page pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>

<head>
	<meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>AI筆電商城 購物車</title>
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
     
    </script>
    <style>
    
    	#container-cart{
            height: 1000px;
            background-image: url(../images/background-img.jpg);
       }

		#cartDetails {
			font-family: Helvetica, Arial, sans-serif;
			border-collapse: collapse;
			width: 80%;
			margin: auto;
			padding-top: 100px;
		}
			
		#cartDetails td, #cartDetails th {
			border: 1px solid #ddd;
			padding: 8px;
		}
			
		#cartDetails tr:nth-child(even){
			background-color: #f2f2f2;
		}
			
		#cartDetails tr:hover {
			background-color: #ddd;
		}
			
		#cartDetails caption {
			  padding-top: 12px;
			  padding-bottom: 12px;		  
			  background-color: #ea1717;
			  color: white;
			  margin-top: 80px;	  
		}
			
		#cartDetails tbody input[type=number]{
			width:5ex;
		}
		
		#cartDetails tfoot{
			text-align: right;
		}
		
		.productName{
			font-weight: bold;
		}

		.listPrice{
			text-decoration: line-through;
			font-size: smaller;
			color:gray;
		}
			
		.price{
			font-size: larger;
			color:blue;
		}
		
		#no-cart{
	   		display: flex;
            justify-content: center;
	   }
	   
	   #no-cart h2{
            width: 300px;
			color: #ea1717;
       }
    </style>
</head>
<body>
	<jsp:include page="/subviews/header.jsp" >
		<jsp:param value="購物車" name="subheader"/>
	</jsp:include>
	
		<div id="container-cart">
		
<%-- 			<p>購物車內容: ${sessionScope.cart}</p> --%>
			<%
			
				ShoppingCart cart = (ShoppingCart)session.getAttribute("cart");
				if(cart==null || cart.isEmpty()){
			%>
			
			<div id="no-cart">
	            <h2>購物車是空的!</h2>
	        </div>	
				
			<%} else{%>
			
			<form action="update_cart.do" method="POST">
				<table id="cartDetails">
					<caption>購物明細</caption>					
					<thead>
						<tr>
							<th>編號</th><th>產品名稱 螢幕尺寸 規格</th>
							<th>價格</th>
							<th>數量</th><th>小計</th><th>刪除</th>
						</tr>
					</thead>
					<tbody>
						<% 	Set<CartItem> itemSet = cart.getCartItemsSet();					
							for(CartItem item:itemSet){						
						%>
						<tr>
							<td><%= item.getProductId() %></td>
							<td>
								<a href="../product_detail.jsp?productId=<%=item.getProductId() %>">
									<img style="width:40px;float:left;" src="<%= item.getPhotoUrl() %>">
									<div class='productName'><%= item.getProductName() %></div>
								</a>
								<%= item.getSizeName() %> <%= item.getSpecName() %> 庫存<%= item.getStock() %>件
							</td>
							<td>
								<div><span class='listPrice'><%= item.getListPrice() %></span>元</div> 
								<div><%= item.getDiscountString() %></div> 
								<span class='price'><%= item.getPrice() %></span>元
							</td>						
							<td><input type="number" name="quantity<%=item.hashCode() %>" max="<%= item.getStock() %>" value="<%= cart.getQuantity(item) %>" required>  </td>
							<td><%= cart.getAmount(item) %></td>
							<td><input type="checkbox" name="delete<%=item.hashCode() %>"></td>
						</tr>
						<% } %>
					</tbody>
					<tfoot>
						<tr>
							<td colspan="3">共<%= cart.size() %>項</td>
							<td colspan="1"><%= cart.getTotalQuantity() %>台</td>
							<td colspan="2">總金額: <%= cart.getTotalAmount() %>元</td>
						</tr>
						<tr>
							<td colspan="4"><input type="submit" value="修改購物車"></td>
							<td colspan="2"><button value="checkOut" name="submit">我要結帳</button></td>
						</tr>
					</tfoot>
				</table>
			</form>
			<%} %>
		</div> 
		 
	<%@include file="/subviews/footer.jsp" %>	
</body>
</html>