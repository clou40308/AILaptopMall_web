<%@page import="com.ailaptopmall.entity.Size"%>
<%@page import="com.ailaptopmall.entity.SpecialOffer"%>
<%@page import="com.ailaptopmall.service.ProductService"%>
<%@page import="com.ailaptopmall.entity.Product"%>
<%@page pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>產品明細</title>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/style/ailm.css">
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/style/header.css">
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/style/footer.css">
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/style/nav.css">
    <script src="https://code.jquery.com/jquery-3.0.0.js" integrity="sha256-jrPLZ+8vDxt2FnE1zvZXCkCcebI/C8Dt5xyaQBjxQIo=" crossorigin="anonymous"></script>
    
    <!-- favicon icon 網頁的icon -->
    <link rel="apple-touch-icon" sizes="180x180" href="./favicon_package/apple-touch-icon.png">
	<link rel="icon" type="image/png" sizes="32x32" href="./favicon_package/favicon-32x32.png">
	<link rel="icon" type="image/png" sizes="16x16" href="./favicon_package/favicon-16x16.png">
	<link rel="manifest" href="./favicon_package/site.webmanifest">
	<link rel="mask-icon" href="./favicon_package/safari-pinned-tab.svg" color="#5bbad5">
	<meta name="msapplication-TileColor" content="#da532c">
	<meta name="theme-color" content="#ffffff">
	
    <script>	
		$(document).ready(init);
		
		function init(){
			$("#productMainData-size span").on("click", changeSizeData);
			$("select[name=spec]").on("change", changeSpecData);
			$("#search-bar-keyword").focus(focusHandler).blur(blurHandler);
		}
		
		function changeSizeData(){
				//alert("alert");	
			console.log("change Size Data:" , 
					$(this).attr("title"), $(this).attr("data-release-date"),$(this).attr("data-stock"));
			
			var sizeName = $(this).attr("title");
			var releaseDate = $(this).attr("data-release-date");
			var stock = $(this).attr("data-stock");
			
			//修改畫面中指定位置的資料			
			$("#theReleaseDate").text(releaseDate);
			$("#theSizeStock").text( ", " + sizeName + "吋: "+ stock + "台");
			$("input[name=quantity]").attr("max",  stock);	
			ajaxGetSpecsOption(sizeName);
		}
		
		function ajaxGetSpecsOption(sizeName){
			//Ajax請求->get_size_specs.jsp
			var productId = $("input[name=productId]").val();
			
			$.ajax({
				url: "get_size_specs.jsp?sizeName=" + sizeName 
							+ "&productId="+productId,
				method: "GET"
			}).done(ajaxGetSpecsOptionDone);			
		}
		
		function ajaxGetSpecsOptionDone(result, status, xhr){
			//alert(result);
			
			//將選項套用在$("select[name=spec]")，顯示spec選單
			$("select[name=spec]").html(result);
		}
		
		function changeSpecData(){
			//alert("alert");
			var stock = $("select[name=spec] option:selected").attr("data-stock");
			var listPrice = $("select[name=spec] option:selected").attr("data-list-price");
			var price = $("select[name=spec] option:selected").attr("data-price");
			var photoUrl = $("select[name=spec] option:selected").attr("data-photo-src");
			var description1 = $("select[name=spec] option:selected").attr("data-description-1");
			var description2 = $("select[name=spec] option:selected").attr("data-description-2");
			var description3 = $("select[name=spec] option:selected").attr("data-description-3");
			console.log(stock, listPrice, price,photoUrl ,description1,description2,description3);
			
			//TODO: 修改畫面中指定位置的資料
			$("input[name=quantity]").attr("max",  stock);
			$("#theListPrice").text(listPrice);
			$("#thePrice").text(price);	
			$("#product-data-photo").attr("src", photoUrl);
			$("#description1").text(description1);	
			$("#description2").text(description2);	
			$("#description3").text(description3);	
		}
		
        function focusHandler() {
            $("#darken").show();
        }
        
        function blurHandler() {
            $("#darken").hide();
        }
        
        function sendAjaxAddToCart(){
        	//alert("sendAjaxAddToCart");
        	
        	//自行送出ajax非同步請求
        	$.ajax({
        		url:$("#cartForm").attr("action"),
        		method:$("#cartForm").attr("method"),
        		data:$("#cartForm").serialize()
        	}).done(sendAjaxAddToCartDoneHandler);	
        	//取消同步請求
        	return false;
        }
        
        function sendAjaxAddToCartDoneHandler(result, status, xhr){
			//alert(result);

			$(".totalQtySpan").text("("+result.totalQty+")");
		}
	</script>	
    <style>
       
       #container-product{
            height: 800px;
            background-image: url(./images/background-img.jpg);
       }
    
	   #no-product-id{
	   		display: flex;
            justify-content: center;
	   }
	   
	   #no-product-id h2{
            width: 300px;
			color: #ea1717;
       }
       
       #product-data-area{
       		height: 800px;
       		margin:15px 60px;
       }
       
	   #product-data-area-up{
			height: 55%;
			display: flex;
			justify-content: center;
			align-items: center;
	   }

	   #product-data-area-down{
			height: 230px;
			display: flex;
			justify-content: center;
			align-items: center;
		}
		
       #product-data-photo{
	       width: 350px;
		   height: 350px;
	       margin: 10px;
       }

	   #productMainData{
			width: 500px;
			height: 400px;
			margin-left: 30px;
	   }

	   #productMainData h2{
			color: #4797d3;
			font-weight: 700;
			width: 500px;
	   }

	   #productMainData-ReleaseDate,
	   #productMainData-ListPrice,
	   #productMainData-UnitPrice,
	   #productMainData-Stock,
	   #productMainData-quantity,
	   #productMainData-size,
	   #productMainData-spec{
			height:	35px;
	   }
	   
	   #productMainData-ReleaseDate p,
	   #productMainData-ListPrice p,
	   #productMainData-UnitPrice p,
	   #productMainData-Stock p{
	   		font-size: 18px;
	   		margin: 5px 0px;
	   		font-weight: 550;
	   }
	   
	   #productMainData-quantity label,
	   #productMainData-size-label,
	   #productMainData-spec label{
			font-size: 18px;
	   		margin: 5px 0px;
	   		font-weight: 550;
	   }

	   #productMainData-quantity input{
			width: 60px;
			height: 20px;
			margin: 5px 0px;
			font-size: 18px;
	   }

	   #submit-btn{
			width: 125px;
			height: 35px;
			font-size: 18px;
			background-color:  #ea1717;
			color: #fff;
			border: 0px;
			border-radius: 10px;
			margin-top: 10px;
			margin-left: 10px;
	   }
	   
		#submit-btn:hover {
            cursor: pointer;
            transform: scale(1.05);
        }

        #submit-btnn:active {
            transform: scale(0.95);  
        }
        
        #productMainData-size-date{
        	font-size: 20px;
			margin-left: 8px;
			cursor: pointer;
        }
		
		/* HIDE RADIO */
		#productMainData-size input[type=radio] { 
		  	position: absolute;
		  	opacity: 0;
		  	width: 1px;
		  	height: 1px;
		}
		
				/* CHECKED STYLES */
		#productMainData-size input[type=radio]:checked +span {
		  	outline: 3px solid #ea1717;
		}
		
		#productMainData-spec select{
			height: 30px;
			width: 260px;
		}
		
		#productDesc span{
			font-size: 18px;
			font-weight: 600;
		}

		#productDesc div{
			margin-top: 15px;
		}
		
		#theListPrice{
			color:gray; 
			text-decoration: line-through;
		}

		#thePrice{
			color:blue;
			font-size: larger
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
		<jsp:param value="產品說明" name="subheader"/>
	</jsp:include>
	   
	 <div id="container-product">
		
		<%@include file="./subviews/nav.jsp" %>
        
        <%  //1.取得request中的queryString
			String productId = "10";// request.getParameter("productId");
			Product p = null;			
			ProductService pService = new ProductService();
			if(productId!=null && (productId=productId.trim()).length()>0){
				p = pService.getProductById(productId);				
			}		
		%>
		
		<% if( p==null){ %>
		
			<div id="no-product-id">
	            <h2>查無此代號的產品(<%= productId%>)!</h2>
	        </div>	
	        
		<%}else{ %>	
		
			<div id="product-data-area">

				<div id="product-data-area-up">
					<img id="product-data-photo" src="<%= p.getPhotoUrl() %>">
					<div id="productMainData">

						<h2><%= p.getName() %></h2>

						<div id="productMainData-ReleaseDate">
							<p>上架日期:<span id="theReleaseDate"><%= p.getReleaseDate() %></span></p>
						</div>

						<% if(p instanceof SpecialOffer) {%>
							<div id="productMainData-ListPrice">
								<p>定價:$<span id="theListPrice"><%= ((SpecialOffer)p).getListPrice() %></span>元</p>
							</div>
						<% } %>

						<div id="productMainData-UnitPrice">
							<p>
								優惠價: <%= p instanceof SpecialOffer ?((SpecialOffer)p).getDiscountString() :""%>
								$<span id="thePrice"><%= p.getUnitPrice() %></span> 元
							</p>
						</div>

						<div id="productMainData-Stock">
							<p>庫存: 共<%= p.getStock() %>台<span id="theSizeStock"></span></p>
						</div>
												
						<form id="cartForm" action="add_to_cart.do" method="POST" onsubmit="return sendAjaxAddToCart()">
							<input type="hidden" name="productId" value="<%= p.getId() %>">
							
							<% if(p.getSizeList()!=null && p.getSizeList().size()>0){%>
								<div id="productMainData-size">
									<label id="productMainData-size-label">螢幕尺吋:</label>
									<% for(int i=0;i<p.getSizeList().size();i++) {
										Size size = p.getSizeList().get(i);
									%>
								<label id="productMainData-size-date" name="productMainData-size-date">
									<input type="radio" name="size" value="<%= size.getSizeName()%>" required>	
									<span title="<%= size.getSizeName() %>"
									 data-release-date="<%= size.getReleaseDate() %>" 
									 data-stock="<%= size.getStock() %>"><%= size.getSizeName()%></span>					
								</label>
									<% } %>
								</div>
							<% } %>
							
							<!-- 判斷有無規格資料 { -->
							<% if(p.getSpecCount()>0) {%>							
								<div id="productMainData-spec">
									<label>規格:</label>
									<select name="spec" required class="specSelect">
										<option value="">請先選擇螢幕尺寸</option>
									</select>
								</div>							
							<% } %>	
												
							<div id="productMainData-quantity">
								<label>數量:</label>
								<input type="number" name="quantity" required min="1" max="<%= p.getStock() %>">
							</div>						
							<input type="submit"  id="submit-btn"  value="加入購物車">						
						</form>

					</div>
				</div>

				<hr>

				<div id="product-data-area-down">
					<div id="productDesc">
						<div><span><%= p.getDescription() %></span></div>
						<div><span id="description1"></span></div>
						<div><span id="description2"></span></div>
						<div><span id="description3"></span></div>
					</div>	
				</div>

			</div>
			
			<script>
				<% if(p.getSizeList().size()==0 && p.getSpecCount()>0){%>
						//alert("應帶入規格資料");
						ajaxGetSpecsOption("");
				<%}%>
			</script>
		<%} %>
	 </div>
	 
	<div id="darken"></div>
	
    <%@include file="/subviews/footer.jsp" %>	
</body>

</html>