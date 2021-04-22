<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:useBean id="mgr" class="language.model.LanguageMgr"/>

<c:set var="list" value="${mgr.getLanguageList()}"/>
	<html>
	<head>
		<link rel="stylesheet" href="../resources/css/bootstrap.min.css" />
			<title>insertLanguage</title>
	</head>
	<body>
		<div class="modal-header">
				<h3>언어 추가&편집</h3>
	    </div>
	    <div class="modal-body" >
			<form action="../language/insertLanguage" method="POST">
				<label style="font-size: 18px; color: red;">언어추가</label>
				<div class="form-group row mb-3">
					<div class="col-sm-5">
						<input type="text" name="language"class="form-control" required autofocus>
					</div>
					<div class="col-sm-2">
						<input type="submit" class="btn btn-info mb-3" value="등록">
					</div>
				</div>
			</form>
			<hr>
			<label class="mt-3" style="font-size: 18px; color: red;">언어편집</label>
			<c:forEach var="item" items="${list}">
				<form action="../language/updateLanguage" method="POST">
				<div class="row">
					<div class="col-5">
						<input class="form-control" name="setlanguage" type="text" name="setlanguage" value="${item.language}" >
						<input class="form-control" name="language" type="hidden" name="setlanguage" value="${item.language}" >
					</div>
					<div class="col-5">
						<input type="submit" class="btn btn-primary" value="수정">
						<a href="../language/deleteLanguage?language=${item.language}" class="btn btn-danger">삭제</a>
					</div>
				</div>
				</form>
			</c:forEach>
		</div>
		<div class="modal-footer">
			<button type="button" class="btn btn-secondary col-sm-2" data-dismiss="modal">닫기</button>
		</div>
	</body>
	</html>