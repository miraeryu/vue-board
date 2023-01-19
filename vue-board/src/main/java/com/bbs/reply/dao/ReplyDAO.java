package com.bbs.reply.dao;

import java.util.List;

import javax.annotation.Resource;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.bbs.reply.vo.ReplyVO;

@Repository("replyDAO")
public class ReplyDAO {
	
	@Resource(name="sqlSession")
	SqlSession sql;
	
	/**
	 * 해당 게시물에 대한 댓글 조회
	 * @param bbsId
	 * @throws Exception
	 */
	public List<ReplyVO> replyList(int bbsId) throws Exception {
		return sql.selectList("replyMapper.replyList", bbsId);
	}
	
	/**
	 * 해당 게시물에 대한 댓글 조회
	 * @param 
	 * @throws Exception
	 * @return VueReplyVO
	 */
	public ReplyVO replySelect(int replyId) throws Exception {
		return sql.selectOne("replyMapper.replySelect", replyId);
	}
	
	/**
	 * 댓글 비밀번호 대조
	 * @param replyId
	 * @throws Exception
	 */
	public String passwordResult(int replyId) throws Exception {
		return sql.selectOne("replyMapper.passwordResult", replyId);
	}
	
	/**
	 * 새로 입력될 replyId값 조회
	 * @throws Exception
	 */
	public int maxReplyId() throws Exception {
		return sql.selectOne("replyMapper.maxReplyId");
	}
		
	/**
	 * 댓글 등록+수정
	 * @param vo
	 * @throws Exception
	 */
	public int editReply(ReplyVO vo) throws Exception{
		return sql.update("replyMapper.editReply", vo);
	}
		
	/**
	 * 댓글 삭제
	 * @param replyId
	 * @throws Exception
	 */
	public int deleteReply(int replyId) throws Exception{
		return sql.delete("replyMapper.deleteReply", replyId);
	}
		

}
