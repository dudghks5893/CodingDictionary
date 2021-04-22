package user.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import user.model.UserMgr;

@WebServlet("/member/checkUserEmail")
public class CheckUserEmailServlet extends HttpServlet{
	private static final long serialVersionUID = 1L;
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response ) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		
		UserMgr mgr = new UserMgr();
		String mail1 = "";
		String mail2 = "";
		String mail = "";
		
		mail1 = request.getParameter("mail1");
		mail2 = request.getParameterValues("mail2")[0];
		mail = mail1 + "@" + mail2;
		
		int checkEmail = mgr.checkUserEmail(mail);
		
		if(checkEmail < 1)
			response.getWriter().write(0+"");
		if(checkEmail >= 1)
			response.getWriter().write(1+"");
	}
}

