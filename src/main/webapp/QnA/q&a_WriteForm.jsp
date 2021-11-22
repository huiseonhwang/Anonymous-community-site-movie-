<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.Random" %>   

<h2 align="center">Q&A</h2> 
<h5 align="center">- 문의사항을 남겨주세요</h5>

<style>
  table {
    width: 70%;
    border-top: 1px solid #444444;
    border-collapse: collapse;
  }
  th, td {
    border-bottom: 1px solid #444444;
    border-left: 1px solid #444444;
    padding: 10px;
  }
  th:first-child, td:first-child {
    border-left: none;
  }
</style>

<script>
	function check(){
		contentcheck = document.getElementsByName("content")[0].value;
		pwcheck = document.getElementsByName("pw")[0].value;
		
		if(contentcheck == ""){
			alert("내용을 작성해주세요");
			return false;
		}
		
		if(pwcheck == ""){
			alert("비밀번호를 입력해주세요")
			return false;	
		}
	}
</script>

<%
	int num = 0, ref = 1, re_step = 0, re_level = 0;
	// 만약 요청한 num파라미터가 null이 아니면, 문자를 integer타입으로 변환한다.
	if(request.getParameter("num") != null){
		num = Integer.parseInt(request.getParameter("num"));
		ref = Integer.parseInt(request.getParameter("ref"));
		re_step = Integer.parseInt(request.getParameter("re_step"));
		re_level = Integer.parseInt(request.getParameter("re_level"));
	}
%>

<%	
	String id;
	String id2 = (String)session.getAttribute("id"); //id 세션을 요청	
	String kid = (String)session.getAttribute("kid"); //카카오id 세션을 요청
	String admin = (String)session.getAttribute("admin"); //관리자 admin 세션을 요청

	Random random = new Random(); //random이라는 객체를 생성한다
	String writer = "익명" + random.nextInt(1000000); //writer객체에 익명 + 랜덤번호를 생성하는 코드를 대입

	if(admin == null){	
		if(kid == null){ //카카오kid가 null값이면
			if(id2 == null){ //if문이 실행되고, id2가 null값이면
				id = writer; //id에 랜덤 writer를 대입
			} else {
				id = id2; //null값이 아니면, id에 id2를 대입
			}
		} else {
			id = "카카오" + kid; //카카오kid가 null값이 id에 아니면 카카오kid를 대입
		}
	} else { //관리자 admin이 null값이 아니면 id에 admin을 대입 
		id = admin;
	}
%>	

<table width="800" align="center"> 
	<form action="q&a_WritePro.jsp" method="post" onsubmit="return check();"> 
	<input type="hidden" name="num" value="<%=num%>">
	<input type="hidden" name="ref" value="<%=ref%>">
	<input type="hidden" name="re_step" value="<%=re_step%>">
	<input type="hidden" name="re_level" value="<%=re_level%>">
		<tr>
			<%if(request.getParameter("num") == null) {%>
				<td width="85" align="center">작성자</td>
				<td><input type="hidden" name="id" value="<%=id%>"><%=id%></td>
			<%}else{%>
				<td width="85" align="center">작성자</td>
				<td><input type="hidden" name="id" value="<%=admin%>"><%=admin%></td>
			<%}%>
		</tr>
		<tr>
			<%if(request.getParameter("num") == null) {%>
				<%if(id == admin){%>
					<td width="85" align="center">제목</td>
					<td>
						<select name="subject" value="문의 드립니다">
							<option>안내 드립니다</option>
						</select>
					</td>
				<%}else{%>
					<td width="85" align="center">제목</td>
					<td>
						<select name="subject" value="문의 드립니다">
							<option>문의 드립니다</option>
						</select>
					</td>
				<%}%>
			<%}else{%>
				<td width="85" align="center">제목</td>
				<td>
					<select name="subject" value="답변 드립니다">
						<option>답변 드립니다</option>
					</select>
				</td>
			<%}%>
		</tr>
		<tr>
			<td width="85" align="center">내용</td>
			
			<td><textarea rows="10" cols="85" name="content" placeholder="내용을 작성해주세요"></textarea></td>
		</tr>
		<tr>
			<td width="85" align="center">비밀번호</td>
			<td><input type="password" name="pw"></td>
		</tr>
		<tr>
			<td colspan="2" align="center">
				<input type="submit" value="등록하기"> 
				<input type="reset" value="다시작성"> 
				<input type="button" value="목록보기" onclick="window.location='q&a_List.jsp'">
			</td>
		</tr>	
	</form>    
</table> 
