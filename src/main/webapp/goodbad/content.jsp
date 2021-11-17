<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="team03.bean.BoardDAO" %>

<jsp:useBean class="team03.bean.BoardDTO" id="dto" />
<jsp:setProperty property="num" name="dto" />

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
	String id = (String)session.getAttribute("id");
	String kid = (String)session.getAttribute("kid");
	
	kid = "카카오" + kid;

	String pageNum = request.getParameter("pageNum");
	
	BoardDAO dao = BoardDAO.getInstance();
	dao.readcountUp(dto);
	
	dto = dao.getContent(dto);
%>

<table>
	<tr>
		<th colspan="4"> 게시글 </th>
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
			<td colspan="5">
				<a href="/team03/team03File/<%= dto.getFilename() %>">
					<%= dto.getFilename() %> </a>
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
	
	<%
		if(kid != null){
			if(kid.equals(dto.getWriter())){ %>
				<tr>
				<td> <input type="button" value="글 수정"
						onclick="window.location='memUpdateForm.jsp?num=<%=dto.getNum()%>&pageNum=<%=pageNum%>'" /> </td>
				<td> <input type="button" value="글 삭제"
						onclick="window.location='memDeleteForm.jsp?num=<%=dto.getNum()%>&pageNum=<%=pageNum%>'" /> </td>
				<td style="text-align: right;" colspan="2">
					<input type="button" value="글 목록"
						onclick="window.location='list.jsp?pageNum=<%=pageNum%>'" />
				</td>
			</tr>
		<%	}
			
			if(id != null){
				if(id.equals(dto.getWriter())){ %>
					<tr>
						<td> <input type="button" value="글 수정"
								onclick="window.location='memUpdateForm.jsp?num=<%=dto.getNum()%>&pageNum=<%=pageNum%>'" /> </td>
						<td> <input type="button" value="글 삭제"
								onclick="window.location='memDeleteForm.jsp?num=<%=dto.getNum()%>&pageNum=<%=pageNum%>'" /> </td>
						<td style="text-align: right;" colspan="2">
							<input type="button" value="글 목록"
								onclick="window.location='list.jsp?pageNum=<%=pageNum%>'" />
						</td>
					</tr>
		<%		}
			} 
			if(dto.getPw() != null){ %>
				<tr>
					<td> <input type="button" value="글 수정"
							onclick="window.location='updateForm.jsp?num=<%=dto.getNum()%>&pageNum=<%=pageNum%>'" /> </td>
					<td> <input type="button" value="글 삭제"
							onclick="window.location='deleteForm.jsp?num=<%=dto.getNum()%>&pageNum=<%=pageNum%>'" /> </td>
					<td style="text-align: right;" colspan="2">
						<input type="button" value="글 목록"
							onclick="window.location='list.jsp?pageNum=<%=pageNum%>'" />
					</td>
				</tr>
		<%	}
		
		} %>		

</table>