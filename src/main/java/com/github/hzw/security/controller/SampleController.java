package com.github.hzw.security.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.github.hzw.security.entity.Resources;
import com.github.hzw.util.Common;

/**
 * 开版录入&查询
 * @author wuyb
 */
@Controller
@RequestMapping("/background/sample/")
public class SampleController extends BaseController{
	
	/**
	 * 列表页面
	 * @param model
	 * @param menu
	 * @param pageNow
	 * @return
	 */
	@RequestMapping("list")
	public String list(Model model, Resources menu, String pageNow) {
		return Common.BACKGROUND_PATH+"/sample/list";
	}
	
	/**
	 * 跳转到新增界面
	 * 
	 * @param model
	 * @return
	 */
	@RequestMapping("addUI")
	public String addUI(Model model) {
		model.addAttribute("nowDate", Common.fromDateY());
		return Common.BACKGROUND_PATH+"/sample/add";
	}

}
