<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="team03.bean.LocalBoardCommentDAO" %>

<jsp:useBean class="team03.bean.LocalBoardCommentDTO" id="dto" />
<jsp:setProperty property="boardNum" name="dto" />
<jsp:setProperty property="num" name="dto" />

<%
	
	String pageNum = request.getParameter("pageNum");
	
	LocalBoardCommentDAO dao = LocalBoardCommentDAO.getInstance();
	int result = dao.LdeleteMemComment(dto);
		
		if(result == 1){ %>
		
			<script>
				alert("삭제되었습니다.");
				opener.location.reload();
				window.close();
			</script>
			
		<%} else { %>
			
			<script>
				alert("다시 확인해 주세요.");
				history.go(-1);
			</script>
			
		<%}%>