package com.bbs.reply.controller;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import com.bbs.reply.service.ReplyService;
import com.bbs.reply.vo.ReplyVO;
import com.bbs.vue.vo.VueVO;

@Controller("/reply")
public class ReplyController {
	
	@Resource(name="replyService")
	private ReplyService replyService;
	
	//수정 폼 이동
	@RequestMapping("/editReplyForm")
	public String editReplyForm(@ModelAttribute VueVO vo, Model model) throws Exception {
		System.out.println(vo.toString());
		
		return "board/editReplyForm.tiles";
	}

}
