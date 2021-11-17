<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="team03.bean.Q_DAO" %>

<% request.setCharacterEncoding("UTF-8"); %>

<jsp:useBean class="team03.bean.Q_DTO"  id="dto" />
<jsp:setProperty property="*" name="dto" />

<%
	String admin = request.getParameter("admin");

	Q_DAO dao = new Q_DAO();
	
	 
	dao.insertQuestion(dto);
%>
	<script>alert("등록 되었습니다");</script>
<% 
	response.sendRedirect("q&a_List.jsp");
%>		
	
