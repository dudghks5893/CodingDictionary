<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="../dbconn.jsp" %>
<jsp:include page="../include/menu.jsp" />
<jsp:useBean id="mgr" class="user.model.UserMgr"/>
<c:set var="name" value="${mgr.getName(sessionId)}"/>
<html>
<head>
<title>Board</title>
</head>
<script type="text/javascript">
	function checkForm() {
		var write = /^[a-z|A-Z|ㄱ-ㅎ|ㅏ-ㅣ|가-힣|0-9]/;
		var subject = $('#subject').val();
		
		if (!write.test(subject)) {
			alert("공백으로 시작하실 수 없습니다.");
			$('#subject').select();
			return false;
		}		
	}
</script>
<body>

	<div class="jumbotron">
		<div class="container">
			<h1 class="display-3">공지 등록</h1>
		</div>
	</div>
	<div class="container">
		<form name="newWrite" action="../board/adminBoardWriteAction.do" class="form-horizontal" method="post" onsubmit="return checkForm()">
			<input name="id" type="hidden" class="form-control"
				value="${sessionId}">
			<div class="card">
				<div class="card-header">
					<input name="name" type="hidden" class="form-control" value="${name}"
						placeholder="이름">
						${name}
				</div>
				<div class="card-body">
					<input name="subject" type="text" class="form-control mb-3"
						placeholder="제목" required autofocus>
					<textarea id="content" name="content" cols="100" rows="15" class="form-control"
						placeholder="내용" required></textarea>
					<div class="form-group row mt-3">
						<div class="col-sm-offset-2 col-sm-10 ">
				 			<input type="submit" class="btn btn-primary " value="등록 ">				
					 		<a href="javascript:window.history.back();" class="btn btn-primary">취소</a>
						</div>
					</div>
				</div>
			</div>
		</form>
	</div>
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



