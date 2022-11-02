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

	@Override
	public List<VueVO> allList(VueVO vo) {
		return vueDAO.allList(vo);
	}

	@Override
	public int rowCnt(VueVO vo) {
		return vueDAO.rowCnt(vo);
	}

	@Override
	public VueVO readOne(int bbsId) {
		return vueDAO.readOne(bbsId);
	}

	@Override
	public int newPost(VueVO vo) {
		return vueDAO.newPost(vo);
	}

	@Override
	public int maxBbsId() {
		return vueDAO.maxBbsId();
	}

	@Override
	public int editPost(VueVO vo) {
		return vueDAO.editPost(vo);
	}

	@Override
	public int deletePost(int bbsId) {
		return vueDAO.deletePost(bbsId);
	}

	@Override
	public int updateReadCnt(int bbsId) {
		return vueDAO.updateReadCnt(bbsId);
	}

}
