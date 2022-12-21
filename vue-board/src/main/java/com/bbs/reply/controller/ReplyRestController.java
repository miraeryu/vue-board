package com.bbs.reply.controller;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.bbs.reply.service.ReplyService;
import com.bbs.reply.vo.ReplyVO;

@RestController
@RequestMapping("/reply")
public class ReplyRestController {
	
	private static final Logger logger = LoggerFactory.getLogger(ReplyRestController.class);
	
	@Resource(name="replyService")
	ReplyService replyService;
	
	// 댓글 입력 ajax
	@RequestMapping("/inAndUp")
	public Map<String, Object> inAndUp(@RequestBody ReplyVO vo) throws Exception {
		logger.info("====================inAndUp ajax====================");
		Map<String, Object> result = new HashMap<String, Object>();
		//	replyId 값이 없는 경우 세팅
		if(vo.getReplyId() == 0) {
			int replyId = replyService.maxReplyId();
			vo.setReplyId(replyId);
		}
		result.put("result", replyService.editReply(vo));
		result.put("reply", replyService.replyList(vo.getBbsId()));
		return result;
	}
	
	// 댓글 삭제 ajax
	@RequestMapping(value = "/delReply", method = RequestMethod.POST)
	public Map<String, Object> delReply(@RequestBody ReplyVO vo) throws Exception {
		logger.info("====================Delete ajax====================");
		Map<String, Object> result = new HashMap<String, Object>();
		// 비밀번호 체크
		String password = replyService.passwordResult(vo.getReplyId());
		if(password.equals(vo.getRplPass())) {
			// 삭제 진행
			result.put("passResult", replyService.deleteReply(vo.getReplyId()));
		} else {
			result.put("passResult", 2);
		}
		result.put("reply", replyService.replyList(vo.getBbsId()));
		return result;
	}
}
