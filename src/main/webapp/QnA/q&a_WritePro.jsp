<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="team03.bean.Q_DAO" %>

<% request.setCharacterEncoding("UTF-8"); %>
<%-- 액선태그 dto객체를 생성해서 *(all) 다 가져오는 기능 --%>
<jsp:useBean class="team03.bean.Q_DTO"  id="dto" />  
<jsp:setProperty property="*" name="dto" />

<script>
	alert("등록되었습니다");
	window.location="q&a_List.jsp";
</script>

<%
	Q_DAO dao = new Q_DAO();
	dao.insertQuestion(dto);	
%>


	
	
