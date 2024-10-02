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
import com.ailaptopmall.entity.VIP;
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
		
		Customer member = (Customer)session.getAttribute("member");		
		
		//1.讀取request中的form data: account,id,email,phone, password,name,birthday,gender,captcha
										//address,subscribed
		String account = request.getParameter("account");
		String password = request.getParameter("password");
		String changePwd = request.getParameter("changePwd");
		String theNewPassword = request.getParameter("theNewPassword");
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
		if(member == null) {
				errors.add("會員資料不正確，請重新登入!");
				response.sendRedirect("../");
				return;
		}else {
			if(!member.getAccount().equals(account)) errors.add("不得修改帳號!");
			
			if(!member.getPassword().equals(password)) errors.add("原密碼不正確!");
			
			if(changePwd!=null) {
				if(theNewPassword==null || theNewPassword.length()==0) {
					if(!member.getPassword().equals(password)) errors.add("新密碼不正確!");
				}
			}else {
				theNewPassword = password;
			}		
			if(id==null || (id=id.trim()).length()==0) errors.add("必須輸入身分證字號");	
			if(email==null || (email=email.trim()).length()==0) errors.add("必須輸入email");
			if(phone==null || (phone=phone.trim()).length()==0) errors.add("必須輸入手機");
			if(name==null || (name=name.trim()).length()==0) errors.add("必須輸入姓名");
			if(birthday==null || birthday.length()==0) errors.add("必須輸入生日");
			if(gender==null || gender.length()!=1) errors.add("必須選擇性別");
			
			if(captcha ==null || (captcha=captcha.trim()).length()==0) {
					errors.add("必須輸入驗證碼.");
			}else {
				String captchaString = (String)session.getAttribute("captchaString");
				if(!captcha.equalsIgnoreCase(captchaString)) {
					errors.add("驗證碼不正確.");
				}
			}
		}
		session.removeAttribute("captchaString");
		
		//2.若無誤，呼叫商業邏輯
		if(errors.isEmpty()){	
			
			Customer c=null;
			try {
				c = member.getClass().newInstance();
			} catch (InstantiationException|IllegalAccessException e) {
				c = new Customer(); 
			}
			try{
				c.setAccount(member.getAccount());
				c.setId(id);
				c.setEmail(email);
				c.setPhone(phone);
				c.setPassword(changePwd!=null?theNewPassword:password);
				c.setName(name);
				c.setBirthday(birthday);
				c.setGender(gender.charAt(0));
				
				c.setAddress(address);
				c.setSubscribed(subscribed!=null);
				
				if(c instanceof VIP) {
					((VIP)c).setDiscount(((VIP)member).getDiscount());
				}
				
				CustomerService service = new CustomerService();
				service.update(c);
				session.setAttribute("member", c);//取代session中的舊會員資料
				//3.1 外部轉交首頁
				response.sendRedirect("../member/update_success.jsp");
				return;
				
			}catch(AILMDataInvalidException e) {
				errors.add(e.getMessage());
			} catch (AILMException e) {
				errors.add(e.getMessage()+", 請聯絡Admin"); //for users
				this.log(e.getMessage(), e); //for admin
			}catch(Exception e) { 
				errors.add("系統發生錯誤:"+e.getMessage()+", 請聯絡Admin"); //for users
				this.log("會員修改，系統發生錯誤", e); //for admin				
			}
		}
		
		//3.2 內部轉交(forward)失敗的register.jsp
		request.setAttribute("errors", errors);
		RequestDispatcher dispatcher = 
				request.getRequestDispatcher("update.jsp");
		dispatcher.forward(request, response);
	}

}
