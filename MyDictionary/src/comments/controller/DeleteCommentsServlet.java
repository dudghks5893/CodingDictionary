package comments.controller;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import comments.model.CommentsBean;
import comments.model.CommentsMgr;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;

@WebServlet("/board/deleteComments")
public class DeleteCommentsServlet extends HttpServlet{
	private static final long serialVersionUID = 1L;
	
	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response ) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		
		CommentsMgr mgr = new CommentsMgr();
		CommentsBean bean = new CommentsBean();
		
		String pageNum = request.getParameter("pageNum");
		int board_num = Integer.parseInt(request.getParameter("num"));
		
		bean.setNum(Integer.parseInt(request.getParameter("commentNum")));
		
		
		mgr.deleteComments(bean);
		response.sendRedirect("./BoardViewAction.do?num="+board_num+"&pageNum="+pageNum);
	}
}
