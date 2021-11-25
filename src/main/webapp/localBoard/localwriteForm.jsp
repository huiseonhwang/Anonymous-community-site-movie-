<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<head>
<link href="https://cdn.discordapp.com/attachments/902120345748774922/912167936536481842/My_Post_Copy_1.jpg" rel="shortcut icon" type="image/x-icon">
<title>지역게시판 게시물 작성</title>
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
   function check(){
	   localv = document.getElementsByName("local")[0].value;
	   subjectv = document.getElementsByName("subject")[0].value;
	   contentv = document.getElementsByName("content")[0].value;
	   if(localv == ""){
		   alert("지역을 입력하세요");
		   return false;
	   }
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

<%
	String kid = (String)session.getAttribute("kid");
	String id = (String)session.getAttribute("id");

	
	if(kid == null){
		if(id != null) { %>
		
		<form action="localwritePro.jsp" method="post" enctype="multipart/form-data" onsubmit = "return check();">
			<table>
				
				<tr>
					<th colspan="5"> <h1> 게시글 작성 </h1> </th>
				</tr>
				<tr>
				<td>지역</td>
				<td>
				<select name="local">
				<option value = "인천">인천</option>
				<option value = "서울">서울</option>
				<option value = "경기">경기</option>
				<option value = "강원">강원</option>
				<option value = "충북">충북</option>
				<option value = "충남">충남</option>
				<option value = "대전">대전</option>
				<option value = "전북">전북</option>
				<option value = "경북">경북</option>
				<option value = "대구">대구</option>
				<option value = "전남">전남</option>
				<option value = "광주">광주</option>
				<option value = "경남">경남</option>
				<option value = "울산">울산</option>
				<option value = "부산">부산</option>
				<option value = "제주">제주</option>
				</select>
				</td>
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
					<td> <input type="text" name="subject" /> </td>
				</tr>
				<tr>
					<td>내용</td>
					<td> <textarea rows="20" cols="50" name="content"></textarea> </td>
				</tr>
				<tr>
					<td>첨부파일</td>
					<td> <input type="file" name="filename" /> </td>
				</tr>
				<tr>
					<th colspan="3">
						<input type="submit" value="작성"/>
					</th>
				</tr>
			</table>
		</form>
	<%} else {%>
	<script>
	alert("로그인 후 이용하세요");
	history.go(-1);
	</script>
	<%}} 
		if(id == null) { 
			if(kid != null){%>
		<form action="localwritePro.jsp" method="post" enctype="multipart/form-data">
			<table>
				<tr>
					<th colspan="5"> <h1> 게시글 작성 </h1> </th>
				</tr>
				<tr>
				<td>지역</td>
				<td>
				<select name="local">
				<option value = "인천">인천</option>
				<option value = "서울">서울</option>
				<option value = "경기">경기</option>
				<option value = "강원">강원</option>
				<option value = "충북">충북</option>
				<option value = "충남">충남</option>
				<option value = "대전">대전</option>
				<option value = "전북">전북</option>
				<option value = "경북">경북</option>
				<option value = "대구">대구</option>
				<option value = "전남">전남</option>
				<option value = "광주">광주</option>
				<option value = "경남">경남</option>
				<option value = "울산">울산</option>
				<option value = "부산">부산</option>
				<option value = "제주">제주</option>
				</select>
				</td>
				</tr>
				<tr>
					<td>작성자</td>
					<td> 
						카카오<%= kid %>
						<input type="hidden" name="writer" value="카카오<%= kid %>" />
					</td>
				</tr>
				<tr>
					<td>제목</td>
					<td> <input type="text" name="subject" /> </td>
				</tr>
				<tr>
					<td>내용</td>
					<td> <textarea rows="20" cols="50" name="content"></textarea> </td>
				</tr>
				<tr>
					<td>첨부파일</td>
					<td> <input type="file" name="filename" /> </td>
				</tr>
				<tr>
					<th colspan="3">
						<input type="submit" value="작성"/>
					</th>
				</tr>
			</table>
		</form>
		
	<%} else { %>
		<script>
		alert("로그인 후 이용하세요");
		window.location = "/team03/main.jsp";
		</script>
 	 <%}}%>
		