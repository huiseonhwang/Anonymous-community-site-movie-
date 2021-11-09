<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="team03.bean.CommentDAO" %>
    
<% request.setCharacterEncoding("UTF-8"); %>

<jsp:useBean class="team03.bean.CommentDTO" id="dto" />
<jsp:setProperty property="*" name="dto" />

<%
	int boardNum = Integer.parseInt(request.getParameter("boardNum"));

	CommentDAO dao = CommentDAO.getInstance();
	int result = dao.insertReComment(dto, boardNum);
	
	if(result == 1){ %>
		<script>
			alert("작성완료");
			opener.location.reload();
			window.close();
		</script>
	<%}
%>