<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.Arrays"%>
<%@page pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>EZShip Call Back</title>
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
         #darken {
            height: 100vh;
            width: 100vw;
            background-color: rgba(0, 0, 0, 0.7);
            position: fixed;
            top: 0px;
            left: 0px;
            display: none;
        }
        
        #container-ezship-call-back{
            height: 1000px;
			display: flex;
			justify-content: center;
			align-items: center;
            background-image: url(../images/background-img.jpg);
       }
       
       #myForm{
       		height: 700px;
			width: 850px;
       }

	   #processID,
	   #stCate,
	   #stCode,
	   #stName,
	   #stAddr,
	   #stTel,
	   #shippingAddress,
	   #name{
			height: 40px;
			width: 800px;
			font-size: 24px;
	   }
	   
	   #submit-btn{
	   		height: 40px;
	   		width: 140px;
			margin-top: 50px;
	   		font-size: 24px;
			cursor: pointer;
			background-color: #dc0001;
            border: none;
            color: #fff;
            border-radius: 5px;
	   }
	</style>
</head>
<body>
	<jsp:include page="/subviews/header.jsp" >
		<jsp:param value="EZShip Call Back" name="subheader"/>
	</jsp:include>
	
		<div id="container-ezship-call-back">
		
			    <article >
		
		        <%         
		
		            //================================ 接收購物網站所需的各項參數 ==================================
		            String processID = request.getParameter("processID") == null ? "" : request.getParameter("processID");  // 訂單編號
		            String stCate = request.getParameter("stCate") == null ? "" : request.getParameter("stCate");  // 超商別
		            String stCode = request.getParameter("stCode") == null ? "" : request.getParameter("stCode");  // 門市代碼
		            String stName = request.getParameter("stName") == null ? "" : request.getParameter("stName");  // 門市名稱
		            String stAddr = request.getParameter("stAddr") == null ? "" : request.getParameter("stAddr");  // 門市地址
		            String stTel = request.getParameter("stTel") == null ? "" : request.getParameter("stTel");    // 門市電話
		            String webPara = request.getParameter("webPara") == null ? "" : request.getParameter("webPara");  //選擇門市前check_out網頁中的輸入項內容
		
		            String params[] = webPara.split("&");//取回原來結帳畫面的欄位值
		
		            //System.out.println(Arrays.toString(params));
		
		            Map<String, String> paramsMap = new HashMap<>();
		            if (params != null && params.length > 0) {
		                for (String data : params) {
		                    int index = data.indexOf('=');
		                    if(index>0){
		                        String name = data.substring(0, index);
		                        String value = java.net.URLDecoder.decode(data.substring(index + 1), "UTF-8");
		                        paramsMap.put(name, value);
		                    }
		                }
		            }
		            //System.out.println("paramsMap = " + paramsMap); //for test on server console
		
		        %>
		
		        <form action="check_out.jsp" method="post" id="myForm">
		            <input id="processID" name="processID" type="text" value="<%=processID%>">
		            <input id="stCate" name="stCate" type="text" value="<%=stCate%>">
		            <input id="stCode" name="stCode" type="text" value="<%=stCode%>">
		            <input id="stName" name="stName" type="text" value="<%=stName%>">
		            <input id="stAddr" name="stAddr" type="text" value="<%=stAddr%>">
		            <input id="stTel" name="stTel" type="text" value="<%=stTel%>">
		            <input id="shippingAddress" name="shippingAddress" type="text" value="<%=stName%>,<%=stAddr%>,店號:<%=stCode%>"> <!--shippingAddress必須與check_out.jsp中要帶入超商資料的欄位name一樣 -->
		            <% for (String name : paramsMap.keySet()) {%>
		            <input id="name" name="<%=name%>" type="text" value="<%= paramsMap.get(name)%>">
		            <%}%>
		            <input id="submit-btn" type='submit' value='回結帳畫面'>
		            <script>
		               document.getElementById("myForm").submit();<!-- 測試完畢後，請將此行uncomment，讓資料立刻submit回check+out.jsp  -->
		            </script>
		        </form>
		
		    </article>  
		    
		    
		</div> 
	<div id="darken"></div>
    
    <%@include file="/subviews/footer.jsp" %>	
    
</body>
</html>