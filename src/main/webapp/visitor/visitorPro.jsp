<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="team03.bean.VisitorDTO" %>
<%@ page import="team03.bean.VisitorDAO" %>

<%
	request.setCharacterEncoding("UTF-8");

	String num = request.getParameter("num");
	String id = request.getParameter("id");
	String writer = request.getParameter("writer");
	String pw = request.getParameter("pw");
	String content = request.getParameter("content");

	VisitorDTO dto = new VisitorDTO();
	dto.setId(id);
	dto.setPw(pw);
	dto.setContent(content);
	
	VisitorDAO dao = new VisitorDAO();
	int result = dao.visitorInsert(dto);
	if(result == 1){
%>		<script>
			alert("작성되었습니다.!");
			window.location="visitorForm.jsp";
		</script>		
<%}%>	
