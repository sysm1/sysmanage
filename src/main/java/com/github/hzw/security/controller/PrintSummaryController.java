package com.github.hzw.security.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.github.hzw.pulgin.mybatis.plugin.PageView;
import com.github.hzw.security.entity.OrderSummary;
import com.github.hzw.security.service.FactoryInfoService;
import com.github.hzw.security.service.OrderSummaryService;
import com.github.hzw.util.Common;
import com.github.hzw.util.DateUtil;


@Controller
@RequestMapping("/background/printsummary/")
public class PrintSummaryController extends BaseController {

	@Inject
	private OrderSummaryService orderSummaryService;
	
	@Inject
	private FactoryInfoService factoryInfoService;
	
	/**
	@RequestMapping("list")
	public String list(Model model, Resources menu, String pageNow) {
		return Common.BACKGROUND_PATH+"/printsummary/list";
	}
	**/
	
	@RequestMapping("list")
	public String list(Model model, HttpServletRequest request, HttpServletResponse response, String pageNow,String pagesize) {
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("printNum", 0);
		
		map.put("beginTime", DateUtil.beginDate(null));
		map.put("endTime", DateUtil.endDate(null));
		
		map.put("printStatus", "2");
		
		if(StringUtils.isEmpty(pageNow)) {
			pageNow = "1";
		}
		
		if(StringUtils.isEmpty(pagesize)) {
			pagesize = "100";
		}
		
		pageView = orderSummaryService.queryPrint(getPageView(pageNow,pagesize), map);
		model.addAttribute("pageView", pageView);
		
		
		return Common.BACKGROUND_PATH+"/printsummary/list";
		
	}
	
	@ResponseBody
	@RequestMapping("queryPrint")
	public PageView queryPrint(HttpServletRequest request, HttpServletResponse response, String pageNow,String pagesize) {
		
		Map<String, Object> map = new HashMap<String, Object>();
		if(StringUtils.isEmpty(pageNow)) {
			pageNow = "1";
		}
		
		if(StringUtils.isEmpty(pagesize)) {
			pagesize = "100";
		}
		
		map.put("printNum", 0);
		
		map.put("beginTime", DateUtil.beginDate(null));
		map.put("endTime", DateUtil.endDate(null));
		
		map.put("printStatus", "2");
		
		pageView = orderSummaryService.queryPrint(getPageView(pageNow,pagesize), map);
		return pageView;
		
	}
	
	// @ResponseBody
	@RequestMapping("demo")
	public String demo() {
		return Common.BACKGROUND_PATH+"/printsummary/demo";
	}
	
	@RequestMapping("printnotify")
	public String printnotify(Model model, HttpServletRequest request, HttpServletResponse response) {
		
		String ids = request.getParameter("ids");
		if(StringUtils.isEmpty(ids)) {
			throw new RuntimeException("打印订单不能为空");
		}
		String factoryId = request.getParameter("factoryId");
		if(StringUtils.isEmpty(factoryId)) {
			throw new RuntimeException("工厂不能为空");
		}
		List<OrderSummary>  list = new ArrayList<OrderSummary>();
		String[] arrayIds = ids.split("[,]");
		for(String id : arrayIds) {
			list.add(orderSummaryService.getById(id));
		}
		
		model.addAttribute("list", list);
		model.addAttribute("factory", factoryInfoService.getById(factoryId));
		
		return Common.BACKGROUND_PATH+"/printsummary/printnotify";
	}
	
	
	@RequestMapping("printsave")
	public String printsave(Model model, HttpServletRequest request, HttpServletResponse response) {
		
		System.out.println("printsave...");
		String ids = request.getParameter("ids");
		String mark = request.getParameter("mark");
		System.out.println("ids:" + ids);
		System.out.println("mark:" + mark);
		
		return this.list(model, request, response, "1", "100");
	}
	
	
}
