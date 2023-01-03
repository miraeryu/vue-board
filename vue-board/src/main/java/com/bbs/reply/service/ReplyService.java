package com.bbs.reply.service;

import java.util.List;

import com.bbs.reply.vo.ReplyVO;

public interface ReplyService {

	/*
	 * 0.댓글 조회
	 * 1.댓글 등록
	 * 	1-1.대댓글 등록
	 * 2.댓글 수정
	 * 	2-1.대댓글 수정
	 * 3.댓글 삭제
	 * 	3-1.대댓글 삭제
	 * */
	
	// 게시글에 해당하는 댓글 조회
	public List<ReplyVO> replyList(int bbsId) throws Exception;
	
	// 댓글 1건 조회
	//public ReplyVO vo replyInfo(int replyId) throws Exception;
	
	// 비밀번호 조회
	public String passwordResult(int replyId) throws Exception;
	
	// 새로 입력될 replyId 조회
	public int maxReplyId() throws Exception;
	
	// 댓글 등록+수정
	public int editReply(ReplyVO vo) throws Exception;
	
	// 댓글 삭제
	public int deleteReply(int replyId) throws Exception;
	
	
}
