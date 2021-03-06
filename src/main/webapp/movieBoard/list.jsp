<%@page import="team03.bean.MovieCommentDAO"%>
<%@page import="java.net.URLEncoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.text.SimpleDateFormat" %>
<%@ page import = "java.util.List" %>
<%@ page import = "team03.bean.MovieDAO" %>
<%@ page import = "team03.bean.MovieDTO" %>
<%@ page import = "java.util.ArrayList"%>    

<head>
	<meta charset="UTF-8">
	<link href="https://cdn.discordapp.com/attachments/902120345748774922/912167936536481842/My_Post_Copy_1.jpg" rel="shortcut icon" type="image/x-icon">
	<title>시네톡-영화게시판</title>
</head>

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
		text-align: center;
	}
	#left{
		text-align: left;
	}
	#right{
		text-align: right;
	}
</style>

<%! 
	// 선언문 안에 작성
	// main 메서드라고 생각, 인스턴스 변수가 아닌 class 변수가 된다.
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
	// 날짜 생성 class 
%>

<%
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
<h1 style="text-align: center;">
<a href = "list.jsp"> 영화게시판 </a> </h1>

<table style="width: 95%;">
	<tr>
		<% if(id != null || kid != null){ %>
			<td colspan="8"> 
				<div id="left" style="float: left;">
					<input type="button" value="전체글 보기" 
						onclick="window.location='list.jsp'" />
				</div>
				<div id="right" style="float: right;">
					<input type="button" value="글쓰기"
						onclick="window.location='writeForm.jsp'" />
					<input type="button" value="내 작성글"
						onclick="window.location='list.jsp?my=1'" />
					<input type="button" value="메인으로 돌아가기"
						onclick="window.location='/team03/main.jsp'" />
				</div>
			</td>
		<%} else { %>
			<td colspan="8">
				<div id="left" style="float: left;">
					<input type="button" value="전체글 보기" 
						onclick="window.location='list.jsp'" />
				</div>
				<div id="right" style="float: right;">
					<input type="button" value="글쓰기"
						onclick="window.location='writeForm.jsp'" />
					<input type="button" value="메인으로 돌아가기"
						onclick="window.location='/team03/main.jsp'" />
				</div>
			</td>
	 <%	 } %>
	</tr>
	<tr>
	<th> 글 번호</th>
	<th> 
		<select name = "kategorie" onchange = "if(this.value) location.href=(this.value);" >
			<option value = "kategorie" > 카테고리 </option>
			<option value = "list.jsp" > 전체 </option>
			<option value ="klist.jsp?kategorie=<%=URLEncoder.encode("로맨스/멜로", "UTF-8")%>"> 로맨스/멜로 </option>
			<option value ="klist.jsp?kategorie=<%=URLEncoder.encode("코미디", "UTF-8")%>"> 코미디 </option>
			<option value ="klist.jsp?kategorie=<%=URLEncoder.encode("액션", "UTF-8")%>"> 액션 </option>
			<option value ="klist.jsp?kategorie=<%=URLEncoder.encode("SF", "UTF-8")%>"> SF </option>
			<option value ="klist.jsp?kategorie=<%=URLEncoder.encode("판타지", "UTF-8")%>"> 판타지 </option>
			<option value ="klist.jsp?kategorie=<%=URLEncoder.encode("스릴러/공포", "UTF-8")%>"> 스릴러/공포 </option>
			<option value ="klist.jsp?kategorie=<%=URLEncoder.encode("어드벤쳐", "UTF-8")%>"> 어드벤쳐 </option>
			<option value ="klist.jsp?kategorie=<%=URLEncoder.encode("드라마", "UTF-8")%>"> 드라마 </option>
		</select> 
	</th>
	<th> 작성자 </th>
	<th> 제목 </th>
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
				<td id = "center">
					<%= number -- %>
					<input type = "hidden" name = "num" value = "<%=dto.getNum() %>"/>
				</td>
				<td>
					<%=dto.getKategorie() %>
				</td>
				<td style="width: 15%;">
					<% if (!dto.getWriter().contains("익")) { %>
						<a href="/team03/visitor/visitorForm.jsp?owner=<%=URLEncoder.encode(dto.getWriter(), "UTF-8")%>">
							<%=dto.getWriter()%>
						</a>
					<% } else { %>
						<%= dto.getWriter()%>
					<%} %>
				</td>
				<td style="width: 40%;">
					<a href = "content.jsp?num=<%=dto.getNum()%>&pageNum=<%=pageNum%>">
					<%=dto.getSubject()%>
				</a>
				<% 
					// 게시글에 달려있는 댓글이 있을 때 게시글 제목 옆에 댓글 갯수를 표기해주는 코드
					MovieCommentDAO CMdao = MovieCommentDAO.getInstance();
					int commentCount = CMdao.countComment(dto.getNum());
					
					if(commentCount > 0){%>
						&nbsp;
						<font>[<%=commentCount %>]</font>
					<%}
				%>
				</td>
			
				<td> <%= sdf.format(dto.getReg()) %> </td>
				<td> <%= dto.getReadcount() %> </td>
				<td> <%= dto.getGood() %> </td>
				<td> <%= dto.getBad() %> </td>
				</tr>
			<%} %>
	<%} %>
	
</table>
<div id="center">
	<%
		// 페이지 정렬
		if(count > 0){
			int pageCount = count / pageSize + (count % pageSize == 0 ? 0 : 1);
			int startPage = (currentPage / 10) * 10 + 1;
			int pageBlock = 10;
			int endPage = startPage + pageBlock-1;
			if(endPage > pageCount){
				endPage = pageCount;
			}
			if(my == null){
				if(startPage > 10){%>
					<a href="list.jsp?pageNum=<%=startPage-10%>">[이전]</a>
				<%}
				for(int i = startPage ; i <= endPage ; i++){
				%>	<a href="list.jsp?pageNum=<%=i%>">[<%=i%>]</a> 	
			  <%}
				if(endPage < pageCount){%>
				<a href="list.jsp?pageNum=<%=startPage + 10%>">[다음]</a>
			  <%}
			} else {
				if(startPage > 10){%>
				<a href="list.jsp?pageNum=<%=startPage-10%>&my=<%=my%>">[이전]</a>
			<%}
			for(int i = startPage ; i <= endPage ; i++){
			%>	<a href="list.jsp?pageNum=<%=i%>&my=<%=my%>">[<%=i%>]</a> 	
		  <%}
			if(endPage < pageCount){%>
			<a href="list.jsp?pageNum=<%=startPage + 10%>&my=<%=my%>">[다음]</a>
		  <%}
			}
		}
	%>
</div>
<div id="center">
	<form action = "slist.jsp" method = "post">
		<select name = "colum">
			<option value = "writer" > 작성자 </option>
			<option value = "subject" > 제목 </option>
			<option value = "kategorie" > 카테고리 </option>
			<option value = "boardContent" > 글 내용 </option>
		</select>
		<input type = "text" name = "search" />
		<input type = "submit" value = "검색" />
	</form>
</div>