<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>

<%@include file="../includes/header.jsp"%>

<div class="container">
	<div class="row">
		<div class="col-md-4 col-md-offset-4">
			<div class="login-panel panel panel-default">
<div class="panel-heading">Create New Account Page</div>
<!-- /.panel-heading -->

<div class="panel-body">

<form role="form" action="/member/create" method="post">

			<!-- CSRF 토큰 설정 post 방식에는 꼭 있어야 합니다-->
			<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }"/>
			
<div class="form-group">
	<label>아이디 : </label>
	
	<input class="form-group" id="userid" name='userid' type="text" maxlength="12" autofocus="autofocus" onkeydown="checkSpacebar()"/>
	
	<button class="btn btn-warning" type="button" id="idCheck" name="idCheck" onclick="fn_idCheck();" value="N">중복 확인</button>	
</div>

<div class="form-group">
	<label>비밀번호 : </label>
	<input class="form-group" id="userpw" name='userpw' type="password" required="required" onkeydown="checkSpacebar()"/>
</div>

<div class="form-group">
	<label>확인 : </label>
	<input class="form-group" id="userpww" name='userpww' type="password" onkeydown="checkSpacebar()"/>
	<button class="btn btn-warning" type="button" id="pwCheck" name="pwCheck" onclick="fn_pwCheck();" value="N">확인</button>	
</div>

<div class="form-group">	
	<label>이름 : </label>
	<input class="form-group" name='userName' id="userName" type="text" required="required" maxlength="10" onkeydown="checkSpacebar()"/>
</div>

<div class="form-group">
	<label>주소 : </label>
	<input class="form-group" name='addr' id="addr" type="text" onkeydown="checkSpacebar2()"/>
</div>

<div class="form-group">
	<label>번호 : </label>
	<input class="form-group" name='phone' id="phone" type="text" onkeydown="checkSpacebar()"/>
</div>

<div class="form-group">
	<label>Email : </label>
	<input class="form-group" name='email' id="email" type="text" onkeydown="checkSpacebar()"/>
</div>


<button type="submit" id="signUpBtn" class="btn btn-default">Create</button>
<button type="reset" class="btn btn-danger">Cancel</button>
<a href="../board/list" class="btn btn-info">List</a>


</form>
</div>
<!-- /.panel-body -->

</div>
</div>
</div>
</div>
<!-- /.container  -->

<%@ include file="../includes/footer.jsp"%>






<script type="text/javascript">

//토큰은 필수야..
var csrfHeaderName = "${_csrf.headerName}";
var csrfTokenValue = "${_csrf.token}";
$(document).ajaxSend(function(e, xhr, options) {
	xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
});//이건 ajax 보낼 때 마다 자동으로 보내준다!


//비밀번호 확인 체크
function fn_pwCheck(){
	console.log("checking pw......function");
	if($("#userpw").val() == $("#userpww").val()){
		alert("확인되었습니다.");
		$("#pwCheck").attr("value", "Y");
	}else{
		alert("같지 않습니다.");
	}
	
};//function end


//아이디 중복 여부 체크 Ajax
function fn_idCheck(){
	console.log("chekcing id.....function");
	//여기까진 된다우..
	console.log("아이디 : " + $("#userid").val());
	//이것도 성공
	
	$.ajax({
		url: '/member/idCheck',
		type: 'POST',
		dataType: 'json', // Ajax를 통해 호출한 페이지의 return 형식
		data: {"userid" : $("#userid").val()},//요청과 함께 서버에 보내는 string 또는 json
		success: function(data){//요청이 성공일때 실행되는 callback 함수, (data, textStatus, jqXHR) , 반대는 error
			if (data == 1){
				alert("중복된 아이디입니다.");
			} else if (data == 0) {
				$("#idCheck").attr("value", "Y");
				alert("사용 가능한 아이디입니다.");
			}
		}
	}); // end ajax
}; // function end 

//회원 가입 버튼 동작 관련 자바 스크립트 
	$(document).ready(function(){
			
	// 회원 가입 시  
		$("#signUpBtn").on("click", function(){
				
			// 아이디의 길이가 6~12자 범위에 포함되지 않을 경우 
			if($("#userid").val().length < 6 || $("#userid").val().length > 12) {
				alert("아이디는 6~12자 이내로 입력해주세요.")
				$("#userid").focus();
				return false;
			}
				
				
			// 비밀번호의 길이가 8자보다 짧을 경우 
			if($("#userpw").val().length < 5){
				alert("비밀번호는 5자 이상 입력해주세요.");
				$("#userpw").focus();
				return false;
			}
			
			if($("#userName").val() == ""){
				alert("이름을 입력해주세요.");
				$("#userName").focus();
				return false;
			}
			
			if($("#addr").val() == ""){
				alert("주소를 입력해 주세요.");
				$("#addr").focus();
				return false;
			}
			
			if($("#phone").val() == ""){
				alert("휴대폰 번호를 입력해주세요.");
				$("#phone").focus();
				return false;
			}
			
			if($("#email").val() == ""){
				alert("이메일 주소를 입력해 주세요.");
				$("#email").focus();
				return false;
			}
				
			
		// 아이디, 사용자 이름 중복 여부 확인 
		var idCheckVal = $("#idCheck").val();
		
		if(idCheckVal == "N") {
			alert("아이디 중복 확인 버튼을 눌러주세요.");
			return false;
		}
		
		var pwCheckVal = $("#pwCheck").val();
		
		if(pwCheckVal == "N") {
			alert("비밀번호 확인 버튼을 눌러주세요.");
			return false;
		}
		
		// 모두 이상 없을 경우 회원 가입 버튼 동작 
		$("#signUpForm").submit();
		alert("회원가입이 완료되었습니다. 로그인해주세요.");
		
		}); 
}); 
</script>


<script type="text/javascript">
function checkSpacebar(){
	
	var kcode = event.keyCode;
	
	if(kcode == 32) event.returnValue = false;	
	
};
	
function checkSpacebar2(){
	
	var kcode = event.keyCode;
	
	if($("#addr").val().length < 1){
		if(kcode == 32) event.returnValue = false;	
	}
};
</script>

