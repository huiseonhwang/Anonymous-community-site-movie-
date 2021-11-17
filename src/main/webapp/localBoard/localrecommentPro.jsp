<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="team03.bean.LocalBoardCommentDAO" %>
    
<% request.setCharacterEncoding("UTF-8"); %>

<jsp:useBean class="team03.bean.LocalBoardCommentDTO" id="dto" />
<jsp:setProperty property="*" name="dto" />

<%
	int boardNum = Integer.parseInt(request.getParameter("boardNum"));

	LocalBoardCommentDAO dao = LocalBoardCommentDAO.getInstance();
	int result = dao.LinsertReComment(dto, boardNum);
	
	if(result == 1){ %>
		<script>
			alert("작성완료");
			opener.location.reload();
			window.close();
		</script>
	<%}
%>