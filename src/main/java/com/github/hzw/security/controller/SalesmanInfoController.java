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
import com.github.hzw.security.VO.OrderInputVO;
import com.github.hzw.security.entity.OrderSummary;
import com.github.hzw.security.entity.SalesmanInfo;
import com.github.hzw.security.service.OrderInputService;
import com.github.hzw.security.service.OrderSummaryService;
import com.github.hzw.security.service.SalesmanInfoService;
import com.github.hzw.util.Common;
import com.github.hzw.util.POIUtils;

@Controller
@RequestMapping("/background/salesman/")
public class SalesmanInfoController extends BaseController {
	@Inject
	private OrderSummaryService orderSummaryService;
	
	@Inject
	private OrderInputService orderInputService;
	
	@Inject
	private SalesmanInfoService salesmanInfoService;
	
	@RequestMapping("list")
	public String list(Model model,SalesmanInfo salesmanInfo,String pageNow,String pagesize) {
		pageView = salesmanInfoService.query(getPageView(pageNow,pagesize), salesmanInfo);
		model.addAttribute("pageView", pageView);
		return Common.BACKGROUND_PATH+"/salesman/list";
	}
	
	/**
	 * @param model
	 * 存放返回界面的model
	 * @return
	 */
	@ResponseBody
	@RequestMapping("query")
	public PageView query(SalesmanInfo salesmanInfo,String pageNow,String pagesize) {
		pageView = salesmanInfoService.query(getPageView(pageNow,pagesize), salesmanInfo);
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
	public Map<String, Object> add(SalesmanInfo salesmanInfo) {
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			salesmanInfoService.add(salesmanInfo);
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
		return Common.BACKGROUND_PATH+"/salesman/add";
	}
	
	/**
	 * 验证业务员名称是否存在
	 * @param name
	 * @return
	 */
	@RequestMapping("isExist")
	@ResponseBody
	public boolean isExist(String name){
		SalesmanInfo salesmanInfo = salesmanInfoService.isExist(name);
		if(salesmanInfo == null){
			return true;
		}else{
			return false;
		}
	}
	/**
	 * 获取多个业务员名称
	 * @return
	 */
	@RequestMapping("getSalmansName")
	@ResponseBody
	public String getSalmansName(String ids){
		String sumId=ids.split("_")[1];
		OrderSummary info = orderSummaryService.getById(sumId);
		String orderIds=info.getOrderIds();
		if(null==orderIds){
			return "";
		}
		List<OrderInputVO> list=orderInputService.queryByIds(orderIds.split(","));
		String msg="";
		for(OrderInputVO vo:list){
			msg+=","+vo.getSaleManName()+"("+vo.getNum()+")";
		}
		//String[] idsa=ids.split("_")[0].split(",");
		//return salesmanInfoService.getSalmansName(idsa);
		return msg.substring(1);
	}
	
	/**
	 * 跑到新增界面
	 * 
	 * @param model
	 * @return
	 */
	@RequestMapping("editUI")
	public String editUI(Model model,String id) {
		SalesmanInfo salesmanInfo = salesmanInfoService.getById(id);
		model.addAttribute("salesman", salesmanInfo);
		return Common.BACKGROUND_PATH+"/salesman/edit";
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
	public Map<String, Object> update(Model model, SalesmanInfo salesmanInfo) {
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			salesmanInfoService.update(salesmanInfo);
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
					salesmanInfoService.delete(string);
				}
			}
			map.put("flag", "true");
		} catch (Exception e) {
			map.put("flag", "false");
		}
		return map;
	}
	
	@RequestMapping("exportExcel")
	public void exportExcel(HttpServletResponse response,SalesmanInfo salesmanInfo) {
		 List<SalesmanInfo> acs =salesmanInfoService.queryAll(salesmanInfo);
		POIUtils.exportToExcel(response, "业务员报表", acs, SalesmanInfo.class, "业务员", acs.size());
	}
	
	
}
