<%@page import="com.ailaptopmall.service.ProductService"%>
<%@page import="com.ailaptopmall.entity.Spec"%>
<%@page import="java.util.List"%>
<%@ page pageEncoding="UTF-8"%>
	<!-- ajax get_color_spec.jsp start -->
	<%
		String sizeName = request.getParameter("sizeName");
		String productId = request.getParameter("productId");
		List<Spec> list = null;
		ProductService pService = new ProductService();
		if(productId!=null && sizeName!=null){
			list = pService.getProductSpecsByIdAndSizeName(productId, sizeName);	
		}
		if(list!=null && list.size()>0){
	%>	
	<option value="">請選擇</option>
		<% for(int i = 0;i<list.size();i++) {
			Spec spec = list.get(i);
			%>
		<option data-stock="<%= spec.getStock() %>" 
			data-list-price="<%= spec.getUnitPrice() %>" 
			data-price="<%= spec.getPrice() %>" 
			data-photo-src="<%= spec.getPhotoUrl() %>" 
			data-description-1="<%= spec.getDescription1() %>"
			data-description-2="<%= spec.getDescription2() %>"
			data-description-3="<%= spec.getDescription3() %>"
			value="<%= spec.getSpecName() %>">
				<%= spec.getSpecName() %>, <%= spec.getStock() %>台
		</option>
		<% } %>
	<% }else{ %>
	<option value="">查無規格</option>	
	<%} %>
	<!-- ajax get_color_spec.jsp end -->