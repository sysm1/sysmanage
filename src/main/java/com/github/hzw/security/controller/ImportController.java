package com.github.hzw.security.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

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
import com.github.hzw.security.VO.SampleInputVO;
import com.github.hzw.security.entity.SampleAdditional;
import com.github.hzw.security.service.ClothInfoService;
import com.github.hzw.security.service.FactoryInfoService;
import com.github.hzw.security.service.OrderSummaryService;
import com.github.hzw.security.service.SampleAdditionalService;
import com.github.hzw.security.service.SampleInputService;
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
	@Resource
	private SampleInputService sampleInputService;
	@Resource
	private SampleAdditionalService SampleAdditionalService;
	
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
		// String all = request.getParameter("all");
		// System.out.println("all:" + all);
		map.put("beginTime", beginTime);
		map.put("endTime", endTime);
		map.put("clothId", clothId);
		List<OrderReportClothVO> acs = orderSummaryService.queryReportByCloth(map);
		POIUtils.exportToExcel(response, "下单报表(布种)", acs, OrderReportClothVO.class, "下单报表(布种)", acs.size());
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
		POIUtils.exportToExcel(response, "下单报表(工厂)", acs, OrderReportFactoryVO.class, "下单报表(工厂)", acs.size());
	}
	
	@RequestMapping("list")
	public String list(Model model, HttpServletRequest request, HttpServletResponse response){
		
		return Common.BACKGROUND_PATH+"/report/list";
	}
	
	
	@RequestMapping("exportSampleExcel")
	public void exportSampleExcel(HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> map = new HashMap<String, Object>();
		String beginTime = request.getParameter("beginTime");
		String endTime = request.getParameter("endTime");
		
		map.put("beginTime", beginTime);
		map.put("endTime", endTime);
		
		List<SampleInputVO> acs = sampleInputService.queryReport(map);
		// 组装
		List<SampleAdditional> list = SampleAdditionalService.queryAll(null);
		for(SampleInputVO vo : acs) {
			
			// 处理状态
			switch (vo.getStatus()) {
			case 0:
				vo.setStatusStr("未回");
				break;
			case 1:
				vo.setStatusStr("新版");
				break;
			case 2:
				vo.setStatusStr("新厂");
				break;
			case 3:
				vo.setStatusStr("新色");
				break;
			case 4:
				vo.setStatusStr("重复");
				break;
			default:
				break;
			}
			// key: factoryCode  value: factoryColor... 
			Map<String,List<String>> facotoryCodeMap = new HashMap<String,List<String>>();
			for(SampleAdditional si : list) {
				if(vo.getId().equals(si.getSampleId())) {
					if(null == facotoryCodeMap.get(si.getFactoryCode())){
						facotoryCodeMap.put(si.getFactoryCode(), new ArrayList<String>());
					}
					facotoryCodeMap.get(si.getFactoryCode()).add(si.getFactoryColor());
				}
			}
			
			Set<String> set = facotoryCodeMap.keySet();
			String keys = "";
			String values = "";
			for(String s : set) {
				keys = " " + s;
				values = values + org.apache.commons.lang.StringUtils.join(list.toArray(),",");
			}
			vo.setFactoryCodeStr(keys);
			vo.setFactoryColorStr(values);
			
		}
		
		
		POIUtils.exportToExcel(response, "开版进度查询", acs, SampleInputVO.class, "开版进度查询", acs.size());
	}
	




	
	
}
