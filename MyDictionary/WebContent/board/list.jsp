<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:useBean id="mgr" class="comments.model.CommentsMgr"/>
<jsp:include page="../include/menu.jsp"/>

<html>
<head>
<title>게시판</title>
<script type="text/javascript">
	function checkForm() {	
		if (${sessionId==null}) {
			alert("로그인 해주세요.");
			return false;
		}

		location.href = "./BoardWriteForm.do?id=${sessionId}"
	}
</script>
</head>
<body>
	<div class="jumbotron">
		<div class="container">
			<h1 class="display-3">게시판</h1>
		</div>
	</div>
	<div class="container">
			<div>
				<div class="text-right">
					<span class="badge badge-success">전체 ${total_record}건	</span>
				</div>
			</div>
			<div style="margin-top: 20px">
				<table class="table table-hover text-center" style="border-bottom: 1px solid #ddd">
					<tr style="text-align:center; background: #4C4C4C; color: #EAEAEA ">
						<th style="width:10%;"></th>
						<th style="width:40%;">제목</th>
						<th style="width:15%;">글쓴이</th>
						<th style="width:25%;">작성일</th>
						<th style="width:10%;">조회</th>
					</tr>
					<c:forEach var="row" items="${noticelist}">
					<tr class="jumbotron">
						<td><span class="notice-radius" style="width:10%; color: #FF0000;">공지</span></td>
						<td style="width:40%; text-align:left;"><a href="../notice/adminBoardViewAction.do?num=${row.num}&pageNum=${pageNum}" style="color: #FF0000;"><c:out value="${row.subject}"/></a></td>
						<td style="width:15%;"><c:out value="${row.name}"/></td>
						<td style="width:25%;"><c:out value="${fn:substring(row.regist_day,0,10)}"/></td>
						<td style="width:10%;"><c:out value="${row.hit}"/></td>
					</tr>
					</c:forEach>

					<c:forEach var="item" items="${boardlist}">
					<c:set var="commentsCount" value="${mgr.getCommentsCount(item.num)}"/>
					<tr>
						<td style="width:10%;">${item.num}</td>
						<td style="width:40%; text-align:left;"><a href="./BoardViewAction.do?num=${item.num}&pageNum=${pageNum}" style="color: #000000;"><c:out value="${item.subject} [${commentsCount}]"/></a></td>
						<td style="width:15%;">${item.name}</td>
						<td style="width:25%;">${item.regist_day}</td>
						<td style="width:10%;">${item.hit}</td>
					</tr>
					</c:forEach>

				</table>
			</div>
<%-- 			${pageCount}<br>
			${blockStartNum}<br>
			${blockLastNum}<br>
			${total_page}<br>
			넥스트${next}<br>
			${back}<br> --%>
			<div style="text-align:right;">
				<a href="#" onclick="checkForm(); return false;" class="btn btn-primary p-2 fas fa-pencil-alt">글쓰기</a>
			</div>
			<div style="background-color:#F3F3F3; ">
			<div class="mt-5 pt-3" align="center">
				<c:set var="pageNum" value="${pageNum}" />
				<c:if test="${!empty text && pageNum >pageCount}">
					<a href="<c:url value="./BoardListAction.do?pageNum=${back}&items=${items}&text=${text}"/>" style="font-size: 12px; text-decoration: none; color: black;">&#60;이전ㅣ</a>
				</c:if>
				<c:if test="${empty text && pageNum >pageCount}">
					<a href="<c:url value="./BoardListAction.do?pageNum=${back}" />" style="font-size: 12px; text-decoration: none; color: black;">&#60;이전ㅣ</a>
				</c:if>
				<c:forEach var="i" begin="${blockStartNum}" end="${blockLastNum}">
					<c:if test="${text ne null}">
						<c:choose>
							<c:when test="${pageNum==i}">
								<a href="<c:url value="./BoardListAction.do?pageNum=${i}&items=${items}&text=${text}" /> " style="text-decoration: none; color: 4C5317;"><b> [${i}]</b></a>
							</c:when>
							<c:otherwise>
								<a href="<c:url value="./BoardListAction.do?pageNum=${i}&items=${items}&text=${text}" /> " style="text-decoration: none; color: 4C5317;"> [${i}]</a>
							</c:otherwise>
						</c:choose>
					</c:if>
					<c:if test="${text eq null}">
						<c:choose>
							<c:when test="${pageNum==i}">
								<a href="<c:url value="./BoardListAction.do?pageNum=${i}" /> " style="text-decoration: none; color: 4C5317;"><b> [${i}]</b></a>
							</c:when>
							<c:otherwise>
								<a href="<c:url value="./BoardListAction.do?pageNum=${i}" /> " style="text-decoration: none; color: 4C5317;"> [${i}]</a>
							</c:otherwise>
						</c:choose>
					</c:if>
				</c:forEach>
				<c:if test="${!empty text && total_page > blockLastNum}">
					<a href="<c:url value="./BoardListAction.do?pageNum=${next}&items=${items}&text=${text}"/>" style="font-size: 12px; text-decoration: none; color: black;">ㅣ다음&#62;</a>
				</c:if>
				<c:if test="${empty text && total_page > blockLastNum}">
					<a href="<c:url value="./BoardListAction.do?pageNum=${next}"/>" style="font-size: 12px; text-decoration: none; color: black;">ㅣ다음&#62;</a>
				</c:if>
			</div>
			<hr>
		<form action="<c:url value="./BoardListAction.do"/>" method="post">
			<div class="pb-2" align="center">
				<table>
					<tr>
						<td width="100%" align="left">&nbsp;&nbsp; 
						<select name="items" class="txt">
								<option value="subject">제목에서</option>
								<option value="content">본문에서</option>
								<option value="name">글쓴이에서</option>
						</select> <input name="text" type="text" placeholder="검색어를 입력해 주세요" /> <input type="submit" id="board-search" class="btn btn-primary " value="검색 " />
						</td>
					</tr>
				</table>
			</div>
		</form>
		</div>
	</div>
	<jsp:include page="../include/footer.jsp" />
</body>
</html>



