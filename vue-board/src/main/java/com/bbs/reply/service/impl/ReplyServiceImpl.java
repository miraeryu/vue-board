package com.bbs.reply.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.bbs.reply.dao.ReplyDAO;
import com.bbs.reply.service.ReplyService;
import com.bbs.reply.vo.ReplyVO;

@Service("replyService")
public class ReplyServiceImpl implements ReplyService {
	
	@Resource(name="replyDAO")
	ReplyDAO replyDAO;
	
	/**
	 * 해당 게시물에 대한 댓글 조회
	 * @param bbsId
	 * @throws Exception
	 * @return List<VueReplyVO>
	 */
	@Override
	public List<ReplyVO> replyList(int bbsId) throws Exception {
		return replyDAO.replyList(bbsId);
	}
	
	/**
	 * 해당 게시물에 대한 댓글 조회
	 * @param bbsId
	 * @throws Exception
	 * @return List<VueReplyVO>
	 */
	@Override
	public ReplyVO replySelect(int replyId) throws Exception {
		return replyDAO.replySelect(replyId);
	}
	
	/**
	 * 댓글 비밀번호 대조
	 * @param replyId
	 * @throws Exception
	 * @return String
	 */
	@Override
	public String passwordResult(int replyId) throws Exception {
		return replyDAO.passwordResult(replyId);
	}
	
	/**
	 * 새로 입력될 replyId값 조회
	 * @return int
	 * @throws Exception
	 */
	@Override
	public int maxReplyId() throws Exception {
		return replyDAO.maxReplyId();
	}

	/**
	 * 댓글 등록+수정
	 * @param vo
	 * @throws Exception
	 * @return int
	 */
	@Override
	public int editReply(ReplyVO vo) throws Exception {
		return replyDAO.editReply(vo);
	}

	/**
	 * 댓글 삭제
	 * @param replyId
	 * @throws Exception
	 * @return int
	 */
	@Override
	public int deleteReply(int replyId) throws Exception {
		return replyDAO.deleteReply(replyId);
	}

}
