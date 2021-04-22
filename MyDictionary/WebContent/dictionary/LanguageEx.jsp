<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@page import="dictionary.model.DictionaryBean"%>
<jsp:useBean id="mgr" class="dictionary.model.DictionaryMgr"/>
<jsp:useBean id="bookmarkMgr" class="bookmark.model.BookmarkMgr"/>
<jsp:include page="../include/menu.jsp" />
<%
	String num = request.getParameter("num");
	String search = request.getParameter("search");
	String pageNum = request.getParameter("pageNum");
	String userid = (String) session.getAttribute("sessionId");
	String userName = (String) session.getAttribute("name");
	DictionaryBean bean = mgr.getEx(num);
	int checkBookmark = bookmarkMgr.checkBookmark(userName, num);
%>
		<html>
		<head>
			<title>Ex</title>
<script type="text/javascript">
	function mark() {
		if(<%=userid%>==null){
			alert("로그인을 해주세요.");
			return false;
		}
	}
</script>
		</head>
		<body>
			<div class="container text-center">
				<h1 class="display-3" style="margin-top:30px;">코딩사전</h1>
			</div>
			<div class="container"style="padding-top: 80px;">
				<%if(search != null){%>
					<%if(userid != null &&checkBookmark>=1){%>
						<p><b>즐겨찾기:</b> <a href="deleteBookmark_L?search=<%=search%>&userName=<%=userName%>&pageNum=<%=pageNum%>&num=<%=num%>" onclick="mark(); return false;"  style="font-size: 25px; font-weight:bold; text-decoration:none;">★</a></p>
					<%} if(checkBookmark<=0){%>	
						<p><b>즐겨찾기:</b> <a href="insertBookmark_L?search=<%=search%>&userName=<%=userName%>&pageNum=<%=pageNum%>&num=<%=num%>" onclick="mark(); return false;"  style="font-size: 25px; font-weight:bold; text-decoration:none;">☆</a></p>
					<%}%>
				<%}%>	
				<%if(search == null){%>
					<%if(userid != null &&checkBookmark>=1){%>
						<p><b>즐겨찾기:</b> <a href="deleteBookmark_L?userName=<%=userName%>&pageNum=<%=pageNum%>&num=<%=num%>" onclick="mark(); return false;"  style="font-size: 25px; font-weight:bold; text-decoration:none;">★</a></p>
					<%} if(checkBookmark<=0){%>	
						<p><b>즐겨찾기:</b> <a href="insertBookmark_L?userName=<%=userName%>&pageNum=<%=pageNum%>&num=<%=num%>" onclick="mark(); return false;"  style="font-size: 25px; font-weight:bold; text-decoration:none;">☆</a></p>
					<%}%>
				<%}%>	
						<p><b>언어:</b> <%=bean.getLanguage()%></p>
						<p><b>코드:</b> <%=bean.getCode().replaceAll("<", "&#60;")%></p>
						<p><b>약칭:</b> <%=bean.getAbbreviation()%></p>
						<p><b>의미:</b> <%=bean.getMeaning()%></p>
						<p><b>형식:</b> <%=bean.getType()%></p>
						<p><b>설명:</b> <%=bean.getExplanation().replaceAll(" ", "&nbsp;").replaceAll("<", "&#60;")%></p>
						<p><b style="color: red;">사용예제</b></p>
			</div>
				<div class="container">
				<div class="card">
					<div class="card-body">
						<%=bean.getEx()%>
					</div>
				</div>
				</div>						
			<div class="container">
			<%if(search != null){%>
				<a href="selectLanguage?search=<%=search%>&language=<%=bean.getLanguage()%>&pageNum=<%=pageNum%>" class="btn btn-primary mt-3">뒤로가기</a>
			<%} if(search == null){%>	
				<a href="selectLanguage?language=<%=bean.getLanguage()%>&pageNum=<%=pageNum%>" class="btn btn-primary mt-3">뒤로가기</a>
			<%}%>
			</div>
			<jsp:include page="../include/footer.jsp" />
		</body>
		</html>
		