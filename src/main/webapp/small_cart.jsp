<%@page pageEncoding="UTF-8" contentType="application/json"%>
<%--json Object --%>
{
	"totalQty": ${sessionScope.cart.getTotalQuantity()}
}