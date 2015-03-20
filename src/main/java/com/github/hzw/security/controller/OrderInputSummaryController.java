package com.github.hzw.security.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.github.hzw.pulgin.mybatis.plugin.PageView;
import com.github.hzw.security.VO.OrderInputSummaryVO;
import com.github.hzw.security.entity.OrderInputSummary;
import com.github.hzw.security.entity.Resources;
import com.github.hzw.security.service.OrderInputService;
import com.github.hzw.security.service.OrderInputSummaryService;
import com.github.hzw.util.Common;
import com.github.hzw.util.POIUtils;

@Controller
@RequestMapping("/background/inputsummary/")
public class OrderInputSummaryController extends BaseController {

	@Inject
	private OrderInputSummaryService orderInputSummaryService;
	
	@Inject
	private OrderInputService orderInputService;
	
	@RequestMapping("list")
	public String list(Model model, Resources menu,HttpServletRequest request, String pagesize,OrderInputSummary info) {
		String pageNow=request.getParameter("pageNow");
		pageView = orderInputSummaryService.queryVO(getPageView(pageNow,pagesize), info);
		model.addAttribute("pageView", pageView);
		return Common.BACKGROUND_PATH+"/inputsummary/list";
	}
	
	/**
	 * @param model
	 * 存放返回界面的model
	 * @return
	 */
	@ResponseBody
	@RequestMapping("query")
	public PageView query(OrderInputSummary info,String pageNow,String pagesize) {
		pageView = orderInputSummaryService.query(getPageView(pageNow,pagesize), info);
		return pageView;
	}
	
	/**
	 * @param model
	 * 存放返回界面的model
	 * @return
	 */
	@SuppressWarnings("unchecked")
	@ResponseBody
	@RequestMapping("queryList")
	public List<OrderInputSummaryVO> queryList(OrderInputSummary info,String pageNow,String pagesize,String id) {
		//pageView = orderInputSummaryService.queryVO(getPageView(pageNow,"100"), info);
		pageView= orderInputSummaryService.queryOrderInputBySummaryId(getPageView(pageNow,"100"), info);
		return pageView.getRecords();
	}
	
	/**
	 * @param model
	 * 查询下单预录入详单
	 * @return
	 */
	@SuppressWarnings("unchecked")
	@ResponseBody
	@RequestMapping("queryOrderInputBySummaryId")
	public List<OrderInputSummaryVO> queryOrderInputBySummaryId(OrderInputSummary info,String pageNow,String pagesize,String id) {
		pageView= orderInputSummaryService.queryOrderInputBySummaryId(getPageView(pageNow,"100"), info);
		return pageView.getRecords();
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
	public Map<String, Object> add(OrderInputSummary info) {
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			orderInputSummaryService.add(info);
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
		return Common.BACKGROUND_PATH+"/inputsummary/add";
	}
	

	/**
	 * 跑到新增界面
	 * 
	 * @param model
	 * @return
	 */
	@RequestMapping("editUI")
	public String editUI(Model model,String id) {
		OrderInputSummary info = orderInputSummaryService.getById(id);
		model.addAttribute("inputsummary", info);
		return Common.BACKGROUND_PATH+"/inputsummary/edit";
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
	public Map<String, Object> update(Model model, OrderInputSummary info) {
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			orderInputSummaryService.update(info);
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
			String[] idarray=new String[2];//0位存预下单ID  1位存汇总ID
			OrderInputSummary summary=null;
			for (String string : id) {
				if(!Common.isEmpty(string)){
					idarray=string.split("_");
					orderInputService.delete(idarray[0]);
					summary=orderInputSummaryService.getById(idarray[1]);
					String orderIds=","+summary.getOrderIds()+",";
					orderIds=orderIds.replace(","+idarray[0]+",", ",");
					if(orderIds.equals(",")){
						summary.setOrderIds("");
					}else{
						summary.setOrderIds(orderIds.substring(1, orderIds.length()-1));
					}
					orderInputSummaryService.update(summary);
				}
			}
			map.put("flag", "true");
		} catch (Exception e) {
			map.put("flag", "false");
		}
		return map;
	}
	
	@RequestMapping("exportExcel")
	public void exportExcel(HttpServletResponse response,OrderInputSummary info) {
		 List<OrderInputSummary> acs = orderInputSummaryService.queryAll(info);
		POIUtils.exportToExcel(response, "预下单录入汇总报表", acs, OrderInputSummary.class, "预下单录入汇总", acs.size());
	}
	
}
