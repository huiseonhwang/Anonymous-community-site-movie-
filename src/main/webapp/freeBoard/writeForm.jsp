<%@page import="java.util.Random"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

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
	// 익명 작성자명 랜덤 부여
	Random r = new Random();
	String writer = "익명"+r.nextInt(100000);
	
	String id = (String)session.getAttribute("id");
	
 	if(id == null) { %>
	<form action="writePro.jsp" method="post" enctype="multipart/form-data">
		<table>
			<tr>
				<th colspan="3"> <h1> 게시글 작성 </h1> </th>
			</tr>
			<tr>
				<td>작성자</td>
				<td> 
					<%= writer %>
					<input type="hidden" name="writer" value="<%= writer %> "/>
				</td>
			</tr>
			<tr>
				<td>제목</td>
				<td>
					<input type="text" name="subject" />
				</td>
			</tr>
			<tr>
				<td>내용</td>
				<td>
					<textarea rows="20" cols="50" name="content"></textarea>
				</td>
			</tr>
			<tr>
				<td>첨부파일</td>
				<td>
					<input type="file" name="filename" />
				</td>
			</tr>
			<tr>
				<td>비밀번호</td>
				<td>
					<input type="password" name="pw" />
				</td>
			</tr>
			<tr>
				<th colspan="3">
					<input type="submit" value="작성"/>
				</th>
			</tr>
		</table>
	</form>
<%	} else { %>
	<form action="memWritePro.jsp" method="post" enctype="multipart/form-data">
		<table>
			<tr>
				<th colspan="3"> <h1> 게시글 작성 </h1> </th>
			</tr>
			<tr>
				<td>작성자</td>
				<td> 
					<%= id %>
					<input type="hidden" name="writer" value="<%= id %>" />
				</td>
			</tr>
			<tr>
				<td>제목</td>
				<td>
					<input type="text" name="subject" />
				</td>
			</tr>
			<tr>
				<td>내용</td>
				<td>
					<textarea rows="20" cols="50" name="content"></textarea>
				</td>
			</tr>
			<tr>
				<td>첨부파일</td>
				<td>
					<input type="file" name="filename" />
				</td>
			</tr>
			<tr>
				<th colspan="3">
					<input type="submit" value="작성"/>
				</th>
			</tr>
		</table>
	</form>
<%}%>
