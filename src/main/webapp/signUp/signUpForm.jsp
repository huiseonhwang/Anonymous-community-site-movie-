
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<head>
	<meta charset="UTF-8">
	<link href="https://cdn.discordapp.com/attachments/902120345748774922/912167936536481842/My_Post_Copy_1.jpg" rel="shortcut icon" type="image/x-icon">
	<title>시네톡-회원가입</title>
</head>
    
    
<script>
	function confirm() {
		//value = document.getElemenrsByName("id")[0].value;
		// open('confirmId.jsp?id='+value,'confirm');
		value = document.getElementsByName("id")[0].value;
		
		//Element는 html 태그를 의미한다. Elements는 태그를 다 찾는다는 뜻~
		//그중 name 속성이 "id"인 것을 찾겠다는 뜻이다
		open("confirmId.jsp?id="+value,'confirm', "width=300, height=150");
	}
	
	function nullCheck(){
		idVal = document.getElementsByName("id")[0].value;
		pwVal = document.getElementsByName("pw")[0].value;
		nameVal = document.getElementsByName("name")[0].value;
		email1Val = document.getElementsByName("email1")[0].value;
		email2Val = document.getElementsByName("email2")[0].value;
		
		if(idVal == ""){
			alert("아이디를 작성해주세요.");
			return false;
		}
		if(pwVal == ""){
			alert("비밀번호를 작성해주세요.");
			return false;
		}
		if(nameVal == ""){
			alert("이름을 작성해주세요.");
			return false;
		}
		if(email1Val == ""){
			alert("이메일을 작성해주세요.");
			return false;
		}
		if(email2Val == ""){
			alert("주소를 전택하세요.");
			return false;
		}
	}
</script>

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
	#idCheck{
		font-weight: bold;
	}
   </style>

<form action ="signUpPro.jsp" method = "post" onsubmit="return nullCheck();">
	<table>
		<tr>
			<th colspan="2" style="background-color: #B0C4DE;"> 회원가입 </th>
		</tr>
		<tr>
			<th> 아이디 </th>
			<td>
				<input type = "text" name = "id" />
				<input type = "button" value = "id중복확인" onclick="confirm();" />
				<label id="idCheck"></label>
			</td>
		</tr>
		<tr>
			<th> 비밀번호 </th>
			<td> <input type = "password" name = "pw" /> </td>
		</tr>
		<tr>
			<th> 이름 </th>
			<td> <input type = "text" name = "name" /> </td>
		</tr>
		<tr>
			<th> 이메일 </th>
			<td> 
				<input type = "text" name = "email1" />@
				<select name ="email2">
					<option value="">선택하세요</option>
					<option value="gmail.com">gmail.com</option>
					<option value="naver.com">naver.com</option>
					<option value="hanmail.net">hanmail.net</option>
				</select>
			</td>
		</tr>
		<tr>
			<th colspan="2">
				<input type = "submit" value = "회원가입" />
		 		<input type = "reset" value = "다시입력" />
			</th>
		</tr>
		<tr>
			<th colspan="2">
		 		<input type = "button" value = "메인으로 돌아가기" onclick = 'window.location ="/team03/login/loginform.jsp"' />
			</th>
		</tr>
	</table>
</form>

