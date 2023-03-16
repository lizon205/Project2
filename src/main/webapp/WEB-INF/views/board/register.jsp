<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<%@include file="../includes/header.jsp"%>

<!-- upload css -->
<style>
.uploadResult {
	
	width:100%;
	background-color: gray;
}

.uploadResult ul{
	display:flex;
	flex-flow: row;
	justify-content: center;
	align-items: center;
}

.uploadResult ul li {
	list-style: none;
	padding: 10px;
	align-content: center;
	text-align: center;
}

.uploadResult ul li img{
	width: 100px;
}

.uploadResult ul li span {
	color:white;
} 

.bigPictureWrapper {
	position: absolute;
	display: none;
	justify-content: center;
	align-items: center;
	top:0%;
	width:100%;
	height:100%;
	background-color:gray;
	z-index: 100;
	background:rgba(255,255,255,0.5);	
}

.bigPicture {
	position: relative;
	display:flex;
	justify-content: center;
	align-items: center;
}

.bigPicture img {
	width:600px;
}
</style>
<!-- upload css end -->

<!-- 첨부파일 관련 -->
<script type="text/javascript">


function showUploadResult(uploadResultArr) {
	
	if(!uploadResultArr || uploadResultArr.length == 0){ return; }
	
	var uploadUL = $(".uploadResult ul");
	
	var str = "";
	
	$(uploadResultArr).each(function(i, obj) {
		
		//image type
		if(obj.image) {

			var fileCallPath = encodeURIComponent( obj.uploadPath+"/s_"+obj.uuid +"_"+obj.fileName);
			str += "<li data-path='"+obj.uploadPath+"'";
			str += "data-uuid='"+obj.uuid+"' data-filename='"+obj.fileName+"' data-type='"+obj.image+"'"
			str += " ><div>";
			str += "<span>"+obj.fileName+"</span>";
			str += "<button type='button' data-file=\'"+fileCallPath+"\' "
			str += "data-type='image' class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>";
			str += "<img src='/display?fileName="+fileCallPath+"'>";
			str += "</div>";
			str += "</li>";
		} else {
// 			str += "<li>" + obj.fileName + "</li>";
			var fileCallPath = encodeURIComponent(obj.uploadPath+ "/"+obj.uuid+"_"+obj.fileName);
			var fileLink = fileCallPath.replace(new RegExp(/\\/g),"/");
			
			str += "<li "
			str += "data-path='"+obj.uploadPath+"' data-uuid='"+obj.uuid+"' data-filename='"+obj.fileName+"' data-type='"+obj.image+"'><div>";
			str += "<span>"+obj.fileName+"</span>";
			str += "<button type='button' data-file=\'"+fileCallPath+"\' data-type='file' "
			str += "class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>";
			str += "<img src='/resources/img/attach.png'></a>";
			str += "</div>";
			str += "</li>";
		}
	});
	uploadUL.append(str);
}


$(document).ready(function(e){
	
	var formObj = $("form[role='form']");
	
	$("button[type='submit']").on("click", function(e){
		
		e.preventDefault();
		
		console.log("submit clicked");
		
					
		//제목 2자 이상
		if($("#title").val().length < 2){
			alert("제목은 2자 이상 입력해주세요.");
			$("#title").focus();
			return false;
		}
		
		//내용이 없을 경우
		if($("#content").val() == ""){
			alert("내용을 입력해주세요.");
			$("#content").focus();
			return false;
		}
		
		

		var str = "";
		
		$(".uploadResult ul li").each(function(i, obj){
			
			var jobj = $(obj);
			
			console.dir(jobj);
			
			str += "<input type='hidden' name='attachList["+i+"].fileName' value='"+jobj.data("filename")+"'>";
			str += "<input type='hidden' name='attachList["+i+"].uuid' value='"+jobj.data("uuid")+"'>";
			str += "<input type='hidden' name='attachList["+i+"].uploadPath' value='"+jobj.data("path")+"'>";
			str += "<input type='hidden' name='attachList["+i+"].fileType' value='"+jobj.data("type")+"'>";
			
		});
		
		formObj.append(str).submit();
		
		
	});//가장 먼저 첨부파일 관련 처리 위함
	
	var regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
	var maxSize = 5242880; // 5MB

	function checkExtension(fileName, fileSize){
		
		if(fileSize >= maxSize){
			alert("파일 사이즈 초과");
			return false;
		}
		
		if(regex.test(fileName)){
			alert("해당 종류의 파일은 업로드할 수 없습니다.");
			return false;
		}
		return true;
	}//파일 판단
	
	//CSRF
	var csrfHeaderName = "${_csrf.headerName}";
	var csrfTokenValue = "${_csrf.token}";
	
	$("input[type='file']").change(function(e){
		
		var formData = new FormData();
		
		var inputFile = $("input[name='uploadFile']");
		
		var files = inputFile[0].files;
		
		//add FIle Data to formData
		for(var i=0; i<files.length; i++){
			
			if(!checkExtension(files[i].name, files[i].size) ){
				return false;
			}
			formData.append("uploadFile", files[i]);
		}
	
		$.ajax({
			url: '/uploadAjaxAction',
				processData: false,
				contentType: false,
				beforeSend: function(xhr){
					xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
				},
				data: formData,
				type: 'POST',
				dataType: 'json',
				success: function(result){
					console.log(result);
					showUploadResult(result); //업로드 결과 처리 함수
				}
		});//$.ajax
	});//change
		
	$(".uploadResult").on("click", "button", function(e){

		console.log("delete file");
		
		var targetFile = $(this).data("file");
		var type = $(this).data("type");
		
		var targetLi = $(this).closest("li");
		
		$.ajax({
			url: '/deleteFile',
			data: {fileName: targetFile, type:type},
			beforeSend: function(xhr){
				xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
			},
			dataType:'text',
			type: 'POST',
				success: function(result){
					alert(result);
					targetLi.remove();
				}
		});//$.ajax
		
	});//x 아이콘 이벤트
	
});//function ready

</script>

<div class="row">
	<div class="col-lg-12">
		<h1 class="page-header">게시글 작성</h1>
	</div>
	<!-- /.col-lg-12 -->
</div>
<!-- /.row -->

<div class="row">
	<div class="col-lg-12">
		<div class="panel panel-default">
			<div class="panel-heading">Board Register</div>		
			<!-- /.panel-heading -->
			<div class="panel-body">
				<form role="form" action="/board/register" method="post">
				
					<!-- CSRF 토큰 설정 -->
					<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }"/>
				
					<div class="form-group">
						<label>Title</label> <input class="form-control" name="title" id="title" onkeydown="checkSpacebar()" autofocus="autofocus" required="required">
					</div>
					
					<div class="form-group">
						<label>Text area</label>
						<textarea class="form-control" rows="3" name='content' id="content" required="required"></textarea>
					</div>
					
					<div class="form-group">
						<label>Writer</label> <input class="form-control" name='writer' value='<sec:authentication property="principal.username"/>' readonly="readonly">
					</div>
					<button type="submit" class="btn btn-default" id="submitBtn">Submit Button</button>
					<button type="reset" class="btn btn-danger">Reset Button</button>
					<a href="../board/list" class="btn btn-info">List</a>
				</form>
			</div>
			<!-- end panel-body -->
		</div>
		<!-- end panel-body -->
	</div>
	<!-- end panel -->
</div>
<!-- /.row -->

<!-- 새로 추가하는 부분, 파일 관련 -->
<div class="row">
	<div class="col-lg-12">
		<div class="panel panel-default">
			<div class="panel-heading">File Attach</div>
			<!-- /.panel-heading -->
			<div class="panel-body">
				<div class="form-group uploadDiv">
					<input type="file" name='uploadFile' multiple>
				</div>
				
			<div class='uploadResult'>
				<ul>
				
				</ul>
			</div>
			</div>
			<!-- end panel-body -->
		</div>
		<!-- end panel-body -->
	</div>
	<!-- end panel -->
</div>
<!-- /.row -->





<script type="text/javascript">

//첫 글자 쓰기 전 까지 스페이스바 금지
function checkSpacebar(){
	
	var kcode = event.keyCode;
	
	if($("#title").val().length < 1){
		if(kcode == 32) event.returnValue = false;	
	}
	
};

</script>




















<%@ include file="../includes/footer.jsp"%>