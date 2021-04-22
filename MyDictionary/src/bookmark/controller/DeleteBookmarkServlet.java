package bookmark.controller;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import bookmark.model.BookmarkBean;
import bookmark.model.BookmarkMgr;
import user.model.UserMgr;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;

@WebServlet({"/dictionary/deleteBookmark_D","/dictionary/deleteBookmark_L","/bookmark/deleteBookmark_B"})
public class DeleteBookmarkServlet extends HttpServlet{
	private static final long serialVersionUID = 1L;
	
	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response ) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		
		// 조건문에 담기 위함
		String RequestURI = request.getRequestURI(); // 파일의 경로 path
		String contextPath = request.getContextPath(); // 프로젝트 경로 path
		String command = RequestURI.substring(contextPath.length());
		
		BookmarkMgr mgr = new BookmarkMgr();
		BookmarkBean bean = new BookmarkBean();
		
		String search = request.getParameter("search");
		String userName = request.getParameter("userName");
		int cdNum = Integer.parseInt(request.getParameter("num"));
		String pageNum = request.getParameter("pageNum");
		
		
		
		bean.setCdnum(cdNum);
		bean.setUsername(userName);
		
		mgr.deleteBookmark(bean);
		
		if(search == null) {
			if(command.equals("/dictionary/deleteBookmark_D")) {
				RequestDispatcher rd = request.getRequestDispatcher("DictionaryEx.jsp?pageNum="+pageNum+"&num="+cdNum);
				rd.forward(request, response);
			} else if(command.equals("/dictionary/deleteBookmark_L")) {
				RequestDispatcher rd = request.getRequestDispatcher("LanguageEx.jsp?pageNum="+pageNum+"&num="+cdNum);
				rd.forward(request, response);
			} else if(command.equals("/bookmark/deleteBookmark_B")) {
				RequestDispatcher rd = request.getRequestDispatcher("BookmarkEx.jsp?userName="+userName+"&pageNum="+pageNum+"&num="+cdNum);
				rd.forward(request, response);
			}
		} else {
			if(command.equals("/dictionary/deleteBookmark_D")) {
				RequestDispatcher rd = request.getRequestDispatcher("DictionaryEx.jsp?search="+search+"&pageNum="+pageNum+"&num="+cdNum);
				rd.forward(request, response);
			} else if(command.equals("/dictionary/deleteBookmark_L")) {
				RequestDispatcher rd = request.getRequestDispatcher("LanguageEx.jsp?search="+search+"&pageNum="+pageNum+"&num="+cdNum);
				rd.forward(request, response);
			} else if(command.equals("/bookmark/deleteBookmark_B")) {
				RequestDispatcher rd = request.getRequestDispatcher("BookmarkEx.jsp?search="+search+"&userName="+userName+"&pageNum="+pageNum+"&num="+cdNum);
				rd.forward(request, response);
			}
		}
	}
}
