<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@page import="java.util.ArrayList"%>
<%@page import="dictionary.model.DictionaryBean"%>
<jsp:include page="../include/menu.jsp" />
<jsp:useBean id="mgr" class="dictionary.model.DictionaryMgr"/>
<jsp:useBean id="paging" class="my.util.paging.Paging"/>
<html>
<head>
<link rel="stylesheet" type="text/css" href="../resources/css/dictionary.css"/>
			<title>Dictionary</title>
</head>
<body>
	<c:set var="mode" value="다크모드"/>
			<h1>
    			<span>C</span><span>o</span><span>d</span><span>i</span><span>n</span><span>g</span>
  			</h1>
 			 <form>
   			 	<div class="mx-auto mt-5 search-bar input-group mb-3">
      				<input name="search" type="text" class="form-control rounded-pill" placeholder="Coding 검색 " aria-label="Recipient's username" aria-describedby="button-addon2">
      				<div class="input-group-append">
     	 			</div>
    			</div>
 			 </form>
			<div class="container" style="margin-top: 60px;">
				<h2>전체 ${total_record}개</h2>
				
<%-- 				다음${next}<br>
				이전${back}<br>
				블록${blockLastNum}<br>
				시작블록${blockStartNum}<br>
				페이징사이즈${total_page}<br>
				페이징 출력 개수${pageCount}<br> --%>
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
						<td><a href="Ex.jsp?num=${item.num}" class="btn" style="height: 25px; padding: 1px; color: white; background-color: #C07F5A; border: #8A4924;">사용예제</a></td>
					</tr>
				</c:forEach>
				</table>
			</div>
		<div class="mt-5" align="center">
			<c:set var="pageNum" value="${pageNum}"/>
			<c:if test="${!empty search && pageNum >pageCount}">
				<a href="selectDictionary?search=${search}&pageNum=${back}" class="btn btn-outline-info mr-2"><b>&laquo;</b></a>
			</c:if>
			<c:if test="${empty search && pageNum >pageCount}">
				<a href="selectDictionary?pageNum=${back}" class="btn btn-outline-info mr-2"><b>&laquo;</b></a>
			</c:if>
			<c:forEach var="i" begin="${blockStartNum}" end="${blockLastNum}">
				<c:if test="${search ne null}">
					<c:choose>
						<c:when test="${pageNum==i}">
							<a href="selectDictionary?search=${search}&pageNum=${i}" class="btn btn-info">${i}</a>
						</c:when>
						<c:otherwise>
							<a href="selectDictionary?search=${search}&pageNum=${i}" class="btn btn-outline-info">${i}</a>
						</c:otherwise>
					</c:choose>
				</c:if>
				<c:if test="${search eq null}">
					<c:choose>
						<c:when test="${pageNum==i}">
							<a href="selectDictionary?pageNum=${i}" class="btn btn-info">${i}</a>
						</c:when>
						<c:otherwise>
							<a href="selectDictionary?pageNum=${i}" class="btn btn-outline-info">${i}</a>
						</c:otherwise>
					</c:choose>
			   </c:if>
			</c:forEach>
			<c:if test="${!empty search && total_page > blockLastNum}">
				<a href="selectDictionary?search=${search}&pageNum=${next}" class="btn btn-outline-info ml-2"><b>&raquo;</b></a>
			</c:if>
			<c:if test="${empty search && total_page > blockLastNum}">
				<a href="selectDictionary?pageNum=${next}" class="btn btn-outline-info ml-2"><b>&raquo;</b></a>
			</c:if>
		</div>
<!-- 우측하단 고정 -->
<div class="bottomright">
   <input class="btn btn-outline-info" id="night_day" type="button" value="다크모드" onclick="darkMode()">
</div>
	<jsp:include page="../include/footer.jsp" />
</body>

</html>