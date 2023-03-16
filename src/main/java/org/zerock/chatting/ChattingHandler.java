package org.zerock.chatting;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
public class ChattingHandler extends TextWebSocketHandler{

private List<WebSocketSession> sessionList = new ArrayList<WebSocketSession>();
	
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
				
//		log.info("#ChattingHandler, afterConnectionEstablished");
		sessionList.add(session);
		
		log.info(session.getPrincipal().getName() + "´ÔÀÌ ÀÔÀåÇÏ¼Ì½À´Ï´Ù.");
		System.out.println(session.getPrincipal().getName()+ "´Ô ÀÔÀå");
	}
	
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		
//		log.info("#ChattingHandler, handleMessage");
		log.info(session.getId() + ": " + message);
		System.out.println("¼¼¼Ç ¾ÆÀÌµð" + session.getId() + "¸Þ¼¼Áö" + message);
		
		for(WebSocketSession s : sessionList) {
			s.sendMessage(new TextMessage(session.getPrincipal().getName() + ":" + message.getPayload()));
		}
	}
	
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		
//		log.info("#ChattingHandler, afterConnectionClosed");

		sessionList.remove(session);
		
		log.info(session.getPrincipal().getName() + "´ÔÀÌ ÅðÀåÇÏ¼Ì½À´Ï´Ù.");
		System.out.println(session.getPrincipal().getName()+ "´Ô ÅðÀå");

	}
}