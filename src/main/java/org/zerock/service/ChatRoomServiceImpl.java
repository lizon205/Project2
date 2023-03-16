package org.zerock.service;

import java.util.ArrayList;
import java.util.Collections;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.PostConstruct;

import org.springframework.stereotype.Service;
import org.zerock.domain.ChatRoomDTO;

@Service
public class ChatRoomServiceImpl implements ChatRoomService {
	
	private Map<String, ChatRoomDTO> chatRoomDTOMap;

    @PostConstruct     //의존관게 주입완료되면 실행되는 코드
    private void init() {
    	chatRoomDTOMap = new LinkedHashMap<>();
    }

    //채팅방 불러오기
    public List<ChatRoomDTO> findAllRooms(){
        //채팅방 생성 순서 최근 순으로 반환
        List<ChatRoomDTO> result = new ArrayList<>(chatRoomDTOMap.values());
        Collections.reverse(result);

        return result;
    }

    //채팅방 하나 불러오기
    public ChatRoomDTO findRoomById(String id){
        return chatRoomDTOMap.get(id);
    }

    //채팅방 생성
    public ChatRoomDTO createChatRoomDTO(String name){
        ChatRoomDTO room = ChatRoomDTO.create(name);
        chatRoomDTOMap.put(room.getRoomId(), room);

        return room;
    }
}
