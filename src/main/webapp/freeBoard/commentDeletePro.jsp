<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="team03.bean.CommentDAO" %>

<jsp:useBean class="team03.bean.CommentDTO" id="dto" />
<jsp:setProperty property="boardNum" name="dto" />
<jsp:setProperty property="num" name="dto" />

<%
	String pw = request.getParameter("pw");
	String pageNum = request.getParameter("pageNum");
	
	if(pw == null){
		CommentDAO dao = CommentDAO.getInstance();
		int result = dao.deleteMemComment(dto);
		if(result == 1){ %>
		
			<script>
				alert("삭제되었습니다.");
				opener.location.reload();
				window.close();
			</script>
			
		<%}
	} else {
		CommentDAO dao = CommentDAO.getInstance();
		dto.setPw(pw);
		int result = dao.deleteComment(dto);
		if(result == 1){ %>
		
			<script>
				alert("삭제되었습니다.");
				opener.location.reload();
				window.close();
			</script>
			
		<%} else { %>
			
			<script>
				alert("비밀번호가 틀립니다.");
				history.go(-1);
			</script>
			
		<%}
	}
%>