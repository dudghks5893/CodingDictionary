<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@page import="java.util.ArrayList"%>
<%@page import="dictionary.model.DictionaryBean"%>
<%@page import="language.model.LanguageBean"%>
<jsp:useBean id="mgr" class="dictionary.model.DictionaryMgr"/>
<jsp:useBean id="mgr2" class="language.model.LanguageMgr"/>

<%
	String num = request.getParameter("num");
	DictionaryBean bean = mgr.getEx(num);
	String language = bean.getLanguage();// select문 초기값 설정 
	ArrayList<LanguageBean> list = mgr2.getLanguageList();
%>
		<html>

		<head>
			<title>updatePage</title>
		</head>

		<body>
		<jsp:include page="../include/menu.jsp" />
		<div class="jumbotron">
			<div class="container">
				<h1 class="display-3">
					코드 수정
				</h1>
			</div>
		</div>
		<div class="container" style="margin-top: 50px">
			<form id="updateDictionary" action="updateDictionary" method="POST">
				<div class="form-group row">
					<div class="col-sm-5">
						<input type="hidden" name="num" id="num" class="form-control" value='<%=bean.getNum()%>'>
					</div>
				</div>			
				<div class="form-group row">
					<label class="col-sm-2">언어</label>
					<div class="col-sm-5">
						<select name="language" id="language" class="form-control">
							<%
								for(int i=0; i<list.size(); i++){
							%>
								<option <% if(language.equals(list.get(i).getLanguage())){ %> selected <% } %> ><%=list.get(i).getLanguage()%></option>
							
							<%}%>
						</select>						
					</div>
				</div>
				<div class="form-group row">
					<label class="col-sm-2">코드</label>
					<div class="col-sm-5">
						<input type="text" name="code" id="code" class="form-control" value='<%=bean.getCode()%>'>
					</div>
				</div>
				<div class="form-group row">
					<label class="col-sm-2">약칭</label>
					<div class="col-sm-5">
						<input type="text" name="abbreviation" id="abbreviation" class="form-control" value='<%=bean.getAbbreviation()%>'>
					</div>
				</div>
				<div class="form-group row">
					<label class="col-sm-2">의미</label>
					<div class="col-sm-5">
						<input type="text" name="meaning" id="meaning" class="form-control" value='<%=bean.getMeaning()%>'>
					</div>
				</div>
				<div class="form-group row">
					<label class="col-sm-2">형식</label>
					<div class="col-sm-5">
						<input type="text" name="type" id="type" class="form-control" value='<%=bean.getType()%>'>
					</div>
				</div>
				<div class="form-group row">
					<label class="col-sm-2">설명</label>
					<div class="col-sm-8">
						<textarea name="explanation" id="explanation" cols="100" rows="5" class="form-control"><%=bean.getExplanation()%></textarea>
					</div>
				</div>
				<div class="form-group row">
					<label class="col-sm-2">사용예제</label>
					<div class="col-sm-8">
						<textarea name="ex" id="ex" cols="100" rows="10" class="form-control"><%=bean.getEx()%></textarea>
					</div>
				</div>
				<div class="form-group row">
					<div class="col-sm-offset-2 col-sm-10">
						<input type="submit" class="btn btn-primary" value="수정">
						<a href="javascript:window.history.back();" class="btn btn-primary">취소</a>
					</div>
				</div>
			</form>
		</div>
			<jsp:include page="../include/footer.jsp" />
		</body>

		</html>