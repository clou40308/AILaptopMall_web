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
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/style/nav.css">
    <script src="https://code.jquery.com/jquery-3.0.0.js"
    integrity="sha256-jrPLZ+8vDxt2FnE1zvZXCkCcebI/C8Dt5xyaQBjxQIo=" crossorigin="anonymous"></script>
    
    <!-- favicon icon 網頁的icon -->
    <link rel="apple-touch-icon" sizes="180x180" href="./favicon_package/apple-touch-icon.png">
	<link rel="icon" type="image/png" sizes="32x32" href="./favicon_package/favicon-32x32.png">
	<link rel="icon" type="image/png" sizes="16x16" href="./favicon_package/favicon-16x16.png">
	<link rel="manifest" href="./favicon_package/site.webmanifest">
	<link rel="mask-icon" href="./favicon_package/safari-pinned-tab.svg" color="#5bbad5">
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
    
       #container-product-list{
            background-image: url(./images/background-img.jpg);
            height: 1800px;
       }
       
       #product-list{
            margin:0px 60px;
       }

       #productItem{
            display:inline-block;
            width:235px;
            height: 340px;
            background-color: #fff;
            vertical-align:top;
            box-shadow: 5px 5px 5px #888888;
            margin:10px 5px 10px 5px;
            padding: 2px 1em;
            border: 1px black solid;
            border-radius: 5px;
       }

       #productItem img{
            width: 220px;
            height: 200px;
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
	<% request.setCharacterEncoding("UTF-8"); %>
	
	<jsp:include page="/subviews/header.jsp" >
		<jsp:param value="買筆電" name="subheader"/>
	</jsp:include>
	
	<div id="container-product-list">
	
		<%@include file="./subviews/nav.jsp" %>
		
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
                <a href="product_detail.jsp?productId=<%= p.getId() %>"><img src="<%= p.getPhotoUrl() %>"></a>
                <a href="product_detail.jsp?productId=<%= p.getId() %>"><h4><%= p.getName() %></h4></a>
                <div id="productItem-price">優惠價:<%= p instanceof SpecialOffer?((SpecialOffer)p).getDiscountString():"" %> $<%= p.getUnitPrice() %>元</div>	
            </div>
            <% } %>	
        </div>
    <% } %>	
    </div>   
    
    <div id="darken"></div>
    
    <%@include file="/subviews/footer.jsp" %>	
</body>

</html>