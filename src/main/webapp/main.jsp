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
<style>
		 .front{
			text-align: center;
		 }
		 .login{
		 	text-align: right;
		 }
		
</style>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<div class="front">
<h1>메인</h1>
</div>
<%
	String id = (String)session.getAttribute("id");
	String kid = (String)session.getAttribute("kid");
	
								
	if(id == null && kid == null) {%>
	<div class="login">
	<input type="button" value="로그인" onclick="window.location='/team03/login/loginform.jsp'"/>
	<input type="button" value="회원가입" onclick="window.location='/team03/signUp/signUpForm.jsp'"/>
	<input type="button" value="게시판"	onclick="window.location='/team03/freeBoard/list.jsp'"/>
	</div>
	<%}else{ %>
	<div class="login">
	<h3> [<%=id %>] 님.</h3>
	<input type="button" value="로그아웃" onclick=" window.location='/team03/page/logout.jsp'" /> 
	<input type="button" value="마이페이지" onclick="window.location='/team03/page/mypage.jsp'"/>
	<input type="button" value="게시판"	onclick="window.location='/team03/freeBoard/list.jsp'"/>
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
			






