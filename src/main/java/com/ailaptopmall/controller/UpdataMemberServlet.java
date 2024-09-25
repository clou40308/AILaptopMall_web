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
import com.ailaptopmall.exception.AILMDataInvalidException;
import com.ailaptopmall.exception.AILMException;
import com.ailaptopmall.service.CustomerService;

/**
 * Servlet implementation class UpdataMemberServlet
 */
@WebServlet("/member/update.do")
public class UpdataMemberServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UpdataMemberServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		List<String> errors = new ArrayList<>();
		request.setCharacterEncoding("utf-8");		
		HttpSession session = request.getSession();
		
		//1.讀取request中的form data: account,password,id,email,phone,name,birthday,gender,captcha
										//address,subscribed
		String password = request.getParameter("password");
		String id = request.getParameter("id");
		String email = request.getParameter("email");
		String phone = request.getParameter("phone");	
		String name = request.getParameter("name");
		String birthday = request.getParameter("birthday");
		String gender = request.getParameter("gender");
		String captcha = request.getParameter("captcha");
		
		String address = request.getParameter("address");
		String subscribed = request.getParameter("subscribed");
		
		//並檢查之
		if(password==null || password.length()==0) errors.add("必須輸入密碼");
		if(id==null || (id=id.trim()).length()==0) errors.add("必須輸入身分證字號");			
		if(email==null || (email=email.trim()).length()==0) errors.add("必須輸入email");
		if(phone==null || (phone=phone.trim()).length()==0) errors.add("必須輸入手機");
		if(name==null || (name=name.trim()).length()==0) errors.add("必須輸入姓名");
		if(birthday==null || birthday.length()==0) errors.add("必須輸入生日");
		if(gender==null || gender.length()!=1) errors.add("必須選擇性別");
		
		if(captcha ==null || (captcha=captcha.trim()).length()==0) {
				errors.add("必須輸入驗證碼");
		}else {
			String captchaString = (String)session.getAttribute("captchaString");
			if(!captcha.equalsIgnoreCase(captchaString)) {
				errors.add("驗證碼不正確");
			}
		}
		session.removeAttribute("captchaString");
		
		//2.若無誤，呼叫商業邏輯
		if(errors.isEmpty()){			
			Customer c = new Customer();
			try{
				c.setPassword(password);
				c.setId(id);
				c.setEmail(email);
				c.setPhone(phone);
				c.setName(name);
				c.setBirthday(birthday);
				c.setGender(gender.charAt(0));
				
				c.setAddress(address);
				c.setSubscribed(subscribed!=null);
				
				CustomerService service = new CustomerService();
				service.register(c);
				
				//3.1 內部轉交(forward)成功 register_success.jsp
				request.setAttribute("member", c);
				RequestDispatcher dispatcher = 
						request.getRequestDispatcher("index.jsp");
				dispatcher.forward(request, response);
				return;
				
			}catch(AILMDataInvalidException e) {
				errors.add(e.getMessage());
			} catch (AILMException e) {
				errors.add(e.getMessage()+", 請聯絡Admin"); //for users
				this.log(e.getMessage(), e); //for admin
			}catch(Exception e) { 
				errors.add("系統發生錯誤:"+e.getMessage()+", 請聯絡Admin"); //for users
				this.log("會員註冊，系統發生錯誤", e); //for admin				
			}
		}
		
		//3.2 內部轉交(forward)失敗的register.jsp
		request.setAttribute("errors", errors);
		RequestDispatcher dispatcher = 
				request.getRequestDispatcher("register.jsp");
		dispatcher.forward(request, response);		
	}

}
