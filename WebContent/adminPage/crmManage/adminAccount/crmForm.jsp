<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.Timestamp"%>
<%@ page contentType = "text/html; charset=UTF-8" %>
<%@ page import = "user.dao.MemberDAO" %>
<%@ page import = "user.dto.MemberDTO" %>
<%@ page import = "java.util.List" %>
<%@ page import = "java.text.SimpleDateFormat" %>

<link href="../style.css" rel="stylesheet" type="text/css">
<%@ include file="../../adminTop.jsp" %>
<div class="crmmng" align="center">
<%@ include file="../../adminAside.jsp" %>
<main>

<%


	int pageSize = 10;  // 한페이지에 보여질 게시물수
    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm"); // 작성날짜 해당 형식으로 보기위함  아래 91라인에서 sdf.format(article.getReg_date()) 사용 

    String pageNum = request.getParameter("pageNum");  // 리스트에서 페이지번호 클릭시 받을수있다. 
    if (pageNum == null) {
        pageNum = "1";
    } 

    int currentPage = Integer.parseInt(pageNum);  // 1
    int startRow = (currentPage - 1) * pageSize + 1;  // (1-1) * 10 + 1 = 11
    int endRow = currentPage * pageSize;  // 1 * 10 = 10
    int count = 0;  // 전체 게시물수.. 
    int number=0;  // 화면 글번호 

    List articleList = null;
    
    MemberDAO dbPro =new MemberDAO();
    count = dbPro.admingetArticleCount();
	
    if (count > 0) {
        articleList = dbPro.admingetArticles(startRow, endRow);
    }
   	number=count-(currentPage-1)*pageSize;  
   
   	String id = (String)session.getAttribute("memId");
	int status = 0;	// 로그인이 아닌경우 status =  0
	Object obj = session.getAttribute("memSt");	// 로그인인 경우 status를 obj라는 이름으로 가져옴 
	// System.out.println(obj); 입력받은 status 확인
	if(id == null || obj == null)	// id 혹은 status가 입력되지 않은경우. 즉, 비회원
	{
		id = "GUEST";
		// System.out.println("status = " + status); 입력받은 status 확인
	}
	else
	{
		status = (int)obj; // status를 obj(받아온 status) 재설정
	}
%>
<html>
<head>
<title>관리자 계정관리페이지</title>

<link href="style.css" rel="stylesheet" type="text/css">
</head>

<body>
<center><b>관리자 목록(전체 관리자:<%=count%>)</b>
<br/>
<input type="button" value="계정생성" onclick="window.location='insertAdminAccount.jsp'"/>
<table width="700">
   <tr>
       <td align="right">
          <%
          if(id != null){ %>

          <%
          }else{
          %>
             <a href="/badgudu/userPage/user/LoginForm.jsp">로그인후 회원관리</a>
          <%
          }
          %>
       </td>
    </tr>
</table>

<%
if (count == 0) {
%>
   <table width="700" border="1" cellpadding="0" cellspacing="0">
      <tr>
          <td align="center">
             관리자가 존재하지 않습니다.
          </td>
       </tr>
   </table>


<%
} else {
%>
<table border="1" width="900" cellpadding="0" cellspacing="0" align="center"> 
      <tr height="30" > 
         <td align="center"  width="50"  >No</td>  
      <td align="center"  width="50" >이 름</td> 
       <td align="center"  width="100" >아이디</td>
       <td align="center"  width="50" >상태</td>  
       <td align="center"  width="150" >가입날짜</td>   
       <td align="center"  width="200" >주소</td>  
       <td align="center"  width="200" >전화번호</td>  
    </tr>
<%
for (int i = 0 ; i < articleList.size() ; i++) {
    	MemberDTO article = (MemberDTO)articleList.get(i);
%>
   <tr bgcolor="#f7f7f7"
          onmouseout="this.style.backgroundColor = '#f7f7f7'"
          onmouseover="this.style.backgroundColor = '#eeeeef'"> 
            <!-- 마우스 올렸을때랑 기본 색 지정-->
            <td align="center" width="50"> <%= number-- %></td>
             <td align="center" width="50"><%= article.getName() %></td>
             <td align="center" width="100"><a href="crmUpdateForm.jsp?num=<%=article.getNum()%>&pageNum=<%=currentPage%>"><%= article.getId() %></td>
             <td align="center" width="50"><%if(article.getStatus()==1){%>유저<%}%>
             								<%if(article.getStatus()==2){%>휴면<%}%>
             								<%if(article.getStatus()==3){%>탈퇴<%}%>
             								<%if(article.getStatus()==10){%>어드민<%}%></td>
             <td align="center" width="50"><%= sdf.format(article.getSignupdate()) %></td>
             <td align="center" width="200"><%= article.getAddress() %></td>
             <td align="center" width="200"><%= article.getPhoneNumber() %></td>
         </tr>
   <%
      }%>
</table>
<%}%>

<%
    if (count > 0) {
        int pageCount = count / pageSize + ( count % pageSize == 0 ? 0 : 1);
       
        int startPage = (int)(currentPage/10)*10+1;
      int pageBlock=10;
        int endPage = startPage + pageBlock-1;
        if (endPage > pageCount) 
           endPage = pageCount;
        
        if (startPage > 10) {    %>
        <a href="crmForm.jsp?pageNum=<%= startPage - 10 %>">[이전]</a>
<%      }
        for (int i = startPage ; i <= endPage ; i++) {  %>
           <a href="crmForm.jsp?pageNum=<%= i %>">[<%= i %>]</a>
<%      }
        if (endPage < pageCount) {  %>
           <a href="crmForm.jsp?pageNum=<%= startPage + 10 %>">[다음]</a>
<%      }
    }
%>
		<form action="crmSearchList.jsp" method="post">
			<select name="col">
				<option value="name">이름</option>
				<option value="id">아이디</option>
				<option value="status">상태</option>
			</select>
			<input type="text" name="search" />
			<input type="submit" value="검색" />
		</form>

</center>
</body>
</html>
</main>
</div>