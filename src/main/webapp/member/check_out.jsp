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
    <title>AI筆電商城 結帳</title>
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
	$(init);
	
	function init(){
		$("#convenience-store-button").hide();
		<%if("POST".equals(request.getMethod())) { %>
		repopulateFormData();				
	}

	function repopulateFormData(){
		$("select[name=shippingType]").val("${param.shippingType}");
		$("select[name=paymentType]").val("${param.paymentType}");
		$("input[name=name]").val("${param.name}");
		$("input[name=email]").val("${param.email}");
		$("input[name=phone]").val("${param.phone}");
		$("select[name=shippingType]").trigger("change");
		$("select[name=paymentType]").trigger("change");				
		$("input[name=shippingAddress]").val("${param.shippingAddress}");
		<% } %>
	}
	
	function copyMemberData(){
		//alert("copyMemberData");				
		$("input[name=name]").val("${sessionScope.member.getName()}");
		$("input[name=email]").val("${sessionScope.member.getEmail()}");
		$("input[name=phone]").val("${sessionScope.member.getPhone()}");
		if($("select[name=shippingType]").val()=="${ShippingType.HOME.name()}"){
			$("input[name=shippingAddress]").val("${sessionScope.member.getAddress()}");
		}
	}
	
	function changePaymentOption(){				
		$("select[name=paymentType] option").prop("disabled", true);
		$("select[name=paymentType] option[value='']").removeAttr("disabled");
		
		if($("select[name=shippingType] option:selected").val()!=''){
			var array = $("select[name=shippingType] option:selected").attr("data-array").split(',');
			for(i=0;i<array.length;i++){
				$("select[name=paymentType] option[value='"+array[i]+"']").removeAttr("disabled");
			}
		}
		
		if($("select[name=paymentType] option:selected").prop("disabled")){
			$("select[name=paymentType]").val("");
		}
		
		changeShippingAddress($("select[name=shippingType]").val());
		calculateFee();
	}
	
	function changeShippingAddress(shippingType){
		console.log("貨運方式: ", shippingType);
		
		//TODO:調整shippingAddress的輸入方式
		$("input[name=shippingAddress]").removeAttr("list");
		$("input[name=shippingAddress]").attr("required", true);
		$("input[name=shippingAddress]").removeAttr("readonly");
		$("input[name=shippingAddress]").val('');
		$("#convenience-store-button").hide();
		switch(shippingType){
		case 'SHOP':					
			$("input[name=shippingAddress]").attr("list", "shoplist");
			$("input[name=shippingAddress]").attr("autocomplete", "off");					
			break;
		case 'HOME':					
			$("input[name=shippingAddress]").attr("autocomplete", "on")
			break;
		case 'STORE':					
			$("input[name=shippingAddress]").prop("readonly", true);					
			$("#convenience-store-button").show();
			break;
		case 'NO':
			alert('無須貨運');
		}
	}
	
	function calculateFee(){
		//alert("calculateFee");
		var amount = Number($("#totalAmount").text());
		var shippingFee=0;
		var paymentFee=0;
		if($("select[name=shippingType] option:selected").val()!=''){
			shippingFee = Number($("select[name=shippingType] option:selected").attr("data-fee"));
		}
		if($("select[name=paymentType] option:selected").val()!=''){
			paymentFee = Number($("select[name=paymentType] option:selected").attr("data-fee"));
		}
		//alert(amount+shippingFee+paymentFee);
		$("#totalAmountWithFee").text(amount + shippingFee+paymentFee);				
	}
    </script>
    <style>
    
    	#container-cart{
            height: 1000px;
            background-image: url(../images/background-img.jpg);
       }

		#cartDetails {
			font-family: Helvetica, Arial, sans-serif;
			border-collapse: collapse;
			width: 100%;
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
		
		#no-check-out{
	   		display: flex;
            justify-content: center;
	   }
	   
	   #no-check-out h2{
            width: 500px;
			color: #ea1717;
       }
       
       #container-width{
       		width: 80%;
			margin: auto;
			padding-top: 30px;
       }
       
	   #shippingTypeSpan{
			font-size: 24px;
	   }
	   
	   #paymentTypeSpan {
	   		font-size: 24px;
			margin-left: 150px;
	   }
		
	   #shippingTypeSpan select,
	   #paymentTypeSpan select{
			width:180px;
			height:25px;
			font-size: 20px;
	   }
	   
	   #order-submit{
			margin-left: 50px;
			height:28px;
			width: 90px;
			font-size: 18px;
			border: 0px;
			border-radius: 5px;
			background-color: #ea1717;
			color: #fff;
	   }
	   	#same-as-the-orderer{
			border: 0px;
			border-radius: 5px;
			background-color: #ea1717;
			color: #fff;
			height:28px;
			width: 70px;
		}

	   	#same-as-the-orderer:hover,
	    #order-submit:hover,
		#convenience-store-button:hover {
            cursor: pointer;
            transform: scale(1.05);
        }

		#same-as-the-orderer:active,
		#order-submit:active,
        #convenience-store-button:active {
            transform: scale(0.95);  
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
			margin-left: 20px;
	   }
	   
	   #fieldset-email{
	   		height: 25px;
			width: 280px;
			font-size: 20px;
			margin-left: 10px;
	   }
	   
	   #fieldset-shipping-address{
	   		height: 25px;
			width: 700px;
			font-size: 20px;
			margin-left: 20px;
	   }

	   #recipient{
		font-size: 18px;
	   }

	   #recipient input{
		font-size: 14px;
	   }

	   #convenience-store-button{
			font-size: 18px;
			margin-left: 50px;
			border: 0px;
			border-radius: 5px;
			background-color: #ea1717;
			color: #fff;
	   }
	   
	   summary{
	   		font-size: 20px;
			margin-top: 40px;
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
		<jsp:param value="結帳" name="subheader"/>
	</jsp:include>
	
		<div id="container-cart">
		
<%-- 			<p>購物車內容: ${sessionScope.cart}</p> --%>
			<%
			
				ShoppingCart cart = (ShoppingCart)session.getAttribute("cart");
				if(cart==null || cart.isEmpty()){
			%>
			
			<div id="no-check-out">
	            <h2>購物車是空的，無法結帳!請先至[賣場]選購!</h2>
	        </div>	
				
			<%} else{%>
			<div id="container-width">
					<div>${errors}</div>
					<form id="checkOutForm" action="check_out.do" method="POST">
					<p>
						<span id="shippingTypeSpan">
							<label>貨運方式:</label>
							<select name="shippingType" required onchange="changePaymentOption()">
								<option value=''>請選擇...</option>
								<% for(int i=0;i<ShippingType.values().length;i++) {		
									ShippingType shType = ShippingType.values()[i];
								%>
								<option value='<%= shType.name()%>' data-fee="<%= shType.getFee()%>"
									data-array='<%= shType.getPaymentTypeArrayStr() %>'
								>
									<%= shType%>									
								</option>
								<% } %>
							</select>
						</span>
						<span id="paymentTypeSpan">
							<label>付款方式:</label>
							<select name="paymentType" required onchange="calculateFee()">
								<option value=''>請選擇...</option>
								<% for(PaymentType pType:PaymentType.values()){ %>
								<option value='<%= pType.name()%>' data-fee=<%=pType.getFee() %>><%=pType %></option>
								<% } %>
							</select>
						</span>
						<input id="order-submit" type="submit" value="送出訂單" >
					</p>
					
					<fieldset>
						<legend id="recipient">收件人<input id="same-as-the-orderer" type="button" value="同訂購人" onclick="copyMemberData()"></legend>
						<div><label>姓名:</label><input id="fieldset-name" name="name" placeholder="請輸入真實姓名" required></div>
						<div><label>手機:</label><input id="fieldset-phone" type="tel" name="phone" placeholder="請輸入正確手機號碼" required></div>
						<div><label>Email:</label><input id="fieldset-email" type="email" name="email" placeholder="請輸入正確Email" required></div>
						<div><label>地址:</label><input id="fieldset-shipping-address" name="shippingAddress" required>
							 <datalist id="shoplist">
								<option>101旗艦店 台北市信義區信義路五段7號</option>
								<option>復北門市 台北市復興北路99號1F</option>									
							 </datalist>
							 <input id="convenience-store-button" type="button" value="選擇超商" style="dispaly:none" onclick="goEZShip()">								
						</div>
					</fieldset>
				</form>
				
			<!-- ezship程式 start -->
		  <script>
		           function goEZShip() {//前往EZShip選擇門市
		               //if (confirm("Go EZShip前，你的網址已經改用ip Address了嗎?")) {
		               //   alert("出發至EZShip[選擇超商]");
		               // } else {
		               //    alert("快改網址!並重新登入與購買");
		               //    return;
		               // }
		
		               //去除文字欄位資料前後的多餘空白
			           $("input[name=name]").val($("input[name=name]").val().trim());
			           $("input[name=email]").val($("input[name=email]").val().trim());
			           $("input[name=phone]").val($("input[name=phone]").val().trim());
			           $("input[name=shippingAddress]").val($("input[name=shippingAddress]").val().trim());
		
		               var protocol = "https"; //之後務必要改成https
		               var ipAddress = "<%= java.net.InetAddress.getLocalHost().getHostAddress()%>";
		               var url = protocol + "://" + ipAddress + ":" + location.port + "<%=request.getContextPath()%>/member/ezship_callback.jsp";
		               $("#rtURL").val(url);
		
		           		//$("#webPara").val($("form[action='check_out.do']").serialize());
		               $("#webPara").val($("#checkOutForm").serialize());
		              // alert('現在網址不得為[locolhost]: '+url); //測試用，測試完畢後請將此行comment
		               //alert($("#webPara").val()) //測試用，測試完畢後請將此行comment
		
		               $("#ezForm").submit(); 
		           }
           
           </script>
           <form id="ezForm" method="post" name="simulation_from" action="https://map.ezship.com.tw/ezship_map_web.jsp" > 
               <input type="hidden" name="suID"  value="test@vgb.com"> <!-- 業主在 ezShip 使用的帳號, 隨便寫 -->       
               <input type="hidden" name="processID" value="VGB202107050000005"> <!-- 購物網站自行產生之訂單編號, 隨便寫 -->
               <input type="hidden" name="stCate"  value=""> <!-- 取件門市通路代號 -->        
               <input type="hidden" name="stCode"  value=""> <!-- 取件門市代號 -->        
               <input type="hidden" name="rtURL" id="rtURL" value=""> <!-- 回傳路徑及程式名稱 -->
               <input type="hidden" id="webPara" name="webPara" value=""> <!-- 結帳網頁中checkOutForm中的輸入欄位資料。ezShip將原值回傳，才能帶回結帳網頁 -->
           </form>
		   <!-- ezship程式 end -->
				
				
				<details>
					<summary>共<%= cart.getTotalQuantity() %>件, 總金額(含物流費): <span id="totalAmountWithFee"><%= cart.getTotalAmount() %></span>元 (點選即可看到明細)</summary>
					<table id="cartDetails">
						<caption>購物明細</caption>					
						<thead>
							<tr>
								<th>編號</th><th>產品名稱 螢幕尺寸 規格</th>
								<th>價格</th>
								<th>數量</th><th>小計</th>
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
								<td><%= cart.getQuantity(item) %></td>
								<td><%= cart.getAmount(item) %></td>							
							</tr>
							<% } %>
						</tbody>
						<tfoot>
							<tr>
								<td colspan="2">共<%= cart.size() %>項</td>
								<td colspan="1"><%= cart.getTotalQuantity() %>件</td>
								<td colspan="2">總金額: <span id="totalAmount"><%= cart.getTotalAmount() %></span>元</td>
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
</html>