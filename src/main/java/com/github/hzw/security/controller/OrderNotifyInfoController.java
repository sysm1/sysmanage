package com.github.hzw.security.controller;

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
import com.github.hzw.security.entity.Account;
import com.github.hzw.security.entity.ClothAllowance;
import com.github.hzw.security.entity.OrderNotifyInfo;
import com.github.hzw.security.entity.OrderSummary;
import com.github.hzw.security.service.ClothInfoService;
import com.github.hzw.security.service.FactoryInfoService;
import com.github.hzw.security.service.OrderNotifyInfoService;
import com.github.hzw.security.service.OrderSummaryService;
import com.github.hzw.security.service.PasswordService;
import com.github.hzw.security.service.RecordLogService;
import com.github.hzw.security.service.TechnologyInfoService;
import com.github.hzw.util.Common;
import com.github.hzw.util.DateUtil;
import com.github.hzw.util.POIUtils;

@Controller
@RequestMapping("/background/notify/")
public class OrderNotifyInfoController extends BaseController {

	@Inject
	private OrderNotifyInfoService orderNotifyInfoService;
	@Inject
	private FactoryInfoService factoryInfoService;
	@Inject
	private OrderSummaryService orderSummaryService;
	@Inject
	private ClothInfoService clothInfoService;
	@Inject
	private TechnologyInfoService technologyInfoService;
	
	@Inject
	private RecordLogService recordLogService;
	
	@Inject
	private PasswordService passwordService;
	
	
	/**
	@RequestMapping("list")
	public String list(Model model, Resources menu, String pageNow) {
		model.addAttribute("factorys",factoryInfoService.queryAll(null));
		return Common.BACKGROUND_PATH+"/notify/list";
	}
	**/
	
	
	
	/**
	 * @param model
	 * 存放返回界面的model
	 * @return
	 */
	@ResponseBody
	@RequestMapping("query")
	public PageView query(OrderNotifyInfo info,String pageNow,String pagesize) {
		pageView = orderNotifyInfoService.query(getPageView(pageNow,pagesize), info);
		return pageView;
	}
	
	@ResponseBody
	@RequestMapping("queryFind")
	public PageView queryFind(HttpServletRequest request, HttpServletResponse response,String pageNow,String pagesize) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("factoryId", request.getParameter("factoryId"));
		map.put("clothId", request.getParameter("clothId"));
		map.put("factoryId", request.getParameter("factoryId"));
		map.put("factoryCode", request.getParameter("factoryCode"));
		map.put("factoryColor", request.getParameter("factoryColor"));
		map.put("beginTime", DateUtil.str2Date(request.getParameter("beginTime"), "yyyy-MM-dd hh:mm:ss"));
		map.put("endTime", DateUtil.str2Date(request.getParameter("endTime"), "yyyy-MM-dd hh:mm:ss"));
		pageView = orderNotifyInfoService.queryFind(getPageView(pageNow,pagesize), map);
		return pageView;
	}
	
	// @ResponseBody
	@RequestMapping("list")
	public String querynotify(Model model, HttpServletRequest request, HttpServletResponse response, String pageNow,String pagesize) {
		
		if(StringUtils.isEmpty(pageNow)) {
			pageNow = "1";
		}
		
		if(StringUtils.isEmpty(pagesize)) {
			pagesize = "100";
		}
		Account account = (Account) request.getSession().getAttribute("userSession");
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("clothId", request.getParameter("clothId"));
		map.put("factoryId", request.getParameter("factoryId"));
		map.put("cityId", account.getCityId());
		map.put("printStatus", "1");
		map.put("technologyId", request.getParameter("technologyId"));
		map.put("factoryCode", request.getParameter("factoryCode"));
		map.put("factoryColor", request.getParameter("factoryColor"));
		
		map.put("beginTime", DateUtil.str2Date(request.getParameter("beginTime"), "yyyy-MM-dd"));
		map.put("endTime", DateUtil.str2Date(request.getParameter("endTime"), "yyyy-MM-dd"));
		PageView pageView = getPageView(pageNow,pagesize);
		pageView = orderSummaryService.queryNotify(getPageView(pageNow,pagesize), map);
		
		model.addAttribute("pageView", pageView);
		
		model.addAttribute("cloths",clothInfoService.queryAll(null));
		model.addAttribute("factorys",factoryInfoService.queryAll(null));
		model.addAttribute("technologys",technologyInfoService.queryAll(null));
		
		model.addAttribute("model", map);
		
		
		// 今天的
		int recordCount = recordLogService.sum("notify", "cancel");
		model.addAttribute("recordCount", recordCount);
		// model.addAttribute("recordCount", 6);
		int num = passwordService.getNum();
		model.addAttribute("num", num);
		
		return Common.BACKGROUND_PATH+"/notify/list";
	}
	
	
	/**
	 * 保存数据
	 * 
	 * @param model
	 * @param videoType
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping("add")
	@ResponseBody
	public Map<String, Object> add(OrderNotifyInfo info) {
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			info.setCreateTime(new Date());
			orderNotifyInfoService.add(info);
			map.put("flag", "true");
		} catch (Exception e) {
			map.put("flag", "false");
		}
		return map;
	}

	
	/**
	 * 跑到新增界面
	 * 
	 * @param model
	 * @return
	 */
	@RequestMapping("addUI")
	public String addUI() {
		return Common.BACKGROUND_PATH+"/notify/add";
	}
	

	/**
	 * 跑到新增界面
	 * 
	 * @param model
	 * @return
	 */
	@RequestMapping("editUI")
	public String editUI(Model model,String id) {
		OrderNotifyInfo info = orderNotifyInfoService.getById(id);
		model.addAttribute("notify", info);
		return Common.BACKGROUND_PATH+"/notify/edit";
	}
	
	
	/**
	 * 更新类型
	 * 
	 * @param model
	 * @return
	 * @throws Exception 
	 */
	@ResponseBody
	@RequestMapping("update")
	public Map<String, Object> update(Model model, OrderNotifyInfo info) {
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			orderNotifyInfoService.update(info);
			map.put("flag", "true");
		} catch (Exception e) {
			map.put("flag", "false");
		}
		return map;
	}
	
	/**
	 * 删除
	 * 
	 * @param model
	 * @param videoTypeId
	 * @return
	 * @throws Exception 
	 */
	@ResponseBody
	@RequestMapping("deleteById")
	public Map<String, Object> deleteById(Model model, String ids) {
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			String id[] = ids.split(",");
			for (String string : id) {
				if(!Common.isEmpty(string)){
					orderNotifyInfoService.delete(string);
				}
			}
			map.put("flag", "true");
		} catch (Exception e) {
			map.put("flag", "false");
		}
		return map;
	}
	
	@RequestMapping("exportExcel")
	public void exportExcel(HttpServletResponse response,OrderNotifyInfo info) {
		 List<OrderNotifyInfo> acs = orderNotifyInfoService.queryAll(info);
		POIUtils.exportToExcel(response, "下单通知报表", acs, ClothAllowance.class, "下单通知", acs.size());
	}
	
	@ResponseBody
	@RequestMapping("cancel")
	public Map<String, Object> cancel(Model model, String ids) {
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			String id[] = ids.split(",");
			orderNotifyInfoService.cancel(id);
			map.put("flag", "true");
		} catch (Exception e) {
			map.put("flag", "false");
		}
		return map;
	}
	
	@RequestMapping("detail")
	public String detail(Model model,String id) {
		
		OrderNotifyInfo info = orderNotifyInfoService.getById(id);
		List<OrderSummary> list = orderSummaryService.query(id);
		
		model.addAttribute("notify", info);
		model.addAttribute("list", list);
		model.addAttribute("factory", factoryInfoService.getById(info.getFactoryId() + ""));
		
		return Common.BACKGROUND_PATH+"/notify/detail";
	}
	
	
}
