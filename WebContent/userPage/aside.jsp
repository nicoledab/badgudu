<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<link href="style.css" rel="stylesheet" type="text/css">

<tr><td>
<aside>
	<div align="center">
    <h3>카테고리</h3>
	</div>
	<ul>
		<li><a class="cate" href="/badgudu/userPage/category.jsp?pdCategory=40">신상품</a></li>
		<li><a class="cate" href="/badgudu/userPage/category.jsp?pdCategory=50">SALE</a></li>
		<li><a class="cate" href="/badgudu/userPage/category.jsp?pdCategory=60">Event</a></li>
		<li><a class="cate" href="/badgudu/userPage/category.jsp?pdCategory=1">로퍼</a></li>
		<li><a class="cate" href="/badgudu/userPage/category.jsp?pdCategory=2">플랫</a></li>
		<li><a class="cate" href="/badgudu/userPage/category.jsp?pdCategory=3">펌프스/힐</a></li>
		<li><a class="cate" href="/badgudu/userPage/category.jsp?pdCategory=4">슬링백/뮬</a></li>
		<li><a class="cate" href="/badgudu/userPage/category.jsp?pdCategory=5">샌들/슬리퍼</a></li>
		<li><a class="cate" href="/badgudu/userPage/category.jsp?pdCategory=6">스니커즈</a></li>
		<li><a class="cate" href="/badgudu/userPage/category.jsp?pdCategory=7">액세서리/양말</a></li>
	</ul>
	<br/>
	<center>
	<form action="searchList.jsp" method="post" style="margin-left:20px;">
		<input type="text" name="search" />
		<input type="submit" value="검색" />
	</form>
	</center>
	<br/>
	<br/>
	<br/>
	<div align="center">
    <h3>게시판</h3>
	</div>
	<ul>
		<li><a class="cate" href="/badgudu/userPage/csBoard/notice/notice.jsp">공지사항</a></li>
		<li><a class="cate" href="/badgudu/userPage/csBoard/qna/qnalist.jsp">자주 묻는 질문</a></li>
		<li><a class="cate" href="/badgudu/userPage/csBoard/oto/otoUserList.jsp">1:1 문의</a></li>
		<li><a class="cate" href="/badgudu/userPage/csBoard/review/reviewlist.jsp">상품후기</a></li>
	</ul>
</aside>
</td></tr>
