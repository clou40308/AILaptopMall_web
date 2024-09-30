<%@page import="com.ailaptopmall.entity.Customer"%>
<%@page pageEncoding="UTF-8" %>
<!-- header.jsp start -->
    <header>
        <div id="header-title">
            <h2><a href="<%= request.getContextPath() %>/">AI筆電商城</a></h2>
            <hr id="header-title-hr">
            <span id="header-title-span">助你成就每一刻</span>
            <hr id="header-title-hr">
            <sub><%= request.getParameter("subheader")==null?"首頁":request.getParameter("subheader") %></sub>
        </div>
        <div id="search-bar">
            <form action="<%= request.getContextPath() %>/products_list.jsp" method="GET">
                <img id="search-bar-img" src="<%= request.getContextPath() %>/images/search_icon.png" alt="">
                <input id="search-bar-keyword" type="search" name="keyword" value="${param.keyword}" required placeholder="搜尋商品">
                <input id="search-bar-submit" type="submit" value="查詢">
            </form>
        </div>
        <div id="account-area">
        	<%				
				Customer member = (Customer)session.getAttribute("member");
			%>
            <a href="<%= request.getContextPath() %>/products_list.jsp">買筆電</a>
            <hr id="account-area-hr">
            <% if(member==null){ //尚未登入 %>
            <a href="<%= request.getContextPath() %>/login.jsp">登入</a>
            <hr id="account-area-hr">
            <a href="<%= request.getContextPath() %>/register.jsp">註冊</a>
            <hr id="account-area-hr">
            <% }else{ //已經登入%>
            <a href="<%= request.getContextPath() %>/member/update.jsp">修改會員</a>
            <hr id="account-area-hr">
            <a href="<%= request.getContextPath() %>/logout.do">登出</a>
            <hr id="account-area-hr">
            <% } %>
            <span><%= member!=null?member.getName()+"，你好!":"" %></span>
        </div>
    </header>
<!-- header.jsp end -->		