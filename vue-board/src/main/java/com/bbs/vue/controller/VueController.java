package com.bbs.vue.controller;

import java.util.List;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import com.bbs.vue.service.VueService;
import com.bbs.vue.vo.VueVO;

@Controller
public class VueController {
	
	private static final Logger logger = LoggerFactory.getLogger(VueController.class);
	
	@Resource
	private VueService vueService;
	
	@RequestMapping("/list")
	public String list(@ModelAttribute VueVO vo, Model model) {
		logger.info("=========================list============================");
		model.addAttribute(vueService.allList(vo));
		return "board/list.tiles";
	}
	
	@RequestMapping("/listLoad")
	public ResponseEntity<List<VueVO>> listLoad(@ModelAttribute VueVO vo) {
		logger.info("=========================Load============================");
		System.out.println("category : " + vo.getCategory() + ", keyword : " + vo.getKeyword());
		List<VueVO> list = vueService.allList(vo);
		return new ResponseEntity<List<VueVO>>(list, HttpStatus.OK);
	}
	
	@RequestMapping("/readPost")
	public String readPost(@ModelAttribute VueVO vo, Model model) {
		VueVO readPost = vueService.readOne(vo.getBbsId());
		model.addAttribute("post", readPost);
		model.addAttribute("vo", vo);
		if (readPost != null) {
			vueService.updateReadCnt(vo.getBbsId());
			logger.info("***********조회 수 업데이트**********");
		}
		return "board/readPost.tiles";
	}
	
}
