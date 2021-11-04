<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.text.SimpleDateFormat" %>
<%@ page import = "java.util.List" %>
<%@ page import = "team03.bean.MovieDAO" %>
<%@ page import = "team03.bean.MovieDTO" %>
<%@ page import = "java.util.ArrayList"%>    
<%! 
	// 선언문 안에 작성
	// main 메서드라고 생각, 인스턴스 변수가 아닌 class 변수가 된다.
	int pageSize = 10;
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
	// 날짜 생성 class 
%>

<%
	String id = request.getParameter("id");
	String pageNum = request.getParameter("pageNum");
	// Parameter값을 받아 오기, request(dto.get)
	// request("");
	int pageSize = 10;
	if (pageNum == null) {
		pageNum = "1";
		// 1 이라고 지정 안하는 이유 = pageNum은 숫자값이고, 유저가 누르는 값에 따라서
		// 변동하기 때문에 계산식(변동식)이 아닌 문자식으로 지정해준다.
	}
	

	int currentPage = Integer.parseInt(pageNum);
	// integer class 내에, parseInt
	// 문자열로 지정된 pageNum을 숫자로 형변환중
	int start = (currentPage -1) * pageSize + 1; // 수식선언
	int end = currentPage * pageSize;
	int count = 0;
	int number = 0;
	
	List<MovieDTO> list = null;
	MovieDAO dao = MovieDAO.getInstance();
	count = dao.getCount();		
		
		if(count > 0) {
			list = dao.getAllList(start, end);
		}
%>


<h1> 게시판 </h1>

<% if (count == 0) { %>
		작성된 글이 없습니다.
	
	<%}else{ %>	
		<% for (MovieDTO dto : list) { %>
			<%= dto.getNum() %>
			<a href = "content.jsp?num=<%=dto.getNum() %>&pageNum=<%=pageNum%>">
			<%=dto.getSubject()%>
			</a>
		<%} %>
	<%} %>
	
<table>
	<%if(id != null) { %>
		<input type = "button" value = "글쓰기" onclick ="window.location='writeForm.jsp'" />
		<input type = "button" value = "글목록" onclick ="window.location='list.jsp'"/>
		<input type = "button" value = "메인" onclick="window.location='/team03/main.jsp'"/>
		<%} else { %>
		<script>
			alert("로그인해주세요");
			window.location="/team03/main.jsp"/
		</script>
	<%} %>
</table>
	
			





