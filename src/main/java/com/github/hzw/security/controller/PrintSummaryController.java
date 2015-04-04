package com.github.hzw.security.controller;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collection;
import java.util.Date;
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
import com.github.hzw.security.entity.FactoryInfo;
import com.github.hzw.security.entity.OrderNotifyInfo;
import com.github.hzw.security.entity.OrderSummary;
import com.github.hzw.security.service.DateVersionService;
import com.github.hzw.security.service.FactoryInfoService;
import com.github.hzw.security.service.OrderNotifyInfoService;
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
	
	@Inject
	private OrderNotifyInfoService orderNotifyInfoService;
	@Inject
	private DateVersionService dateVersionService;
	
	private final String DEFAULTPAGE = "100";
	
	/**
	@RequestMapping("list")
	public String list(Model model, Resources menu, String pageNow) {
		return Common.BACKGROUND_PATH+"/printsummary/list";
	}
	**/
	
	@RequestMapping("list")
	public String list(Model model, HttpServletRequest request, HttpServletResponse response, String pageNow,String pagesize) {
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		// map.put("printNum", 0);
		
		map.put("beginTime", DateUtil.beginDate(null));
		map.put("endTime", DateUtil.endDate(null));
		
		map.put("printStatus", "2");
		
		if(StringUtils.isEmpty(pageNow)) {
			pageNow = "1";
		}
		
		if(StringUtils.isEmpty(pagesize)) {
			pagesize = DEFAULTPAGE;
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
			pagesize = DEFAULTPAGE;
		}
		
		map.put("printNum", 0);
		
		map.put("beginTime", DateUtil.beginDate(null));
		map.put("endTime", DateUtil.endDate(null));
		
		map.put("printStatus", "2");
		
		map.put("printDate", DateUtil.date2Str(new Date(), "yyyy-MM-dd"));
		
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
		model.addAttribute("printDate", DateUtil.date2Str(new Date(), "yyyy-MM-dd"));
		
		return Common.BACKGROUND_PATH+"/printsummary/printnotify";
	}
	
	
	@RequestMapping("printsave")
	public String printsave(Model model, HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("printsave...");
		String[] ids = request.getParameterValues("ids");
		String mark = request.getParameter("mark");
		String factoryId = request.getParameter("factoryId");
		// 生成订单
		String tmp = DateUtil.date2Str(new Date(), "yyyyMMdd");
		int no = dateVersionService.getValue("printsummary", tmp);
		String noString = tmp + Common.prefixFillChar(4, no + "", "0");
		
		OrderNotifyInfo info = new OrderNotifyInfo();
		FactoryInfo factory = factoryInfoService.getById(factoryId);
		info.setCreateTime(new Date());
		info.setFactoryId(factory.getId());
		info.setFactoryName(factory.getName());
		info.setMark(mark);
		StringBuffer tmpIds = new StringBuffer();
		for(String id : ids) {
			tmpIds.append(id).append(",");
		}
		
		info.setSummaryIds(tmpIds.toString());
		info.setNo(noString);
		
		orderNotifyInfoService.save(info);
		
		return this.list(model, request, response, "1", "100");
	}
	
	
}
