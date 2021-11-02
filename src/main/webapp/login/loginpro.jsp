<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "team03.bean.LoginDAO" %>
<%@ page import = "team03.bean.LoginDTO" %>
<%@ page import = "team03.bean.KloginDTO" %>
<%@ page import = "team03.bean.KloginDAO" %>

 
 <jsp:useBean class = "team03.bean.LoginDTO" id ="dto"/>
 <jsp:setProperty property = "*" name ="dto"/>
 <jsp:useBean class = "team03.bean.KloginDTO" id ="kdto"/>
 <jsp:setProperty property = "*" name ="kdto"/>
 
 
 
<% 
	

LoginDAO manager = LoginDAO.getInstance();
boolean result = manager.logincheck(dto);
String kid = request.getParameter("kid");
String kemail = request.getParameter("kemail");
String kname = request.getParameter("kname");

if(kid != null){
	kdto.setKid(kid);
	kdto.setEmail(kemail);
	kdto.setName(kname);
	
	KloginDAO kdao = KloginDAO.getInstance();
	int kresult = kdao.insertKid(kdto);
	
    session.setAttribute("kid", kdto.getKid());
    %>
    <script>
        alert("로그인 되었습니다.");
    </script>
    <%
    response.sendRedirect("/team03/main.jsp");
    
} else {
       if(result == true){
           session.setAttribute("id", dto.getId()); 
           %>
           <script>
                  alert("로그인 되었습니다.");
           </script>
           <%
           response.sendRedirect("/team03/main.jsp");

       }else{ %>
        <script>
            alert("아이디/비밀번호를 확인하세요");
            history.go(-1);
        </script>
    <% } }%>