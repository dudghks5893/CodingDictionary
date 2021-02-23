<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@page import="dictionary.model.DictionaryBean"%>
<jsp:useBean id="mgr" class="dictionary.model.DictionaryMgr"/>
<%
	String num= request.getParameter("num");
	String userid = (String) session.getAttribute("sessionId");
	DictionaryBean bean = mgr.getEx(num);
%>
		<html>
		<head>
			<title>Ex</title>
<script type="text/javascript">
	function idcheck() {
		if(<%=userid%>==null){
			alert("로그인을 해주세요.");
			return false;
		}
		
		location.href = "../bookmark/bookmarkProc.jsp?id=<%=userid%>&&num=<%=num%>"
	}
</script>
		</head>
		<body>
			<jsp:include page="../include/menu.jsp" />
			<div class="container text-center">
				<h1 class="display-3" style="margin-top:30px;">코딩사전</h1>
			</div>
		<%

		%>			
			
			<div class="container"style="padding-top: 80px;">
						<p><b>즐겨찾기:</b> <a href="#" onclick="idcheck(); return false;"  style="font-size: 25px; font-weight:bold; text-decoration:none;">☆</a></p>
						<p><b>언어:</b> <%=bean.getLanguage()%></p>
						<p><b>코드:</b> <%=bean.getCode().replaceAll("<", "&#60;")%></p>
						<p><b>약칭:</b> <%=bean.getAbbreviation()%></p>
						<p><b>의미:</b> <%=bean.getMeaning()%></p>
						<p><b>형식:</b> <%=bean.getType()%></p>
						<p><b>설명:</b> <%=bean.getExplanation().replaceAll(" ", "&nbsp;").replaceAll("<", "&#60;")%></p>
						<p><b style="color: red;">사용예제</b></p>
			</div>
				<div class="container">
					<pre style="font-size: 20px; font: bold;"><code><%=bean.getEx().replaceAll("<", "&#60;")%></code></pre>
				</div>						
			<div class="container">
				<a href="javascript:window.history.back();" class="btn btn-primary">뒤로가기</a>
			</div>
			<jsp:include page="../include/footer.jsp" />
		</body>
		</html>
		