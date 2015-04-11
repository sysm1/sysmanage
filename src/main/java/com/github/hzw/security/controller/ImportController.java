package com.github.hzw.security.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.github.hzw.pulgin.mybatis.plugin.PageView;
import com.github.hzw.security.VO.OrderReportClothVO;
import com.github.hzw.security.VO.OrderReportFactoryVO;
import com.github.hzw.security.service.ClothInfoService;
import com.github.hzw.security.service.FactoryInfoService;
import com.github.hzw.security.service.OrderSummaryService;
import com.github.hzw.util.Common;
import com.github.hzw.util.POIUtils;


@Controller
@RequestMapping("/background/report/")
public class ImportController extends BaseController {

	@Resource
	private OrderSummaryService orderSummaryService;
	@Resource
	private ClothInfoService clothInfoService;
	@Resource
	private FactoryInfoService factoryInfoService;
	
	@RequestMapping("exportCloth")
	public String exportCloth(Model model, HttpServletRequest request, HttpServletResponse response, String pageNow,String pagesize) {
		
		Map<String, Object> map = new HashMap<String, Object>();
		String beginTime = request.getParameter("beginTime");
		String endTime = request.getParameter("endTime");
		String clothId = request.getParameter("clothId");
		map.put("beginTime", beginTime);
		map.put("endTime", endTime);
		map.put("clothId", clothId);
		if(StringUtils.isEmpty("pageNow")) {
			pageNow = "1";
		}
		if(StringUtils.isEmpty("pagesize")) {
			pagesize = "10";
		}
		PageView pageView = this.getPageView(pageNow, pagesize);
		model.addAttribute("cloths",clothInfoService.queryAll(null));
		model.addAttribute("pageView",orderSummaryService.queryReportByClothPage(pageView, map));
		
		return Common.BACKGROUND_PATH+"/report/cloth";
	}
	
	@RequestMapping("exportFactory")
	public String exportFactory(Model model, HttpServletRequest request, HttpServletResponse response, String pageNow,String pagesize) {
		Map<String, Object> map = new HashMap<String, Object>();
		String beginTime = request.getParameter("beginTime");
		String endTime = request.getParameter("endTime");
		String factoryId = request.getParameter("factoryId");
		map.put("beginTime", beginTime);
		map.put("endTime", endTime);
		map.put("factoryId", factoryId);
		if(StringUtils.isEmpty("pageNow")) {
			pageNow = "1";
		}
		if(StringUtils.isEmpty("pagesize")) {
			pagesize = "10";
		}
		PageView pageView = this.getPageView(pageNow, pagesize);
		model.addAttribute("factorys",factoryInfoService.queryAll(null));
		model.addAttribute("pageView",orderSummaryService.queryReportByFactoryPage(pageView, map));
		
		return Common.BACKGROUND_PATH+"/report/factory";
	}
	
	@RequestMapping("exportClothExcel")
	public void exportClothExcel(HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> map = new HashMap<String, Object>();
		String beginTime = request.getParameter("beginTime");
		String endTime = request.getParameter("endTime");
		String clothId = request.getParameter("clothId");
		map.put("beginTime", beginTime);
		map.put("endTime", endTime);
		map.put("clothId", clothId);
		List<OrderReportClothVO> acs = orderSummaryService.queryReportByCloth(map);
		POIUtils.exportToExcel(response, "布种报表", acs, OrderReportClothVO.class, "布种", acs.size());
	}
	
	
	@RequestMapping("exportFactoryExcel")
	public void exportFactoryExcel(HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> map = new HashMap<String, Object>();
		String beginTime = request.getParameter("beginTime");
		String endTime = request.getParameter("endTime");
		String factoryId = request.getParameter("factoryId");
		map.put("beginTime", beginTime);
		map.put("endTime", endTime);
		map.put("factoryId", factoryId);
		List<OrderReportFactoryVO> acs = orderSummaryService.queryReportByFactory(map);
		POIUtils.exportToExcel(response, "工厂报表", acs, OrderReportFactoryVO.class, "工厂", acs.size());
	}
	
}
