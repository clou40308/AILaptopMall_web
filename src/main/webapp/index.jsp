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
    <title>AI筆電商城 首頁</title>
    <link rel="stylesheet" type="text/css" href="style/ailm.css">
    <link rel="stylesheet" type="text/css" href="style/header.css">
    <link rel="stylesheet" type="text/css" href="style/footer.css">
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
	<script type="text/javascript">
		var myInterval, index = 0;
		$(document).ready(function init() {
			$(".dot,#next,#prev").click(moveHandler);//run the same function
			myInterval = setTimeout(moveHandler, 3000);//initial timer
			$("#search-bar-keyword").focus(focusHandler).blur(blurHandler);
		});
        function focusHandler() {
            $("#darken").show();
        }
        function blurHandler() {
            $("#darken").hide();
        }
		function moveHandler(e) {
			clearInterval(myInterval);//reset timer
			myInterval = setTimeout(moveHandler, 3000);//set timeer
			$(".dot:eq(" + index + ")").css("backgroundColor", "gray");//reset dot color
			if (this == window) {
				index++;//setInterval
			} else if ($(this).attr("myIndex")) {
				index = Number($(this).attr("myIndex"));//.dot
			} else {
				index += Number($(this).attr("direction"));// $#prev / #next
			}
			if (index > 4) index = 0;//last image
			if (index < 0) index = 4;//first image
			$(".dot:eq(" + index + ")").css("backgroundColor", "white");//set dot color
			$("#photos").stop().animate({ "marginLeft": -index * 2000 + "px" }, 1000);//image width=735px
		}
	</script>
    <style>
        /* site-logo css */
        #site-logo {
            height: 90px;
            background-color: black;
            display: flex;
            justify-content: center;
            align-items: center;
        }
        /* site-logo css */
        
		#container-index{
			background-image: url(./images/background-img.jpg);
			height: 1300px;
		}

        #outer {
			position: relative;
			width: 2000px;
			/*image width=753 height=357*/
			overflow: hidden;
			background-color: #666;
			margin: auto;
		}

		#photos {
			position: relative;
			width: 10000px;
			height: 660px;
			/*image width=753x5=3765px*/
			display: flex;
		}

		#prev,
		#next {
			position: absolute;
			width: 30px;
			height: 40px;
			color: white;
			cursor: pointer;
			font-size: 3em;
			top: 300px;
			opacity: 0.5;
		}

		#prev {
			left: 0px;
		}

		#next {
			right: 0px;
		}

		#prev:hover,
		#next:hover {
			opacity: 0.9;
		}

		#dots {
			width: 130px;
			/*(16+5x2)x5=130px*/
			margin: auto;
			display: flex;
		}

		.dot {
			width: 16px;
			height: 16px;
			background-color: gray;
			border-radius: 50%;
			margin: 5px;
		}

		.dot:first-child {
			background-color: white;
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
        
		#container-interest{
			height: 500px;
			margin-top: 50px;
			padding: 0px 70px 0px 70px;
		}

		#container-interest p{
			width: 300px;
			font-size: 24px;
			font-weight: 600;
			color: #12ae57;
			margin-bottom: 0px;
		}

		hr{
			height:5px;
			background-color: #12ae57;
		}

		#interest-area{
			height: 400px;
		}
		
		#product-list{
            margin:15px 80px;
       	}
       	
		#productItem{
            display:inline-block;
            width:235px;
            height: 340px;
            background-color: #fff;
            vertical-align:top;
            box-shadow: 5px 5px 5px #888888;
            margin:5px 10px 5px 10px;
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
            width: 300px;
			color: #ea1717;
        }
    </style>
</head>

<body>
	<jsp:include page="/subviews/header.jsp" />
	
    <div id="site-logo">
        <div>
            <img src="./images/logo-ai.png" alt="">
        </div>
    </div>

    <div id="container-index">

		<div id="outer">
			<div id="photos">
				<a href=""><img src="carousel_images/asus_zenbook_S14.jpg"></a>
				<a href=""><img src="carousel_images/copilot_pc1.jpg"></a>
				<a href=""><img src="carousel_images/copilot_pc2.jpg"></a>
				<a href=""><img src="carousel_images/intel_ultra.jpg"></a>
				<a href=""><img src="carousel_images/Summit_E16.jpg"></a>
			</div>
			<div id="prev" direction="-1">&ltdot;</div>
			<div id="next" direction="1">&gtdot;</div>
			<div id="dots">
				<div class="dot" myIndex="0"></div>
				<div class="dot" myIndex="1"></div>
				<div class="dot" myIndex="2"></div>
				<div class="dot" myIndex="3"></div>
				<div class="dot" myIndex="4"></div>
			</div>
		</div>

		<div id="container-interest">
			<p>你可能感興趣</p>
			<hr>
			<div id="interest-area">
					<%
						ProductService pService = new ProductService();
						List<Product> list = pService.getRandomProducts();
						
						//若查無資料
						if(list==null || list.size()==0){				
					%>
					    <div id="no-product">
				            <h2>查無感興趣產品資料!</h2>
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
		</div>
			
	</div>

	<div id="darken"></div>
	
	<%@include file="/subviews/footer.jsp" %>	
</body>

</html>