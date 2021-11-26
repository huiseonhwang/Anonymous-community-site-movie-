<%@page import="java.net.URLEncoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<head>
 	<link href="https://cdn.discordapp.com/attachments/902120345748774922/912167936536481842/My_Post_Copy_1.jpg" rel="shortcut icon" type="image/x-icon">
	<title>로그인-아이디 찾기</title>
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
	#center{
		margin: 0 auto;
		text-align: center;
	}
</style>

<script>
	//제목, 내용, 비밀번호 입력값이 없을 시 띄우는 경고창 (유효성 검사)
	function nullCheck(){
		nameVal = document.getElementsByName("name")[0].value;
		
		if(nameVal == ""){
			alert("이름을 입력해주세요.");
			return false;
		}
	}
</script>

<form action="findIdPro.jsp" method="post" onsubmit="return nullCheck();">
	<table>
		<tr style="background-color: #B0C4DE;">
			<th> 이름을 입력하세요. </th>
		</tr>
		<tr>
			<td> <input type="text" name="<%=URLEncoder.encode("name", "UTF-8")%>" /> </td>
		</tr>
		<tr>
			<th> <input type="submit" value="아이디 찾기" /> </th>
		</tr>
	</table>
</form>