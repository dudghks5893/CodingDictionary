package language.controller;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import language.model.LanguageBean;
import language.model.LanguageMgr;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;

@WebServlet("/language/insertLanguage")
public class InsertLanguageServlet extends HttpServlet{
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response ) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		
		LanguageMgr mgr = new LanguageMgr();
		LanguageBean bean = new LanguageBean();
		String language = "";
		int check = 0;
		
		language = request.getParameter("language");
		bean.setLanguage(request.getParameter("language"));
		
		check = mgr.checkLanguage(language); // 중복 체크
		 
		 
		if(check >= 1) {
			PrintWriter out = response.getWriter();
			out.println("<script>alert('이미 존재하는 언어입니다.'); location.href='../dictionary/selectDictionary';</script>");
			out.flush();
		} else {
			mgr.insertLanguage(bean);
			response.sendRedirect("../dictionary/selectDictionary");
		}
		
	}
}
