<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<% response.setStatus(HttpServletResponse.SC_OK); %>

<!DOCTYPE html>
<html>

<head>
	<meta charset="UTF-8">
	<title>시네톡</title>
</head>

<style>
	*{
		text-align: center;
	}
</style>

<body>
	<h1>죄송합니다.</h1>
	<h1>현재 페이지는 준비중입니다.</h1>
	<input type="button" value="메인화면으로" onclick="window.location='/team03/main.jsp'" />
</body>

</html>