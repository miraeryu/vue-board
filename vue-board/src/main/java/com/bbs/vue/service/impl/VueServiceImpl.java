package com.bbs.vue.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.bbs.vue.dao.VueDAO;
import com.bbs.vue.service.VueService;
import com.bbs.vue.vo.VueVO;

@Service("vueService")
public class VueServiceImpl implements VueService {
	
	@Resource(name="VueDAO")
	VueDAO vueDAO;
	
	/**
	 * 전체 목록 조회
	 * @param VueVO
	 * @throws Exception
	 * @return List<VueVO>
	 */
	@Override
	public List<VueVO> allList(VueVO vo) throws Exception {
		return vueDAO.allList(vo);
	}
	
	/**
	 * 게시물 전체 개수 조회
	 * @param VueVO
	 * @throws Exception
	 * @return int
	 */
	@Override
	public int rowCnt(VueVO vo) throws Exception {
		return vueDAO.rowCnt(vo);
	}
	
	/**
	 * 게시물 상세 조회
	 * @param VueVO
	 * @throws Exception
	 * @return VueVO
	 */
	@Override
	public VueVO readOne(int bbsId) throws Exception {
		return vueDAO.readOne(bbsId);
	}
	
	/**
	 * 게시물 번호 최대값+1을 구하는 메소드
	 * @param 
	 * @throws Exception
	 * @return int
	 */
	@Override
	public int maxBbsId() throws Exception {
		return vueDAO.maxBbsId();
	}

	/**
	 * 게시물 등록 / 수정
	 * @param VueVO
	 * @throws Exception
	 * @return int
	 */
	@Override
	public int editPost(VueVO vo) throws Exception {
		return vueDAO.editPost(vo);
	}

	/**
	 * 게시물 삭제
	 * @param int
	 * @throws Exception
	 * @return int
	 */
	@Override
	public int deletePost(int bbsId) throws Exception {
		return vueDAO.deletePost(bbsId);
	}

	/**
	 * 게시물 조회수 업데이트
	 * @param int
	 * @throws Exception
	 * @return int
	 */
	@Override
	public int updateReadCnt(int bbsId) throws Exception {
		return vueDAO.updateReadCnt(bbsId);
	}

}
