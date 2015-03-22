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
import com.github.hzw.security.VO.OrderInputVO;
import com.github.hzw.security.entity.ClothAllowance;
import com.github.hzw.security.entity.FactoryInfo;
import com.github.hzw.security.entity.OrderInputSummary;
import com.github.hzw.security.entity.Resources;
import com.github.hzw.security.entity.SalesmanInfo;
import com.github.hzw.security.entity.TechnologyInfo;
import com.github.hzw.security.service.ClothAllowanceService;
import com.github.hzw.security.service.FactoryInfoService;
import com.github.hzw.security.service.OrderInputService;
import com.github.hzw.security.service.OrderInputSummaryService;
import com.github.hzw.security.service.SalesmanInfoService;
import com.github.hzw.security.service.TechnologyInfoService;
import com.github.hzw.util.Common;
import com.github.hzw.util.POIUtils;
import com.github.hzw.util.PropertiesUtils;

@Controller
@RequestMapping("/background/inputsummary/")
public class OrderInputSummaryController extends BaseController {

	@Inject
	private OrderInputSummaryService orderInputSummaryService;
	
	@Inject
	private OrderInputService orderInputService;
	
	@Inject
	private ClothAllowanceService clothAllowanceService;
	
	@Inject
	private SalesmanInfoService salesmanInfoService;
	
	@Inject
	private TechnologyInfoService technologyInfoService;
	
	@Inject
	private FactoryInfoService factoryInfoService;
	
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
	 * 下单页面
	 * @param model
	 * @return
	 */
	@RequestMapping("order")
	public String order(Model model,String id) {
		String ids="";
		String[] idsa=id.split(",");
		for(String idss:idsa){
			ids+=","+idss.split("_")[0];
		}
		String summId=idsa[0].split("_")[1];
		OrderInputSummaryVO info = orderInputSummaryService.getVOById(summId);
		List<FactoryInfo> factoryInfos=factoryInfoService.queryAll(null);
		List<OrderInputVO> orderInputList=orderInputService.queryByIds(ids.substring(1));
		List<TechnologyInfo> technologyInfos= technologyInfoService.queryAll(null);
		List<SalesmanInfo> salesmanInfos= salesmanInfoService.queryAll(null);
		//坯布余量查询
		ClothAllowance clothAllowance=null;//clothAllowanceService.queryByCloth(info.getClothId()+"");
		String cloth_allowance_tiao=PropertiesUtils.findPropertiesKey("cloth_allowance_tiao");
		//String cloth_allowance_kg=PropertiesUtils.findPropertiesKey("cloth_allowance_kg");
		if(null!=clothAllowance){
			if(clothAllowance.getAllowance()>Double.parseDouble(cloth_allowance_tiao)){
				model.addAttribute("clothAllowance", "大量");
			}else{
				model.addAttribute("clothAllowance", clothAllowance.getAllowance());
			}
		}
		int num=0;
		for(OrderInputVO vo:orderInputList){
			num+=vo.getNum();
		}
		
		//下单编号
		String orderNo="3333333333333333";
		model.addAttribute("inputsummary", info);
		model.addAttribute("factoryInfos", factoryInfos);
		model.addAttribute("orderInputList", orderInputList);
		model.addAttribute("technologyInfos", technologyInfos);
		model.addAttribute("orderNo", orderNo);
		model.addAttribute("num",num);
		model.addAttribute("salesmanInfos",salesmanInfos);
		model.addAttribute("nowDate", Common.fromDateY());
		return Common.BACKGROUND_PATH+"/inputsummary/order";
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
