package com.github.hzw.security.controller;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
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
import com.github.hzw.security.VO.OrderInputSummaryVO;
import com.github.hzw.security.VO.OrderInputVO;
import com.github.hzw.security.entity.ClothColor;
import com.github.hzw.security.entity.ClothInfo;
import com.github.hzw.security.entity.FactoryInfo;
import com.github.hzw.security.entity.FlowerAdditional;
import com.github.hzw.security.entity.FlowerInfo;
import com.github.hzw.security.entity.OrderInputSummary;
import com.github.hzw.security.entity.OrderSummary;
import com.github.hzw.security.entity.Resources;
import com.github.hzw.security.entity.SalesmanInfo;
import com.github.hzw.security.entity.TechnologyInfo;
import com.github.hzw.security.service.ClothInfoService;
import com.github.hzw.security.service.DateVersionService;
import com.github.hzw.security.service.FactoryInfoService;
import com.github.hzw.security.service.FlowerAdditionalService;
import com.github.hzw.security.service.FlowerInfoService;
import com.github.hzw.security.service.OrderInputService;
import com.github.hzw.security.service.OrderInputSummaryService;
import com.github.hzw.security.service.OrderSummaryService;
import com.github.hzw.security.service.PasswordService;
import com.github.hzw.security.service.RecordLogService;
import com.github.hzw.security.service.SalesmanInfoService;
import com.github.hzw.security.service.TechnologyInfoService;
import com.github.hzw.util.Common;
import com.github.hzw.util.DateUtil;
import com.github.hzw.util.POIUtils;

@Controller
@RequestMapping("/background/inputsummary/")
public class OrderInputSummaryController extends BaseController {

	@Inject
	private OrderInputSummaryService orderInputSummaryService;
	
	@Inject
	private OrderSummaryService orderSummaryService;
	
	@Inject
	private OrderInputService orderInputService;
	
	@Inject
	private FlowerAdditionalService flowerAdditionalService;
	
	@Inject
	private FlowerInfoService flowerInfoService;
	
	@Inject
	private SalesmanInfoService salesmanInfoService;
	
	@Inject
	private TechnologyInfoService technologyInfoService;
	
	@Inject
	private FactoryInfoService factoryInfoService;
	
	@Inject
	private ClothInfoService clothInfoService;
	
	@Inject
	private DateVersionService dateVersionService;
	
	@Inject
	private RecordLogService recordLogService;
	
	@Inject
	private PasswordService passwordService;
	
	
	@RequestMapping("list")
	public String list(Model model, Resources menu,HttpServletRequest request, String pagesize,OrderInputSummary info) {
		String pageNow=request.getParameter("pageNow");
		pageView = orderInputSummaryService.queryVO(getPageView(pageNow,pagesize), info);
		int recordCount = recordLogService.sum("inputsummary", "delete");
		model.addAttribute("pageView", pageView);
		model.addAttribute("recordCount", recordCount);
		// model.addAttribute("recordCount", 6);
		int num = passwordService.getNum();
		model.addAttribute("num", num);
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
	@ResponseBody
	@RequestMapping("queryMyCompanyCodeByClothId")
	public List<String> queryMyCompanyCodeByClothId(String clothId) {
		return orderInputSummaryService.queryMyCompanyCodeByClothId(clothId);
	}
	
	@ResponseBody
	@RequestMapping("queryMyCompanyColorByMyCompanyCode")
	public List<String> queryMyCompanyColorByMyCompanyCode(String myCompanyCode) {
		return orderInputSummaryService.queryMyCompanyColorByMyCompanyCode(myCompanyCode);
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
	 * 跑到修改界面
	 * 
	 * @param model
	 * @return
	 */
	@RequestMapping("editUI")
	public String editUI(Model model,String addId,HttpServletRequest request) {
		String[] addIdsa=addId.split(",");
		String[] newArr=new String[addIdsa.length];
		int i=0;
		for(String ids:addIdsa){
			String[] idsa=ids.split("_");
			newArr[i++]=idsa[0];
		}
		List<OrderInputVO> list=orderInputService.queryByIds(newArr);
		List<String> mycompanyCodes=null;
		for(OrderInputVO vo:list){
			FlowerInfo flowerInfo=new FlowerInfo();
			flowerInfo.setClothId(vo.getClothId());
			flowerInfo.setTechnologyId(vo.getTechnologyId());
			mycompanyCodes=flowerInfoService.queryMycompanyCodeByCloth1(flowerInfo);
			vo.setMyCompanyCodes(mycompanyCodes);
		}
		List<ClothInfo> cloths = clothInfoService.queryAll(null);
		List<SalesmanInfo> salesmanInfos= salesmanInfoService.queryAll(null);
		List<TechnologyInfo> technologys=technologyInfoService.queryAll(null);
		model.addAttribute("cloths", cloths);
		model.addAttribute("technologys", technologys);
		model.addAttribute("salesmanInfos", salesmanInfos);
		model.addAttribute("list", list);
		return Common.BACKGROUND_PATH+"/inputsummary/edit";
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
		String technologyId=idsa[0].split("_")[2];
		OrderInputSummaryVO info = orderInputSummaryService.getVOById(summId);
		List<OrderInputVO> orderInputList=orderInputService.queryByIds(ids.substring(1).split(","));//ids.substring(1).split(",")
		//List<TechnologyInfo> technologyInfos= technologyInfoService.queryAll(null);
		TechnologyInfo technoInfo=technologyInfoService.getById(technologyId);
		List<SalesmanInfo> salesmanInfos= salesmanInfoService.queryAll(null);
		
		int num=0;
		String salmanIds="";
		for(OrderInputVO vo:orderInputList){
			num+=vo.getNum();
			salmanIds+=","+vo.getSalesmanId();
		}
		salmanIds=salmanIds.substring(1);
		
		//****判断我司编号和我司颜色是否在花号基本资料中存在 不存在标记为红色****/
		FlowerAdditional fa=new FlowerAdditional();
		fa.setMyCompanyCode(info.getMyCompanyCode());
		fa.setMyCompanyColor(info.getMyCompanyColor());
		List<String> factoryCodes=flowerAdditionalService.queryFactoryCode1(fa);
		if(factoryCodes.size()==0){
			model.addAttribute("codeRed", "red;font-weight:bold");
			factoryCodes=flowerAdditionalService.queryFactoryCode1(null);
		}
		model.addAttribute("factoryCodes",factoryCodes);
		
		List<String> factoryColors=flowerAdditionalService.queryFactoryColor(info.getMyCompanyColor());
		if(factoryColors.size()==0){
			model.addAttribute("colorRed", "red;font-weight:bold");
			factoryColors=flowerAdditionalService.queryFactoryColor(null);
		}
		model.addAttribute("factoryColors",factoryColors);
		//***颜色判断结束****//
		
		//下单编号
		String orderNo=null;
		String tmp = DateUtil.date2Str(new Date(), "yyyyMMdd");
		try {
			orderNo=dateVersionService.getValue("orderInputSummary", tmp)+"";
			orderNo = tmp + Common.prefixFillChar(4, orderNo + "", "0");
		} catch (Exception e) {
			e.printStackTrace();
		}
		OrderSummary orderSummary =new OrderSummary();
		orderSummary.setClothId(info.getClothId());
		orderSummary.setMyCompanyCode(info.getMyCompanyCode());
		orderSummary.setMyCompanyColor(info.getMyCompanyColor());
		String noRetrun=orderSummaryService.queryNoReturnNum(orderSummary);
		
		ClothInfo clothInfo=clothInfoService.getById(info.getClothId()+"");
		List<ClothColor> colors=clothInfoService.queryColorsById(clothInfo.getId()+"");
		String unitName=clothInfo.getUnitName();
		if("包".equals(unitName)){
			unitName="KG";
		}
		
		//过滤工厂信息
		Map<String,Object> map=new HashMap<String,Object>();
		map.put("myCompanyCode", info.getMyCompanyCode());
		map.put("myCompanyColor", info.getMyCompanyColor());
		map.put("technologyId", technologyId);
		map.put("clothId", info.getClothId());
		List<GlVo> glList=flowerInfoService.queryGlFactory(map);
		model.addAttribute("glList", glList);
		model.addAttribute("clothInfo", clothInfo);
		model.addAttribute("colors",colors);
		model.addAttribute("inputsummary", info);
		model.addAttribute("unitName", unitName);
		model.addAttribute("orderInputList", orderInputList);
		model.addAttribute("technoInfo", technoInfo);
		model.addAttribute("orderNo", orderNo);
		model.addAttribute("num",num);
		model.addAttribute("technologyId",technologyId);
		model.addAttribute("salesmanInfos",salesmanInfos);
		model.addAttribute("nowDate", Common.fromDateY());
		model.addAttribute("inputIds",ids.substring(1));
		model.addAttribute("summId",summId);
		model.addAttribute("salmanIds",salmanIds);
		model.addAttribute("noRetrun",null==noRetrun?"0":noRetrun);
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
	/**
	 * 添加到花号基本资料
	 * @param model
	 * @param request
	 * @return
	 */
	@RequestMapping("addtoFlowerUI")
	public String addtoFlowerUI(Model model,HttpServletRequest request){
		FactoryInfo factoryInfo=factoryInfoService.getById(request.getParameter("factoryId"));
		ClothInfo clothInfo=clothInfoService.getById(request.getParameter("clothId"));
		List<TechnologyInfo> technologyInfos= technologyInfoService.queryAll(null);
		List<FactoryInfo> factoryInfos=factoryInfoService.queryAll(null);
		model.addAttribute("factoryInfos",factoryInfos);
		model.addAttribute("clothInfo", clothInfo);
		model.addAttribute("factoryInfo", factoryInfo);
		model.addAttribute("technologyInfos", technologyInfos);
		model.addAttribute("factoryId", request.getParameter("factoryId"));
		String myCompanyCode=null;
		try {
			myCompanyCode = URLDecoder.decode(request.getParameter("myCompanyCode"),"utf-8");
			//myCompanyCode = URLDecoder.decode(request.getParameter("myCompanyCode"),"iso-8859-1");
			//myCompanyCode = new String(request.getParameter("myCompanyCode").getBytes("ISO8859_1"));
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}//
		model.addAttribute("myCompanyCode", myCompanyCode);
		model.addAttribute("myCompanyColor", request.getParameter("myCompanyColor"));
		model.addAttribute("technologyId", request.getParameter("technologyId"));
		model.addAttribute("factoryCode", request.getParameter("factoryCode"));
		return Common.BACKGROUND_PATH+"/inputsummary/addtoFlower";
	}
	
	@RequestMapping("exportExcel")
	public void exportExcel(HttpServletResponse response,OrderInputSummary info) {
		 List<OrderInputSummary> acs = orderInputSummaryService.queryAll(info);
		POIUtils.exportToExcel(response, "预下单录入汇总报表", acs, OrderInputSummary.class, "预下单录入汇总", acs.size());
	}
	
}
