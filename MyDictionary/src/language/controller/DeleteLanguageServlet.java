package language.controller;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import language.model.LanguageBean;
import language.model.LanguageMgr;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;

@WebServlet("/language/deleteLanguage")
public class DeleteLanguageServlet extends HttpServlet{
	
	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response ) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		LanguageMgr mgr = new LanguageMgr();
		LanguageBean bean = new LanguageBean();
		
		bean.setLanguage(request.getParameter("language"));
		
		mgr.deleteLanguage(bean);
		response.sendRedirect("../dictionary/selectDictionary");
		
	}
}
