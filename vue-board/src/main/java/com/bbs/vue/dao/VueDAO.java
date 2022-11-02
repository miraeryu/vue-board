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
	
	public List<VueVO> allList(VueVO vo) {
		return sql.selectList("VueMapper.allList", vo);
	}

	public int rowCnt(VueVO vo) {
		return sql.selectOne("VueMapper.rowCnt", vo);
	}

	public VueVO readOne(int bbsId) {
		return sql.selectOne("VueMapper.readOne", bbsId);
	}

	public int newPost(VueVO vo) {
		return sql.insert("VueMapper.newPost", vo);
	}

	public int maxBbsId() {
		return sql.selectOne("VueMapper.maxBbsId");
	}

	public int editPost(VueVO vo) {
		return sql.update("VueMapper.editPost", vo);
	}

	public int deletePost(int bbsId) {
		return sql.delete("VueMapper.deletePost", bbsId);
	}

	public int updateReadCnt(int bbsId) {
		return sql.update("VueMapper.updateReadCnt", bbsId);
	}

}
