<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="team03.bean.Q_DAO" %>
<%@ page import="team03.bean.Q_DTO" %> 
<%@ page import="java.util.List" %>

<html>
	<head>
		<title>시네톡-Q&A 글목록</title>
		<link rel="shortcut icon" href="https://cdn.discordapp.com/attachments/902120345748774922/912167936536481842/My_Post_Copy_1.jpg" type="image/x-icon">
	</head>
		<body>

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
		    padding: 15px;
		  }
		  th:first-child, td:first-child {
		    border-left: none;
		  }
		</style>

		<%
			int pageSize = 10;
			
			String admin = (String)session.getAttribute("admin");
			String id = (String)session.getAttribute("id");
			String kid = (String)session.getAttribute("kid");
			
			String my = request.getParameter("my"); // 내 작성글을 찾을때 사용하기 때문에 파라미터를 요청해놓음
			String pageNum = request.getParameter("pageNum");
			
			if(pageNum == null){
				pageNum = "1";
			}
			
			int currentPage = Integer.parseInt(pageNum);
			int start = (currentPage-1) * pageSize+1;
			int end = currentPage * pageSize;
			int count = 0;
			int number = 0;
		
			List<Q_DTO> QuestionList = null; // dto를 참조해서 questionlist 객체를 생성한다. 일단 null값을 대입해놓는다.
			Q_DAO dao = new	Q_DAO();
			
			if(my == null){ // my가 null값이면 dao에서 아래 매서드를 실행한다
				count = dao.getQuestionCount(); // dao로 가보면 sql의 question테이블에서 *(모든) 게시글수를 가져오는 코드를 실행한다
				if(count > 0){ // 게시글수가 0보다 크면 dao에서 리스트를 출력하는 아래 매서드를 실행한다. 매개변수는 위에 선언해놓은 시작과 끝.
					QuestionList = dao.getQuestionList(start, end); 
				}
			}else{ // my가 null값이 아니라면 아래 조건문이 실행된다
				if(id != null){ // id가 null값이 아니라면, dao에서 내 게시글 수를 찾는 메서드를 실행한다.
					count = dao.getMyCount(id); //매개변수는 id
					if(count > 0){ // 게시글수가 0보다 크면 dao에서 내가 쓴 글의 리스트를 출력하는 메서드를 실행한다. 매개변수는 id와 시작과 끝.
						QuestionList = dao.getMyList(id, start, end);
					}
				}
				
				if(kid != null){ // id가 null값이 아니고, kid가 null값이 아니라면, dao에서 내 게시글 수를 찾는 메서드를 실행한다.
					count = dao.getMyCount(kid); //매개변수는 kid
					if(count > 0){ // 게시글수가 0보다 크면 dao에서 내가 쓴 글의 리스트를 출력하는 메서드를 실행한다. 매개변수는 kid와 시작과 끝.
						QuestionList = dao.getMyList(kid, start, end);
					}
				}
			}
				
			number = count - (currentPage-1) * pageSize;
		%>

		<%
			if(count == 0){
		%>

		<table width="800" align="center">
			<tr>
				<td>
					작성된 글이 없습니다
				</td>
			</tr>
		</table>

		<%}else{%>

		<table width="800" align="center">
			<tr align="center">
				<td>번호</td>
				<td>제목</td>
				<td>작성자</td>
				<td>작성일</td>
				<td>조회수</td>
			</tr>
		
		<%
			for(int i = 0; i < QuestionList.size(); i++) {
		   	Q_DTO dto = (Q_DTO)QuestionList.get(i);
		%>
		
			<tr align="center">
				<td><%=number--%></td>
				<td align="left">
					<%
						int wid = 0; //댓글을 작성할때 사용되는 사진앞에 공백을 주기위해 일단 0을 대입해놓음
					    if(dto.getRe_level() > 0){ //sql의 question테이블에 re_level이 0보다 크다면(댓글은 무조건 0보다 큼), 
					    						   //공백의 값을 대입하는 코드를 실행한다. 
					    		wid = 20 * dto.getRe_level();
					%>
					
					  <img src="/team03/QnA/images/level.gif" width="<%=wid%>" height="16">
					  <img src="/team03/QnA/images/re.gif">
					<%}else{%>
					  <img src="/team03/QnA/images/level.gif" width="<%=wid%>" height="16">	
					<%}%>
					
					<a href="q&a_Content.jsp?num=<%=dto.getNum()%>&pageNum=<%=pageNum%>">
					<%=dto.getSubject()%></a>
				
				 	<% if(dto.getReadcount() >= 30){%>
				    <img src="/team03/QnA/images/hot.gif" border="0"  height="16"><%}%>  
			     </td>
			    
				<td><%=dto.getId()%></td> 
				<td><%=dto.getReg()%></td> 
				<td><font color="red"><%=dto.getReadcount()%></font></td> 
			</tr>
		
		<%}%>
		
			<tr>
				<td colspan="5" align="center">
					<form action="q&a_SearchList.jsp" method="post">
						<select name="searchq">
							<option value="id">작성자</option>
						</select>
						<input type="text" name="search">
						<input type="submit" value="검색">
					</form>
				</td>
			</tr>
		</table>
		<%}%>
		<table width="800" align="center">
			<tr>
				<td align="center">
				<%
				    if (count > 0) {
				        int pageCount = count/pageSize + ( count % pageSize == 0 ? 0 : 1);
				        int startPage = (int)(currentPage/10) * 10+1;
						int pageBlock = 10;
				        int endPage = startPage + pageBlock-1;
				        if(endPage > pageCount) endPage = pageCount;
				        
				        // 시작페이지가 10보다 크면 a태그로 [이전]으로 보냄 
				        if(startPage > 10) {%>
				        <a href="q&a_List.jsp?pageNum=<%=startPage-10%>">[이전]</a>
						<%}
				        
				        //for문으로 i가 끝 페이지의 수와 작거나 같을때까지 하나씩 더해주는 것이 반복됨
				        for(int i = startPage ; i <= endPage ; i++) {%>
				        <a href="q&a_List.jsp?pageNum=<%=i%>">[<%=i%>]</a>
						<%}
				        
				        if(endPage < pageCount) {%>
				        <a href="q&a_List.jsp?pageNum=<%=startPage+10%>">[다음]</a>
						<%}
				    }%>
				</td>
			</tr>
			<tr>
				<td align="center">
					<input type="button" value="작성하기"  onclick="window.location='q&a_WriteForm.jsp'">
					<input type="button" value="메인으로"  onclick="window.location='/team03/main.jsp'">
				</td>
			</tr>
		</table>
	</body>
</html>
		
