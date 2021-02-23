<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> <!-- jstl-1.2.jar라이브러리 추가해야 코어태그 사용가능 -->
<%@ include file="../dbconn.jsp"%>

	<!-- 부트스트랩 CSS -->
	<link rel="stylesheet" href="./resources/css/bootstrap.min.css" />
	<!-- 폰트오썸 링크CSS -->
	<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.0.13/css/all.css"/>
	<!-- styles폴더에 highlight CSS (코딩 하이라이터)-->
	<link href="./resources/styles/monokai-sublime.css" rel="stylesheet" type="text/css">

	
	<%
		//로그인과정에서 저장된 세션 id를 가져온다. 없으면 null값.
		String sessionId = (String) session.getAttribute("sessionId");
	%>
	
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
    		  <a class="navbar-brand dropdown-toggle" data-toggle="dropdown" style="color:#9C5B36" href="<c:url value="./dictionary/Dictionary.jsp"/>">
    			  <i class="fas fa-book"></i>
    		  </a>
    			<div class="dropdown-menu">
              		<a href="<c:url value="./dictionary/Dictionary.jsp"/>" class="dropdown-item">
                		<i class="fas fa-book"></i> 전체보기
              		</a>
              		<a href="<c:url value="./dictionary/Language.jsp?language=CSS"/>" class="dropdown-item">
                		<i class="fas fa-book"></i> CSS
              		</a>
              		<a href="<c:url value="./dictionary/Language.jsp?language=HTML"/>" class="dropdown-item">
                		<i class="fas fa-book"></i> HTML
              		</a>
              		<a href="<c:url value="./dictionary/Language.jsp?language=JAVA"/>" class="dropdown-item">
                		<i class="fas fa-book"></i> JAVA
              		</a>
              		<a href="<c:url value="./dictionary/Language.jsp?language=JavaScript"/>" class="dropdown-item">
                		<i class="fas fa-book"></i> JavaScript
              		</a>
              		<a href="<c:url value="./dictionary/Language.jsp?language=JSTL"/>" class="dropdown-item">
                		<i class="fas fa-book"></i> JSTL
              		</a>
              		<a href="<c:url value="./dictionary/Language.jsp?language=XML"/>" class="dropdown-item">
                		<i class="fas fa-book"></i> XML
              		</a>
    		   </div>          	
          </li>
          <li class="nav-item">
			<a href="<c:url value="/BoardListAction.do?pageNum=1"/>" class="nav-link"> <!-- 서블릿으로 감 -->
			  <i class="fas fa-Bulletin"></i> 게시판
			</a> 
		  </li>
        </ul>
        <!-- 오른쪽 메뉴 -->
        <ul class="navbar-nav ml-auto">
          <c:choose>
			<c:when test="${empty sessionId }">
          <li class="nav-item">
            <a class="nav-link" href="#" data-remote="./member/boardLogin.jsp" data-toggle="modal" data-target="#theModal">
              <i class="fas fa-user"></i> 로그인
            </a>
          </li>
         <!-- 외부페이지를 모달로 받아오는 곳 --> 
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
            <a href="<c:url value="./member/addMember.jsp"/>" class="nav-link">
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
              <a href="<c:url value="./dictionary/addDictionary.jsp"/>" class="dropdown-item">
                <i class="fas fa-plus"></i> 코딩추가
              </a>
              <a href="<c:url value="./dictionary/updateDictionary.jsp"/>" class="dropdown-item">
                <i class="fas fa-cog"></i> 코딩수정
              </a>
              <a href="<c:url value="./dictionary/deleteDictionary.jsp"/>" class="dropdown-item">
                <i class="fas fa-trash"></i> 코딩삭제
              </a>
              <a href="<c:url value="./memberInfo/MemberManage.jsp"/>" class="dropdown-item">
                <i class="fas fa-user"></i> 유저정보
              </a>
              <a href="<c:url value="./notice/addAdminBoard.jsp"/>" class="dropdown-item">
                <i class="fas fa-bullhorn"></i> 공지등록
              </a>
            </div>
          </li>
          <li class="nav-item">
            <a href="<c:url value="./member/logoutMember.jsp"/>" class="nav-link">
              <i class="fas fa-user-times"></i> 로그아웃
            </a>
          </li>
          </c:when>
          	<c:otherwise>
          	<%
          		String sql = "SELECT * FROM member where id = ?";
          		pstmt = conn.prepareStatement(sql);
          		pstmt.setString(1,sessionId);
				rs = pstmt.executeQuery();
				if(rs.next()){
          	%>
          	<li class="nav-item dropdown mr-3">
            <a href="javascript:window.history.back();" class="nav-link dropdown-toggle" data-toggle="dropdown">
              <i class="fas fa-user"></i> [<%=rs.getString("name")%>]<b>님</b>
            </a>
            <%
				}
				//DB연결을 닫는다.
				if (rs != null) rs.close();
				if (pstmt != null) pstmt.close();
				if (conn != null) conn.close();
            %>
          	 <div class="dropdown-menu">
              <a href="<c:url value="./member/updateMember.jsp"/>" class="dropdown-item">
                <i class="fas fa-cog"></i> 회원정보
              </a>
              <a href="<c:url value="/#"/>" class="dropdown-item">
                <i class="fas fa-Star"></i> 즐겨찾기
              </a>
              <a href="<c:url value="./member/deleteMember.jsp"/>" class="dropdown-item">
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
    <script src="./resources/js/jquery-3.5.1.min.js"></script>
    <script src="./resources/js/bootstrap.bundle.min.js"></script>
    <!-- 코딩 하이라이터 js -->
    <script src="./resources/js/highlight.pack.js"></script>
	<script>hljs.initHighlightingOnLoad();</script>
	
    <script src="./resources/js/highlightjs-line-numbers.js"></script>
<script> hljs.initLineNumbersOnLoad();
$(document).ready(function() {
	$('code.hljs').each(function(i, block) {
		hljs.lineNumbersBlock(block);
	});
});
</script>
    
    
    
    <!-- 외부 페이지 모달창으로 받아오는 함수 -->
    <script type="text/javascript">
    $('#theModal').on('show.bs.modal', function(e) {
    	
		var button = $(e.relatedTarget);
		var modal = $(this);
		
		modal.find('.modal-body').load(button.data("remote"));

	});
    </script>  
