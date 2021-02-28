<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@page import="java.util.ArrayList"%>
<%@page import="dictionary.model.DictionaryBean"%>
<jsp:useBean id="mgr" class="dictionary.model.DictionaryMgr"/>
<jsp:useBean id="paging" class="my.util.paging.Paging"/>
<html>
<head>
			<title>updateDictionary</title>
</head>
<body>
			<jsp:include page="../include/menu.jsp" />
			<div class="container text-center">
				<h1 class="display-3" style="margin-top:30px;">코딩수정</h1>
			</div>
			<div class="container " style="margin-top: 50px">
				<form class="form-inline">
					<input class="form-control border border-success col-sm-10 col-md-11 col-lg-11 " type="search"
						placeholder="Search" aria-label="Search" name="search">
					<button class="btn btn-success col-sm-2 col-md-1 col-lg-1" type="submit">검색</button>
				</form>
			</div>
			<div class="container" style="margin-top: 60px;">
				<h1>전체 ${total_record}개</h1>
				다음${next}<br>
				이전${back}<br>
				블록${blockLastNum}<br>
				시작블록${blockStartNum}<br>
				페이징사이즈${total_page}<br>
				페이징 출력 개수${pageCount}<br>
			</div>
			<div style="padding-top: 50px;">
				<table class="table table-hover" style="border: 1px solid #ddd">
					<tr style="background: #4C4C4C; color: #EAEAEA">
						<th>언어</th>
						<th>코드</th>
						<th style="text-align:center;">설명</th>
						<th>사용예제</th>
					</tr>
				<c:forEach var="item" items="${dictionarylist}">
					<tr>
						<td>${item.language}</td>
						<td>${fn:replace(item.code, '<', '&#60;')}</td>
						<td>${fn:replace(item.explanation, '<', '&#60;').replace(' ','&nbsp;')}</td>
						<td><a href="./updatePage.jsp?num=${item.num}" class="btn btn-primary" style="height: 25px; padding: 1px; color: white;" >코드수정 &raquo;</a></td>
					</tr>
				</c:forEach>
				</table>
			</div>
		<div class="mt-5" align="center">
			<c:set var="pageNum" value="${pageNum}"/>
			<c:if test="${!empty search && pageNum >pageCount}">
				<a href="selectDictionary_update?search=${search}&pageNum=${back}" class="btn btn-outline-info mr-2"><b>&laquo;</b></a>
			</c:if>
			<c:if test="${empty search && pageNum >pageCount}">
				<a href="selectDictionary_update?pageNum=${back}" class="btn btn-outline-info mr-2"><b>&laquo;</b></a>
			</c:if>
			<c:forEach var="i" begin="${blockStartNum}" end="${blockLastNum}">
				<c:if test="${search ne null}">
					<c:choose>
						<c:when test="${pageNum==i}">
							<a href="selectDictionary_update?search=${search}&pageNum=${i}" class="btn btn-info">${i}</a>
						</c:when>
						<c:otherwise>
							<a href="selectDictionary_update?search=${search}&pageNum=${i}" class="btn btn-outline-info">${i}</a>
						</c:otherwise>
					</c:choose>
				</c:if>
				<c:if test="${search eq null}">
					<c:choose>
						<c:when test="${pageNum==i}">
							<a href="selectDictionary_update?pageNum=${i}" class="btn btn-info">${i}</a>
						</c:when>
						<c:otherwise>
							<a href="selectDictionary_update?pageNum=${i}" class="btn btn-outline-info">${i}</a>
						</c:otherwise>
					</c:choose>
			   </c:if>
			</c:forEach>
			<c:if test="${!empty search && total_page > blockLastNum}">
				<a href="selectDictionary_update?search=${search}&pageNum=${next}" class="btn btn-outline-info ml-2"><b>&raquo;</b></a>
			</c:if>
			<c:if test="${empty search && total_page > blockLastNum}">
				<a href="selectDictionary_update?pageNum=${next}" class="btn btn-outline-info ml-2"><b>&raquo;</b></a>
			</c:if>
		</div>
	<jsp:include page="../include/footer.jsp" />
</body>

</html>