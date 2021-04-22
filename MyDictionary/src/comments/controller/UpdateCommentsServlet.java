package comments.controller;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import comments.model.CommentsBean;
import comments.model.CommentsMgr;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;

@WebServlet("/board/updateComments")
public class UpdateCommentsServlet extends HttpServlet{
	private static final long serialVersionUID = 1L;
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response ) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		
		CommentsMgr mgr = new CommentsMgr();
		CommentsBean bean = new CommentsBean();
		
		String pageNum = request.getParameter("pageNum");
		int board_num = Integer.parseInt(request.getParameter("num"));
		
		bean.setContent(request.getParameter("comment2"));
		bean.setNum(Integer.parseInt(request.getParameter("commentNum")));
		
		
		mgr.updateComments(bean);
		response.sendRedirect("./BoardViewAction.do?num="+board_num+"&pageNum="+pageNum);
	}
}
