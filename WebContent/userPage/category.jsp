<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import = "user.dao.UserMenuDAO" %>
    <%@ page import = "user.dto.UserMenuDTO" %>
    <%@ page import = "java.util.*" %>
    <%
    request.setCharacterEncoding("UTF-8");
    %>
    
<title>BAD GUDU</title>

<%@ include file ="top.jsp" %>
<div id="category" align="center">

<%--사이드 메뉴 끌어오기 --%>
<%@ include file ="aside.jsp" %>

<link href="style.css" rel="stylesheet" type="text/css">


<%
	//카테고리
	String pdCategory = request.getParameter("pdCategory");
	int currentCate = Integer.parseInt(pdCategory);

	//등록된 상품의 총 개수
	int getCatePdCount = 0;
	int getCateSalePdCount = 0;
	int getCateEventPdCount = 0;
	int getCateNewPdCount = 0;
	
	UserMenuDAO dao = new UserMenuDAO();
	getCatePdCount = dao.getCatePdCount(currentCate);			// pdcategory로 카운트
	getCateNewPdCount = dao.getCateNewPdCount(currentCate);		// 신상품 카운트
	getCateSalePdCount = dao.getCateSalePdCount(currentCate);	// sale=1(진행중)으로 카운트
	getCateEventPdCount = dao.getCateEventPdCount(currentCate);	// evaent=1(진행중)으로 카운트
	
	//System.out.println("상품 = " + getCatePdCount);
	//System.out.println("신상품 = " + getCateNewPdCount);
	//System.out.println("세일상품 = " + getCateSalePdCount);
	//System.out.println("이벤트상품 = " + getCateEventPdCount);
	
	/*
	if(currentCate == 40){
		getCatePdCount = dao.getCateNewPdCount(currentCate); //신상품 조회
	}else{
		getCatePdCount = dao.getCatePdCount(currentCate);	
	}*/
	
	//한 페이지에 보여질 게시물 수
	int pageSize = 8;
	
	//한 줄에 보여질 게시물 수
	int col = 4;
	
	//리스트에스 페이지 번호 클릭 시 받는 파라미터.
	String pageNum = request.getParameter("pageNum");
	if(pageNum==null){
		pageNum="1";
	}
	
	int currentPage = Integer.parseInt(pageNum);
	int startRow = (currentPage - 1) * pageSize + 1;
	int endRow = currentPage * pageSize;
	
	//상품 이름, 가격 가져오기
	List thumbnailPdList = null;
	if(currentCate == 40){	// 신상품
		thumbnailPdList = dao.getCateThumNewPd(currentCate, startRow, endRow);
		getCatePdCount = getCateNewPdCount;
	}
	else if(currentCate == 50)	// 세일
	{
		thumbnailPdList = dao.getCateThumSalePd(currentCate, startRow, endRow);
		getCatePdCount = getCateSalePdCount;
	}
	else if(currentCate == 60)	// 이벤트
	{
		thumbnailPdList = dao.getCateThumEventPd(currentCate, startRow, endRow);
		getCatePdCount = getCateEventPdCount;
	}else{	// 그 외의 종류
		thumbnailPdList = dao.getCateThumPd(currentCate, startRow, endRow);
	}
	
	
	//상품 썸네일 가져오기
	String thumbnailImg = "";
	
	//카테고리 이름 가져오기
	String categoryName = dao.categoryName(currentCate);
	
%>


<main>
<br />

<table width = "1200" border="1" cellpadding="2">
<tr><td colspan='4' align='left'> <h3>>><a href="main.jsp">main</a>>><%=categoryName %> </h3></td></tr>
<%
	if(thumbnailPdList != null){
		
		for(int i = 0; i<thumbnailPdList.size(); i++){
			
			UserMenuDTO dto = (UserMenuDTO)thumbnailPdList.get(i);
			if(i%col ==0){
				%> <tr align='center'><%
			}
			%><td>
						<table width='300' onClick="location.href='product.jsp?pdCode=<%=dto.getPdCode() %>'" style="cursor:pointer;">
					<tr align='center'> 
					<td> <%
							thumbnailImg = dao.getCateThumbImg(dto.getPdCode());
						
						if(thumbnailImg == null){
							%>대표 이미지를 입력해주세요 <br ><%
						} else{
							%><img src="${pageContext.request.contextPath}\productImg\<%=thumbnailImg %>" width="270" height="270"/><%
						} %> </td></tr>
					<tr align="center"><td>
					<%if(currentCate == 40){ %>		<!-- 신상품 이름 옆에 이미지 -->
					<img src="images/new.png" border="0" height="18">
					<%}
					else if(dto.getSale() == 1 && dto.getEvent() == 1){ %>	<!-- 세일,이벤트(중복) 이름 옆에 이미지 -->
					<img src="images/sale.jpg" border="0" height="18">
					<img src="images/event.png" border="0" height="18"">
					<%}
					else if(dto.getSale() == 1){ %>	<!-- 세일 이름 옆에 이미지 -->
					<img src="images/sale.jpg" border="0" height="18">
					<%}
					else if(dto.getEvent() == 1){%>	<!-- 이벤트 이름 옆에 이미지 -->
					<img src="images/event.png" border="0" height="18"">
					<%}%>
					<strong><%=dto.getProductName() %></strong></td></tr>
					<tr align="right"><td> <%=dto.getSellingPrice() %>원</td></tr>
					</table><%
		}
	} else{
		%> <tr><td colspan='4' align='center'><h3>등록된 상품이 없습니다</h3></td></tr><%
	}
%>
</table>

<br />
<br />
<%
	if(getCatePdCount>0){
		int pageCount = getCatePdCount / pageSize + (getCatePdCount%pageSize == 0 ? 0:1);
		
		int startPage = (int)(currentPage/10)*10+1;
		int pageBlock = 10;
		int endPage = startPage+pageBlock-1;
		if (endPage>pageCount) {
			endPage = pageCount;
		}
		if (startPage>10){
			%> <a href="category.jsp?pdCategory=<%=currentCate %>&pageNum=<%=startPage-10 %>"> [이전]</a><%
		}
		for(int i = startPage; i <= endPage; i++){
			%> <a href="category.jsp?pdCategory=<%=currentCate %>&pageNum=<%=i %>">[<%=i %>]</a><%
		}
		if (endPage<pageCount) {
			%> <a href="cateogory.jsp?pdCategory=<%=currentCate %>&pageNum=<%=startPage+10 %>">[다음]</a><%
		}
	}
%>
</div>
</main>
<%@ include file="bottom.jsp" %>
