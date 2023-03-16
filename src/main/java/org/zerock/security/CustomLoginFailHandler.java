package org.zerock.security;

import java.io.IOException;


import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.authentication.SimpleUrlAuthenticationFailureHandler;

import lombok.extern.log4j.Log4j;

@Log4j
public class CustomLoginFailHandler extends SimpleUrlAuthenticationFailureHandler  {
	 
	//httpServletRequest -> request �� ���� ���� , httpServletResponse -> response �� ���� ������ �� �ִ� ����
    //AuthenticationException e -> �α��� ���� �� ���ܿ� ���� ������ ��� ����.
	 @Override
	 public void onAuthenticationFailure(HttpServletRequest request, HttpServletResponse response,
	 AuthenticationException exception) throws IOException, ServletException {
		 
	 log.error("==========================================");
	 log.error(exception);
	 
	 
	 
	 if(exception.getMessage().equals("NULL")) {
	 
	 getRedirectStrategy().sendRedirect(request, response, "/notUser");
	 

	 }
	 
	 
	 if(exception.getClass().getName().equals("org.springframework.security.authentication.BadCredentialsException")) {
	 
	 
	 getRedirectStrategy().sendRedirect(request, response, "/badUser");
		 
	 
	 }
	 
	 	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 }

	 
}

