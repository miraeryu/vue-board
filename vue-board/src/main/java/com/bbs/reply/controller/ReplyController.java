package com.bbs.reply.controller;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import com.bbs.reply.service.ReplyService;
import com.bbs.reply.vo.ReplyVO;
import com.fasterxml.jackson.databind.ObjectMapper;

@Controller("/reply")
public class ReplyController {
	
	@Resource(name="replyService")
	private ReplyService replyService;
	
	//수정 폼 이동
	@RequestMapping("/editReplyForm")
	public String editReplyForm(@ModelAttribute ReplyVO vo, Model model) throws Exception {
		System.out.println(vo.getReplyId());
		ObjectMapper mapper = new ObjectMapper();
		model.addAttribute("reply", mapper.writeValueAsString(replyService.replySelect(vo.getReplyId())));
		return "board/editReplyForm.tiles";
	}

}
