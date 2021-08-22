<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    
<script type="text/javascript">
	function test(){		
		var cl_length = document.getElementsByName("cl").length; 
		var sz_length = document.getElementsByName("sz").length; 
		var sendZone=document.getElementById("sendZone");
		var str ='';
		for(var i=0; i<cl_length; i++){
			for(var y=0; y<sz_length; y++){
				if(document.getElementsByName("cl")[i].checked==true){
					 if(document.getElementsByName("sz")[y].checked==true){
						//alert(document.getElementsByName("cl")[i].value + document.getElementsByName("sz")[y].value);
						var color = document.getElementsByName("cl")[i].value;
						var size = document.getElementsByName("sz")[y].value;
						str+="<tr><td width='150'>"+color+' '+size+"</td>"+"<td><input type='text' name='qty' /> EA </td></tr>";
					 }
				}
			}
		}
		sendZone.innerHTML="<table>"+str+"</table>";
		//del 추가하기.
	}
	function del() {
		
	}

</script>

<link href="style.css" rel="stylesheet" type="text/css">
<%@ include file="../adminTop.jsp" %>
<div class="pdmng" align="center">
<%@ include file="../adminAside.jsp" %>
<main>
<title>상품 등록</title>
<center>
<h1>상품 등록</h1>
<form name="pdRegForm" action="/badgudu/adminPage/productManage/productRegFormPro.jsp" method="post" enctype="multipart/form-data">
<table border=1 width="700" cellpadding="7">

<%--표시설정--%>
	<tr> <td colspan="2" bgcolor="lightgray"><b>표시 설정<b/></td></tr>
	<tr>
	<%--진열여부(상품판매여부) --%>
		<td align="center" width="150">진열상태</td>
		<td width="600" >
			<input type="radio" name="display" value="true" /> 진열함
			<input type="radio" name="display" value="false" /> 진열안함 
		</td>
	</tr>
	<tr>
	<%--상품카테고리 선택 --%>
		<td align="center" width="150">상품분류 선택</td>
		<td>
			<select name="pdCategory">
				<option value="">카테고리 선택</option>
				<option value="1">로퍼</option>
				<option value="2">플랫</option>
				<option value="3">펌프스/힐</option>
				<option value="4">슬링백/뮬</option>
				<option value="5">샌들/슬리퍼</option>
				<option value="6">스니커즈</option>
				<option value="7">액세서리/양말</option>
				<option value='8'>세트상품</option>
			</select>
		</td>
	</tr>
	
<%--기본 정보--%>
	<tr> <td colspan="2" bgcolor="lightgray"><b>기본 정보<b/></td></tr>
	<tr>
	<%--상품명--%>
		<td width="150">*상 품 명</td>
		<td>
			<input type="text" name="productName" placeholder="상품명"  />
		</td>
	</tr>
	<%--상품코드 자동부여--%>
	<tr>
		<td width="150">*상품 번호</td>
		<td>
			자동생성
		</td>
	</tr>
	<%--상품 요약 설명--%>
	<tr>
		<td width="150">*상품 요약 설명</td>
		<td>
			<textarea name="pdExplain" rows="2" cols="60"></textarea>
		</td>
	</tr>
	<%--상품 상세 설명--%>
	<tr>
		<td width="150">*상품 상세 설명</td>
		<td>
			<textarea name="pdDetailExplain" rows="30" cols="60"></textarea>
		</td>
	</tr>
	<%--상품 공급가와 판매가--%>
	<tr>
		<td width="150">*공급가</td>
		<td>
			<input type="number" name="supplyPrice" /> 원
		</td>
	</tr>
	<tr>
		<td width="150">*판매가</td>
		<td>
			<input type="number" name="sellingPrice" /> 원 
		</td>
	</tr>
	<%--상품 판매가능수량--%>
	<tr>
	<td width="150">* 색상</td>
		<td>
			<input type="checkbox" name="cl" value="black" /> 블랙
			<input type="checkbox" name="cl" value="white" /> 화이트
			<input type="checkbox" name="cl" value="ivory" /> 아이보리
			<input type="checkbox" name="cl" value="navy" /> 네이비
			<input type="checkbox" name="cl" value="brown" /> 브라운
			<input type="checkbox" name="cl" value="red" /> 레드
		</td>
	</tr>
	<tr>
	<td width="150">* 크기</td>
		<td>
			<input type="checkbox" name="sz" value="225" /> 225 
			<input type="checkbox" name="sz" value="230" /> 230 
			<input type="checkbox" name="sz" value="235" /> 235 
			<input type="checkbox" name="sz" value="240" /> 240 
			<input type="checkbox" name="sz" value="245" /> 245 
			<input type="checkbox" name="sz" value="250" /> 250 
		</td>
	</tr>
	<tr>
	<td width="150">* 판매가능 수량</td>
		<td>
			<input type="button" value="수량 추가" onclick="test();"/>
			<div id="sendZone">  </div> 
			수량 입력 후 '수량 추가'버튼을 클릭하면 초기화됩니다.
		</td>
	</tr>
	
	
<%--이미지 정보--%>
	<tr> <td colspan="2" bgcolor="lightgray"><b>이미지 정보<b/></td></tr>
	<tr><td colspan="2">이미지 삽입만 가능합니다.</td></tr>
	<tr>
	<td width="150">*대표 이미지</td>
		<td>
			대표 이미지는 최대 3개까지 설정 가능합니다.<br/>
			<input type="file" name="productImg1"/>  [썸네일 이미지] <br/> 
			<input type="file" name="productImg2"/> <br/> 
			<input type="file" name="productImg3"/> 
		</td>
	</tr>
	<tr>
	<td width="200">*상품 상세이미지</td>
		<td>
			상세 이미지는 최대 2개까지 설정 가능합니다.<br/>
			<input type="file" name="productDetailImg1" /><br/>
			<input type="file" name="productDetailImg2" />
		</td>
	</tr>
	
	<tr><td colspan="2" align="center"><input type="submit" value=" 등 록 "/></td></tr>

</table>
</form>
</center>
</main>
</div>