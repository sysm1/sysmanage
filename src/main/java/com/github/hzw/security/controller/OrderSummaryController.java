package com.github.hzw.security.controller;

import java.util.Date;
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
import com.github.hzw.security.VO.GlVo;
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
import com.github.hzw.security.service.OrderInputService;
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
	private OrderInputService orderInputService;
	
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
		
		//ClothInfo cloth=new ClothInfo();
		//cloth.setId(info.getClothId());
		//List<ClothInfo> cloths = clothInfoService.query(getPageView(pageNow,null), cloth).getRecords();
		ClothInfo clothInfo=clothInfoService.getById(info.getClothId()+"");
		FactoryInfo fac=new FactoryInfo();
		fac.setId(info.getFactoryId());
		List<FactoryInfo> factoryInfos=factoryInfoService.query(getPageView(pageNow,null), fac).getRecords();
		
		if("".equals(info.getFactoryCode())){
			info.setFactoryCode(null);
		}if("".equals(info.getMyCompanyCode())||",".equals(info.getMyCompanyCode())){
			info.setMyCompanyCode(null);
		}
		pageView = orderSummaryService.query(getPageView(pageNow,null), info);
		FlowerInfo flowerInfo=new FlowerInfo();
		flowerInfo.setMyCompanyCode(info.getMyCompanyCode());
		List<String> myCompanyCodes=flowerInfoService.queryMycompanyCodeByCloth1(null);
//		if(cloths.size()==1){
//			model.addAttribute("cloth", cloths.get(0));
//		}
		List<TechnologyInfo> technologyInfos= technologyInfoService.queryAll(null);
		List<SalesmanInfo> salesmanInfos= salesmanInfoService.queryAll(null);
		model.addAttribute("pageView", pageView);
		model.addAttribute("size", pageView.getRecords().size()-1);
		if(factoryInfos.size()==1){
			model.addAttribute("factoryInfo", factoryInfos.get(0));
		}
		model.addAttribute("clothInfo", clothInfo);
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
	 * 撤销下单录入汇总
	 */
	@ResponseBody
	@RequestMapping("undo")
	public Map<String, Object> undo(String ids){
		Map<String, Object> map=new HashMap<String, Object>();
		map=orderSummaryService.undo(ids);
		return map;
	}
	
	/**
	 * 保存下单汇总数据
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
			info.setStatus("未回");
			OrderInputSummary orderInputSummary=orderInputSummaryService.getById(summId);
			//下单汇总后  将汇总中的预录入单据ID清空
			String orderIds=orderInputSummary.getOrderIds().replace(",,",",");
			if(orderIds.indexOf(",")==0){
				orderIds=orderIds.substring(1);
			}
			info.setOrderIds(orderIds);
			orderSummaryService.add(info);
			orderIds=","+orderIds;
			String [] idsa=inputIds.split(",");
			for(String id:idsa){
				orderIds=orderIds.replace(","+id, "");
			}
			if(orderIds.equals(",")){
				orderIds="";
			}
			orderInputSummary.setOrderIds(orderIds);
			orderInputSummaryService.update(orderInputSummary);
			
			//修改坯布余量 ？？？？？
			ClothInfo clothInfo=clothInfoService.getById(info.getClothId()+"");
			Double tiaoKg=clothInfo.getTiaoKg();
			ClothAllowance clothAllowance=clothAllowanceService.queryByClothAndFactory(info.getClothId(), info.getFactoryId(),info.getColor());
			if(null==clothAllowance){
				clothAllowance=new ClothAllowance();
				clothAllowance.setClothId(info.getClothId());
				clothAllowance.setFactoryId(info.getFactoryId());
				//clothAllowance.setColor(info.getColor());
				clothAllowance.setChangeSum(0);
				clothAllowance.setChangeSumkg(0D);
				clothAllowance.setInputDate(new Date());
				int unit=info.getUnit();
				if(unit==0){
					clothAllowance.setAllowance(info.getNum().intValue());
					clothAllowance.setAllowancekg(info.getNum().intValue()*tiaoKg);
				}else{
					clothAllowance.setAllowance(0);
					clothAllowance.setAllowancekg(info.getNum());
				}
				clothAllowanceService.addAllowance(clothAllowance);
			}else{
				int unit=info.getUnit();
				Double allowanceKg=clothAllowance.getAllowancekg();
				if(0==unit){
					Integer allowance=clothAllowance.getAllowance();
					allowance=allowance-info.getNum().intValue();
					allowanceKg=allowanceKg-tiaoKg*info.getNum();
					clothAllowance.setAllowancekg(allowanceKg);
					clothAllowance.setAllowance(allowance);
				}else{
					//allowanceKg=allowanceKg-info.getNum().intValue()*tiaoKg;
					clothAllowance.setAllowancekg(allowanceKg);
				}
				clothAllowanceService.addAllowance(clothAllowance);
			}
			//坯布余量修改完成
			
			/**判断花号基本资料是否被使用**/
			FlowerInfo flowerInfo=new FlowerInfo();
			flowerInfo.setFactoryCode(info.getFactoryCode());
			flowerInfo.setClothId(info.getClothId());
			flowerInfo.setTechnologyId(info.getTechnologyId());
			List<FlowerInfo> flowerInfos=flowerInfoService.queryFind(flowerInfo);
			if(flowerInfos.size()>0){
				flowerInfo=flowerInfos.get(0);
				flowerInfoService.updateByStatus(flowerInfo.getId(), 1);//修改为不可删除
			}
			
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
		//List<ClothInfo> clothInfos=clothInfoService.queryAll(null);
		OrderSummary info = orderSummaryService.getById(id);
		Map<String,Object> map=new HashMap<String,Object>();
		map.put("myCompanyCode", info.getMyCompanyCode());
		map.put("myCompanyColor", info.getMyCompanyColor());
		map.put("technologyId", info.getTechnologyId());
		map.put("clothId", info.getClothId());
		List<GlVo> glList=flowerInfoService.queryGlFactory(map);
		List<GlVo> glListfc=flowerInfoService.queryGlFactoryCode(map);
		List<GlVo> glListfco=flowerInfoService.queryGl(map);
		model.addAttribute("factoryCodes",glListfc);
		model.addAttribute("glList", glList);
		model.addAttribute("glList", glList);
		List<SalesmanInfo> salesmanInfos= salesmanInfoService.queryAll(null);
		model.addAttribute("factoryColors",glListfco);
		model.addAttribute("inputsummary", info);
		model.addAttribute("orgNum", info.getNum()-(null==info.getBalance()?0:info.getBalance()));
		model.addAttribute("salesmanInfos", salesmanInfos);
		//model.addAttribute("clothInfos",clothInfos);
		return Common.BACKGROUND_PATH+"/ordersummary/edit";
	}
	
	/**
	 * 跑到修改界面
	 * 
	 * @param model
	 * @return
	 */
	@RequestMapping("viewUI")
	public String viewUI(Model model,String id) {
		List<FactoryInfo> factoryInfos=factoryInfoService.queryAll(null);
		
		OrderSummary info = orderSummaryService.getById(id);
		ClothInfo clothInfo=clothInfoService.getById(info.getClothId()+"");
		TechnologyInfo technologyInfo=technologyInfoService.getById(info.getTechnologyId()+"");
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
		model.addAttribute("orgNum", info.getNum()-(null==info.getBalance()?0:info.getBalance()));
		model.addAttribute("salesmanInfos", salesmanInfos);
		model.addAttribute("factoryInfos", factoryInfos);
		model.addAttribute("clothInfo",clothInfo);
		model.addAttribute("technologyInfo", technologyInfo);
		return Common.BACKGROUND_PATH+"/ordersummary/view";
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
	
	@RequestMapping("exportSummaryExcel")
	public void exportSummaryExcel(HttpServletRequest request, HttpServletResponse response) {
		
		String beginTime = request.getParameter("beginTime");
		String endTime = request.getParameter("endTime");
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("beginTime", beginTime);
		map.put("endTime", endTime);
		List<OrderSummary> acs = orderSummaryService.queryReportBySummary(map);
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
	
	@ResponseBody
	@RequestMapping("queryNoReturnNum1")
	public Map<String, Object> queryNoReturnNum1(OrderSummary orderSummary){
		List<FlowerInfo> list = flowerInfoService.queryByClothIdAndMyCompanyCode(orderSummary.getClothId(), orderSummary.getMyCompanyCode());
		String data =  orderSummaryService.queryNoReturnNum(orderSummary);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("list", list);
		map.put("data", data);
		return map;
	}
	
	@ResponseBody
	@RequestMapping("queryFactoryCodeByFactoryId")
	public List<String> queryFactoryCodeByFactoryId(String factoryId){
		return orderSummaryService.queryFactoryCodeByFactoryId(factoryId);
	}
	
	@ResponseBody
	@RequestMapping("queryFactoryColor")
	public List<String> queryFactoryColor(OrderSummary orderSummary){
		OrderSummary os=new OrderSummary();
		os.setFactoryId(orderSummary.getFactoryId());
		os.setFactoryCode(orderSummary.getFactoryCode());
		return orderSummaryService.queryFactoryColor(os);
	}
	
}
