<%@page import="java.net.URLEncoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="team03.bean.VisitorDAO"%>
<%@ page import="team03.bean.VisitorDTO"%>

<% 	
	request.setCharacterEncoding("UTF-8");

	int num = Integer.parseInt(request.getParameter("num"));
	String pageNum = request.getParameter("pageNum");
	String pw = request.getParameter("pw");
	String content = request.getParameter("content");
	String owner = request.getParameter("owner");
	
	VisitorDTO dto = new VisitorDTO();
	dto.setOwner(owner);
	dto.setNum(num);
	dto.setPw(pw);
	dto.setContent(content);
	
	VisitorDAO dao = new VisitorDAO();
	int check = dao.updateContent(dto);
			
	if(check == 1){%>
		<script>
			alert("수정되었습니다.");
			window.location="visitorForm.jsp?owner=<%=URLEncoder.encode(owner, "UTF-8")%>&pageNum=<%=pageNum%>";
		</script>
	<%}else{%>
		<script>
			alert("비밀번호를 확인해주세요.");
			history.go(-1);
		</script>
	<% } %>