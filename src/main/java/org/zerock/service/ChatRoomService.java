package org.zerock.service;

import java.util.List;

import org.zerock.domain.ChatRoomDTO;

public interface ChatRoomService {

	public List<ChatRoomDTO> findAllRooms();
	
	public ChatRoomDTO findRoomById(String id);
	
	public ChatRoomDTO createChatRoomDTO(String name);
	
}
