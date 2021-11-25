<%@page import="java.net.URLEncoder"%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "team03.bean.LoginDTO" %>
    
 <head>
 <link href="https://cdn.discordapp.com/attachments/902120345748774922/912167936536481842/My_Post_Copy_1.jpg" rel="shortcut icon" type="image/x-icon">
<title>로그인</title>
</head>
    
   <script>
	   function check(){
		   idv = document.getElementsByName("id")[0].value;
		   pwv = document.getElementsByName("pw")[0].value;
		   if(idv == ""){
			   alert("아이디를 입력해주세요");
			   return false;
		   }
		   if(pwv == ""){
			   alert("비밀번호를 입력하세요");
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
   </style>
    
    <form action = "loginpro.jsp" method = "post" onsubmit = "return check();" >
    	<table>
    		<tr>
    			<th colspan="2" style="background-color: #B0C4DE;"> 로그인 </th>
    		</tr>
    		<tr>
    			<th> 아이디 </th>
    			<td> <input type = "text" name = "<%=URLEncoder.encode("id", "UTF-8")%>"/> </td>
    		</tr>
    		<tr>
    			<th> 비밀번호 </th>
    			<td>
    				<input type = "password" name = "pw"/>
    				<input type="hidden" name="login" value="base" />
    			</td>
    		</tr>
    		<tr>
    			<th colspan="2">
    				<input type = "submit" value = "로그인"/>
    				<input type = "button" value = "회원가입" onclick = "window.location = '/team03/signUp/signUpForm.jsp'"/>
    			</th>
    		</tr>
    	</table>
    	
    </form>
    	
    <div id="center">
   		<input type="button" value="카카오 로그인" onclick="kakaoLogin();" />
    </div>
    
    <a href="javascript:void(0)"> </a>

<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
<script>
Kakao.init('fe7344bb892ab9d3081040d3d8b90568'); //발급받은 키 중 javascript키를 사용해준다.
console.log(Kakao.isInitialized()); // sdk초기화여부판단
//카카오로그인
function kakaoLogin() {
 
    Kakao.Auth.login({
      success: function (response) {
        Kakao.API.request({
          url: '/v2/user/me',
          success: function (response) {
        	  
        	  var kid = response.id;
        	  var kemail = response.kakao_account.email;
        	  var kname = response.kakao_account.profile.nickname;
        	  
        	  window.location.href=
        		  '/team03/login/loginpro.jsp?kid='+kid+'&kemail='+kemail+'&kname='+encodeURIComponent(kname)+'&login=kakao';         	  
        	  
          },
          fail: function (error) {
            console.log(error)
          },
        })
      },
      fail: function (error) {
        console.log(error)
      },
    })
  }
//카카오로그아웃  
function kakaoLogout() {
    if (Kakao.Auth.getAccessToken()) {
      Kakao.API.request({
        url: '/v1/user/unlink',
        success: function (response) {
        	console.log(response)
        },
        fail: function (error) {
          console.log(error)
        },
      })
      Kakao.Auth.setAccessToken(undefined)
    }
  }  
</script>