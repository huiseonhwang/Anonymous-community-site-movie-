<%@ page import="java.net.URLEncoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="team03.bean.VisitorDTO" %>
<%@ page import="team03.bean.VisitorDAO" %> 

<%
	request.setCharacterEncoding("UTF-8");

	String num = request.getParameter("num");
	String owner = request.getParameter("owner");
	String id = request.getParameter("id");
	String pw = request.getParameter("pw");
	String content = request.getParameter("content");
	String pageNum = request.getParameter("pageNum");

	VisitorDTO dto = new VisitorDTO();
	dto.setOwner(owner);
	dto.setId(id);
	dto.setPw(pw);
	dto.setContent(content);
	
	VisitorDAO dao = new VisitorDAO();
	int result = dao.visitorInsert(dto);
	
	if(result == 1){		
%>		
	<script>
		alert("작성되었습니다");
		window.location="visitorForm.jsp?owner=<%=URLEncoder.encode(owner, "UTF-8")%>&pageNum=<%=pageNum%>";
	</script>		
<%}%>	
