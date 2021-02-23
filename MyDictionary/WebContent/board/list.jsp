<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>


<html>
<head>
<link rel="stylesheet" href="./resources/css/bootstrap.min.css" />
<link rel="stylesheet" href="./resources/css/box.css" />
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
	<jsp:include page="../include/boardMenu.jsp" />
	<div class="jumbotron">
		<div class="container">
			<h1 class="display-3">게시판</h1>
		</div>
	</div>
	<div class="container">
		<form action="<c:url value="./BoardListAction.do"/>" method="post">
			<div>
				<div class="text-right">
					<span class="badge badge-success">전체 ${total_record}건	</span>
				</div>
			</div>
			<div style="margin-top: 50px">
				<table class="table table-hover text-center" style="border: 1px solid #ddd">
					<tr style="text-align:center; background: #4C4C4C; color: #EAEAEA ">
						<th style="width:10%;"></th>
						<th style="width:40%;">제목</th>
						<th style="width:15%;">글쓴이</th>
						<th style="width:25%;">작성일</th>
						<th style="width:10%;">조회</th>
					</tr>
					<sql:setDataSource var="dataSource"
						url="jdbc:mysql://localhost:3306/Dictionary?useSSL=false"
						driver="com.mysql.jdbc.Driver" user="root" password="1234" />
					
					<sql:query var="resultSet" dataSource="${dataSource}">
						select * from adminboard ORDER BY num DESC
					</sql:query>
					<c:forEach var="row" items="${resultSet.rows}">
					<tr class="jumbotron">
						<td><span class="box-radius" style="width:10%; color: #FF0000;">공지</span></td>
						<td style="width:40%; text-align:left;"><a href="./adminBoardViewAction.do?num=${row.num}" style="color: #FF0000;"><c:out value="${row.subject}"/></a></td>
						<td style="width:15%;"><c:out value="${row.name}"/></td>
						<td style="width:25%;"><c:out value="${fn:substring(row.regist_day,0,10)}"/></td>
						<td style="width:10%;"><c:out value="${row.hit}"/></td>
					</tr>
					</c:forEach>

					<c:forEach var="item" items="${boardlist}">
					<tr>
						<td style="width:10%;">${item.num}</td>
						<td style="width:40%; text-align:left;"><a href="./BoardViewAction.do?num=${item.num}&pageNum=${pageNum}" style="color: #000000;"><c:out value="${item.subject}"/></a></td>
						<td style="width:15%;">${item.name}</td>
						<td style="width:25%;">${item.regist_day}</td>
						<td style="width:10%;">${item.hit}</td>
					</tr>
					</c:forEach>

				</table>
			</div>
			<div class="mb-3" align="center">
				<c:set var="pageNum" value="${pageNum}" />
				<c:forEach var="i" begin="1" end="${total_page}">
					<c:if test="${text ne null}">
						<a href="<c:url value="./BoardListAction.do?pageNum=${i}&items=${items}&text=${text}" /> ">
					</c:if>
					<c:if test="${text eq null}">
						<a href="<c:url value="./BoardListAction.do?pageNum=${i}" /> ">
					</c:if>
						<c:choose>
							<c:when test="${pageNum==i}">
								<font color='4C5317'><b> [${i}]</b></font>
							</c:when>
							<c:otherwise>
								<font color='4C5317'> [${i}]</font>

							</c:otherwise>
						</c:choose>
					</a>
				</c:forEach><!-- a태에 주소값을 준 다음 폰트태그들을 감싸주고 해당 페이지 넘버이면 b태그적용 아니면 노멀 -->
			</div>
			<div align="left">
				<table>
					<tr>
						<td width="100%" align="left">&nbsp;&nbsp; 
						<select name="items" class="txt">
								<option value="subject">제목에서</option>
								<option value="content">본문에서</option>
								<option value="name">글쓴이에서</option>
						</select> <input name="text" type="text" /> <input type="submit" id="btnAdd" class="btn btn-primary " value="검색 " />
						</td>
						<td width="100%" align="right">
							<a href="#" onclick="checkForm(); return false;" class="btn btn-primary">&laquo;글쓰기</a>
						</td>
					</tr>
				</table>
			</div>
		</form>
	</div>
	<jsp:include page="../include/footer.jsp" />
</body>
</html>





