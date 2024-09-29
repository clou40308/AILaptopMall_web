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
    <script src="https://code.jquery.com/jquery-3.0.0.js" integrity="sha256-jrPLZ+8vDxt2FnE1zvZXCkCcebI/C8Dt5xyaQBjxQIo=" crossorigin="anonymous"></script>
    <script>	
		$(document).ready(init);
		
		function init(){
			$("#productMainData-size span").on("click", changeSizeData);
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
		}
	</script>	
    <style>
       
       #container-product{
            height: 800px;
            background-image: url(./images/background-img.jpg);
       }
       
       nav{
       		height: 50px;
            border: 2px black solid;
            text-align: center;
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
			border: 1px black solid;
	   }

	   #product-data-area-down{
			border: 1px black solid;
			height: 45%;
		}
		
       #product-data-photo{
	       width: 350px;
		   height: 350px;
	       margin: 10px;
       }

	   #productMainData{
			border: 1px black solid;
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
	   #productMainData-size{
			height:	35px;
			border: 1px black solid;
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
	   #productMainData-size-label{
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
		  	outline: 2px solid #ea1717;
		}
		
    </style>
</head>

<body>
	<jsp:include page="/subviews/header.jsp" >
		<jsp:param value="產品說明" name="subheader"/>
	</jsp:include>
	   
	 <div id="container-product">
	 	 <nav>
            <a href="<%= request.getContextPath() %>/products_list.jsp?latest=">新品</a>
            <a href="<%= request.getContextPath() %>/products_list.jsp?maker=LENOVO">LENOVO</a>
            <a href="<%= request.getContextPath() %>/products_list.jsp?maker=HP">HP</a>
            <a href="<%= request.getContextPath() %>/products_list.jsp?">全部</a>
        </nav>
        
        <%  //1.取得request中的queryString
			String productId = request.getParameter("productId");
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
								<p>定價:$<%= ((SpecialOffer)p).getListPrice() %>元</p>
							</div>
						<% } %>

						<div id="productMainData-UnitPrice">
							<p>
								優惠價: <%= p instanceof SpecialOffer ?((SpecialOffer)p).getDiscountString() :""%>
								$<%= p.getUnitPrice() %> 元
							</p>
						</div>

						<div id="productMainData-Stock">
							<p>庫存: 共<%= p.getStock() %>台<span id="theSizeStock"></span></p>
						</div>
												
						<form>
							<input type="hidden" name="productId" value="<%= p.getId() %>">
							
							<% if(p.getSizeList()!=null && p.getSizeList().size()>0){%>
								<div id="productMainData-size">
									<label id="productMainData-size-label">螢幕尺吋:</label>
									<% for(int i=0;i<p.getSizeList().size();i++) {
										Size size = p.getSizeList().get(i);
									%>
								<label id="productMainData-size-date" name="productMainData-size-date">
									<input type="radio" name="size" value="<%= size.getSizeName()%>" required>	
									<span id="" title="<%= size.getSizeName() %>"
									 data-release-date="<%= size.getReleaseDate() %>" 
									 data-stock="<%= size.getStock() %>"><%= size.getSizeName()%></span>					
								</label>
									<% } %>
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
					<div class="productDesc">
						<p><%= p.getDescription() %></p>
					</div>	
				</div>

			</div>
		<%} %>
	 </div>
	 
    <%@include file="/subviews/footer.jsp" %>	
</body>

</html>