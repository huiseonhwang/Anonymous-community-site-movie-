<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "team03.bean.LoginDTO" %>
    
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
   
   
    
    <form action = "loginpro.jsp" method = "post" onsubmit = "return check();" >
    id : <input type = "text" name = "id"/><br/>
    pw : <input type = "password" name = "pw"/><br/>
    		<input type="hidden" name="login" value="base" />
    	<input type = "submit" value = "로그인"/>
    </form>
    	<input type = "button" value = "회원가입" onclick = "window.location = '/team03/signUp/signUpForm.jsp'"/><br/>
    
    	
    	
   <img src="https://t1.daumcdn.net/cfile/tistory/99BEE8465C3D7D1214"  width="150" onclick="kakaoLogin();" value = "kakao"/>
      <a href="javascript:void(0)">
          
      </a>
	</li>
	<li onclick="kakaoLogout();">
      <a href="javascript:void(0)">
          <span>카카오 로그아웃</span>
      </a>
	</li>
</ul>

<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
<script>
Kakao.init('d33045b96b39d277326dceb9d3fe967a'); //발급받은 키 중 javascript키를 사용해준다.
console.log(Kakao.isInitialized()); // sdk초기화여부판단
//카카오로그인
function kakaoLogin() {
 
    Kakao.Auth.login({
      success: function (response) {
        Kakao.API.request({
          url: '/v2/user/me',
          success: function (response) {

        	  window.location='/team03/login/loginpro.jsp?id='+response.id+'&login=kakao';  //로그인프로로 보내기 -> 프로에서 로그인 방법마다 다르게 처리하기(kakao/base)
        	  
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