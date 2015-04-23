package com.github.hzw.security.controller;

import java.util.Date;
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
import com.github.hzw.security.entity.ClothAllowance;
import com.github.hzw.security.entity.ClothInfo;
import com.github.hzw.security.entity.FactoryInfo;
import com.github.hzw.security.entity.FlowerInfo;
import com.github.hzw.security.entity.OrderInputSummary;
import com.github.hzw.security.entity.OrderSummary;
import com.github.hzw.security.entity.Resources;
import com.github.hzw.security.entity.SalesmanInfo;
import com.github.hzw.security.entity.TechnologyInfo;
import com.github.hzw.security.service.ClothAllowanceService;
import com.github.hzw.security.service.ClothInfoService;
import com.github.hzw.security.service.FactoryInfoService;
import com.github.hzw.security.service.FlowerAdditionalService;
import com.github.hzw.security.service.FlowerInfoService;
import com.github.hzw.security.service.OrderInputSummaryService;
import com.github.hzw.security.service.OrderSummaryService;
import com.github.hzw.security.service.SalesmanInfoService;
import com.github.hzw.security.service.TechnologyInfoService;
import com.github.hzw.util.Common;
import com.github.hzw.util.POIUtils;

@Controller
@RequestMapping("/background/ordersummary/")
public class OrderSummaryController extends BaseController {

	@Inject
	private OrderSummaryService orderSummaryService;
	
	@Inject
	private OrderInputSummaryService orderInputSummaryService;
	
	@Inject
	private FactoryInfoService factoryInfoService;
	
	@Inject
	private SalesmanInfoService salesmanInfoService;
	
	@Inject
	private ClothInfoService clothInfoService;
	
	@Inject
	private TechnologyInfoService technologyInfoService;
	
	@Inject
	private ClothAllowanceService clothAllowanceService;
	
	@Inject
	private FlowerAdditionalService flowerAdditionalService;
	
	@Inject
	private FlowerInfoService flowerInfoService;
	
	@SuppressWarnings("unchecked")
	@RequestMapping("list")
	public String list(Model model, Resources menu, String pageNow,OrderSummary info,String flag) {
		if("1".equals(flag)){
			//model.addAttribute("startDate", Common.fromDateY());
			//model.addAttribute("endDate", Common.fromDateY());
			model.addAttribute("flag", flag);//从下单录入汇总页面跳转到此页面
			//info.setStartDate(new Date());
			//info.setEndDate(new Date());
		}
		
		ClothInfo cloth=new ClothInfo();
		cloth.setId(info.getClothId());
		List<ClothInfo> cloths = clothInfoService.query(getPageView(pageNow,null), cloth).getRecords();
		
		FactoryInfo fac=new FactoryInfo();
		fac.setId(info.getFactoryId());
		List<FactoryInfo> factoryInfos=factoryInfoService.query(getPageView(pageNow,null), fac).getRecords();
		
		pageView = orderSummaryService.query(getPageView(pageNow,null), info);
		FlowerInfo flowerInfo=new FlowerInfo();
		flowerInfo.setMyCompanyCode(info.getMyCompanyCode());
		List<String> myCompanyCodes=flowerInfoService.queryMycompanyCodeByCloth(null);
		if(cloths.size()==1){
			model.addAttribute("cloth", cloths.get(0));
		}
		List<TechnologyInfo> technologyInfos= technologyInfoService.queryAll(null);
		List<SalesmanInfo> salesmanInfos= salesmanInfoService.queryAll(null);
		model.addAttribute("pageView", pageView);
		model.addAttribute("size", pageView.getRecords().size()-1);
		if(factoryInfos.size()==1){
			model.addAttribute("factoryInfo", factoryInfos.get(0));
		}
		model.addAttribute("cloths", cloths);
		model.addAttribute("salesmanInfos", salesmanInfos);
		model.addAttribute("bean", info);
		model.addAttribute("technologyInfos", technologyInfos);
		model.addAttribute("myCompanyCodes", myCompanyCodes);
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
	public Map<String, Object> add(OrderSummary info,String inputIds,String summId) {
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			info.setPrintStatus(0);
			info.setPrintNum(0);
			info.setCreateTime(new Date());
			orderSummaryService.add(info);
			OrderInputSummary orderInputSummary=orderInputSummaryService.getById(summId);
			String orderIds=orderInputSummary.getOrderIds();
			orderIds=","+orderIds;
			String [] idsa=inputIds.split(",");
			for(String id:idsa){
				orderIds=orderIds.replace(","+id, "");
			}
			orderInputSummary.setOrderIds(orderIds);
			orderInputSummaryService.update(orderInputSummary);
			
			//修改坯布余量 ？？？？？
			ClothAllowance clothAllowance=clothAllowanceService.queryByClothAndFactory(info.getClothId(), info.getFactoryId());
			if(null==clothAllowance){
				clothAllowance=new ClothAllowance();
				clothAllowance.setClothId(info.getClothId());
				clothAllowance.setFactoryId(info.getFactoryId());
				double num=0-info.getNum();
				int unit=info.getUnit();
				if(unit==0){
					clothAllowance.setAllowance(num);
				}else{
					clothAllowance.setAllowancekg(num);
				}
				clothAllowanceService.add(clothAllowance);
			}else{
				Double allowance=clothAllowance.getAllowance();
				allowance=allowance-info.getNum();
				int unit=info.getUnit();
				if(unit==0){
					clothAllowance.setAllowance(allowance);
				}else{
					clothAllowance.setAllowancekg(allowance);
				}
				clothAllowanceService.update(clothAllowance);
			}
			//坯布余量修改完成
			
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
	 * 跑到修改界面
	 * 
	 * @param model
	 * @return
	 */
	@RequestMapping("editUI")
	public String editUI(Model model,String id) {
		List<FactoryInfo> factoryInfos=factoryInfoService.queryAll(null);
		List<ClothInfo> clothInfos=clothInfoService.queryAll(null);
		List<TechnologyInfo> technologyInfos= technologyInfoService.queryAll(null);
		OrderSummary info = orderSummaryService.getById(id);
		
		List<String> factoryCodes=flowerAdditionalService.queryFactoryCode(info.getMyCompanyCode());
		if(factoryCodes.size()==0){
			model.addAttribute("codeRed", "red;font-weight:bold");
			factoryCodes=flowerAdditionalService.queryFactoryCode(null);
		}
		model.addAttribute("factoryCodes",factoryCodes);
		
		List<String> factoryColors=flowerAdditionalService.queryFactoryColor(info.getMyCompanyColor());
		if(factoryColors.size()==0){
			model.addAttribute("colorRed", "red;font-weight:bold");
			factoryColors=flowerAdditionalService.queryFactoryColor(null);
		}
		List<SalesmanInfo> salesmanInfos= salesmanInfoService.queryAll(null);
		model.addAttribute("factoryColors",factoryColors);
		model.addAttribute("inputsummary", info);
		model.addAttribute("orgNum", info.getNum()-info.getBalance());
		model.addAttribute("salesmanInfos", salesmanInfos);
		model.addAttribute("factoryInfos", factoryInfos);
		model.addAttribute("clothInfos",clothInfos);
		model.addAttribute("technologyInfos", technologyInfos);
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
	
	/**
	 * 查询未回数量
	 * @param clothId
	 * @param myCompanyCode
	 * @param myCompanyColor
	 * @return
	 */
	@ResponseBody
	@RequestMapping("queryNoReturnNum")
	public String queryNoReturnNum(OrderSummary orderSummary){
		return orderSummaryService.queryNoReturnNum(orderSummary);
	}
	
}
