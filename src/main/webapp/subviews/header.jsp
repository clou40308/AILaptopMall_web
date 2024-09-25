<%@page import="com.ailaptopmall.entity.Customer"%>
<%@page pageEncoding="UTF-8" %>
<!-- header.jsp start -->
    <header>
        <div id="header-title">
            <h2><a href="./">AI筆電商城</a></h2>
            <hr id="header-title-hr">
            <span id="header-title-span">助你成就每一刻</span>
        </div>
        <div id="search-bar">
            <form action="" method="get">
                <img id="search-bar-img" src="./images/search_icon.png" alt="">
                <input id="search-bar-keyword" type="search" name="keyword" required placeholder="搜尋商品">
                <input id="search-bar-submit" type="submit" value="查詢">
            </form>
        </div>
        <div id="account-area">
        	<%				
				Customer member = (Customer)session.getAttribute("member");
			%>
            <a href="">買筆電</a>
            <hr id="account-area-hr">
            <% if(member==null){ //尚未登入 %>
            <a href="./login.jsp">登入</a>
            <hr id="account-area-hr">
            <a href="./register.jsp">註冊</a>
            <hr id="account-area-hr">
            <% }else{ //已經登入%>
            <a href="./logout.do">登出</a>
            <hr id="account-area-hr">
            <a href="">修改會員</a>
            <hr id="account-area-hr">
            <% } %>
            <span><%= member!=null?member.getName()+"，你好!":"" %></span>
        </div>
    </header>
<!-- header.jsp end -->		