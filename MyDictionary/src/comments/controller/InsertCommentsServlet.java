package comments.controller;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import comments.model.CommentsBean;
import comments.model.CommentsMgr;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;

@WebServlet("/board/insertComments")
public class InsertCommentsServlet extends HttpServlet{
	private static final long serialVersionUID = 1L;
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response ) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		CommentsMgr mgr = new CommentsMgr();
		CommentsBean bean = new CommentsBean();
		
		java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat();
		String regist_day = formatter.format(new java.util.Date());
		String pageNum = request.getParameter("pageNum");
		int num = Integer.parseInt(request.getParameter("num"));
		
		
		bean.setBoard_num(num);
		bean.setName(request.getParameter("name"));
		bean.setContent(request.getParameter("comment"));
		bean.setRegist_day(regist_day);
		
		
		mgr.insertComments(bean);
		response.sendRedirect("./BoardViewAction.do?num="+num+"&pageNum="+pageNum);
		
		
	}
}
