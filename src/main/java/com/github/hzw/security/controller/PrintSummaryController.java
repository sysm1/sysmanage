package com.github.hzw.security.controller;

import java.util.HashMap;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.github.hzw.pulgin.mybatis.plugin.PageView;
import com.github.hzw.security.entity.Resources;
import com.github.hzw.security.service.OrderSummaryService;
import com.github.hzw.util.Common;
import com.github.hzw.util.DateUtil;


@Controller
@RequestMapping("/background/printsummary/")
public class PrintSummaryController extends BaseController {

	@Inject
	private OrderSummaryService orderSummaryService;
	
	
	@RequestMapping("list")
	public String list(Model model, Resources menu, String pageNow) {
		return Common.BACKGROUND_PATH+"/printsummary/list";
	}
	
	
	@ResponseBody
	@RequestMapping("queryPrint")
	public PageView queryPrint(HttpServletRequest request, HttpServletResponse response, String pageNow,String pagesize) {
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("printNum", 0);
		
		map.put("beginTime", DateUtil.beginDate(null));
		map.put("endTime", DateUtil.endDate(null));
		
		map.put("printStatus", "2");
		
		pageView = orderSummaryService.queryPrint(getPageView(pageNow,pagesize), map);
		return pageView;
		
	}
	
	
}
