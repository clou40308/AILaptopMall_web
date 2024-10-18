<%@page import="com.ailaptopmall.entity.CartItem"%>
<%@page import="java.util.Set"%>
<%@page import="com.ailaptopmall.entity.ShoppingCart"%>
<%@page pageEncoding="UTF-8" contentType="application/json"%>
<%--json Object --%>
{
	<%
		ShoppingCart cart = (ShoppingCart)session.getAttribute("cart");	
	%>
		"totalQty": ${sessionScope.cart.getTotalQuantity()}
		,"cart":[		
	<%
		if(cart!=null && cart.size()>0){
		Set<CartItem> cartItemSet = cart.getCartItemsSet();		
	%>	
		<%
			for(CartItem item:cartItemSet){
		%>
			{"name": "<%=item.getProductName()%>", "size":"<%=item.getSizeName()%>", "spec": "<%=item.getSpecName()%>", "qty": "<%=cart.getQuantity(item)%>"}
		<% } %>	
	<%}%>
	]
}