<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import ="team03.bean.MemberDAO" %>
<%@ page import ="team03.bean.MemberDTO" %>
<link rel="stylesheet" type="text/css" href="mypage.css">
<style>
		*{
			text-align:center;
		 }
</style>
<script>
        function check_pw(){
            var pw = document.getElementById('pw').value;
            var SC = ["!","@","#","$","%"];
            var check_SC = 0;
 
            if(pw.length < 6 || pw.length>16){
                window.alert('비밀번호는 6글자 이상, 16글자 이하만 이용 가능합니다.');
                document.getElementById('pw').value='';
            }
            for(var i=0;i<SC.length;i++){
                if(pw.indexOf(SC[i]) != -1){
                    check_SC = 1;
                }
            }
            if(check_SC == 0){
                window.alert('!,@,#,$,% 의 특수문자가 들어가 있지 않습니다.')
                document.getElementById('pw').value='';
            }
            if(document.getElementById('pw').value !='' && document.getElementById('pw2').value!=''){
                if(document.getElementById('pw').value==document.getElementById('pw2').value){
                    document.getElementById('check').innerHTML='비밀번호가 일치합니다.'
                    document.getElementById('check').style.color='blue';
                }
                else{
                    document.getElementById('check').innerHTML='비밀번호가 일치하지 않습니다.';
                    document.getElementById('check').style.color='red';
                }
            }
        }
    </script>


<div id="containAll">
<h1>비밀번호 변경</h1>

<%
	String id = (String)session.getAttribute("id");
	MemberDAO dao = new MemberDAO();
	MemberDTO dto = dao.getUserInfo(id);
%>
	
	<form name="pwform" action="updatePro.jsp" method="post" tag="document.twin">
		<h3>비밀번호 : <%=dto.getPw()%></h3>
		<h3>새로운 비밀번호 : <input type="password" name="Pw" onchage="check_pw()" /></h3>
		<h3>새로운 비밀번호 확인 : <input type="password" name="Pw2" onchange="check_pw()" /></h3> 
		<input type="submit" value="비밀번호 변경"  />
	</form>			
</div>
