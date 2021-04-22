package user.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import user.model.UserMgr;

@WebServlet("/member/updatePwd")
public class updatePwdServlet extends HttpServlet{
	private static final long serialVersionUID = 1L;
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response ) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		HttpSession session = request.getSession();

		
		UserMgr mgr = new UserMgr();
		String userId = (String) session.getAttribute("userId");
		String pwd = request.getParameter("pwd");
		PrintWriter out = response.getWriter();
		
		session.invalidate();
		out.println("<script>alert('비밀번호가 변경 되었습니다'); location.href='../dictionary/selectDictionary';</script>");
		mgr.updatePwd(pwd, userId);

		
	}
	
}

