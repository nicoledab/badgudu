<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="admin.dao.ProductDAO2" %>
<%@ page import="admin.dto.UpdateDTO" %>
<%@ page import = "java.util.*" %>

<link href="style.css" rel="stylesheet" type="text/css">
<%@ include file="../adminTop.jsp" %>
<div class="pdmng" align="center">
<%@ include file="../adminAside.jsp" %>
<main>
    
<%
	String pdCode = (String)request.getParameter("pdCode");

	ProductDAO2 dao = new ProductDAO2();
	UpdateDTO dto = dao.getData(pdCode); // pdCode로 PRODUCT 데이터 가져오기
	UpdateDTO dto2 = dao.getData2(pdCode); // pdCode로 STOCK 데이터 가져오기 (다른 메소드 getData, getData2)
	UpdateDTO dto3 = dao.getimageData(pdCode); // pdCode로 img정보 가저오기
%>
<body>
<script type="text/javascript">
function add(){      
	//기존옵션 받아줌.
	var origin = "";
	var originList = new Array();
	var colorOrigin_length = document.getElementsByName("colorOrigin").length;
	var sizeOrigin_length = document.getElementsByName("sizeOrigin").length;
	for(var i=0; i<colorOrigin_length; i++){
		var colorOrigin = document.getElementsByName("colorOrigin")[i].value;
		var sizeOrigin = document.getElementsByName("sizeOrigin")[i].value;
		origin = colorOrigin+sizeOrigin;
		originList.push(origin);
	}

	//신규옵션 검사
	var cl_length = document.getElementsByName("cl").length;
	var sz_length = document.getElementsByName("sz").length;
	var sendZone=document.getElementById("sendZone"); 
    var addOption = "";
    var str ='';
    for(var i=0; i<cl_length; i++){
		for(var y=0; y<sz_length; y++){
			if(document.getElementsByName("cl")[i].checked==true){
				 if(document.getElementsByName("sz")[y].checked==true){
					 
					 var color = document.getElementsByName("cl")[i].value; 
					 var size = document.getElementsByName("sz")[y].value; 
					 addOption = color+size;
             	 	 for(z=0; z<originList.length; z++){
             			var ori = originList[z] 
             			if (addOption==ori){
             				alert("이미 추가된 옵션이 존재합니다. 옵션을 확인해주세요.");
             				return false;
             			}
             		}
             	 	str+="<tr><td width='100'>"+color+' '+size+"</td>"+"<td><input type='text' name='qty'/> EA </td></tr>";
             	}
         	}
		}
   }
   
   sendZone.innerHTML="<table>"+str+"</table>";
}

function deletePro(){
	var pdCode = document.getElementsByName("pdCode")[0].value;
	window.location="productDelete.jsp?pdCode="+pdCode;
}
</script>

<title>상품 변경</title>
<link href="style.css" rel="stylesheet" type="text/css">
<center>
<h1>상품 변경</h1>
<form name="pdUpdateForm" action="productUpdatePro.jsp" method="post" enctype="multipart/form-data">
<table border=1 width="700" cellpadding="7">

<%--표시설정--%>
   <tr> <td colspan="3" bgcolor="lightgray"><b>표시 설정<b/></td></tr>
   <tr>
   <%--진열여부(상품판매여부) --%>
      <td align="center" width="150">진열상태</td>
      <td width="600" >
        <input type="radio" name="display" value="true" <%if(dto.getDisplay().equals("true")){%>checked<%}%> /> 진열함
        <input type="radio" name="display" value="false" <%if(dto.getDisplay().equals("false")){%>checked<%} %> /> 진열안함
      </td>
   </tr>
   <tr>
   <%--상품카테고리 선택 --%>
      <td align="center" width="150">상품분류 선택</td>
      <td>
         <select name="pdCategory">
			<option value="1" <%if(dto.getPdCategory()==1){%>selected<%}%>>로퍼</option>
            <option value="2" <%if(dto.getPdCategory()==2){%>selected<%}%>>플랫</option>
            <option value="3" <%if(dto.getPdCategory()==3){%>selected<%}%>>펌프스/힐</option>
            <option value="4" <%if(dto.getPdCategory()==4){%>selected<%}%>>슬링백/뮬</option>
            <option value="5" <%if(dto.getPdCategory()==5){%>selected<%}%>>샌들/슬리퍼</option>
            <option value="6" <%if(dto.getPdCategory()==6){%>selected<%}%>>스니커즈</option>
            <option value="7" <%if(dto.getPdCategory()==7){%>selected<%}%>>액세서리/양말</option>
            <option value="8" <%if(dto.getPdCategory()==8){%>selected<%}%>>세트상품</option>
         </select>
      </td>
   </tr>
   
<%--기본 정보--%>
   <tr> <td colspan="2" bgcolor="lightgray"><b>기본 정보<b/></td></tr>
   <tr>
   <%--상품명--%>
      <td width="150">*상 품 명</td>
      <td>
         <input type="text" name="productName" value="<%=dto.getProductName() %>"  />
      </td>
   </tr>
   <%--상품코드 자동부여--%>
   <tr>
      <td width="150">*상품 번호</td>
      <td>
         <input type="hidden" name="pdCode" value="<%=dto.getPdCode() %>"/> <%=dto.getPdCode() %>
      </td>
   </tr>
    <%--상품코드 자동부여--%>
   <tr>
      <td width="150">*행사 진행여부</td>
      <td>
         <input type="radio" name="sale" value='1' <%if(dto.getSale() == 1){%>checked<%}%> /> SALE O	<!-- stock DB에서 받아온 sale 컬럼을 비교 -->
         <input type="radio" name="sale" value='2' <%if(dto.getSale() == 2){%>checked<%}%> /> SALE X <br>
         <input type="radio" name="event" value='1'<%if(dto.getEvent() == 1){%>checked<%}%> /> EVENT O 
         <input type="radio" name="event" value='2' <%if(dto.getEvent() == 2){%>checked<%}%>/> EVENT X
      </td>
   </tr>
   <%--상품 요약 설명--%>
   <tr>
      <td width="150">*상품 요약 설명</td>
      <td>
         <textarea name="pdExplain" rows="2" cols="60" ><%=dto.getPdExplain() %></textarea>
      </td>
   </tr>
   <%--상품 상세 설명--%>
   <tr>
      <td width="150">*상품 상세 설명</td>
      <td>
         <textarea name="pdDetailExplain" rows="30" cols="60" ><%=dto.getPdDetailExplain() %></textarea>
      </td>
   </tr>
   <%--상품 공급가와 판매가--%>
   <tr>
      <td width="150">*공급가</td>
      <td>
         <input type="number" name="supplyPrice" value="<%=dto.getSupplyPrice() %>" /> 원
      </td>
   </tr>
   <tr>
      <td width="150">*판매가</td>
      <td>
         <input type="number" name="sellingPrice" value="<%=dto.getSellingPrice() %>" /> 원 
      </td>
   </tr>
   <%--상품 판매가능수량--%>
	<tr> 
	<td width="300">* 잔여재고<br/>(기존재고 수량 수정)</td>
      <td align="center">
      <table>
      <%
      	
      	ArrayList<UpdateDTO> stockList = dao.stockCheck(pdCode);
      	for(int i=0; i<stockList.size(); i++){
      		UpdateDTO updto = stockList.get(i);
      		%><tr style="line-height : 21px;">
      			<td align="center"><input type="hidden" name="colorOrigin" value="<%=updto.getColor1()%>" /><%=updto.getColor1() %> |</td>
      			<td align="center"><input type="hidden" name="sizeOrigin" value="<%=updto.getSize1()%>" /><%=updto.getSize1() %> |</td>
      			<td align="center"><input type="number" name="qtyOrigin" value="<%=updto.getRemainQuant()%>"/></td>
      		</tr><%
      	}
      
      %>
      </table></td>
   </tr>
   
   <%--상품옵션추가--%>
   <tr> <td colspan="2" bgcolor="lightgray"><b>상품옵션추가<b/></td></tr>
   <tr>
   <td width="150">* 색상</td>
      <td>
         <% String [] cl = dto.getCl(); %>
         <input type="checkbox" name="cl" value="black" %> 블랙
         <input type="checkbox" name="cl" value="brown" /> 브라운
         <input type="checkbox" name="cl" value="ivory" /> 아이보리
         <input type="checkbox" name="cl" value="navy"/> 네이비
         <input type="checkbox" name="cl" value="red"/> 레드
         <input type="checkbox" name="cl" value="white"/> 화이트
      </td>
   </tr>
   <tr>
   <td width="150">* 크기</td>
      <td>
         <%  String [] sz = dto.getSz(); %>
         <input type="checkbox" name="sz" value="225" /> 225 
         <input type="checkbox" name="sz" value="230" /> 230 
         <input type="checkbox" name="sz" value="235" /> 235 
         <input type="checkbox" name="sz" value="240" /> 240 
         <input type="checkbox" name="sz" value="245" /> 245 
         <input type="checkbox" name="sz" value="250" /> 250 
      </td>
   </tr>
   
     <td width="150">* 추가수량 </td>
     <td>
   		<input type="button" value="옵션 추가" onclick="return add();"/>
         <div id="sendZone"></div> 
      </td>
   </tr>
   
<%--이미지 정보--%>
   <tr> <td colspan="2" bgcolor="lightgray"><b>이미지 정보<b/></td></tr>
   <tr><td colspan="2">이미지 삽입만 가능합니다.</td></tr>
   <tr>
   <td width="150">*대표 이미지</td>
      <td>
         대표 이미지는 최대 3개까지 설정 가능합니다.<br/>
         <input type="file" name="productImg1" /> | <input type="hidden" name="pdimg1" value=<%=dto3.getProductImg1() %> /><%=dto3.getProductImg1() %> <br/>
         <input type="file" name="productImg2" /> | <input type="hidden" name="pdimg2" value=<%=dto3.getProductImg2() %> /><%=dto3.getProductImg2() %> <br/> 
         <input type="file" name="productImg3" /> | <input type="hidden" name="pdimg3" value=<%=dto3.getProductImg3() %> /><%=dto3.getProductImg3() %> 
      </td>
   </tr>
   <tr>
   <td width="200">*상품 상세이미지</td>
      <td>
         상세 이미지는 최대 2개까지 설정 가능합니다.<br/>
         <input type="file" name="productDetailImg1" /> | <input type="hidden" name="pddtimg1" value=<%=dto3.getProductDetailImg1() %>/><%=dto3.getProductDetailImg1() %><br/>
         <input type="file" name="productDetailImg2" /> | <input type="hidden" name="pddtimg2" value=<%=dto3.getProductDetailImg2() %>/><%=dto3.getProductDetailImg2() %>
      </td>
   </tr>
   
   <tr>
	   <td colspan="2" align="center">
	 	  <input type="button" value=" 상품목록 " onclick="history.go(-1)" />
		   <input type="submit" value=" 수 정 "/>
		   <input type="button" value=" 삭 제 " onclick="deletePro();" />
	   </td>
   </tr>

</table>
</form>
</center>
 </body>
 
 </main>
 </div>