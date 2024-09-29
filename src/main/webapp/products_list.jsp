<%@page import="com.ailaptopmall.entity.SpecialOffer"%>
<%@page import="com.ailaptopmall.entity.Product"%>
<%@page import="java.util.List"%>
<%@page import="com.ailaptopmall.service.ProductService"%>
<%@page pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>產品清單</title>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/style/ailm.css">
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/style/header.css">
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/style/footer.css">
    <style>
       #container-product-list{
            height: 1000px;
            background-image: url(./images/background-img.jpg);
       }
       nav{
       		height: 50px;
            border: 2px black solid;
            text-align: center;
       }
       
       #product-list{
            margin:15px 60px;
       }

       #productItem{
            display:inline-block;
            width:235px;
            height: 350px;
            background-color: #fff;
            vertical-align:top;
            box-shadow: 5px 5px 5px #888888;
            margin:5px;
            padding: 2px 1em;
            border: 1px black solid;
       }

       #productItem img{
            width: 180px;
            height: 180px;
            display:block;
            margin: auto;
       }

       #productItem h4{
            color: #4797d3;
       }

		#productItem-price{
		    text-align: center;
            color: #ea1717;
            font-size: 18px;
            font-weight: 650;
		}
       
        #no-product{
            display: flex;
            justify-content: center;
        }

        #no-product h2{
            width: 200px;
			color: #ea1717;
        }
        
    </style>
</head>

<body>
	<% request.setCharacterEncoding("UTF-8"); %>
	
	<jsp:include page="/subviews/header.jsp" >
		<jsp:param value="買筆電" name="subheader"/>
	</jsp:include>
	
	<div id="container-product-list">
	
        <nav>
            <a href="?latest=">新品</a>
            <a href="?maker=LENOVO">LENOVO</a>
            <a href="?maker=HP">HP</a>
            <a href="?">全部</a>
        </nav>
        
	<% 
			//1.取得request的Form Data/QueryString
			String keyword = request.getParameter("keyword");
			String latest = request.getParameter("latest");
			String maker = request.getParameter("maker");
			
			//2.呼叫商業邏輯
			ProductService pService = new ProductService();
			List<Product> list = null;
			
			if(keyword!=null && (keyword=keyword.trim()).length()>0){
				list = pService.getProductsByKeyword(keyword);
			}else if(latest!=null && (latest=latest.trim()).length()==0){
				list = pService.getLatestProducts();
			}else if(maker!=null && (maker=maker.trim()).length()>0){
				list = pService.getProductsByMaker(maker);
			}else{
				list=pService.getAllProducts();
			}
			
			//若查無資料
			if(list==null || list.size()==0){					
	%>             
        <div id="no-product">
            <h2>查無產品資料!</h2>
        </div>	
	<%} else { %>
        <div id="product-list">
        	<% for(int i=0;i<list.size();i++){
					Product p = list.get(i);
			%>
			<div id="productItem">
                <a href=""><img src="<%= p.getPhotoUrl() %>"></a>
                <a href=""><h4><%= p.getName() %></h4></a>
                <div id="productItem-price">優惠價:<%= p instanceof SpecialOffer?((SpecialOffer)p).getDiscountString():"" %> $<%= p.getUnitPrice() %>元</div>	
            </div>
            <% } %>	
        </div>
    <% } %>	
    </div>   
    
    <%@include file="/subviews/footer.jsp" %>	
</body>

</html>