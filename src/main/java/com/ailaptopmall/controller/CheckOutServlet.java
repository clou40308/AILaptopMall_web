package com.ailaptopmall.controller;

import java.io.IOException;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.ailaptopmall.entity.Customer;
import com.ailaptopmall.entity.Order;
import com.ailaptopmall.entity.PaymentType;
import com.ailaptopmall.entity.ShippingType;
import com.ailaptopmall.entity.ShoppingCart;
import com.ailaptopmall.exception.AILMException;
import com.ailaptopmall.service.OrderService;

/**
 * Servlet implementation class CheckOutServlet
 */
@WebServlet("/member/check_out.do")
public class CheckOutServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public CheckOutServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		List<String> errors = new ArrayList<>();
		HttpSession session = request.getSession();
		Customer member = (Customer) session.getAttribute("member");
		ShoppingCart cart = (ShoppingCart) session.getAttribute("cart");
		if (cart != null && cart.size() > 0) {
			// 1.取得Form data
			String shippingType = request.getParameter("shippingType");
			String paymemntType = request.getParameter("paymentType");

			String name = request.getParameter("name");
			String email = request.getParameter("email");
			String phone = request.getParameter("phone");
			String shippingAddress = request.getParameter("shippingAddress");
			// TODO: 檢查
			if (shippingType == null || shippingType.length() == 0)
				errors.add("必須選擇貨運方式");

			if (paymemntType == null || paymemntType.length() == 0)
				errors.add("必須選擇付款方式");

			if (name == null || (name = name.trim()).length() == 0)
				errors.add("必須輸入收件人姓名");

			if (email == null || (email = email.trim()).length() == 0)
				errors.add("必須輸入收件人Email");

			if (phone == null || (phone = phone.trim()).length() == 0)
				errors.add("必須輸入收件人手機");

			if (shippingAddress == null || (shippingAddress = shippingAddress.trim()).length() == 0)
				errors.add("必須輸入取件地點");

			// 建立訂單()
			if (errors.isEmpty()) {
				ShippingType shType = ShippingType.valueOf(shippingType);
				PaymentType pType = PaymentType.valueOf(paymemntType);

				Order order = new Order();
				order.setMember(cart.getMember());
				order.setCreatedDate(LocalDate.now());
				order.setCreatedTime(LocalTime.now());

				order.setShippingType(shType);
				order.setShippingFee(shType.getFee());

				order.setPaymentType(pType);
				order.setPaymentFee(pType.getFee());

				order.setRecipientName(name);
				order.setRecipientEmail(email);
				order.setRecipientPhone(phone);
				order.setShippingAddress(shippingAddress);
				order.add(cart);

				// System.out.println("結帳前: "+order.getId());

				OrderService oService = new OrderService();
				try {
					oService.checkOut(order);

					// 3.1 轉交給成功check_out_ok.jsp
					request.setAttribute("order", order);
					request.getRequestDispatcher("check_out_success.jsp").forward(request, response);
					return;
				} catch (AILMException e) {
					errors.add(e.getMessage() + ",請聯絡Admin");
					this.log(e.getMessage(), e);
				} catch (Exception e) {
					errors.add("發生系統錯誤:" + e.getMessage() + ",請聯絡Admin");
					this.log("發生系統錯誤!", e);
				}
			}
		} else
			errors.add("購物車是空的，無法結帳");

		if (!errors.isEmpty())
			System.out.println("結帳失敗: " + errors); // for test

		// 3.2 失敗轉交給check_out.jsp
		request.setAttribute("errors", errors);
		request.getRequestDispatcher("check_out.jsp").forward(request, response);
	}

}
