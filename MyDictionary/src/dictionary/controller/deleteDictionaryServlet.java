package dictionary.controller;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dictionary.model.DictionaryBean;
import dictionary.model.DictionaryMgr;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;

@WebServlet("/dictionary/deleteDictionary")
public class deleteDictionaryServlet extends HttpServlet{
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response ) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		DictionaryMgr mgr = new DictionaryMgr();
		DictionaryBean bean = new DictionaryBean();
		
		bean.setNum(Integer.parseInt(request.getParameter("num")));
		
		mgr.deleteDictionary(bean);
		response.sendRedirect("selectDictionary_delete");
		
	}
}
