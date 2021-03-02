<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<jsp:include page="../include/menu.jsp" />

		<html>
		<head>
			<title>insertLanguage</title>
		</head>

		<body>
		<div class="jumbotron">
			<div class="container">
				<h1 class="display-3">
					언어 추가
				</h1>
			</div>
		</div>
		<div class="container" style="margin-top: 50px">
			<form id="newDictionary" action="insertLanguage" method="POST">
				<div class="form-group row">
					<label class="col-sm-2">언어 추가</label>
					<div class="col-sm-5">
						<input type="text" name="language"class="form-control" required autofocus>
					</div>
				</div>
				<div class="form-group row" style="margin-top: 50px">
					<div class="col-sm-offset-2 col-sm-10">
						<input type="submit" class="btn btn-primary" value="등록">
						<a href="javascript:window.history.back();" class="btn btn-primary">취소</a>
					</div>
				</div>
			</form>
		</div>
			<jsp:include page="../include/footer.jsp" />
		</body>

		</html>