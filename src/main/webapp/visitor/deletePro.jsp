<%@page import="java.net.URLEncoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="team03.bean.VisitorDAO" %> 

<%
	request.setCharacterEncoding("UTF-8");

	int num = Integer.parseInt(request.getParameter("num"));
	String pageNum = request.getParameter("pageNum");
	String pw = request.getParameter("pw");
	String owner = request.getParameter("owner");
	
	VisitorDAO dao = new VisitorDAO();

	int check = dao.VisitorDelete(owner, pw, num);  
	
	if(check  == 1) {
%> 
	<script>
		alert("삭제되었습니다");
		window.location="visitorForm.jsp?owner=<%=URLEncoder.encode(owner, "UTF-8")%>&pageNum=<%=pageNum%>";
   </script>
<%}else{%>
	<script>
		alert("비밀번호가 맞지 않습니다");
		history.go(-1);
	</script>
<%}%>