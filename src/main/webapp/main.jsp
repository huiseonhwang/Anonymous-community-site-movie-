<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="team03.bean.MemberDAO"%>
<%@ page import="java.io.IOException"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.Iterator"%>
<%@ page import="org.jsoup.Jsoup" %>
<%@ page import="org.jsoup.nodes.Document"%>
<%@ page import="org.jsoup.nodes.Element" %>
<%@ page import="org.jsoup.select.Elements" %>
<body style='background-color: #e4e4e4;'>
<style>
		 .front{
			text-align: center;
		 }
		 .login{
		 	text-align: right;
		 }
		 .bg{
			background-color: #aaa;
		}
<style>
		
</style>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<div class="front">
<h1>메인</h1>
</div>
<%
	String id = (String)session.getAttribute("id");
	String kid = (String)session.getAttribute("kid");
	// 세션 정보에서 id, kid 가져온 후 각각 id, kid에 대입
	
	
	if(kid == null) {
		// 카카오 아이디가 null 값일 떄
		if(id == null){ 
			// 카카오 아이디와 아이디가 null 값일 때
			// 로그인 버튼과, 회원가입 창을 입력받게 해서 로그인 가능하게 만들어 준다
		%>
			<div class="login">
				<input type="button" value="로그인" onclick="window.location='/team03/login/loginform.jsp'"/>
				<input type="button" value="회원가입" onclick="window.location='/team03/signUp/signUpForm.jsp'"/>
				<input type="button" value="게시판"	onclick="window.location='/team03/freeBoard/list.jsp'"/>
				<input type="button" value="영화 게시판"	onclick="window.location='/team03/movieBoard/list.jsp'"/>
				<input type="button" value="방명록"    onclick="window.location='/team03/visitor/visitorForm.jsp'"/> 
			</div>
		<%}else{
			// 카카오 아이디가 null 값이면서 id 는 null 값이 아닐 떄
		%>
	<div class="login">
		<h3> [<%=id %>] 님.</h3>
		<input type="button" value="로그아웃" onclick=" window.location='/team03/page/logout.jsp'" /> 
		<input type="button" value="마이페이지" onclick="window.location='/team03/page/mypage.jsp'"/>
		<input type="button" value="게시판"	onclick="window.location='/team03/freeBoard/list.jsp'"/>
		<input type="button" value="영화 게시판"	onclick="window.location='/team03/movieBoard/list.jsp'"/>
		<input type="button" value="방명록"    onclick="window.location='/team03/visitor/visitorForm.jsp'"/> 
	</div>
	<%}%>
	<%}else{ 
		// 카카오 아이디가 null 값이 아니면서 id 가 null 값일 때
	%>
	<div class="login">
	<h3> [<%=kid %>] 님.</h3>
		<input type="button" value="로그아웃" onclick=" window.location='/team03/page/logout.jsp'" /> 
		<input type="button" value="마이페이지" onclick="window.location='/team03/page/mypage.jsp'"/>
		<input type="button" value="게시판"	onclick="window.location='/team03/freeBoard/list.jsp'"/>
		<input type="button" value="영화 게시판"	onclick="window.location='/team03/movieBoard/list.jsp'"/>
		<input type="button" value="방명록"    onclick="window.location='/team03/visitor/visitorForm.jsp'"/> 
	</div>												
<%}%>
<br />
<br />
<br />

<% 
	Document doc2 = Jsoup.connect("http://www.cgv.co.kr/movies/").get();
	Elements posts = doc2.body().getElementsByClass("sect-movie-chart");
	Elements file = posts.select("li");
	for(Element e : file){%>
	Title : <%=e.select(".box-contents a").text()%>
	Link : <%=e.select(".box-contents a").attr("href") %>   
	Image : <%=e.select(".thumb-image img").attr("src")%>
	text : <%= e.select(".txt-info").text()%>
	<br />
<%}%>
</body>






