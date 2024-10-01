package com.ailaptopmall.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.ailaptopmall.entity.Customer;
import com.ailaptopmall.exception.AILMException;
import com.ailaptopmall.exception.LoginFailedException;
import com.ailaptopmall.service.CustomerService;

/**
 * Servlet implementation class LoginServlet
 */
@WebServlet(urlPatterns = "/login.do", loadOnStartup = 1) // http://localhost:8080/vgb/login.do
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public LoginServlet() {
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
		// request.setCharacterEncoding("utf-8");
		HttpSession session = request.getSession();

		// 1.讀取request中的form data: id, password, captcha
		String account = request.getParameter("account");
		String password = request.getParameter("password");
		String captcha = request.getParameter("captcha");
		// System.out.println(captcha); //for test

		// 檢查必要欄位是否正確輸入
		if (account == null || (account = account.trim()).length() == 0)
			errors.add("必須輸入帳號");
		if (password == null || password.length() == 0)
			errors.add("必須輸入密碼");
		if (captcha == null || (captcha = captcha.trim()).length() == 0) {
			errors.add("必須輸入驗證碼");
		} else {
			String captchaString = (String) session.getAttribute("captchaString");
			if (!captcha.equalsIgnoreCase(captchaString)) {
				errors.add("驗證碼不正確");
			}
		}
		session.removeAttribute("captchaString");
		String prevURI = (String)session.getAttribute("previous_uri");		
		session.removeAttribute("previous_uri");

		// 2.檢查無誤，呼叫商業邏輯: CustomerService.login
		if (errors.isEmpty()) {
			CustomerService service = new CustomerService();
			try {
				Customer c = service.login(account, password);

				// 3.1 內部轉交(forward)成功 login_success.jsp
				session.setAttribute("member", c);
				if(prevURI!=null)request.setAttribute("previous_uri", prevURI);
				
				// session.setMaxInactiveInterval(10); //sec., 小心這行不要亂加
				RequestDispatcher dispatcher = request.getRequestDispatcher("login_success.jsp");
				dispatcher.forward(request, response);
				return;
			} catch (LoginFailedException e) {
				errors.add(e.getMessage());
			} catch (AILMException e) {
				this.log(e.getMessage(), e); // for admin
				errors.add(e.getMessage() + ", 請聯絡Admin"); // for users
			} catch (Exception e) { // RuntimeException
				this.log("會員登入時系統發生錯誤", e); // for admin
				errors.add("系統發生錯誤:" + e + ", 請聯絡Admin"); // for users
			}
		}

		// 3.2 內部轉交(forward)失敗的login.jsp
		request.setAttribute("errors", errors);
		RequestDispatcher dispatcher = request.getRequestDispatcher("login.jsp");
		dispatcher.forward(request, response);
	}
}