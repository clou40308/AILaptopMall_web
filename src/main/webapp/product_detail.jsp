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
	   #productMainData-quantity{
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
	   
	   #productMainData-quantity label{
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
							<p>上架日期: <%= p.getReleaseDate() %></p>
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
							<p>庫存: <%= p.getStock() %>台</p>
						</div>
												
						<form>
							<input type="hidden" name="productId" value="<%= p.getId() %>">

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