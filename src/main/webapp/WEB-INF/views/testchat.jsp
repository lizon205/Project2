<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>


<%@ include file="includes/header.jsp" %>

<link rel="stylesheet" href="resources/css/testchat.css">

<script src="http://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.js"></script>



<div></div>
<div class="Box" align="center">
	<div class="col-6" align="left">
		<label><b>실시간 채팅</b></label>
	</div>
	
	<div id="chatBox">
		<div id="msgArea" class="col-6" style="width: 1000px; height: 800px; overflow-y: auto; overflow-x:hidden; white-space:normal;">
		
		</div>
		
		
		<div class="col-6">
		<div class="input-group mb-3">
			<input type="text" id="msg" class="form-control" aria-label="Recipient's username" aria-describedby="button-addon2" autofocus="autofocus"  onkeyup="enterkey()">
			<div class="input-group-append" style="float: left">
				<button class="btn btn-outline-secondary" type="button" id="button-send">Enter</button>
			</div>
		</div>
		</div>
	</div>
	<div class="col-6">
	</div>
</div>


<%@ include file="includes/footer.jsp" %>



<script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>

<script type="text/javascript">

	//전송 버튼 누르는 이벤트
	$("#button-send").on("click", function(e) {
		sendMessage();
		$('#msg').val('')
		$("#msgArea").scrollTop($("#msgArea").prop('scrollHeight')); //스크롤 아래로	
	});
	
	//엔터키로도 보내보자
	function enterkey() {
		if (window.event.keyCode == 13) {
			sendMessage();
			$('#msg').val('')
// 			$("#msgArea").scrollTop($("#msgArea")[0].scrollHeight);	//스크롤 아래로
			$("#msgArea").scrollTop($("#msgArea").prop('scrollHeight')); //스크롤 아래로
	    }
	};
	
	
	
			
			
	var sock = new SockJS('http://localhost:9191/chatting');
	sock.onmessage = onMessage;
	sock.onclose = onClose;
	sock.onopen = onOpen;
	
	function sendMessage() {
		sock.send($("#msg").val());
	}
	//서버에서 메시지를 받았을 때
	function onMessage(msg) {
		
		var data = msg.data;
		var sessionId = null; //데이터를 보낸 사람
		var message = null;
		
		var arr = data.split(":");
		
		for(var i=0; i<arr.length; i++){
			console.log('arr[' + i + ']: ' + arr[i]);
		}
		
		var cur_session = '${userid}'; //현재 세션에 로그인 한 사람
		console.log("cur_session : " + cur_session);
		
		sessionId = arr[0];
		message = arr[1];
		
	    //로그인 한 클라이언트와 타 클라이언트를 분류하기 위함
		if(sessionId == cur_session){
			
			var str = "<div class='col-6'>";
			str += "<div class='a_chat'>";
			str += "<b>" + sessionId + " : " + message + "</b>";
			str += "</div></div>";
			
			$("#msgArea").append(str);
			
			$("#msgArea").scrollTop($("#msgArea").prop('scrollHeight')); //스크롤 아래로
		}
		else{
			
			var str = "<div class='col-6'>";
			str += "<div class='b_chat'>";
			str += "<b>" + sessionId + " : " + message + "</b>";
			str += "</div></div>";
			
			$("#msgArea").append(str);
			
			$("#msgArea").scrollTop($("#msgArea").prop('scrollHeight')); //스크롤 아래로
		}
		
	}
	//채팅창에서 나갔을 때
	function onClose(evt) {
		
		var user2 = '${userid}';
		var user = '${pr.username}';
		var str = user2 + " 님이 퇴장하셨습니다.";
		
		$("#msgArea").append(str);
		
		$("#msgArea").scrollTop($("#msgArea").prop('scrollHeight')); //스크롤 아래로
	}
	
	//채팅창에 들어왔을 때
	function onOpen(evt) {
		
		var user2 = '${userid}';
		var user = '${pr.username}'; 
		var str = user2 + "님이 입장하셨습니다.";
		
		$("#msgArea").append(str);
		
		$("#msgArea").scrollTop($("#msgArea").prop('scrollHeight')); //스크롤 아래로
	}

</script>

