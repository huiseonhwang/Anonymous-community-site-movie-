<%@page import="java.util.Random"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<head>
	<meta charset="UTF-8">
	<link href="https://cdn.discordapp.com/attachments/902120345748774922/912167936536481842/My_Post_Copy_1.jpg" rel="shortcut icon" type="image/x-icon">
	<title>시네톡-자유게시판</title>
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

<script>
	
	// 제목, 내용, 비밀번호 입력값이 없을 시 띄우는 경고창 (유효성 검사)
	function memNullCheck(){
		subjectVal = document.getElementsByName("subject")[0].value;
		contentVal = document.getElementsByName("content")[0].value;
		
		if(subjectVal == ""){
			alert("제목을 작성해주세요.");
			return false;
		}
		if(contentVal == ""){
			alert("내용을 작성해주세요.");
			return false;
		}	
	}
	
	// 제목, 내용, 비밀번호 입력값이 없을 시 띄우는 경고창 (유효성 검사)
	function nullCheck(){
		subjectVal = document.getElementsByName("subject")[0].value;
		contentVal = document.getElementsByName("content")[0].value;
		pwVal = document.getElementsByName("pw")[0].value;
		
		if(subjectVal == ""){
			alert("제목을 작성해주세요.");
			return false;
		}
		if(contentVal == ""){
			alert("내용을 작성해주세요.");
			return false;
		}
		if(pwVal == ""){
			alert("비밀번호를 입력해주세요.");
			return false;
		}
	}
	
</script>

<%
	String writer;	

	//익명 작성자명 랜덤 부여
	Random r = new Random();
	writer = "익명"+r.nextInt(100000);

	String kid = (String)session.getAttribute("kid");
	String id = (String)session.getAttribute("id");
	
	if(kid != null){
		writer = "카카오" + kid;
	}
	if(id != null){
		writer = id;
	}
	
%>
<%
	if(kid == null && id == null){%>
		<form action="writePro.jsp" method="post" enctype="multipart/form-data" onsubmit="return nullCheck();">
			<table>
				<tr>
					<th colspan="3"> <h1> 게시글 작성 </h1> </th>
				</tr>
				<tr>
					<td>작성자</td>
					<td> 
						<%= writer %>
						<input type="hidden" name="writer" value="<%= writer %>"/>
					</td>
				</tr>
				<tr>
					<td>제목</td>
					<td>
						<input type="text" name="subject" />
					</td>
				</tr>
				<tr>
					<td> 내용 </td>
					<td> <textarea rows="20" cols="50" name="content"></textarea> </td>
				</tr>
				<tr>
					<td> 첨부파일 </td>
					<td> <input type="file" name="filename" /> </td>
				</tr>
				<tr>
					<td> 비밀번호 </td>
					<td> <input type="password" name="pw" /> </td>
				</tr>
				<tr>
					<th colspan="3">
						<input type="submit" value="작성"/>
					</th>
				</tr>
			</table>
		</form>
<%	}else{ %>
		<form action="writePro.jsp" method="post" enctype="multipart/form-data" onsubmit="return memNullCheck();">
			<table>
				<tr>
					<th colspan="3"> <h1> 게시글 작성 </h1> </th>
				</tr>
				<tr>
					<td>작성자</td>
					<td> 
						<%= writer %>
						<input type="hidden" name="writer" value="<%= writer %>"/>
					</td>
				</tr>
				<tr>
					<td>제목</td>
					<td>
						<input type="text" name="subject" />
					</td>
				</tr>
				<tr>
					<td> 내용 </td>
					<td> <textarea rows="20" cols="50" name="content"></textarea> </td>
				</tr>
				<tr>
					<td> 첨부파일 </td>
					<td> <input type="file" name="filename" /> </td>
				</tr>
				<tr>
					<th colspan="3">
						<input type="submit" value="작성"/>
					</th>
				</tr>
			</table>
		</form>
<%	}
%>

		
