package com.bbs.vue.controller;

import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bbs.vue.service.VueService;
import com.bbs.vue.vo.VueVO;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

@Controller
public class VueController {
	
	private static final Logger logger = LoggerFactory.getLogger(VueController.class);
	
	/*
	 * @Resource, @Service등 어노테이션 뒤에 name 입력 반드시 할것
	 */
	@Resource(name="vueService")
	private VueService vueService;
	
	// 조회 메인 페이지
	@RequestMapping("/list")
	public String list(@ModelAttribute VueVO vo, Model model) throws Exception {
		System.out.println("category : " + vo.getCategory() + ", keyword : " + vo.getKeyword() + ", page : " + vo.getNowPage());
		ObjectMapper mapper = new ObjectMapper();
		logger.info("=========================List========================="); 
		vo.setAllPostCnt(vueService.rowCnt(vo));				//전체 행 개수 세팅
		System.out.println(vueService.rowCnt(vo));
		if (vo.getNowPage() == 0) {							// 처음 로딩할 경우
			vo.setNowPage(1);
		}
		/*
		int endPage = ((int) Math.ceil((double)vo.getNowPage()/(double)vo.getDisplayPage())) * 3;
		int startPage = endPage -2;
		vo.setStartPage(startPage);
		if (endPage > vo.getMaxPageCnt()) {
			vo.setEndPage(vo.getMaxPageCnt());
		} else {
			vo.setEndPage(endPage);
		}
		*/
		if(vo.getCategory() == null) {
			vo.setCategory("all");
		}
		model.addAttribute("list", mapper.writeValueAsString(vueService.allList(vo)));
		model.addAttribute("info", mapper.writeValueAsString(vo));
		return "board/list.tiles";
	}
	
	/*
	 * REST API는 Controller를 분리함
	 * ResponseEntity는 boot에서 일반적으로 쓰고
	 * Map<String, Object> 형식으로 받아오는것도 알아두기~
	 */
	// 아작스로 검색 데이터 다시 불러오는 메소드
	/*
	@RequestMapping("/listLoad")
	public ResponseEntity<List<VueVO>> listLoad(@ModelAttribute VueVO vo) throws Exception {
		logger.info("=========================Load=========================");
		System.out.println("category : " + vo.getCategory() + ", keyword : " + vo.getKeyword() + ", page : " + vo.getNowPage());
		List<VueVO> list = vueService.allList(vo);
		System.out.println(list.get(0).getNowPage());
		return new ResponseEntity<List<VueVO>>(list, HttpStatus.OK);
	}
	*/
	
	@ResponseBody
	@RequestMapping("/listLoad2")
	public List<VueVO> listLoad2(@RequestBody VueVO vo) throws Exception {
		System.out.println("category : " + vo.getCategory() + ", keyword : " + vo.getKeyword() + ", page : " + vo.getNowPage());
		List<VueVO> list = vueService.allList(vo);
		System.out.println(list);
		return list;
	}
	
	// 상세보기
	@RequestMapping("/readPost")
	public String readPost(@ModelAttribute VueVO vo, Model model) throws Exception {
		System.out.println("category : " + vo.getCategory() + ", keyword : " + vo.getKeyword() + ", page : " + vo.getNowPage());
		ObjectMapper mapper = new ObjectMapper();
        
        logger.info("=========================Read=========================");
		String readPost = mapper.writeValueAsString(vueService.readOne(vo.getBbsId()));
		model.addAttribute("post", readPost);
		model.addAttribute("vo", mapper.writeValueAsString(vo));
		if (readPost != null) {
			vueService.updateReadCnt(vo.getBbsId());
			logger.info("======================ViewUpdate======================");
		}
		return "board/readPost.tiles";
	}
	
	// 글 등록/수정 폼
	@RequestMapping("/editForm")
	public String editForm(@ModelAttribute VueVO vo, Model model) throws Exception {
		ObjectMapper mapper = new ObjectMapper();
		System.out.println("category : " + vo.getCategory() + ", keyword : " + vo.getKeyword() + ", page : " + vo.getNowPage());
		logger.info("======================editForm======================");
		VueVO read = new VueVO();
		if(vo.getBbsId() != 0) {
			read = vueService.readOne(vo.getBbsId());
			read.setCategory(vo.getCategory());
			read.setKeyword(vo.getKeyword());
			read.setNowPage(vo.getNowPage());
			model.addAttribute("post", mapper.writeValueAsString(read));
		}else {
			model.addAttribute("post", mapper.writeValueAsString(vo));
		}
		return "board/editForm.tiles";
	}
	
	// 글 등록/수정
	@ResponseBody
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
	@ResponseBody
	@RequestMapping("/deletePost")
	public int deletePost(@RequestParam("bbsId") int bbsId) throws Exception {
		logger.info("=========================Delete=========================");
		int result = vueService.deletePost(bbsId);
		return result;
	}
	
	
}
