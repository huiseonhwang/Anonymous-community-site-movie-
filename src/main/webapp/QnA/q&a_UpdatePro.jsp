<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="team03.bean.Q_DAO" %>

<% request.setCharacterEncoding("UTF-8"); %>

<jsp:useBean class="team03.bean.Q_DTO"  id="dto" />
<jsp:setProperty property="*" name="dto" />

<%	
	int num = Integer.parseInt(request.getParameter("num"));
	String pageNum = request.getParameter("pageNum");
	Q_DAO dao = new Q_DAO();
	int check = dao.updateQuestion(dto);
	if(check == 1){
%>
	<script>
	alert("수정 되었습니다");
	window.location="q&a_Content.jsp?num=<%=num%>&pageNum=<%=pageNum%>";
	</script> 
<%}else{%>
	<script>
	alert("비밀번호를 확인해주세요");
	history.go(-1); 
	</script>
<%}%>		
	