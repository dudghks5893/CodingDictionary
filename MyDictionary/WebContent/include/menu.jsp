<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:useBean id="mgr" class="language.model.LanguageMgr"/>
<jsp:useBean id="userDAO" class="user.model.UserMgr"/>


	<!-- 우측 하단 CSS -->
	<link rel="stylesheet" href="../resources/css/bottom_right.css" />
	<!-- 부트스트랩 CSS -->
	<link rel="stylesheet" href="../resources/css/bootstrap.min.css" />
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" integrity="sha384-JcKb8q3iqJ61gNV9KGb8thSsNjpSL0n8PARn9HuZOnIxN0hoP+VmmDGMN5t9UJ0Z" crossorigin="anonymous">
	<!-- board CSS -->
	<link rel="stylesheet" href="../resources/css/board.css"/>
	<!-- 폰트오썸 링크CSS -->
	<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.0.13/css/all.css"/>
	<link href="../resources/styles/monokai-sublime.css" rel="stylesheet" type="text/css">


	<%
		//로그인과정에서 저장된 세션 id를 가져온다. 없으면 null값.
		String sessionId = (String) session.getAttribute("sessionId");
		session.setAttribute("name", userDAO.getName(sessionId));
	%>
<c:set var="list" value="${mgr.getLanguageList()}"/>


 <!-- 최 상단 검은 네브바 -->
  <nav class="navbar navbar-expand-sm navbar-dark bg-dark">
    <!-- 햄버거바 버튼 -->
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#nav" aria-controls="navbarNav"
        aria-expanded="false" aria-label="Toggle navigation">
    	<span class="navbar-toggler-icon"></span>
    </button>
      <!-- collapse 묶음 시작 (화면 작아질때 햄버거바로 이동) -->
      <div class="collapse navbar-collapse" id="nav">
        <!-- 왼쪽 메뉴 -->
        <ul class="navbar-nav">
          <li> <!-- 코딩사전 -->
    		  <a class="navbar-brand dropdown-toggle" data-toggle="dropdown" style="color:#9C5B36" href="<c:url value="../dictionary/Dictionary.jsp"/>">
    			  <i class="fas fa-book"></i>
    		  </a>
    			<div class="dropdown-menu">
              		<a href="<c:url value="../dictionary/selectDictionary"/>" class="dropdown-item">
                		<i class="fas fa-book"></i> 전체보기
              		</a>
              	<c:forEach var="item" items="${list}">
              		<a href="../dictionary/selectLanguage?language=${item.language}" class="dropdown-item">
                		<i class="fas fa-book"></i> ${item.language}
              		</a>
              	</c:forEach>
    		   </div>          	
          </li>
          <li class="nav-item">
			<a href="<c:url value="../board/BoardListAction.do?pageNum=1"/>" class="nav-link"> <!-- 서블릿으로 감 -->
			  <i class="fas fa-Bulletin"></i> 게시판
			</a> 
		  </li>
        </ul>
        <!-- 오른쪽 메뉴 -->
        <ul class="navbar-nav ml-auto">
          <c:choose>
			<c:when test="${empty sessionId}">
          <li class="nav-item">
            <a class="nav-link" href="../dictionary/selectDictionary" data-remote="../member/login.jsp" data-toggle="modal" data-target="#theModal">
              <i class="fas fa-user"></i> 로그인
            </a>
          </li>
         <!-- login.jsp 페이지를 모달로 받아오는 곳 --> 
        <div class="modal fade" id="theModal" role="dialog">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-body" >
						데이터를 불러올 수 없습니다.
					</div>
				</div>
			</div>
		</div>
          <li class="nav-item">
            <a href="<c:url value="../member/addMember.jsp"/>" class="nav-link">
              <i class="fas fa-user-plus"></i> 회원가입
            </a>
          </li>
         </c:when>
		<c:when test="${sessionId.equals('admin') }">
          <li class="nav-item dropdown mr-3">
            <a href="#" class="nav-link dropdown-toggle" data-toggle="dropdown">
              <i class="fas fa-user"></i> <span style="color:red">관리자</span>
            </a>
            <div class="dropdown-menu">
              <a class="dropdown-item" href="../dictionary/selectDictionary" data-remote="../language/insertLanguage.jsp" data-toggle="modal" data-target="#languageModal">
                <i class="fas fa-book"></i> 언어관리
              </a>
              <a href="<c:url value="../dictionary/addDictionary.jsp"/>" class="dropdown-item">
                <i class="fas fa-plus"></i> 코딩추가
              </a>
              <a href="<c:url value="../dictionary/selectDictionary_update"/>" class="dropdown-item">
                <i class="fas fa-cog"></i> 코딩수정
              </a>
              <a href="<c:url value="../dictionary/selectDictionary_delete"/>" class="dropdown-item">
                <i class="fas fa-trash"></i> 코딩삭제
              </a>
              <a href="<c:url value="../memberInfo/MemberManage.jsp"/>" class="dropdown-item">
                <i class="fas fa-user"></i> 유저정보
              </a>
              <a href="<c:url value="../notice/addAdminBoard.jsp"/>" class="dropdown-item">
                <i class="fas fa-bullhorn"></i> 공지등록
              </a>
            </div>
          </li>
             <!-- insertLanguage.jsp 페이지를 모달로 받아오는 곳 --> 
        	<div class="modal fade" id="languageModal" role="dialog">
				<div class="modal-dialog">
					<div class="modal-content">
						<div class="modal-body" >
							데이터를 불러올 수 없습니다.
						</div>
					</div>
				</div>
			</div>
          <li class="nav-item">
            <a href="<c:url value="../member/logoutMember.jsp"/>" class="nav-link">
              <i class="fas fa-user-times"></i> 로그아웃
            </a>
          </li>
          </c:when>
          	<c:otherwise>
          	<li class="nav-item dropdown mr-3">
            <a href="javascript:window.history.back();" class="nav-link dropdown-toggle" data-toggle="dropdown">
              <i class="fas fa-user"></i> [${name}]<b>님</b>
            </a>
          	 <div class="dropdown-menu">
              <a href="<c:url value="../bookmark/selectBookmark?userName=${name}"/>" class="dropdown-item">
                <i class="fas fa-Star"></i> 즐겨찾기
              </a>
              <a href="<c:url value="../member/updateMember.jsp"/>" class="dropdown-item">
                <i class="fas fa-cog"></i> 회원정보
              </a>
              <a href="<c:url value="../member/deleteMember.jsp"/>" class="dropdown-item">
                <i class="fas fa-trash"></i> 회원탈퇴
              </a>
            </div>
          </li>
          <li class="nav-item">
            <a href="<c:url value="/member/logoutMember.jsp"/>" class="nav-link">
              <i class="fas fa-user-times"></i> 로그아웃
            </a>
          </li>
          	</c:otherwise>
		</c:choose>
        </ul>
        <!-- 오른쪽 메뉴 끝 -->
      </div>
      <!-- collapse 묶음 끝 -->
  </nav>
  <!-- 최 상단 검은 네브바 끝-->
  <!--  <script src="../resources/js/jquery-3.5.1.min.js"></script> --> 
  	<!-- jQuery 항상 최신 버전 사용 -->
    <script  src="http://code.jquery.com/jquery-latest.min.js"></script>
    <script src="../resources/js/bootstrap.bundle.min.js"></script>
    <!-- ckeditor4 -->
	<script src="https://cdn.ckeditor.com/4.16.0/standard-all/ckeditor.js"></script>
    <!-- 다크모드 js -->
    <script src="../resources/js/darkmode.js"></script>
    <!-- 코딩 하이라이터 js -->
    <script src="../resources/js/highlight.pack.js"></script>
	<script>hljs.initHighlightingOnLoad();</script>
    <script src="../resources/js/highlightjs-line-numbers.js"></script>
    
<script> hljs.initLineNumbersOnLoad();
$(document).ready(function() {
	$('code.hljs').each(function(i, block) {
		hljs.lineNumbersBlock(block);
	});
});
</script>
    
    
    
    <!-- login.jsp 페이지 모달창으로 받아오는 함수 -->
    <script type="text/javascript">
    $('#theModal').on('show.bs.modal', function(e) {
    	
		var button = $(e.relatedTarget);
		var modal = $(this);
		
		modal.find('.modal-body').load(button.data("remote"));

	});
    </script>
      
    <!-- insertLanguage.jsp 페이지 모달창으로 받아오는 함수 -->
    <script type="text/javascript">
    $('#languageModal').on('show.bs.modal', function(e) {
    	
		var button = $(e.relatedTarget);
		var modal = $(this);
		
		modal.find('.modal-body').load(button.data("remote"));

	});
    </script>  
