package user.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import my.util.mail.EmailSend;
import user.model.UserMgr;

@WebServlet("/member/findUserId")
public class FindUserIdServlet extends HttpServlet{
	private static final long serialVersionUID = 1L;
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response ) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");

		UserMgr mgr = new UserMgr();
		EmailSend mail = new EmailSend();
		
		String toEmail = request.getParameter("email");
		String title = "CodingDictionary에서 회원님의 아이디를 보냅니다";
		String userId = mgr.sendId(toEmail);
		String content ="";
		response.getWriter().write(mgr.checkUserId(userId)+"");
		
		if(userId != null) {
			content = "<h3>회원님의 아이디는 : "+userId+" 입니다.</h3>";
			mail.send(title, content, toEmail);
		}
		
	}
	
}

