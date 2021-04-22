package user.controller;

import java.io.IOException;
import java.util.Random;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import my.util.mail.EmailSend;
import user.model.UserMgr;

@WebServlet("/member/findAuthenticationKey")
public class FindAuthenticationKeyServlet extends HttpServlet{
	private static final long serialVersionUID = 1L;
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response ) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");

		UserMgr mgr = new UserMgr();
		EmailSend mail = new EmailSend();
		
		String toEmail = request.getParameter("userEmail");
		String userId = request.getParameter("userId");
		String title = "CodingDictionary에서 인증번호를 보냅니다";
		String content = "";
		int check = mgr.sendKey(userId,toEmail);
		response.getWriter().write(check+"");
		
		if(check >= 1) {
            //인증 번호 생성기
            StringBuffer temp = new StringBuffer();
            Random rnd = new Random();
            for(int i=0;i<10;i++)
            {
                int rIndex = rnd.nextInt(3);
                switch (rIndex) {
                case 0:
                    // a-z
                    temp.append((char) ((int) (rnd.nextInt(26)) + 97));
                    break;
                case 1:
                    // A-Z
                    temp.append((char) ((int) (rnd.nextInt(26)) + 65));
                    break;
                case 2:
                    // 0-9
                    temp.append((rnd.nextInt(10)));
                    break;
                }
            }
            String authenticationKey = temp.toString();
            HttpSession session = request.getSession();
            session.setMaxInactiveInterval(3*60); // 세션 3분
            session.setAttribute("authenticationKey", authenticationKey);
            session.setAttribute("userId", userId);
            
			content = "<h3>인증번호는 : "+authenticationKey+" 입니다.</h3>";
			mail.send(title, content, toEmail);
		}
		
	}
	
}

