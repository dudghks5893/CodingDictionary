<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="mgr" class="bookmark.BookmarkMgr"/>
<jsp:useBean id="bean" class="bookmark.BookmarkBean"/>
<jsp:setProperty property="*" name="bean"/>
	

		<%	
			String id = request.getParameter("id");
			int num = Integer.parseInt(request.getParameter("num"));
			//캐시영역에 저장을 안됨.(이 페이지는 항상 서버로 요청 해야함.)
			///response.setHeader("Pragma", "no-cache");
			//if(request.getProtocol().equals("HTTP/1.1"))
				//response.setHeader("Cache-Control", "no-store");
			
			String url = "../dictionary/Ex.jsp?id="+num;
		
			bean.setCdnum(num);
			mgr.insertBookmark(id, bean);
			
		%>
<script>
	location.href = "<%=url%>";
</script>