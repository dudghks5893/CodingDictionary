package user.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import user.model.UserBean;
import user.model.UserMgr;

@WebServlet("/member/insertUser")
public class InsertUserServlet extends HttpServlet{
	private static final long serialVersionUID = 1L;
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response ) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		UserBean bean = new UserBean(); 
		UserMgr mgr = new UserMgr();
		
		String mail1 = "";
		String mail2 = "";
		String mail = "";
		String userName = "";
		String userId = "";
		
		mail1 = request.getParameter("mail1");
		mail2 = request.getParameterValues("mail2")[0];
		mail = mail1 + "@" + mail2;
		
		
		
		userName = request.getParameter("name");
		userId = request.getParameter("id");
		//userId = (String) request.getAttribute("id");
		
		// 현재 날짜와 시간을 생성한다. (가입한 시간 알기 위해서)
		java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyy-MM-dd(HH:mm:ss)");
		String regist_day = formatter.format(new java.util.Date()); 
		
		bean.setUserID(userId);
		bean.setUserPassword(request.getParameter("password"));
		bean.setUserName(userName);
		bean.setUserEmail(mail);
		bean.setregist_day(regist_day);
		
		
		int checkId = mgr.checkUserId(userId);
		int checkName = mgr.checkUserName(userName);
		int checkEmail = mgr.checkUserEmail(mail);
		
		if(checkId >= 1) {
			RequestDispatcher rd = request.getRequestDispatcher("addMember.jsp?error=1");
			rd.forward(request, response);
		} else if (checkName >= 1) {
			RequestDispatcher rd = request.getRequestDispatcher("addMember.jsp?error=2");
			rd.forward(request, response);
		} else if (checkEmail >= 1) {
			RequestDispatcher rd = request.getRequestDispatcher("addMember.jsp?error=3");
			rd.forward(request, response);
		} else {
			mgr.insertUser(bean);
			RequestDispatcher rd = request.getRequestDispatcher("resultMember.jsp?msg=1");
			rd.forward(request, response);
		}
		
	}
}

