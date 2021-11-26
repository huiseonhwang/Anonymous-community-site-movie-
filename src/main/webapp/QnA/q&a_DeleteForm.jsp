<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="team03.bean.Q_DTO" %> 

<html>
	<head>
		<title>시네톡-Q&A 글삭제</title>
		<link rel="shortcut icon" href="https://cdn.discordapp.com/attachments/902120345748774922/912167936536481842/My_Post_Copy_1.jpg" type="image/x-icon">
	</head>
		<body>

		<h2 align="center">Q&A</h2> 
		<h5 align="center">- 문의사항을 남겨주세요</h5>

		<style>
		  table {
		    width: 15%;
		    border-top: 1px solid #444444;
		    border-collapse: collapse;
		  }
		  th, td {
		    border-bottom: 1px solid #444444;
		    border-left: 1px solid #444444;
		    padding: 10px;
		  }
		  th:first-child, td:first-child {
		    border-left: none;
		  }
		</style>

		<%
			int num = Integer.parseInt(request.getParameter("num"));
			String pageNum = request.getParameter("pageNum");
			Q_DTO dto = new Q_DTO();
		%>
		<form action="q&a_DeletePro.jsp" method="post">
			<table align="center">
				<input type="hidden" name="num" value=<%=num%>>
				<input type="hidden" name="pageNum" value=<%=pageNum%>>
				<tr>	
					<td align="center">
						<input type="password" name="pw" placeholder="비밀번호 확인">			
					</td>
				</tr>
				<tr>
					<td align="center">
						<input type="submit" value="삭제하기">
						<input type="button" value="뒤로가기" 
							onclick="window.location='/team03/QnA/q&a_Content.jsp?num=<%=num%>&pageNum=<%=pageNum%>'">
					</td>  
				</tr>
			</table> 
		</form>
	</body>
</html>
		
    