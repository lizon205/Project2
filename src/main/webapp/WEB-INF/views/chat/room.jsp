<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"  %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"  %>

    
<%@ include file="../includes/header.jsp" %>

<link rel="stylesheet" href="../resources/css/testchat.css">

<script src="http://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.js"></script>

            <div class="col-6" align="left">
                <label><b style="color:lightgray;">'${room.name}'</b></label>
            </div>

<div class="container" align="center">

            
            <div>
                <div id="msgArea" class="col" style="width: 1000px; height: 800px; overflow-y: auto; overflow-x:hidden; white-space:normal;">
                
                </div>
                
                <div class="col-6">
                    <div class="input-group mb-3">
                        <input type="text" id="msg" name="msg" class="form-control" aria-label="Recipient's username" aria-describedby="button-addon2" autofocus="autofocus" onkeydown="checkSpacebar()">
                        <div class="input-group-append" style="float: left">
                            <button class="btn btn-outline-secondary" type="button" id="button-send" name="button-send">Enter</button>
                        </div>
                    </div>
                </div>
            </div>
	       <div class="col-6"></div>
</div>


<%@ include file="../includes/footer.jsp" %>


<script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script>


<script type="text/javascript">

//첫 글자 쓰기 전 까지 스페이스바 금지
function checkSpacebar(){
	
	var kcode = event.keyCode;
	
	if($("#msg").val().length < 1){
		if(kcode == 32) event.returnValue = false;	
	}
	
};

</script>
        
<script type="text/javascript">

  
  $(document).ready(function(){
	
	  
      var roomName = '${room.name}';
      var roomId = '${room.roomId}';
      var username = '${userName}';
//       console.log(roomName + ", " + roomId + ", " + username);

      
      var sockJs = new SockJS("/stomp/chat");
      //1. SockJS를 내부에 들고있는 stomp를 내어줌
      var stomp = Stomp.over(sockJs);

      //2. connection이 맺어지면 실행
      stomp.connect({}, function (){
         console.log("STOMP Connection")

         //4. subscribe(path, callback)으로 메세지를 받을 수 있음
         stomp.subscribe("/sub/chat/room/" + roomId, function (chat) {//구독

             var content = JSON.parse(chat.body);
			
             var writer = content.writer;
             var str = '';
			 var message = content.message;  
             
             if(writer == username){
                 str = "<div class='col-6'>";
                 str += "<div class='a_chat'>";
                 str += "<b>" + writer + " : " + message + "</b>";
                 str += "</div></div>";
                 $("#msgArea").append(str);
                 $("#msgArea").scrollTop($("#msgArea").prop('scrollHeight')); //스크롤 아래로
             }else {
                 str = "<div class='col-6'>";
                 str += "<div class='b_chat'>";
                 str += "<b>" + writer + " : " + message + "</b>";
                 str += "</div></div>";
                 $("#msgArea").append(str);
                 $("#msgArea").scrollTop($("#msgArea").prop('scrollHeight')); //스크롤 아래로
             }

//              $("#msgArea").append(str); 
         });

         //3. send(path, header, message)로 메세지를 보낼 수 있음
         stomp.send('/pub/chat/enter', {}, JSON.stringify({roomId: roomId, writer: username}))
      });

      $("#button-send").on("click", function(e){
          var msg = document.getElementById("msg");
          console.log(username + ":" + msg.value);
          stomp.send('/pub/chat/message', {}, JSON.stringify({roomId: roomId, message: msg.value, writer: username}));
          msg.value = '';
          $("#msgArea").scrollTop($("#msgArea").prop('scrollHeight')); //스크롤 아래로
      });
      
      
      //엔터키로 보내자
      $("#msg").on("keyup",function(key){
          if(key.keyCode==13) {
        	  var msg = document.getElementById("msg");
              console.log(username + ":" + msg.value);
              stomp.send('/pub/chat/message', {}, JSON.stringify({roomId: roomId, message: msg.value, writer: username}));
              msg.value = '';
//               $("#msgArea").scrollTop($("#msgArea").prop('scrollHeight')); //스크롤 아래로
              
              //스크롤 아래로 2
//               $('#msgArea')
//               .append(message)
//               .stop()
//               .animate({ scrollTop: $('#msgArea')[0].scrollHeight }, 1000);

				//스크롤 아래로 3
              $('#msgArea').scrollTop($('#msgArea')[0].scrollHeight);
          }
      });
      
  });//end document ready
 
  
  var username = '${userName}';
  


  
  </script>


