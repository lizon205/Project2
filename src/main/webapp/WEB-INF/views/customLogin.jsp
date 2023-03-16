<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"  %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"  %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<!-- Bootstrap Core CSS -->
<link href="/resources/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">

<!-- MetisMenu CSS -->
<link href="/resources/vendor/metisMenu/metisMenu.min.css" rel="stylesheet">

<!-- Custom CSS -->
<link href="/resources/dist/css/sb-admin-2.css" rel="stylesheet">

<!-- Custom Fonts -->
<link href="/resources/vendor/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">

</head>

<body>

    <div class="container">
        <div class="row">
            <div class="col-md-4 col-md-offset-4">
                <div class="login-panel panel panel-default">
                    <div class="panel-heading">
                        <h3 class="panel-title">Please Sign In</h3>
                    </div>
                    <div class="panel-body">
                        <form role="form" method='post' action="/login">
                            <fieldset>
                                <div class="form-group">
                                    <input class="form-control" placeholder="userid" name="username" type="text" autofocus>
                                </div>
                                <div class="form-group">
                                    <input class="form-control" placeholder="Password" name="password" type="password" value="" onkeyup="enterkey()">
                                </div>
                                <div class="checkbox">
                                    <label>
                                        <input name="remember-me" type="checkbox">Remember Me
                                    </label>
                                </div>
                                
									
	                                <c:if test='${msg!=null}'>
	                                	<div class="alert alert-danger">
												<p><c:out value='${msg}'/></p>
										</div>
									</c:if>

                                
                                
                                <!-- Change this to a button or input when using this as a form -->
                                <a href="/board/list" class="btn btn-lg btn-success btn-block">Login</a>
                            </fieldset>
                            <input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
                        </form>
                        <br/>
                        <a href="/board/list" class="btn btn-info">List</a>  <a href="/member/create" class="btn btn-danger">Create Account</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
	
	

	<!-- jQuery -->
    <script src="/resources/vendor/jquery/jquery.min.js"></script>

    <!-- Bootstrap Core JavaScript -->
    <script src="/resources/vendor/bootstrap/js/bootstrap.min.js"></script>

    <!-- Metis Menu Plugin JavaScript -->
    <script src="/resources/vendor/metisMenu/metisMenu.min.js"></script>

    <!-- Custom Theme JavaScript -->
    <script src="/resources/dist/js/sb-admin-2.js"></script>

	<script>
	$(".btn-success").on("click", function(e){
		
		e.preventDefault();
		$("form").submit();
		
	});
	
	
	
	//엔터키로도 보내보자
	function enterkey() {
		if (window.event.keyCode == 13) {   
			$("form").submit();s
	    }
	};
	</script>

</body>

</html>
