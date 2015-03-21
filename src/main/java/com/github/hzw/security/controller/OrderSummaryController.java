package com.github.hzw.security.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.github.hzw.pulgin.mybatis.plugin.PageView;
import com.github.hzw.security.entity.OrderSummary;
import com.github.hzw.security.entity.Resources;
import com.github.hzw.security.service.OrderSummaryService;
import com.github.hzw.util.Common;
import com.github.hzw.util.POIUtils;

@Controller
@RequestMapping("/background/ordersummary/")
public class OrderSummaryController extends BaseController {

	@Inject
	private OrderSummaryService orderSummaryService;
	
	@RequestMapping("list")
	public String list(Model model, Resources menu, String pageNow) {
		return Common.BACKGROUND_PATH+"/ordersummary/list";
	}
	
	/**
	 * @param model
	 * 存放返回界面的model
	 * @return
	 */
	@ResponseBody
	@RequestMapping("query")
	public PageView query(OrderSummary info,String pageNow,String pagesize) {
		pageView = orderSummaryService.query(getPageView(pageNow,pagesize), info);
		return pageView;
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
	public Map<String, Object> add(OrderSummary info) {
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			orderSummaryService.add(info);
			map.put("flag", "true");
		} catch (Exception e) {
			map.put("flag", "false");
			e.printStackTrace();
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
		return Common.BACKGROUND_PATH+"/ordersummary/add";
	}
	

	/**
	 * 跑到新增界面
	 * 
	 * @param model
	 * @return
	 */
	@RequestMapping("editUI")
	public String editUI(Model model,String id) {
		OrderSummary info = orderSummaryService.getById(id);
		model.addAttribute("summary", info);
		return Common.BACKGROUND_PATH+"/ordersummary/edit";
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
	public Map<String, Object> update(Model model, OrderSummary info) {
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			orderSummaryService.update(info);
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
					orderSummaryService.delete(string);
				}
			}
			map.put("flag", "true");
		} catch (Exception e) {
			map.put("flag", "false");
		}
		return map;
	}
	
	@RequestMapping("exportExcel")
	public void exportExcel(HttpServletResponse response,OrderSummary info) {
		 List<OrderSummary> acs = orderSummaryService.queryAll(info);
		POIUtils.exportToExcel(response, "下单汇总报表", acs, OrderSummary.class, "下单汇总", acs.size());
	}
	
}
