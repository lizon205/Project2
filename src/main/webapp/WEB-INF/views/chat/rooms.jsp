<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"  %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"  %>

<script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script>


<%@ include file="../includes/header.jsp" %>


<link rel="stylesheet" href="../resources/css/makeroom.css">

 <div class="container" align="left" style="width: 1000px; height: 800px; overflow-y: auto; overflow-x:hidden; white-space:normal;">
            <div>
				<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }" /><!-- csrf토큰 -->
            
            
            
            	<c:forEach var="room" items="${list}">
<%--                 <ul th:each="room : ${list}"> --%>
				<ul>
                    <li class="roomlist"><a class="roomlist" href="/chat/room?roomId=${room.roomId}">'${room.name}'</a></li>
                </ul>
                </c:forEach>
            </div>
        </div>
        
        
		<form action="/chat/room" method="post">
		
			<div align="center">
			<!-- CSRF 토큰 설정 post 방식에는 꼭 있어야 합니다-->
			<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }"/>
		 
            <input type="text" name="name" id="name" class="form-control" autofocus="autofocus" onkeydown="checkSpacebar()">
            <button class="btn btn-outline-secondary" id="btn-create" name="btn-create">개설하기</button>
            </div>
            
        </form>
        
        
<%@ include file="../includes/footer.jsp" %>
        
        
        
        

<script type="text/javascript">

//첫 글자 쓰기 전 까지 스페이스바 금지
function checkSpacebar(){
	
	var kcode = event.keyCode;
	
	if($("#name").val().length < 1){
		if(kcode == 32) event.returnValue = false;	
	}
	
};

</script>


<script type="text/javascript">

var csrfHeaderName = "${_csrf.headerName}";
var csrfTokenValue = "${_csrf.token}";
$(document).ajaxSend(function(e, xhr, options) {
	xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
});//이건 ajax 보낼 때 마다 자동으로 보내준다!

            $(document).ready(function(){

                var roomName = '${roomName}';
		
                if(roomName != null && roomName != '')
                    alert(roomName + "방이 개설되었습니다.");

                $("#btn-create").on("click", function (e){
                    e.preventDefault();

                    var name = $("input[name='name']").val();
					
                    if(name != '' && name != null){
                    	
                    	$("form").submit();
                    	
                    }else{
                    	alert("Please write the name.");
                    }
                    
                    
                });

            });



</script>

