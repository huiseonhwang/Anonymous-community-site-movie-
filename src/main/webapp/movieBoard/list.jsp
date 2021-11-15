<%@page import="java.net.URLEncoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.text.SimpleDateFormat" %>
<%@ page import = "java.util.List" %>
<%@ page import = "team03.bean.MovieDAO" %>
<%@ page import = "team03.bean.MovieDTO" %>
<%@ page import = "java.util.ArrayList"%>    

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

<%! 
	// 선언문 안에 작성
	// main 메서드라고 생각, 인스턴스 변수가 아닌 class 변수가 된다.
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
	// 날짜 생성 class 
%>

<%
	String kategorie = request.getParameter("kategorie");
	String kid = (String)session.getAttribute("kid");
	String id = (String)session.getAttribute("id");
	String pageNum = request.getParameter("pageNum");
	String my = request.getParameter("my");
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

	if (my == null) {
		// my 값이 null 일 경우
		count = dao.getCount();
		// 게시글 갯수를 count에 대입
		if (count > 0) {
			// 게시글이 존재할 경우
			list = dao.getAllList(start, end);
			// 페이지 정렬을 list에 대입
		}
	} else {
		if ( id != null) {
			// id값이 존재할 경우 (id 세션이 존재할 경우)
			count = dao.getMyCount(id);
			// 내 게시글에서 갯수 확인
			if ( count > 0) {
				// 게시글이 존재할 경우
				list = dao.getMyList(id, start, end);
				// 내 게시글을 정렬
			}
		}
		if (kid != null) {
			// kid 값이 존재할 경우
			count = dao.getMyCount("카카오"+kid); 
				// kid로 쓰여진 게시글 갯수 확인
				if ( count > 0 ) {
					// 게시글이 존재할 경우
					list = dao.getMyList("카카오"+kid, start, end);
					// 내 게시글 정렬
			}
		}
	}
	
	number = count - (currentPage-1)*pageSize;
%>
<h1 style="text-align: center;"> 게시판 </h1>

<table>
<tr style="text-align: right;">
<% if(id != null || kid != null){ %>
	<td colspan = "8"> 
	<input type = "button" value = "글쓰기" 
		onclick = "window.location='writeForm.jsp'"/>
	<input type = "button" value = "내 작성글" 
		onclick = "window.location='list.jsp?my=1'"/>
	<input type = "button" value = "메인" 
		onclick = "window.location='/team03/main.jsp'"/>

	</td>
	<%} else {%>
		<td colspan = "8">
		<input type = "button" value = "글쓰기" onclick = "window.location='writeForm.jsp'"/>
		<input type = "button" value = "메인" onclick = "window.location='/team03/main.jsp'"/>
		</td>
		<%} %>
	</tr>
	<tr>
	<th> 글 번호</th>
	<td> 
		<select name = "kategorie" onchange = "if(this.value) location.href=(this.value);" >
		<option value ="klist.jsp?kategorie=romance"> 로맨스/멜로 </option>
		<option value = "klist.jsp?kategorie=comic"> 코미디 </option>
		<option value = "klist.jsp?kategorie=acthion"> 액션 </option>
		<option value = "klist.jsp?kategorie=sf"> SF </option>
		<option value = "klist.jsp?kategorie=fantasy"> 판타지 </option>
		<option value = "klist.jsp?kategorie=thriller"> 스릴러/공포 </option>
		<option value = "klist.jsp?kategorie=adventure"> 어드벤쳐 </option>
		<option value = "klist.jsp?kategorie=drama"> 드라마 </option>
		</select> 
	</td>
	<th> 제목 </th>
	<th> 작성자 </th>
	<th> 작성일 </th>
	<th> 조회 </th>
	<th> 공감 </th>
	<th> 비공감 </th>
	</tr>
<% if (count == 0) { %>
		<tr> 
			<td colspan="8">작성된 글이 없습니다...</td>
		</tr>
	<%}else{ %>	
		<% for (MovieDTO dto : list) { %>
			<tr>
				<td>
					<%= number -- %>
					<input type = "hidden" name = "num" value = "<%=dto.getNum() %>"/>
				</td>
				<td>
					<%=dto.getKategorie() %>
				</td>
				<td>
					<a href = "content.jsp?num=<%=dto.getNum() %>&pageNum=<%=pageNum%>">
					<%=dto.getSubject()%>
				</a>
			</td>
			<td>
				<% if (!dto.getWriter().contains("익")) { %>
					<a href="/team03/visitor/visitorForm.jsp?writer=<%=URLEncoder.encode(dto.getWriter(), "UTF-8")%>">
						<%=dto.getWriter()%>
					</a>
				<% } else { %>
					<%= dto.getWriter()%>
				<%} %>
				</td>
				<td> <%= dto.getReg() %> </td>
				<td> <%= dto.getReadcount() %> </td>
				<td> <%= dto.getGood() %> </td>
				<td> <%= dto.getBad() %> </td>
				</tr>
			<%} %>
	<%} %>
	
</table>

	<%
		// 페이지 정렬
		if ( count > 0) {
			int pageCount = count / pageSize + (count % pageSize == 0 ? 0 : 1);
			int startPage = (currentPage / 10) *  10 + 1;
			int pageBlock = 10;
			int endPage = startPage + pageBlock -1;
			if(endPage >pageCount) {
				endPage = pageCount;
			}
			if(startPage > 10) { %>
				<a href = "list.jsp?pageNum=<%=startPage-10 %>">[이전]</a>
				<%}
			for(int i = startPage; i<=endPage; i++) {
				%> <a href = "list.jsp?pageNum=<%=i %>">[<%=i %>]</a>
				<% } 
			if (endPage < pageCount) {%>
				<a href = "list.jsp?pageNum=<%=startPage+10 %>">[다음]</a>
			<%}
		}
%>

<form action = "slist.jsp" method = "post">
	<select name = "colum">
		<option value = "writer" > 작성자 </option>
		<option value = "subject" > 제목 </option>
		<option value = "kategorie" > 카테고리 </option>
		<option value = "content" > 내용 </option>
	</select>
	<input type = "text" name = "search" />
	<input type = "submit" value = "검색" />
</form>



<select onchange = "if(this.value) location.href=(this.value);" >
	<option value = ""> 네이버 </option>
	<option value = "http://www.daum.net" > 다음 </option>
</select>
