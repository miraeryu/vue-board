package com.bbs.vue.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.transaction.annotation.EnableTransactionManagement;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.bbs.vue.service.VueService;
import com.bbs.vue.vo.VueVO;

@EnableTransactionManagement
@RestController
public class VueRestController {
	
	
	/*
	 * REST API는 Controller를 분리함
	 * ResponseEntity는 boot에서 일반적으로 쓰고
	 * Map<String, Object> 형식으로 받아오는것도 알아두기~
	 */
	
	
	private static final Logger logger = LoggerFactory.getLogger(VueController.class);
	
	@Resource(name="vueService")
	private VueService vueService;
	
	// 페이지 전환 시 ajax
	@RequestMapping("/listLoad2")
	public Map<String, Object> listLoad2(@RequestBody VueVO vo) throws Exception {
		System.out.println("category : " + vo.getCategory() + ", keyword : " + vo.getKeyword() + ", page : " + vo.getNowPage());
		Map<String, Object> result = new HashMap<String, Object>();
		logger.info("=========================ajax========================="); 
		vo.setAllPostCnt(vueService.rowCnt(vo));				// 전체 행 개수 세팅

		// 페이지 Array 만들기
		ArrayList<Integer> newPages = new ArrayList<Integer>();
		if (vo.getNowPage() == 1) {
			for(int i = 1; i <= 3; i++) {
				if (i <= vo.getMaxPageCnt()) {
					newPages.add(i);
				}
			}
		} else {
			if(vo.getNowPage() == vo.getMaxPageCnt()) {
				for (int i = (vo.getMaxPageCnt()-2); i <= vo.getMaxPageCnt() ; i++ ) {
					if (i > 0) {
						newPages.add(i);
					}
				}
			} else {
				for (int i = (vo.getNowPage() -1); i <= (vo.getNowPage()+1); i++) {
					newPages.add(i);
				}
			}
		}
		vo.setPages(newPages);				// 만든 pages 세팅
		
		List<VueVO> list = vueService.allList(vo);
		VueVO info = vo;
		// Map에 데이터 담기
		result.put("list", list);
		result.put("info", info);
		return result;
	}
	
	
	// 글 등록/수정
	@RequestMapping(value = "/editPost", method = RequestMethod.POST)
	public int editPost(@RequestBody VueVO vo) throws Exception {
		logger.info("===================UpdateAndInsert===================");
		if(vo.getBbsId() == 0) {
			vo.setBbsId(vueService.maxBbsId());
		}
		//insert와 update를 한꺼번에 하는 쿼리
		int result = vueService.editPost(vo);		
		return result;
	}
	
	// 글 삭제
	@Transactional
	@RequestMapping(value="/deletePost", method = RequestMethod.POST)
	public int deletePost(@RequestBody List<VueVO> list) throws Exception {
		logger.info("=========================Delete=========================");
		System.out.println(list);
		for (VueVO vo:list) {
			vueService.deletePost(vo.getBbsId());
			vueService.allList(vo);
		}
//		int result = vueService.deletePost(bbsId);
		return 0;
	}
	
}
