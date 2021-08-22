<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="admin.dao.adminMemberDAO" %>
    
<script>
function loginInfo(){
	var idCode = document.getElementsByName("idCode")[0].value;
	if(idCode=="null"){
		alert("로그인 하세요");
		return false;
	} else if(idCode != 10){
		alert("관리자만 들어갈 수 있습니다.");
		return false;
	}
}

</script>


<%
    String aId = (String) session.getAttribute("memId");
	adminMemberDAO Adao = new adminMemberDAO();
	int idCode = Adao.adminCode(aId);
	
	if(idCode != 10){
    	response.sendRedirect("/badgudu/adminPage/adminLoginMain.jsp");
    }
%>
<input type="hidden" name="idCode" value=<%=idCode %> />

<tr><td>
<aside class = "asice">
	<div align="center">
	</div>
	<ol>
		<li class="cate">상품관리</li>
			<ul>
				<li class="detail"><a href="/badgudu/adminPage/productManage/productRegForm.jsp" onclick="return loginInfo();">상품등록</a></li>
				<li class="detail"><a href="/badgudu/adminPage/productManage/productListBoard.jsp" onclick="return loginInfo();">상품목록</a></li>
				<li class="detail"><a href="/badgudu/adminPage/productManage/produckStock.jsp" onclick="return loginInfo();">재고관리</a></li>
			</ul>
		<li class="cate">주문관리</li>
			<ul>
				<li class="detail"><a href="/badgudu/adminPage/orderManage/orderList.jsp" onclick="return loginInfo();">주문목록</a></li>
				<li class="detail"><a href="/badgudu/adminPage/orderManage/salesManage.jsp">매출관리</a></li>
			</ul>
		<li class="cate">계정관리</li>
			<ul>
				<li class="detail"><a href="/badgudu/adminPage/crmManage/userAccount/crmForm.jsp" onclick="return loginInfo();">고객관리</a></li>
				<li class="detail"><a href="/badgudu/adminPage/crmManage/adminAccount/crmForm.jsp" onclick="return loginInfo();">관리자관리</a></li>
			</ul>
		<li class="cate">게시판관리</li>
			<ul>
				<li class="detail"><a href="/badgudu/adminPage/csBoard/notice/notice.jsp" onclick="return loginInfo();">공지사항</a></li>
				<li class="detail"><a href="/badgudu/adminPage/csBoard/qna/qnalist.jsp" onclick="return loginInfo();">자주 묻는 질문</a></li>
				<li class="detail"><a href="/badgudu/adminPage/otoManage/otoAdminList.jsp" onclick="return loginInfo();">1:1문의</a></li>
				<li class="detail"><a href="/badgudu/adminPage/csBoard/review/reviewlist.jsp" onclick="return loginInfo();">Review</a></li>
			</ul>
		<li class="cate">회사소개</li>
			<ul>
				<li class="detail"><a href="/badgudu/adminPage/companyManage/company.jsp">회사정보수정</a></li>
				<li class="detail"><a href="/badgudu/adminPage/companyManage/bsUpdate.jsp">브랜드스토리</a></li>
			</ul>
	</ol>
</aside>
</td></tr>
