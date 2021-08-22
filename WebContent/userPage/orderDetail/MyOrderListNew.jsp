<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import = "user.dto.OrderDTO" %>
    <%@ page import = "user.dao.OrderDAO" %>
<%@ page import = "java.util.List" %>
<%@ page import = "java.util.*" %>
<%@page import="java.util.ArrayList" %>
<%@ page import = "java.text.SimpleDateFormat" %>
<%request.setCharacterEncoding("UTF-8");%>





<title>BAD GUDU</title>

<%	
String id =(String)session.getAttribute("memId");
int pageSize = 6;	// 한 페이지에 보여질 게시물 수 
SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");	// 작성된 날짜의 형태를 바꿔줌.. 년-월-일 시:분.. 84라인에서 사용(sdf.format(article.getReg_date()))


//페이지 링크를 클릭한 번호 즉 현재 페이지 
String pageNum = request.getParameter("pageNum");	// 리스트에서 페이지 번호를 클릭 시 받을 수 있다.(페이지를 처음에 클릭하지 않는다.)
if (pageNum == null) {	// 페이지를 입력 안하면 1페이지.. 입력하면 null이 아니므로 if문 동작하지않는다.
    pageNum = "1";
}

int currentPage = Integer.parseInt(pageNum);		// 1.. 문자(string)타입으로 들어오니 변환

int startRow = (currentPage - 1) * pageSize + 1;	// (1-1) * 10 + 1 = 1
int endRow = currentPage * pageSize;				// 1 * 10 = 10
int count = 0;	// 전체 게시물 수
int number=0;	// 화면에 보이는 게시물 번호.. 입력한 번호와 다르다..삭제 시 시퀀스는 빈 번호를 채우지 않는다.. 즉, 내장된 번호가 아닌 보이는 번호

List articleList = null;
OrderDAO dbPro =new OrderDAO();
count = dbPro.getArticleCount(id); // 전체 게시물 수를  dbPro의 ArticleCount() 메서드에서 가져옴


if (count > 0) {
	articleList = dbPro.getArticles(id,startRow, endRow);
	  
}

number=count-(currentPage-1)*pageSize;	// 전체 게시물 수 - (페이지 - 1) * 10  = 
		




//OrderDAO dao = new OrderDAO();
//ArrayList<OrderDTO> list = dao.getList(id);

%>
<%@ include file ="../top.jsp" %>

<div id="main" align="center">
<%@ include file ="../aside.jsp" %>

<link href="orderDetail.css" rel="stylesheet" type="text/css">

<head>
<meta charset="UTF-8">
<title>주문내역조회</title>
</head>

<body>

<br /><br /><br /><h1> 나의 주문 내역 </h1> <br /><br />


<%if (count == 0) {%>
	<table width="700" border="1" cellpadding="0" cellspacing="0" height="300">
		<tr>
    		<td align="center" >
    			나의 주문 내역이 없습니다. 
    		</td>
    	</tr>
	</table>

<%  } else {    %>


<table cellpadding="80" cellspacing="0" align="center" style=" border:1px solid gray;" height="400" width="900"  > 
<tr bgcolor="ededed">
<th>  주문번호  </th> <th>  주문일자 </th> <th>  상품정보 </th> <th>  상품구매금액  </th><th>  주문처리상태  </th><th>  주문취소 </th>
</tr>

<%--
 <% for(OrderDTO dto : list){ %>
  --%>
 
 <% for (int i =0; i < articleList.size(); i++){
 		//OrderDTO dto = list.get(i);
 		OrderDTO dto = (OrderDTO)articleList.get(i);
 %>
 
<tr>
		<td align="center"> 
		 <%=dto.getOdcode() %> 
		</td>
 <td>  <%= sdf.format(dto.getOrderDate()) %> </td>
  		<td>  
  		 <a href="orderDetail.jsp?odcode=<%=dto.getOdcode()%>" style="text-decoration: none"> <%=dto.getProductname() %>  </a> <br/>
  		 <%if(dto.getInvoice()!=(null)){
  			 %> 송장번호 : <%=dto.getInvoice() %><%
  		 } %>
  		</td>
  <td> <%=dto.getAmount() %>  </td>
  <td> <%=dto.getOrderStatus() %>  </td>
                             
  <td> 		    <%--     onclick="window.location='OrderCancel.jsp?odcode=<%=dto.getOdcode()%>'" --%>
  
  <%
  	if(dto.getOrderStatus().equals("구매자 취소") || dto.getOrderStatus().equals("판매자 취소")){
  		%> 취소완료<%
  	} else if(dto.getOrderStatus().equals("배송완료")){
  		%>
	  <input type="button" value="반품신청" style="width:90px; height:35px;" onclick="window.location='OrderCancel.jsp?odcode=<%=dto.getOdcode() %>'" />	
	  <% 
  	} else{
  		%>
	  <input type="button" value="구매취소" style="width:90px; height:35px;" onclick="window.location='OrderCancel.jsp?odcode=<%=dto.getOdcode() %>'" />	
		<%  		
  	}
  %>
  
 
  </td>
</tr>
<%} %>
  		
  		
</table>
<%}%>


<%
    if (count > 0) {								
    	// 전체 게시물/10개(한페이지에서 보여지는 최대 게시물 수) + (전체 게시물/10의 나머지 값이 0이면 0 아니면 1)
        int pageCount = count / pageSize + ( count % pageSize == 0 ? 0 : 1); 
     	// 페이지를 int형으로 줘서 currentPage/10의 소숫점아래는 버리고 10페이지 단위로 자르기 위함 ex) 현재 5페이지인 경우 (5/10)*10+1 = 1 										
        //int startPage = (int)(currentPage/5)*5+1;	
		int pageBlock=10;	// 페이지 갯수를 5개로 컷한다.
		int startPage = ((currentPage-1)/pageBlock)*pageBlock+1;
		int endPage = startPage + pageBlock - 1;

        
		// 마지막 페이지가 총 페이지 수 보다 크면 endPage를 pageCount로 할당

        
        if (endPage > pageCount) endPage = pageCount;	// 마지막페이지가 열리는 페이지보다 큰 경우.. endPage에 열리는 페이지를 대입한다.
        
        if (startPage > pageBlock) {    %>
        <a href="MyOrderListNew.jsp?pageNum=<%= startPage - 10 %>">[이전]</a>
<%      }
        
        for (int i = startPage ; i <= endPage ; i++) {  %>
    	<a href="MyOrderListNew.jsp?pageNum=<%= i %>">[<%= i %>]</a>
<%		} //for end 
        
        
        if (endPage < pageCount) {  %>
        	<a href="MyOrderListNew.jsp?pageNum=<%= startPage + 10 %>">[다음]</a>
<%		}
    }
%><br>



<br/> <br/> 

</body>
</div>
<br /><br /><br />
<%@ include file="../bottom.jsp" %>



<% String odcode = request.getParameter("odcode");

%>



