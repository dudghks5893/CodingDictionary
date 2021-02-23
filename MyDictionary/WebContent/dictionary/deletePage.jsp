<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@page import="dictionary.model.DictionaryBean"%>
<jsp:useBean id="mgr" class="dictionary.model.DictionaryMgr"/>
<%
	String num = request.getParameter("num");// 코딩 사전 내용 보여주기 위해 주소값으로 받는 넘버
	DictionaryBean bean = mgr.getEx(num);
	//String num2 = request.getParameter("num2");// 코딩 사전 삭제하기 위해 서브밋으로 받는 넘버
/* 	if(num2 != null){ 현재페이지에서 삭제 시키는 방법
		mgr.deleteDictionary(num2);// 서브밋으로 넘버를 받아와 삭제
		response.sendRedirect("deleteDictionary.jsp");
	}	 */
%>
		<html>

		<head>
			<title>deletePage</title>		
		</head>

		<body>
		<jsp:include page="../include/menu.jsp" />
		<div class="jumbotron">
			<div class="container">
				<h1 class="display-3">
					코드 삭제
				</h1>
			</div>
		</div>
		<div class="container" style="margin-top: 50px">
			<form id="deleteDictionary" action="deleteDictionary" method="POST">
				<div class="form-group row">
					<div class="col-sm-5">
						<input type="hidden" name="num"class="form-control" value='<%=bean.getNum()%>'>
					</div>
				</div>			
				<div class="form-group row">
					<label class="col-sm-2">언어</label>
					<div class="col-sm-5">
							<label class="form-control"><%=bean.getLanguage()%></label>
					</div>
				</div>
				<div class="form-group row">
					<label class="col-sm-2">코드</label>
					<div class="col-sm-5">
						<label class="form-control"><%=bean.getCode().replaceAll("<", "&#60;")%></label>
					</div>
				</div>
				<div class="form-group row">
					<label class="col-sm-2">약칭</label>
					<div class="col-sm-5">
						<label class="form-control"><%=bean.getAbbreviation()%></label>
					</div>
				</div>
				<div class="form-group row">
					<label class="col-sm-2">의미</label>
					<div class="col-sm-5">
						<label class="form-control"><%=bean.getMeaning()%></label>
					</div>
				</div>
				<div class="form-group row">
					<label class="col-sm-2">형식</label>
					<div class="col-sm-5">
						<label class="form-control" ><%=bean.getType()%></label>
					</div>
				</div>
				<div class="form-group row">
					<label class="col-sm-2">설명</label>
					<div class="col-sm-8">
						<label class="form-control"><%=bean.getExplanation().replaceAll(" ", "&nbsp;").replaceAll("<", "&#60;")%></label>
					</div>
				</div>
				<div class="form-group row">
					<label class="col-sm-2">사용예제</label>
					<div class="col-sm-8">
						<pre style="font-size: 16px; border: 1px solid #ddd; padding: 5px;"><%=bean.getEx().replaceAll("<", "&#60;")%></pre>
					</div>
				</div>
				<div class="form-group row">
					<div class="col-sm-offset-2 col-sm-10">
						<input type="submit" class="btn btn-danger" value="삭제">
						<a href="javascript:window.history.back();" class="btn btn-primary">취소</a>
					</div>
				</div>
			</form>
		</div>
			<jsp:include page="../include/footer.jsp" />
		</body>

		</html>