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

    @PostConstruct     //�������� ���ԿϷ�Ǹ� ����Ǵ� �ڵ�
    private void init() {
    	chatRoomDTOMap = new LinkedHashMap<>();
    }

    //ä�ù� �ҷ�����
    public List<ChatRoomDTO> findAllRooms(){
        //ä�ù� ���� ���� �ֱ� ������ ��ȯ
        List<ChatRoomDTO> result = new ArrayList<>(chatRoomDTOMap.values());
        Collections.reverse(result);

        return result;
    }

    //ä�ù� �ϳ� �ҷ�����
    public ChatRoomDTO findRoomById(String id){
        return chatRoomDTOMap.get(id);
    }

    //ä�ù� ����
    public ChatRoomDTO createChatRoomDTO(String name){
        ChatRoomDTO room = ChatRoomDTO.create(name);
        chatRoomDTOMap.put(room.getRoomId(), room);

        return room;
    }
}
