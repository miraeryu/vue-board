package com.bbs.vue.dao;

import java.util.List;

import javax.annotation.Resource;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.bbs.vue.vo.VueVO;


@Repository("VueDAO")
public class VueDAO {
	
	@Resource(name="sqlSession")
	SqlSession sql;
	
	/**
	 * 전체 목록 조회
	 * @param VueVO
	 * @throws Exception
	 */
	public List<VueVO> allList(VueVO vo) throws Exception {
		return sql.selectList("VueMapper.allList", vo);
	}
	
	/**
	 * 게시물 전체 개수 조회
	 * @param VueVO
	 * @throws Exception
	 */
	public int rowCnt(VueVO vo) throws Exception {
		return sql.selectOne("VueMapper.rowCnt", vo);
	}

	/**
	 * 게시물 상세 조회
	 * @param int
	 * @throws Exception
	 */
	public VueVO readOne(int bbsId) throws Exception {
		return sql.selectOne("VueMapper.readOne", bbsId);
	}

	/**
	 * 게시물 번호 최대값+1을 구하는 메소드
	 * @param 
	 * @throws Exception
	 */
	public int maxBbsId() throws Exception {
		return sql.selectOne("VueMapper.maxBbsId");
	}

	/**
	 * 게시물 등록 / 수정
	 * @param VueVO
	 * @throws Exception
	 */
	public int editPost(VueVO vo) throws Exception {
		return sql.update("VueMapper.editPost", vo);
	}

	/**
	 * 게시물 삭제
	 * @param int
	 * @throws Exception
	 */
	public int deletePost(int bbsId) throws Exception {
		return sql.delete("VueMapper.deletePost", bbsId);
	}

	/**
	 * 게시물 조회수 업데이트
	 * @param int
	 * @throws Exception
	 */
	public int updateReadCnt(int bbsId) throws Exception {
		return sql.update("VueMapper.updateReadCnt", bbsId);
	}

}
