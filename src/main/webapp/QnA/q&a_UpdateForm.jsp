<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="team03.bean.Q_DAO" %>
<%@ page import="team03.bean.Q_DTO" %> 

<html>
	<head>
		<title>시네톡-Q&A 글수정</title>
		<link rel="shortcut icon" href="https://cdn.discordapp.com/attachments/902120345748774922/912167936536481842/My_Post_Copy_1.jpg" type="image/x-icon">
	</head>
		<body>

		<% request.setCharacterEncoding("UTF-8"); %>

		<h2 align="center">Q&A</h2> 
		<h5 align="center">- 문의사항을 남겨주세요</h5>

		<jsp:useBean class="team03.bean.Q_DTO"  id="dto" />
		<jsp:setProperty property="*" name="dto" />

		<style>
		  table {
		    width: 70%;
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
			String pageNum=request.getParameter("pageNum");
			
			Q_DAO dao = new Q_DAO();
			dto = dao.getQuestionContent(num);
		%>
		
		<form action="q&a_UpdatePro.jsp" method="post">
			<table width="750" align="center">
				<input type="hidden" name="num" value=<%=dto.getNum()%>>
				<input type="hidden" name="pageNum" value=<%=pageNum%>>
				
				<tr>
					<td width="85" align="center">제목</td> 
					<td>
						<select name="subject"><option><%=dto.getSubject()%></option></select>
					</td>
				</tr>
				<tr>
					<td width="85" align="center">작성자</td>
					<td><%=dto.getId()%></td>
				</tr>
				<tr><td width="85" align="center">내용</td>
					<td>
						<textarea rows="10" cols="80" name="content"><%=dto.getContent()%></textarea>
					</td>
				</tr>
			 	<tr>
			 		<td width="85" align="center">비밀번호</td> 
			 		<td>
			 			<input type="password" name="pw"><br/>
			 		</td>
			 	</tr>
			 	<tr>
			 		<td colspan="2" align="center">
			 			<input type="button" value="뒤로가기" 
			 			onclick="window.location='/team03/QnA/q&a_Content.jsp?num=<%=num%>&pageNum=<%=pageNum%>'">
						<input type="submit" value="수정하기">
					</td>
				</tr>	
			</table> 
		</form>
	</body>
</html>
		
  