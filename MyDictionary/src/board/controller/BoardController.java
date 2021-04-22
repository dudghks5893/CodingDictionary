package board.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import board.model.BoardMgr;
import comments.model.CommentsBean;
import comments.model.CommentsMgr;
import good.model.GoodMgr;
import board.model.BoardBean;
import board.model.AdminBoardMgr;
import my.util.paging.Paging;

// 게시판 서블릿 
public class BoardController extends HttpServlet {
	private static final long serialVersionUID = 1L;

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
	
		if (command.equals("/board/BoardListAction.do")) {//등록된 글 목록 페이지 출력하기
			requestBoardList(request); // 게시판에 표시될 게시글을 request에 저장한다.
			RequestDispatcher rd = request.getRequestDispatcher("list.jsp");
			rd.forward(request, response); // 페이지 이동
		} else if (command.equals("/board/BoardWriteForm.do")) { // 글 등록 페이지 출력하기
				requestLoginName(request);
				RequestDispatcher rd = request.getRequestDispatcher("writeForm.jsp");
				rd.forward(request, response);				
		} else if (command.equals("/board/BoardWriteAction.do")) {// 새로운 글 등록하기
				requestBoardWrite(request);
				RequestDispatcher rd = request.getRequestDispatcher("/board/BoardListAction.do");
				rd.forward(request, response);						
		} else if (command.equals("/board/BoardViewAction.do")) {//선택된 글 상세 페이지 가져오기
				requestBoardView(request);
				RequestDispatcher rd = request.getRequestDispatcher("/board/BoardView.do");
				rd.forward(request, response);						
		} else if (command.equals("/board/BoardView.do")) { //글 상세 페이지 출력하기
				RequestDispatcher rd = request.getRequestDispatcher("view.jsp");
				rd.forward(request, response);	
		} else if (command.equals("/board/BoardUpdateAction.do")) { //선택된 글의 조회수 증가하기
				requestBoardUpdate(request);
				RequestDispatcher rd = request.getRequestDispatcher("/board/BoardListAction.do");
				rd.forward(request, response);
		} else if (command.equals("/board/BoardDeleteAction.do")) { //선택된 글 삭제하기
				requestBoardDelete(request);
				RequestDispatcher rd = request.getRequestDispatcher("/board/BoardListAction.do");
				rd.forward(request, response);				
		} else if (command.equals("/board/adminBoardWriteAction.do")) {// 공지사항 등록하기
			requestAdminBoardWrite(request);
			RequestDispatcher rd = request.getRequestDispatcher("/board/BoardListAction.do");
			rd.forward(request, response);						
		} else if (command.equals("/notice/adminBoardViewAction.do")) {//선택된 공지사항 상세 페이지 가져오기
				requestAdminBoardView(request);
				RequestDispatcher rd = request.getRequestDispatcher("/notice/adminview.do");
				rd.forward(request, response);
		} else if (command.equals("/notice/adminview.do")) { //공지사항 상세 페이지 출력하기
				RequestDispatcher rd = request.getRequestDispatcher("adminview.jsp");
				rd.forward(request, response);
		} else if (command.equals("/board/adminBoardUpdateAction.do")) { //선택된 공지사항 수정&조회수 증가하기
				requestAdminBoardUpdate(request);
				RequestDispatcher rd = request.getRequestDispatcher("/board/BoardListAction.do");
				rd.forward(request, response);
		} else if (command.equals("/board/adminBoardDeleteAction.do")) { //선택된 공지사항 삭제하기
				requestAdminBoardDelete(request);
				RequestDispatcher rd = request.getRequestDispatcher("/board/BoardListAction.do");
				rd.forward(request, response);
		} 
	}
	//등록된 글 목록 가져오기	
	public void requestBoardList(HttpServletRequest request){
			
		BoardMgr mgr = new BoardMgr(); 
		AdminBoardMgr notice = new AdminBoardMgr();
		Paging paging = new Paging(); // 페이징 객체 생성
		List<BoardBean> boardlist = new ArrayList<BoardBean>();
		List<BoardBean> noticelist = new ArrayList<BoardBean>();
		
		
		final int LISTCOUNT = 15;  // 화면에 표시되는 리스트 개수
		final int PAGECOUNT = 5;   // 화면에 표시되는 페이지 개수
	  	int pageNum=1; //최초 페이지넘버는 1이다.
	  	int start = 0;// 리스트 출력할 시작 위치
		int	total_record = 0; // 게시글 총 개수
		
		if(request.getParameter("pageNum")!=null) // 페이지 넘버가 있으면 그 값으로
			pageNum=Integer.parseInt(request.getParameter("pageNum"));
		// items= 제목, 본문, 글쓴이,  text = 검색어
		String items = request.getParameter("items");
		String text = request.getParameter("text");
		
		// 화면에 보여줄 공지사항 리스트
		noticelist = notice.getNoticeList();
		
		// 화면에 보여줄 게시글을 가져온다. (페이지넘버,아이템,검색어,리밋(start,cnt))
		boardlist = mgr.getBoardList(pageNum,items, text,start,LISTCOUNT);
		
		// 게시글 총 개수 (제목 또는 본문 또는 글쓴이), 검색어
		total_record = mgr.getListCount(items, text);
		
        //페이징 블록 처리
        paging.getBlockPaging(pageNum, total_record,LISTCOUNT,PAGECOUNT);
        
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
		request.setAttribute("items", items);
		request.setAttribute("text", text);
   		request.setAttribute("pageNum", pageNum);		  
		request.setAttribute("total_record",total_record); 
		request.setAttribute("boardlist", boardlist);								
		request.setAttribute("noticelist", noticelist);								
	}
	//인증된 사용자명 가져오기
	public void requestLoginName(HttpServletRequest request){
					
		String id = request.getParameter("id");
		
		BoardMgr mgr = new BoardMgr();
		
		String name = mgr.getLoginNameById(id);		
		
		request.setAttribute("name", name);									
	}
	// 새로운 글 등록하기
	public void requestBoardWrite(HttpServletRequest request){
					
		BoardMgr mgr = new BoardMgr();
		
		BoardBean board = new BoardBean();
		board.setId(request.getParameter("id"));
		board.setName(request.getParameter("name"));
		board.setSubject(request.getParameter("subject"));
		board.setContent(request.getParameter("content"));	
		
		java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyy/MM/dd(HH:mm:ss)");
		String regist_day = formatter.format(new java.util.Date()); 
		
		board.setHit(0);
		board.setRegist_day(regist_day);
		board.setIp(request.getRemoteAddr());			
		
		mgr.insertBoard(board);					
	}

	//선택된 글 상세 페이지 가져오기
	public void requestBoardView(HttpServletRequest request){
					
		BoardMgr mgr = new BoardMgr();
		CommentsMgr commentsMgr = new CommentsMgr(); // 댓글
		BoardBean board = new BoardBean();
		
		int num = Integer.parseInt(request.getParameter("num"));
		int pageNum = Integer.parseInt(request.getParameter("pageNum"));
		
		
		board = mgr.getBoardByNum(num, pageNum);
		int commentsCount = commentsMgr.getCommentsCount(num); //댓글 개수
		ArrayList<CommentsBean> commentsList = commentsMgr.getCommentsList(num); //댓글 리스트
		
		
		request.setAttribute("commentsCount", commentsCount);
		request.setAttribute("commentsList", commentsList);
		request.setAttribute("num", num);
   		request.setAttribute("page", pageNum); 
   		request.setAttribute("board", board);   									
	}
	//선택된 글 내용 수정하기
	public void requestBoardUpdate(HttpServletRequest request){
					
		int num = Integer.parseInt(request.getParameter("num"));
		
		BoardMgr mgr = new BoardMgr();
		
		BoardBean board = new BoardBean();		
		board.setNum(num);
		board.setName(request.getParameter("name"));
		board.setSubject(request.getParameter("subject"));
		board.setContent(request.getParameter("content"));		
		
		 java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyy/MM/dd(HH:mm:ss)");
		 String regist_day = formatter.format(new java.util.Date()); 
		 
		 board.setHit(0);
		 board.setRegist_day(regist_day);
		 board.setIp(request.getRemoteAddr());			
		
		 mgr.updateBoard(board);								
	}
	//선택된 글 삭제하기
	public void requestBoardDelete(HttpServletRequest request){
					
		int num = Integer.parseInt(request.getParameter("num"));
		
		BoardMgr mgr = new BoardMgr();
		mgr.deleteBoard(num);							
	}
	
	
//========공지사항 영역=========	
	
	
	//선택된 공지사항 상세 페이지 가져오기
	public void requestAdminBoardView(HttpServletRequest request){
					
		AdminBoardMgr dao = new AdminBoardMgr();
		int num = Integer.parseInt(request.getParameter("num"));
		
		BoardBean board = new BoardBean();
		board = dao.admingetBoardByNum(num);		
		
		request.setAttribute("num", num);		 
   		request.setAttribute("board", board);   									
	}
	
	// 공지사항 등록
	public void requestAdminBoardWrite(HttpServletRequest request){
					
		AdminBoardMgr mgr = new AdminBoardMgr();
		
		BoardBean board = new BoardBean();
		board.setId(request.getParameter("id"));
		board.setName(request.getParameter("name"));
		board.setSubject(request.getParameter("subject"));
		board.setContent(request.getParameter("content"));	
		
		java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyy/MM/dd(HH:mm:ss)");
		String regist_day = formatter.format(new java.util.Date()); 
		
		board.setHit(0);
		board.setRegist_day(regist_day);
		board.setIp(request.getRemoteAddr());			
		
		mgr.insertNotice(board);					
	}
	//선택된 공지사항 내용 수정하기
	public void requestAdminBoardUpdate(HttpServletRequest request){
					
		int num = Integer.parseInt(request.getParameter("num"));
		
		AdminBoardMgr dao = new AdminBoardMgr();		
		
		BoardBean board = new BoardBean();		
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
	public void requestAdminBoardDelete(HttpServletRequest request){
					
		int num = Integer.parseInt(request.getParameter("num"));
		
		AdminBoardMgr dao = new AdminBoardMgr();
		dao.admindeleteBoard(num);							
	}
	
	
}
