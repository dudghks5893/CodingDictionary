<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="board.model.BoardBean"%>
<jsp:include page="../include/menu.jsp"/>
<jsp:useBean id="mgr" class="good.model.GoodMgr"/>
<%
BoardBean notice = (BoardBean) request.getAttribute("board");
	int num = ((Integer) request.getAttribute("num")).intValue();
	int nowpage = ((Integer) request.getAttribute("page")).intValue();
	String userid = (String) session.getAttribute("sessionId");
%>
<html>
<head>
<title>게시글</title>
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
<script type="text/javascript">
	var insertForm = document.insertForm;
	function checkForm() {	
		if (${sessionId==null}) {
			alert("로그인 해주세요.");
			return false;
		}
		insertForm.submit();
	}
</script>

<script type="text/javascript">
	function mark() {
		if(<%=userid%>==null){
			alert("로그인 해주세요.");
			return false;
		}
	}
</script>
<script type="text/javascript">
	function edit(num){
			if (document.querySelector('#comment-edit-btn'+num).value === '수정'){
				$("#content-hide"+num).show();
				$("#content-show"+num).hide();
				document.querySelector('#comment-edit-btn'+num).value = '취소';
			} else {
				$("#content-hide"+num).hide();
				$("#content-show"+num).show();
				document.querySelector('#comment-edit-btn'+num).value = '수정';
			}
		    var config = {
		    	      extraPlugins: 'codesnippet',
		    	      codeSnippet_theme: 'monokai_sublime',
		    	      height: 356
		    	    };

		    	    CKEDITOR.replace('comment'+num, config);
	}
</script>
<!-- <script src="https://cdn.ckeditor.com/ckeditor5/26.0.0/classic/ckeditor.js"></script> -->
</head>
<body>
	<div class="jumbotron">
		<div class="container">
			<h1 class="display-3">게시글</h1>
		</div>
	</div>
<!-- 관리자 혹은 본인이 쓴 글을 볼때 -->
<c:set var="userId" value="<%=notice.getId()%>" />
<c:set var="content" value="<%=notice.getContent()%>"/>
<c:choose>
	<c:when test="${sessionId==userId||sessionId=='admin'}">
	<div class="container">
		<form name="newUpdate"
			action="BoardUpdateAction.do?num=<%=notice.getNum()%>&pageNum=<%=nowpage%>"
			class="form-horizontal" method="post" onsubmit="return checkForm();">
			<div class="card">
				<div class="card-header">
					<input name="name" type="hidden" class="form-control" value="<%=notice.getName()%>">
					<%=notice.getName()%>
				</div>
				<div class="card-body">
					<input id="subject" name="subject" maxlength="50" class="form-control mb-3"	value="<%=notice.getSubject().replaceAll("<", "&#60;")%>" required>
					<textarea id="content" name="content" class="form-control" cols="100" rows="15" required><c:out value="${content}"/></textarea>
					<div class="form-group row mt-3">
						<div class="col-sm-offset-2 col-sm-10 ">
							<a	href="./BoardDeleteAction.do?num=<%=notice.getNum()%>&pageNum=<%=nowpage%>"	class="btn btn-danger"> 삭제</a> 
							<input type="submit" class="btn btn-success" value="수정 ">
						</div>
					</div>
				</div>
			</div>
		</form>
	</div>
	</c:when>

	<c:otherwise>
	<!-- 다른 사람의 게시글을 볼때 -->
		<div class="container">
			<div class="card">
				<div class="card-header">
					<div class="row">
						<div class="col-6">
							제목: <%=notice.getSubject().replaceAll("<", "&#60;")%>
						</div>
						<div class="col-6" align="right">
							닉네임: <%=notice.getName()%>
						</div>
					</div>
				</div>
				<div class="card-body">
					 <%=notice.getContent()%>
				</div>
			</div>
		</div>
	</c:otherwise>
</c:choose>

	<!-- 댓글 -->
		<div class="container mt-5">
			<div class="card">
				<div class="card-header">
					<div class="row">
						<div class="col-6">
							답변 ${commentsCount}
						</div>
					</div>
				</div>
				<div class="card-body">
				<c:forEach var="item" items="${commentsList}">
					<c:set var="getGoodCount" value="${mgr.getGoodCount(item.num)}"/>
					<c:set var="ratingRank" value="${mgr.rating(item.name)}"/>
					<c:choose>
						<c:when test="${item.name eq name}">
						<div class="row">
							<div class="col-6">
							<c:if test="${ratingRank >= 0 and ratingRank <= 2}">
								<img alt="no search image" src="../resources/img/bronze.png" width="30" height="30"> 브론즈 등급
							</c:if>
							<c:if test="${ratingRank >= 3 and ratingRank <= 4}">
								<img alt="no search image" src="../resources/img/silver.png" width="30" height="30"> 실버 등급
							</c:if>
							<c:if test="${ratingRank >= 5}">
								<img alt="no search image" src="../resources/img/gold.png" width="30" height="30"> 골드 등급
							</c:if>
							</div>
							<div class="col-6" align="right">
							<img alt="no search image" src="../resources/img/heart.png" width="20" height="20">
							&nbsp;${getGoodCount}
							</div>
						</div>
							<br>
							${item.name}
							<input class="btn" type="button" id="comment-edit-btn${item.num}" value="수정" onclick="edit(${item.num})" style="height: 18px; padding: 1px; padding-bottom: 20px; margin-bottom:5px ; color: #489CFF; background-color: #FFFFFF; border: #FFFFFF; font-size: 14px;">
							<br>
							${item.regist_day}<br><br><br>
						<div id="content-show${item.num}">
							${item.content}<br> 
						</div>
						<div id="content-hide${item.num}" style="display: none;">
						<form action="updateComments" method="post">
							<input type="hidden" name="num" value="<%=num%>">
							<input type="hidden" name="pageNum" value="<%=nowpage%>">
							<input type="hidden" name="commentNum" value="${item.num}">
							<textarea class="form-control" id="comment${item.num}" name="comment2" rows="3" cols="100" placeholder="댓글 등록"><c:out value="${item.content}"/></textarea>
							<div class="col-sm-offset-2 col-sm-10 mt-3">
							<a href="./deleteComments?num=<%=notice.getNum()%>&pageNum=<%=nowpage%>&commentNum=${item.num}" class="btn btn-danger">삭제</a>
							<input type="submit" class="btn btn-success" value="수정">
							</div> 
						</form>
						</div>
							<hr>
						</c:when>
						<c:otherwise>
						<div class="row">
						<div class="col-6">
							<c:if test="${ratingRank >= 0 and ratingRank <= 2}">
								<img alt="no search image" src="../resources/img/bronze.png" width="30" height="30"> 브론즈 등급
							</c:if>
							<c:if test="${ratingRank >= 3 and ratingRank <= 4}">
								<img alt="no search image" src="../resources/img/silver.png" width="30" height="30"> 실버 등급
							</c:if>
							<c:if test="${ratingRank >= 5}">
								<img alt="no search image" src="../resources/img/gold.png" width="30" height="30"> 골드 등급
							</c:if>
						</div>
						<div class="col-6" align="right">
							<c:set var="checkGood" value="${mgr.checkGood(item.num,name)}"/>
							<c:if test="${checkGood<=0}">
								<a href="insertGood?userName=${name}&pageNum=<%=nowpage%>&num=<%=num%>&commentsNum=${item.num}" onclick="mark(); return false;" style="font-size: 14px; text-decoration: none;">
								 <img alt="no search image" src="../resources/img/unheart.jpg" width="20" height="20">
								</a>
							</c:if>
							<c:if test="${checkGood>=1}">
								<a href="deleteGood?userName=${name}&pageNum=<%=nowpage%>&num=<%=num%>&commentsNum=${item.num}" onclick="mark(); return false;" style="font-size: 14px; text-decoration: none;">
								 <img alt="no search image" src="../resources/img/heart.png" width="20" height="20">
								</a>
							</c:if>
							&nbsp;${getGoodCount}
						</div>
						</div>
							<br>
							${item.name}
							<br>
							${item.regist_day}<br><br><br>
							${item.content}<br>
							<hr>
						</c:otherwise>
					</c:choose>
				</c:forEach>
					${name}
					<form name="insertForm" action="insertComments" method="post">
						<input type="hidden" name="num" value="<%=num%>">
						<input type="hidden" name="pageNum" value="<%=nowpage%>">
						<input type="hidden" name="name" value="${name}">
						<textarea id="editor" name="comment" rows="3" cols="100" placeholder="댓글 등록"></textarea>
						<input type="submit" class="btn btn-success mt-3" onclick="checkForm(); return false;" value="등록">
					</form>
				</div>
			</div>
		</div>
	<div class="container">
		<a href="./BoardListAction.do?pageNum=<%=nowpage%>"	class="btn btn-info mt-5"> 목록</a>
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

<script>
    var config = {
      extraPlugins: 'codesnippet',
      codeSnippet_theme: 'monokai_sublime',
      height: 356
    };

    CKEDITOR.replace('editor', config);
</script>

<!-- <script>
    ClassicEditor
        .create( document.querySelector( '#editor' ) )
        .catch( error => {
            console.error( error );
        } );
</script> -->

</body>
</html>


​
