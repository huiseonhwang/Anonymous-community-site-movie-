<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="team03.bean.LoginDAO" %>

<% request.setCharacterEncoding("UTF-8"); %>

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
	
	*{
		text-align: center;
	}
</style>

<script>
	//제목, 내용, 비밀번호 입력값이 없을 시 띄우는 경고창 (유효성 검사)
	function nullCheck(){
		pwVal = document.getElementsByName("pw")[0].value;
		pw2Val = document.getElementsByName("pw2")[0].value;
		
		if(pwVal == ""){
			alert("비밀번호를 입력해주세요.");
			return false;
		}
		if(pw2Val == ""){
			alert("비밀번호를 확인해주세요.");
			return false;
		}
	}
</script>

<jsp:useBean class="team03.bean.MemberDTO" id="dto" />
<jsp:setProperty property="id" name="dto" />

<script>
	function windowClose(){
		window.close();
	}
</script>

<%
	String id = request.getParameter("id");

	LoginDAO dao = LoginDAO.getInstance();
	int result = dao.getMemberPW(id);
	
	if(result == 1){ %>
		<form action="findPwUpdatePro.jsp" method="post" onsubmit="return nullCheck();">
			<table>
				<tr style="background-color: #B0C4DE;">
					<th colspan="2">비밀번호 변경</th>
				</tr>
				<tr>
					<td> 비밀번호 입력 </td>
					<td> <input type="password" name="pw" />  </td>
				</tr>
				<tr>
					<td> 비밀번호 확인 </td>
					<td> <input type="password" name="pw2" />  </td>
				</tr>
				<tr>
					<th colspan="2">
						<input type="submit" value="비밀번호 변경" />
						<input type="hidden" name="id" value="<%=id%>" />
					</th>
				</tr>
			</table>
		</form>
<%	} else { %>
		해당 아이디는 가입되지 않았습니다.
		<br/><br/>
		<input type="button" value="회원가입 하기" onclick="window.location='/team03/signUp/signUpForm.jsp'"/>
		<input type="button" value="창 닫기" onclick="windowClose();"/>
<%	}
%>