package org.zerock.controller;

import java.security.Principal;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.zerock.service.ChatRoomService;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;


@Controller
@RequiredArgsConstructor
@RequestMapping("/chat")
@Log4j
public class RoomController {
	
	private final ChatRoomService service;

    //채팅방 목록 조회
    @GetMapping(value = "/rooms")
    public ModelAndView rooms(){	

        log.info("# All Chat Rooms");
        ModelAndView mv = new ModelAndView("chat/rooms");
        mv.addObject("list", service.findAllRooms());
        return mv;
    }

    //채팅방 개설
	@PreAuthorize("hasAnyRole('ROLE_ADMIN','ROLE_MEMBER','ROLE_USER')")
    @PostMapping(value = "/room")
    public String create(@RequestParam String name, RedirectAttributes rttr){

        log.info("# Create Chat Room , name: " + name);
        rttr.addFlashAttribute("roomName", service.createChatRoomDTO(name));
        return "redirect:/chat/rooms";
    }

    //채팅방 조회
	@PreAuthorize("hasAnyRole('ROLE_ADMIN','ROLE_MEMBER','ROLE_USER')")
    @GetMapping("/room")
    public void getRoom(String roomId, Model model, Principal principal){

    	String loginId = principal.getName();
    	log.info(loginId);
    	model.addAttribute("userName", loginId);
    	
        log.info("# get Chat Room, roomID : " + roomId);
        model.addAttribute("room", service.findRoomById(roomId));
        
    }
}
