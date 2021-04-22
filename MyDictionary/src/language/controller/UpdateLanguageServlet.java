package language.controller;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import language.model.LanguageBean;
import language.model.LanguageMgr;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;

@WebServlet("/language/updateLanguage")
public class UpdateLanguageServlet extends HttpServlet{
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response ) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		LanguageMgr mgr = new LanguageMgr();
		LanguageBean bean = new LanguageBean();
		
		String setlanguage = request.getParameter("setlanguage");
		bean.setLanguage(request.getParameter("language"));
		
		mgr.updateLanguage(bean,setlanguage);
		response.sendRedirect("../dictionary/selectDictionary");
		
	}
}
