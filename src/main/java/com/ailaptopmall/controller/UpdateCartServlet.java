package com.ailaptopmall.controller;

import java.io.IOException;
import java.util.Set;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.ailaptopmall.entity.CartItem;
import com.ailaptopmall.entity.ShoppingCart;

/**
 * Servlet implementation class UpdateCartServlet
 */
@WebServlet("/member/update_cart.do")
public class UpdateCartServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UpdateCartServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		ShoppingCart cart = (ShoppingCart)session.getAttribute("cart");
		if(cart!=null && !cart.isEmpty()) {
			Set<CartItem> itemSet = cart.getCartItemsSet();
			for(CartItem item:itemSet) {
				//1.取得request的form data
				String quantity = request.getParameter("quantity" + item.hashCode());
				String delete = request.getParameter("delete" + item.hashCode());
				//System.out.printf("qyantity: %s, delete: %s\n", quantity, delete);
				//2. 呼叫商業邏輯
				if(delete==null) {
					//修改數量
					if(quantity!=null && quantity.matches("\\d+")) {
						int qty = Integer.parseInt(quantity);
						if(qty>0) {
							cart.update(item, qty);
						}else {
							cart.remove(item);
						}
					}
				}else {
					cart.remove(item);
				}
			}			
		}
		
		//3.外部轉址to cart.jsp
		String checkOut = request.getParameter("submit");
		if("checkOut".equals(checkOut)) {
			response.sendRedirect("check_out.jsp");			
		}else {		
			response.sendRedirect("cart.jsp");
		}
		
	}

}
