<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="team03.bean.LocalBoardDAO" %>

<jsp:useBean class="team03.bean.LocalBoardDTO" id="dto" />
<jsp:setProperty property="num" name="dto" />

<head>
<link href="https://cdn.discordapp.com/attachments/902120345748774922/912167936536481842/My_Post_Copy_1.jpg" rel="shortcut icon" type="image/x-icon">
<title>지역게시판 게시물 수정</title>
</head>

<style>
	table {
		margin: 0 auto;
		border: 2px solid black;
		border-collapse: collapse;
	}
	tr, td, th {
		border: 2px solid black;
		padding: 10px;
	}
</style>

<%
	String pageNum = request.getParameter("pageNum");
	
	LocalBoardDAO dao = LocalBoardDAO.getInstance();
	dto = dao.LgetContent(dto);
 %>
 
 <script>
   function check(){
	  
	   subjectv = document.getElementsByName("subject")[0].value;
	   contentv = document.getElementsByName("content")[0].value;
	  
	   if(subjectv == ""){
		   alert("제목을 입력하세요");
		   return false;
	   }
	   if(contentv == ""){
		   alert("내용을 입력하세요");
		   return false;
	   }
   }
   </script>
 	
	<form action="localupdatePro.jsp" method="post" enctype="multipart/form-data" onsubmit = "return check();">
		<input type="hidden" name="num" value="<%= dto.getNum() %>" />
		<input type="hidden" name="pageNum" value="<%= pageNum %>" />
		<table>
			<tr>
				<th colspan="3"> <h1> 게시글 수정 </h1> </th>
			</tr>
			<tr>
				<td>지역</td>
				<td> 
					<%= dto.getLocal() %>
				</td>
			</tr>
			<tr>
				<td>작성자</td>
				<td> 
					<%= dto.getWriter() %>
				</td>
			</tr>
			<tr>
				<td>제목</td>
				<td>
					<input type="text" name="subject" value="<%= dto.getSubject() %>"/>
				</td>
			</tr>
			<tr>
				<td>내용</td>
				<td>
					<textarea rows="20" cols="50" name="content"><%= dto.getContent() %></textarea>
				</td>
			</tr>
			<tr>
				<td>첨부파일</td>
				<td>
					<input type="file" name="filename" />
					<% if(dto.getFilename() != null){ %>
						[<%= dto.getFilename() %>]
						<input type="hidden" name="org" value="<%= dto.getFilename() %>" />
				<%	} else { %>
						[첨부파일 없음]
				<%	}%>
				</td>
			</tr>
			<tr>
				<th colspan="3">
					<input type="submit" value="수정"/>
				</th>
			</tr>
		</table>
	</form>
