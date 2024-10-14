package com.ailaptopmall.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.ailaptopmall.entity.Product;
import com.ailaptopmall.entity.ShoppingCart;
import com.ailaptopmall.entity.Spec;
import com.ailaptopmall.exception.AILMException;
import com.ailaptopmall.service.ProductService;

/**
 * Servlet implementation class AddToCartServlet
 */
@WebServlet("/add_to_cart.do")
public class AddToCartServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AddToCartServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		List<String> errors = new ArrayList<>();
		HttpSession session = request.getSession();		
		// 1.取得request的form data 
		String productId = request.getParameter("productId");
		String sizeName = request.getParameter("size");
		String specName = request.getParameter("spec");
		String quantity = request.getParameter("quantity");
		
		//2. 呼叫商業邏輯
		if(productId!=null) {
			ProductService pService = new ProductService();
			try {
				Product p = pService.getProductById(productId);
				if(p!=null) {
					Spec theSpec = null;
					if(p.getSpecCount()>0) {
						theSpec = pService.getTheSpec(productId, sizeName, specName);
					}
					
					if(quantity!=null && quantity.matches("\\d+")) {
						ShoppingCart cart = (ShoppingCart)session.getAttribute("cart");
						if(cart==null) {
							cart = new ShoppingCart();
							session.setAttribute("cart", cart);
						}
						cart.addToCart(p, sizeName, theSpec, Integer.parseInt(quantity));
					}else {
						errors.add("加入cart失敗，購買數量資料不正確:" + quantity);
					}
				}else {
					errors.add("加入cart失敗，查無[" + productId + "]產品");
				}
			} catch (AILMException e) {
				this.log("加入cart失敗", e);
			}			
		}else {
			errors.add("加入cart失敗，productId不得為null");
		}
		
		if(errors.size()>0)this.log("加入cart 發生錯誤: "+errors);
		
		//3.原來是同步請求，外部轉址到cart.jsp
		response.sendRedirect("member/cart.jsp");
		
		//3.改成非同步請求，內部轉交到small_cart.jsp
		//request.getRequestDispatcher("small_cart.jsp").forward(request, response);
	}

}
