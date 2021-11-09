<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "team03.bean.MovieDAO" %>
<%@ page import = "team03.bean.CommentDAO" %>
<%@ page import = "team03.bean.CommentDTO" %>
<%@ page import = "java.util.Random"%>
<%@ page import = "java.util.List"%>

<jsp:useBean class = "team03.bean.MovieDTO" id = "dto" />
<jsp:setProperty property = "num" name = "dto" />

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
<%
	request.setCharacterEncoding("UTF-8");

	String id = (String)session.getAttribute("id");
	String kid = (String)session.getAttribute("kid");
	kid = "카카오"+kid;

	String pageNum = request.getParameter("pageNum");
	
	MovieDAO dao = MovieDAO.getInstance();
	dao.readCountUp(dto);
	
	dto = dao.getContent(dto);
%>

<table id="center">
	<tr>
		<th colspan="4"> <a href="list.jsp"> 게시글 </a> </th>
	</tr>
	<tr>
		<td> 작성자 </td>
		<td> <%= dto.getWriter() %> </td>
		<td> 조회수 </td>
		<td> <%= dto.getReadcount() %> </td>
	</tr>
	<tr>
		<td> 제목 </td>
		<td colspan="4"> <%= dto.getSubject() %> </td>
	</tr>
	<tr>
		<td style="padding-bottom: 300px;"> 내용 </td>
		<td colspan="4" style="padding-bottom: 300px;"> <%= dto.getContent() %> </td>
	</tr>
	<%if(dto.getFilename() != null){ %>
		<tr>
			<td> 첨부파일 </td>
			<td colspan="4">
				<a href="/team03/team03File/<%= dto.getFilename() %>">
					<%= dto.getFilename() %>
				</a>
			</td>
		</tr>
<%	} else { %>
		<tr>
			<td colspan="4">
				[첨부파일 없음]
			</td>
		</tr>
<%	} %>
	<tr>
		<td> <input type="button" value="공감"
				onclick="window.location='goodPro.jsp?num=<%=dto.getNum()%>&pageNum=<%=pageNum%>'" /> </td>
		<td> <%= dto.getGood() %> </td>
		<td> <input type="button" value="비공감"
				onclick="window.location='badPro.jsp?num=<%=dto.getNum()%>&pageNum=<%=pageNum%>'" /> </td>
		<td> <%= dto.getBad() %> </td>
	</tr>
	<tr>
		<%
		if(kid != null){
			if(kid.equals(dto.getWriter())){ %>
				<td> <input type="button" value="글 수정"
						onclick="window.location='updateForm.jsp?num=<%=dto.getNum()%>&pageNum=<%=pageNum%>'" /> </td>
				<td> <input type="button" value="글 삭제"
						onclick="window.location='deleteForm.jsp?num=<%=dto.getNum()%>&pageNum=<%=pageNum%>'" /> </td>
		<%	}
			
			if(id != null){
				if(id.equals(dto.getWriter())){ %>
					<td> <input type="button" value="글 수정"
							onclick="window.location='updateForm.jsp?num=<%=dto.getNum()%>&pageNum=<%=pageNum%>'" /> </td>
					<td> <input type="button" value="글 삭제"
							onclick="window.location='deleteForm.jsp?num=<%=dto.getNum()%>&pageNum=<%=pageNum%>'" /> </td>
		<%		}
			} 
			if(dto.getPw() != null){ %>
				<td> <input type="button" value="글 수정"
						onclick="window.location='updateForm.jsp?num=<%=dto.getNum()%>&pageNum=<%=pageNum%>'" /> </td>
				<td> <input type="button" value="글 삭제"
						onclick="window.location='deleteForm.jsp?num=<%=dto.getNum()%>&pageNum=<%=pageNum%>'" />
				</td>
		<%	} 
		
		} %>
		
		<td style="text-align: right;" colspan="4">
					<input type="button" value="글 목록"
						onclick="window.location='list.jsp?pageNum=<%=pageNum%>'" />
		</td>
	</tr>
</table>

</br>
<%-- 댓글 작성 --%>
<%
	// 위에 이미 kid 라는 변수에 "카카오" 라는 String 문자가 대입되어 있으므로 새로운 변수를 만들어서 대입해준다.
	String kid2 = (String)session.getAttribute("kid");
	
	// 댓글 작성자 writer 변수 선언
	String writer;
	
	// kid 가 null 일 때
	if (kid2 == null) {
		// id 가 null 일 때
		if (id == null) {
			Random r = new Random();
		}
	}
%>