<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="team03.bean.LocalBoardCommentDAO" %>

<% request.setCharacterEncoding("UTF-8"); %>

<jsp:useBean class="team03.bean.LocalBoardCommentDTO" id="dto" />
<jsp:setProperty property="*" name="dto" />

<%
	String pageNum = request.getParameter("pageNum");
	String content = request.getParameter("content");

	int re_step = Integer.parseInt(request.getParameter("re_step"));
	int re_level = Integer.parseInt(request.getParameter("re_level"));
	
	// pw가 null 일 때 (익명이 작성한 댓글이 아닐 때)

	dto.setContent(content);
		LocalBoardCommentDAO dao = LocalBoardCommentDAO.getInstance();
		int result = dao.LupdateMemComment(dto, re_step, re_level);
		
		if(result == 1) { %>
		
			<script>
				alert("수정완료");
				opener.location.reload();
				window.close();
			</script>
			
	<%	}else { %>
	
			<script>
				alert("다시 한번 확인해 주세요.");
				history.go(-1);
			</script>
			
	  <%}%>