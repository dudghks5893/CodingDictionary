package language.controller;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import language.model.LanguageBean;
import language.model.LanguageMgr;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;

@WebServlet("/dictionary/insertLanguage")
public class InsertLanguageServlet extends HttpServlet{
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response ) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		LanguageMgr mgr = new LanguageMgr();
		LanguageBean bean = new LanguageBean();
		
		bean.setLanguage(request.getParameter("language"));
		
		mgr.insertLanguage(bean);
		response.sendRedirect("selectDictionary");
		
	}
}
