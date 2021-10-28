<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "team03.bean.SignUpDAO" %>    
<h1>confirmId</h1>
<jsp:useBean class = "team03.bean.SignUpDTO" id = "dto"/>
<jsp:setProperty property="*" name ="dto"/>

<%
	SignUpDAO dao = new SignUpDAO();
	boolean result = dao.memberIdCheck(dto);
	String str = "사용가능";
	if(result == true) { 
		str = "사용 불가능";
%>	<%=dto.getId() %> 이미 사용중인 아이디 입니다.
	<%}else{%>
	<jsp:getProperty property = "id" name = "dto" /> 사용 가능합니다. 
	<%}%>