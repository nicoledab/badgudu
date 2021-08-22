<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <link href="../style.css" rel="stylesheet" type="text/css">
<%@ include file="../../adminTop.jsp" %>
<div class="crmmng" align="center">
<%@ include file="../../adminAside.jsp" %>
<main>
    
<title>BAD GUDU</title>
    

    
<main>
<style>
body {font-family: Arial, Helvetica, sans-serif;}
* {box-sizing: border-box}

/* Full-width input fields */
input[type=text], input[type=password] {
  width: 100%;
  padding: 15px;
  margin: 5px 0 22px 0;
  display: inline-block;
  border: none;
  background: #f1f1f1;
}

input[type=text]:focus, input[type=password]:focus {
  background-color: #ddd;
  outline: none;
}

hr {
  margin-bottom: 25px;
}

/* Set a style for all buttons */
button {
  background-color: #4CAF50;
  color: white;
  padding: 14px 20px;
  margin: 8px 0;
  border: none;
  cursor: pointer;
  width: 50%;
  opacity: 0.9;
}

button:hover {
  opacity:1;
}

/* Extra styles for the cancel button */
.cancelbtn {
  padding: 14px 20px;
  background-color: #f44336;
}

/* Float cancel and signup buttons and add an equal width */
.cancelbtn, .signupbtn {
  float: left;
  width: 50%;
  align:center;
 
}

/* Add padding to container elements */
.container {
  padding: 16px;
}

/* Clear floats */
.clearfix::after {
  content: "";
  clear: both;
  display: table;
}

/* Change styles for cancel button and signup button on extra small screens */
@media screen and (max-width: 300px) {
  .cancelbtn, .signupbtn {
     width: 100%;
     position:absolute;
  }
}
label{
	width:200px;
}

</style>
<body>

<script>
function loginNext() {
	var pw = document.signUp.pw.value;
	var pwc = document.signUp.pwc.value;
	var idch = document.signUp.idch.value;
	if(pw != pwc) {
		alert("비밀번호가 다릅니다");
		return false;
	}
	if(!idch) {
		alert("중복확인 하십시오");
		return false;
		
	}
}
function confirmId() {
	var id = document.signUp.id.value;
	
	if(!id) {
		alert("아이디를 입력하시오");
		return false;
	}
	open("confirmId.jsp?id="+id, "confirmId","width=300, height=300");
	document.signUp.idch.value="ok";
}

</script>

<form name="signUp" action="insertAdminAccountPro.jsp" method= "post" onsubmit="return loginNext();">
  <div class="signUp">
    <h1>관리자 계정 생성</h1>
    <hr>

  <table width='800'>
  	<tr>
 		<td width='200'><label for="name" ><b>이름</b></label></td>
    	<td width='600' colspan='2'><input type="text" placeholder="이름 입력" name="name" required> <br/></td>
  	</tr>
	<tr> 
    	<td width='200'><label for="Id"><b>아이디</b></label></td>
    	<td width='400'><input type="text" placeholder="아이디 입력" name="id" required>
    					<input type="hidden" name="idch" /></td>
    	<td width='200'><input type= "button" value="아이디 중복검사" onclick="confirmId();"  style="width:180; height:40;"/></td>
    	
	</tr>
    	<td width='200'><label for="pwa"><b>비밀번호</b></label></td>
    	<td width='600' colspan='2' align='center'><input type="password" placeholder="비밀번호 입력" name="pw" required><br/></td>
	<tr>
    	<td width='200'><label for="pwc"><b>비밀번호 확인</b></label></td>
    	<td width='600' colspan='2'><input type="password" placeholder="비밀번호 확인" name="pwc" required><br/></td>
   <tr> 	
    	<td width='200'><label for="address"><b>주소</b></label></td>
    	<td width='600' colspan='2'><input type="text" placeholder="주소 입력" name="address" required><br/></td>
	</tr>
	<tr>
		<td colspan="3">
   		<div class="clearfix">
      	<button type="button" class="cancelbtn" onclick="window.location='/badgudu/adminPage/crmManage/adminAccount/crmForm.jsp'">취소</button>
      	<button type="submit" class="signupbtn">회원가입</button>
      </td>
      </tr>
    </div>
  </table>
  </div>
</form>

</body>
</main>
</div>
