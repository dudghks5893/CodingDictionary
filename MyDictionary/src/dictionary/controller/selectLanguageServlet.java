package dictionary.controller;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dictionary.model.DictionaryBean;
import dictionary.model.DictionaryMgr;
import my.util.paging.Paging;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;

@WebServlet("/dictionary/selectLanguage")
public class selectLanguageServlet extends HttpServlet{
	
	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response ) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		DictionaryMgr mgr = new DictionaryMgr();
		Paging paging = new Paging();
		
		final int LISTCOUNT = 10;  // 화면에 표시되는 리스트 개수
		final int PAGECOUNT = 5; // 화면에 표시되는 페이지 개수
		int pageNum = 1; // 최초 시작 페이지
		int start = 0;   // 리스트 출력할 시작 위치
		int	total_record = 0; // 게시글 총 개수
		
		// request 영역
		if(request.getParameter("pageNum") != null){
	    	pageNum = Integer.parseInt(request.getParameter("pageNum"));
	 	}
		String search = request.getParameter("search");
		// request 영역
		String language = request.getParameter("language");// 보여질 언어
		
		// 사전 리스트
		ArrayList<DictionaryBean> list = mgr.getLanguageDictionary(pageNum, search, language,start,LISTCOUNT);
		
		//페이징 블록 처리
		total_record = mgr.getLanguageCount(search, language);
	    paging.getBlockPaging(pageNum, total_record,LISTCOUNT,PAGECOUNT);
		
		//페이징 처리 변수들
	    int blockStartNum = paging.getBlockStartNum();
	    int blockLastNum = paging.getBlockLastNum();
	    int total_page = paging.getTotal_page();
	    int next = paging.getNext();
	    int back = paging.getBack();
	    
        request.setAttribute("pageCount", PAGECOUNT);
        request.setAttribute("blockStartNum", blockStartNum);
        request.setAttribute("blockLastNum", blockLastNum);
        request.setAttribute("total_page", total_page);
        request.setAttribute("next", next);
        request.setAttribute("back", back);
   		request.setAttribute("pageNum", pageNum);		  
		request.setAttribute("total_record",total_record); 
		request.setAttribute("dictionarylist", list);
		request.setAttribute("search", search);
		request.setAttribute("language", language);
		
		RequestDispatcher rd = request.getRequestDispatcher("Language.jsp");// request값 전달
		rd.forward(request, response);
		
	}
}
