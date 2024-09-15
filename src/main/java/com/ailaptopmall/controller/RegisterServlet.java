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

import com.ailaptopmall.entity.Member;
import com.ailaptopmall.exception.AILMDataInvalidException;
import com.ailaptopmall.exception.AILMException;
import com.ailaptopmall.service.MemberService;


/**
 * Servlet implementation class RegisterServlet
 */
@WebServlet("/register.do")
public class RegisterServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public RegisterServlet() {
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
		String account = request.getParameter("account");
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
		if(account==null || account.length()==0) errors.add("必須輸入帳號.");
		if(password==null || password.length()==0) errors.add("必須輸入密碼.");
		if(id==null || (id=id.trim()).length()==0) errors.add("必須輸入身分證字號.");			
		if(email==null || (email=email.trim()).length()==0) errors.add("必須輸入email.");
		if(phone==null || (phone=phone.trim()).length()==0) errors.add("必須輸入手機.");
		if(name==null || (name=name.trim()).length()==0) errors.add("必須輸入姓名.");
		if(birthday==null || birthday.length()==0) errors.add("必須輸入生日.");
		if(gender==null || gender.length()!=1) errors.add("必須選擇性別");
		
		if(captcha ==null || (captcha=captcha.trim()).length()==0) {
				errors.add("必須輸入驗證碼.");
		}else {
			String captchaString = (String)session.getAttribute("captchaString");
			if(!captcha.equalsIgnoreCase(captchaString)) {
				errors.add("驗證碼不正確.");
			}
		}
		session.removeAttribute("captchaString");
		
		//2.若無誤，呼叫商業邏輯
		if(errors.isEmpty()){			
			Member m = new Member();
			try{
				m.setAccount(account);
				m.setPassword(password);
				m.setId(id);
				m.setEmail(email);
				m.setPhone(phone);
				m.setName(name);
				m.setBirthday(birthday);
				m.setGender(gender.charAt(0));
				
				m.setAddress(address);
				m.setSubscribed(subscribed!=null);
				
				MemberService service = new MemberService();
				service.register(m);
				
				//3.1 內部轉交(forward)成功 register_ok.jsp
				request.setAttribute("member", m);
				RequestDispatcher dispatcher = 
						request.getRequestDispatcher("register_ok.jsp");
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
