
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<h1>signUpForm</h1>
<script>
	function confirm() {
		//value = document.getElemenrsByName("id")[0].value;
		// open('confirmId.jsp?id='+value,'confirm');
		value = document.getElementsByName("id")[0].value;
		//Element는 html 태그를 의미한다. Elements는 태그를 다 찾는다는 뜻~
		//그중 name 속성이 "id"인 것을 찾겠다는 뜻이다
		open("confirmId.jsp?id="+value,'confirm');
	}
</script>

<form action ="signUpPro.jsp" method = "get">
	id : <input type = "text" name = "id" />
		 <input type = "button" value = "id중복확인" onclick="confirm();" /><br/>
	pw : <input type = "password" name = "pw" /><br/>
  name : <input type = "text" name = "name" /><br/>
 email : <input type = "text" name = "email1" /> @
		 <select type = "text" name ="email2">
			<option value="gmail.com">gmail.com</option>
			<option value="naver.com">naver.com</option>
			<option value="hanmail.net">hanmail.net</option>
		</select><br/>
		 <input type = "submit" value = "회원가입" />
		 <input type = "reset" value = "다시입력" />
		 <input type = "button" value = "취소" onclick = 'window.location ="/team03/login/loginform.jsp"' /><br/>
</form>

