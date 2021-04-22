package good.controller;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import good.model.GoodBean;
import good.model.GoodMgr;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;

@WebServlet("/board/deleteGood")
public class DeleteGoodServlet extends HttpServlet{
	private static final long serialVersionUID = 1L;
	
	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response ) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		
		
		GoodMgr mgr = new GoodMgr();
		GoodBean bean = new GoodBean();
		
		int commentsNum = Integer.parseInt(request.getParameter("commentsNum"));
		String userName = request.getParameter("userName");
		int num = Integer.parseInt(request.getParameter("num"));
		String pageNum = request.getParameter("pageNum");
		
		bean.setCommentsNum(commentsNum);
		bean.setUserName(userName);
		
		mgr.deleteGood(bean);
		
		RequestDispatcher rd = request.getRequestDispatcher("BoardViewAction.do?num="+num+"&pageNum="+pageNum);
		rd.forward(request, response);
			
			
	}
}
