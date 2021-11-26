<%@page import="java.net.URLEncoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<head>
 	<link href="https://cdn.discordapp.com/attachments/902120345748774922/912167936536481842/My_Post_Copy_1.jpg" rel="shortcut icon" type="image/x-icon">
	<title>로그인-비밀번호 찾기</title>
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
		idVal = document.getElementsByName("id")[0].value;
		
		if(idVal == ""){
			alert("아이디를 입력해주세요.");
			return false;
		}
	}
</script>

<form action="findPwPro.jsp" method="post" onsubmit="return nullCheck();">
	<table>
		<tr style="background-color: #B0C4DE;">
			<th> 아이디를 입력하세요. </th>
		</tr>
		<tr>
			<td> <input type="text" name="id" /> </td>
		</tr>
		<tr>
			<th> <input type="submit" value="비밀번호 찾기" /> </th>
		</tr>
	</table>
</form>