package dictionary.controller;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dictionary.model.DictionaryBean;
import dictionary.model.DictionaryMgr;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;

@WebServlet("/dictionary/insertDictionary")
public class InsertDictionaryServlet extends HttpServlet{
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response ) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		DictionaryMgr mgr = new DictionaryMgr();
		DictionaryBean bean = new DictionaryBean();
		
		bean.setLanguage(request.getParameter("language"));
		bean.setCode(request.getParameter("code"));
		bean.setAbbreviation(request.getParameter("abbreviation"));
		bean.setMeaning(request.getParameter("meaning"));
		bean.setType(request.getParameter("type"));
		bean.setExplanation(request.getParameter("explanation"));
		bean.setEx(request.getParameter("ex"));
		
		mgr.insertDictionary(bean);
		response.sendRedirect("selectDictionary");
		
	}
}
