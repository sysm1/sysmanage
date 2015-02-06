package com.github.hzw.security.controller;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.github.hzw.pulgin.mybatis.plugin.PageView;
import com.github.hzw.security.entity.Log;
import com.github.hzw.security.entity.Resources;
import com.github.hzw.security.service.LogService;
import com.github.hzw.util.Common;

@Controller
@RequestMapping("/background/log/")
public class LogController extends BaseController{
	@Inject
	private LogService logService;
	
	/**
	 * 查询客户登陆信息
	 * @param model
	 * @param log
	 * @param pageNow
	 * @return
	 */
	@ResponseBody
	@RequestMapping("query")
	public PageView queryUserLogin(Log log,String pageNow,String pagesize){
		pageView = logService.query(getPageView(pageNow,pagesize), log);
		return pageView;
	}
	@RequestMapping("list")
	public String list(Model model, Resources menu, String pageNow) {
		return Common.BACKGROUND_PATH+"/log/list";
	}
}
