<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "team03.bean.LoginDAO" %>
<%@ page import = "team03.bean.LoginDTO" %>
<%@ page import = "team03.bean.KloginDTO" %>
<%@ page import = "team03.bean.KloginDAO" %>
<%@ page import = "team03.bean.AdminDAO" %>
<%@page import="team03.bean.AdminDTO"%>

 
 <jsp:useBean class = "team03.bean.LoginDTO" id ="dto"/>
 <jsp:setProperty property = "*" name ="dto"/>
 <jsp:useBean class = "team03.bean.KloginDTO" id ="kdto"/>
 <jsp:setProperty property = "*" name ="kdto"/>
 
 
<% 
	
AdminDAO Adao = AdminDAO.getInstance();
AdminDTO Adto = Adao.getAdmin();

LoginDAO manager = LoginDAO.getInstance();
boolean result = manager.logincheck(dto);

String id = request.getParameter("id");
String kid = request.getParameter("kid");
String kemail = request.getParameter("kemail");
String kname = request.getParameter("kname");

manager.getMemberData(id);

KloginDAO kdao = KloginDAO.getInstance();
kdao.kgetUserInfo(kid);

if(kid != null){
	kdto.setKid(kid);
	kdto.setEmail(kemail);
	kdto.setName(kname);

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
    	   if(id.contains("admin")){
    		   if(id.equals(Adto.getAdmin())){
    			   session.setAttribute("admin", dto.getId());
        		   %>
                   <script>
                          alert("관리자로 로그인 되었습니다.");
                          window.location="/team03/main.jsp";
                   </script>
                   <%
    		   } else {
    			   session.setAttribute("id", dto.getId()); 
    	           %>
    	           <script>
    	                  alert("로그인 되었습니다.");
    	                  window.location="/team03/main.jsp";
    	           </script>
    	           <%
    		   }
    	   } else {
           session.setAttribute("id", dto.getId()); 
           %>
           <script>
                  alert("로그인 되었습니다.");
                  window.location="/team03/main.jsp";
           </script>
    	   <%}
       }else{ %>
        <script>
            alert("아이디/비밀번호를 확인하세요");
            history.go(-1);
        </script>
    <% } }%>