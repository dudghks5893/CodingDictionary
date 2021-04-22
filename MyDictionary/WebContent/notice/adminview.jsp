<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="board.model.BoardBean"%>
<jsp:include page="../include/menu.jsp" />

<html>
<head>
<title>Board</title>
 <style type="text/css">
.hljs {
  padding: 0.3em;
}
.hljs-ln-numbers {
 
    border-right: 1px solid #121212;
    padding-right: 1px !important;
    font-size: 15px;
 	
}
.hljs-ln-code {
    padding-left: 1px !important;
  	font-size: 15px; 
 	
}
</style> 
</head>
<body>
	<div class="jumbotron">
		<div class="container">
			<h1 class="display-3">공지사항</h1>
		</div>
	</div>
<%
BoardBean notice = (BoardBean) request.getAttribute("board");
	int num = ((Integer) request.getAttribute("num")).intValue();
	int pageNum = Integer.parseInt(request.getParameter("pageNum"));
%>
<!-- 관리자가 공지사항을 볼때 -->
<c:choose>
	<c:when test="${sessionId=='admin'}">
	<div class="container">
		<form name="newUpdate"
			action="../board/adminBoardUpdateAction.do?num=<%=notice.getNum()%>"
			class="form-horizontal" method="post">
			<div class="card">
				<div class="card-header">
					<input name="name" type="hidden" class="form-control" value="<%=notice.getName()%>">
					<%=notice.getName()%>
				</div>
			
				<div class="card-body">
					<input name="subject" class="form-control mb-3" value="<%=notice.getSubject().replaceAll("<", "&#60;")%>" >
					<textarea id="content" name="content" class="form-control" cols="50" rows="15"><c:out value="<%=notice.getContent()%>"/></textarea>
					<div class="form-group row mt-3">
						<div class="col-sm-offset-2 col-sm-10 ">
							<a	href="../board/adminBoardDeleteAction.do?num=<%=notice.getNum()%>"	class="btn btn-danger"> 삭제</a> 
							<input type="submit" class="btn btn-success" value="수정 ">
							<a href="../board/BoardListAction.do?pageNum=<%=pageNum%>"	class="btn btn-primary"> 목록</a>
						</div>
					</div>
				</div>
			</div>
		</form>
	</div>
	</c:when>
	<c:otherwise>
	<!-- 유저가 공지사항을 볼때 -->
	<div class="container">
		<form name="newUpdate"
			action="adminBoardUpdateAction.do?num=<%=notice.getNum()%>"
			class="form-horizontal" method="post">
			<div class="card">
				<div class="card-header">
					<%=notice.getName()%>
				</div>
				<div class="card-body">
					<label class="mb-3">제목: <%=notice.getSubject().replaceAll("<", "&#60;")%></label>
					<%=notice.getContent()%>
					<div class="form-group row mt-3">
						<div class="col-sm-offset-2 col-sm-10 ">
							<a href="../board/BoardListAction.do?pageNum=<%=pageNum%>"	class="btn btn-primary"> 목록</a>
						</div>
					</div>
				</div>
			</div>
		</form>
	</div>
	</c:otherwise>
</c:choose>
	<jsp:include page="../include/footer.jsp" />
<script>
    var config = {
      extraPlugins: 'codesnippet',
      codeSnippet_theme: 'monokai_sublime',
      height: 356
    };

    CKEDITOR.replace('content', config);
</script>
</body>
</html>


