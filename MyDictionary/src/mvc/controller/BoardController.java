package mvc.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import mvc.model.BoardDAO;
import mvc.model.BoardDTO;
import mvc.model.adminBoardDAO;

// 게시판 서블릿 
public class BoardController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	static final int LISTCOUNT = 10;  // 화면에 표시되는 게시글 숫자

	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String RequestURI = request.getRequestURI(); // 파일의 경로 path
		String contextPath = request.getContextPath(); // 프로젝트 경로 path
		// 총 파일경로에서 프로젝트 경로를 뺀 path
		// 예: http://localhost:8010/WebMarket (/BoardListAction.do)
		String command = RequestURI.substring(contextPath.length()); // substring: 잘라내기
		
		response.setContentType("text/html; charset=utf-8");
		request.setCharacterEncoding("utf-8");
	
		if (command.equals("/BoardListAction.do")) {//등록된 글 목록 페이지 출력하기
			requestBoardList(request); // 게시판에 표시될 게시글을 request에 저장한다.
			RequestDispatcher rd = request.getRequestDispatcher("./board/list.jsp");
			rd.forward(request, response); // 페이지 이동
		} else if (command.equals("/BoardWriteForm.do")) { // 글 등록 페이지 출력하기
				requestLoginName(request);
				RequestDispatcher rd = request.getRequestDispatcher("./board/writeForm.jsp");
				rd.forward(request, response);				
		} else if (command.equals("/BoardWriteAction.do")) {// 새로운 글 등록하기
				requestBoardWrite(request);
				RequestDispatcher rd = request.getRequestDispatcher("/BoardListAction.do");
				rd.forward(request, response);						
		} else if (command.equals("/BoardViewAction.do")) {//선택된 글 상세 페이지 가져오기
				requestBoardView(request);
				RequestDispatcher rd = request.getRequestDispatcher("/BoardView.do");
				rd.forward(request, response);						
		} else if (command.equals("/BoardView.do")) { //글 상세 페이지 출력하기
				RequestDispatcher rd = request.getRequestDispatcher("./board/view.jsp");
				rd.forward(request, response);	
		} else if (command.equals("/BoardUpdateAction.do")) { //선택된 글의 조회수 증가하기
				requestBoardUpdate(request);
				RequestDispatcher rd = request.getRequestDispatcher("/BoardListAction.do");
				rd.forward(request, response);
		} else if (command.equals("/BoardDeleteAction.do")) { //선택된 글 삭제하기
				requestBoardDelete(request);
				RequestDispatcher rd = request.getRequestDispatcher("/BoardListAction.do");
				rd.forward(request, response);				
		} else if (command.equals("/adminBoardViewAction.do")) {//선택된 공지사항 상세 페이지 가져오기
				adminrequestBoardView(request);
				RequestDispatcher rd = request.getRequestDispatcher("/adminview.do");
				rd.forward(request, response);
		} else if (command.equals("/adminview.do")) { //공지사항 상세 페이지 출력하기
				RequestDispatcher rd = request.getRequestDispatcher("./notice/adminview.jsp");
				rd.forward(request, response);
		} else if (command.equals("/adminBoardUpdateAction.do")) { //선택된 공지사항 조회수 증가하기
				adminrequestBoardUpdate(request);
				RequestDispatcher rd = request.getRequestDispatcher("/BoardListAction.do");
				rd.forward(request, response);
		} else if (command.equals("/adminBoardDeleteAction.do")) { //선택된 공지사항 삭제하기
				adminrequestBoardDelete(request);
				RequestDispatcher rd = request.getRequestDispatcher("/BoardListAction.do");
				rd.forward(request, response);
		}
	}
	//등록된 글 목록 가져오기	
	public void requestBoardList(HttpServletRequest request){
			
		BoardDAO dao = BoardDAO.getInstance(); // 유일한 객체를 가져옴
		List<BoardDTO> boardlist = new ArrayList<BoardDTO>();
		
	  	int pageNum=1; //최초 페이지넘버는 1이다.
	  	int start = 0;// 리스트 출력할 시작 위치
		int cnt=LISTCOUNT; //화면 표시 게시글수 10
		
		if(request.getParameter("pageNum")!=null) // 페이지 넘버가 있으면 그 값으로
			pageNum=Integer.parseInt(request.getParameter("pageNum"));
		// items= 제목, 본문, 글쓴이,  text = 검색어
		String items = request.getParameter("items");
		String text = request.getParameter("text");
		
		// 게시글이 몇개 인지? (제목 또는 본문 또는 글쓴이), 검색어
		int total_record=dao.getListCount(items, text);
		// 화면에 보여줄 게시글을 가져온다. (페이지넘버, 표시되는게시글수(5), 아이템, 검색어)
		boardlist = dao.getBoardList(pageNum,items, text,start,cnt); 
		
		int total_page;
		
		if (total_record % cnt == 0){ // 총 게시글숫자가 10의 배수일때     
	     	total_page =total_record/cnt;
	     	Math.floor(total_page);  
		}
		else{ // 아닐때
		   total_page =total_record/cnt;
		   Math.floor(total_page); // 소수점 버림 
		   total_page =  total_page + 1; // 나머지가 있는경우에 페이지+1을 해준다. 
		}		
		// 리퀘스트에 페이지넘버, 전체 페이지 수, 전체 게시글 수, 화면에 출력할 게시글리스트
		request.setAttribute("items", items);
		request.setAttribute("text", text);
   		request.setAttribute("pageNum", pageNum);		  
   		request.setAttribute("total_page", total_page);   
		request.setAttribute("total_record",total_record); 
		request.setAttribute("boardlist", boardlist);								
	}
	//인증된 사용자명 가져오기
	public void requestLoginName(HttpServletRequest request){
					
		String id = request.getParameter("id");
		
		BoardDAO  dao = BoardDAO.getInstance();
		
		String name = dao.getLoginNameById(id);		
		
		request.setAttribute("name", name);									
	}
	// 새로운 글 등록하기
	public void requestBoardWrite(HttpServletRequest request){
					
		BoardDAO dao = BoardDAO.getInstance();		
		
		BoardDTO board = new BoardDTO();
		board.setId(request.getParameter("id"));
		board.setName(request.getParameter("name"));
		board.setSubject(request.getParameter("subject"));
		board.setContent(request.getParameter("content"));	
		
		//System.out.println(request.getParameter("name"));
		//System.out.println(request.getParameter("subject"));
		//System.out.println(request.getParameter("content"));
		java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyy/MM/dd(HH:mm:ss)");
		String regist_day = formatter.format(new java.util.Date()); 
		
		board.setHit(0);
		board.setRegist_day(regist_day);
		board.setIp(request.getRemoteAddr());			
		
		dao.insertBoard(board); // 여기에 담음								
	}

	//선택된 글 상세 페이지 가져오기
	public void requestBoardView(HttpServletRequest request){
					
		BoardDAO dao = BoardDAO.getInstance();
		int num = Integer.parseInt(request.getParameter("num"));
		int pageNum = Integer.parseInt(request.getParameter("pageNum"));	
		
		BoardDTO board = new BoardDTO();
		board = dao.getBoardByNum(num, pageNum);		
		
		request.setAttribute("num", num);		 
   		request.setAttribute("page", pageNum); 
   		request.setAttribute("board", board);   									
	}
	//선택된 글 내용 수정하기
	public void requestBoardUpdate(HttpServletRequest request){
					
		int num = Integer.parseInt(request.getParameter("num"));
		
		BoardDAO dao = BoardDAO.getInstance();		
		
		BoardDTO board = new BoardDTO();		
		board.setNum(num);
		board.setName(request.getParameter("name"));
		board.setSubject(request.getParameter("subject"));
		board.setContent(request.getParameter("content"));		
		
		 java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyy/MM/dd(HH:mm:ss)");
		 String regist_day = formatter.format(new java.util.Date()); 
		 
		 board.setHit(0);
		 board.setRegist_day(regist_day);
		 board.setIp(request.getRemoteAddr());			
		
		 dao.updateBoard(board);								
	}
	//선택된 글 삭제하기
	public void requestBoardDelete(HttpServletRequest request){
					
		int num = Integer.parseInt(request.getParameter("num"));
		
		BoardDAO dao = BoardDAO.getInstance();
		dao.deleteBoard(num);							
	}
	
	
	
	
	
	//선택된 공지사항 상세 페이지 가져오기
	public void adminrequestBoardView(HttpServletRequest request){
					
		adminBoardDAO dao = new adminBoardDAO();
		int num = Integer.parseInt(request.getParameter("num"));
		
		BoardDTO board = new BoardDTO();
		board = dao.admingetBoardByNum(num);		
		
		request.setAttribute("num", num);		 
   		request.setAttribute("board", board);   									
	}
	//선택된 공지사항 내용 수정하기
	public void adminrequestBoardUpdate(HttpServletRequest request){
					
		int num = Integer.parseInt(request.getParameter("num"));
		
		adminBoardDAO dao = new adminBoardDAO();		
		
		BoardDTO board = new BoardDTO();		
		board.setNum(num);
		board.setName(request.getParameter("name"));
		board.setSubject(request.getParameter("subject"));
		board.setContent(request.getParameter("content"));		
		
		 java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyy/MM/dd(HH:mm:ss)");
		 String regist_day = formatter.format(new java.util.Date()); 
		 
		 board.setHit(0);
		 board.setRegist_day(regist_day);
		 board.setIp(request.getRemoteAddr());			
		
		 dao.adminupdateBoard(board);								
	}
	//선택된 공지사항 삭제하기
	public void adminrequestBoardDelete(HttpServletRequest request){
					
		int num = Integer.parseInt(request.getParameter("num"));
		
		adminBoardDAO dao = new adminBoardDAO();
		dao.admindeleteBoard(num);							
	}
	
	
}