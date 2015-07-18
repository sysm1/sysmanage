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
import com.github.hzw.security.VO.OrderSummaryVO;
import com.github.hzw.security.entity.ClothInfo;
import com.github.hzw.security.entity.FactoryInfo;
import com.github.hzw.security.entity.OrderSummary;
import com.github.hzw.security.entity.ReturnGoodsProcess;
import com.github.hzw.security.service.ClothInfoService;
import com.github.hzw.security.service.FactoryInfoService;
import com.github.hzw.security.service.OrderSummaryService;
import com.github.hzw.security.service.ReturnGoodsProcessService;
import com.github.hzw.util.Common;
import com.github.hzw.util.DateUtil;
import com.github.hzw.util.POIUtils;
import com.github.hzw.util.PropertiesUtils;

/**
 * 回货进度
 * @author wuyb
 *
 */
@Controller
@RequestMapping("/background/process/")
public class ReturnGoodsProcessController extends BaseController {

	@Inject
	private ReturnGoodsProcessService returnGoodsProcessService;
	
	@Inject
	private OrderSummaryService orderSummaryService;
	
	@Inject
	private FactoryInfoService factoryInfoService;
	
	@Inject
	private ClothInfoService clothInfoService;
	
	@SuppressWarnings("unchecked")
	@RequestMapping("list")
	public String list(Model model,String delay, String pageNow,HttpServletRequest request) {
		String factoryId=request.getParameter("factoryId");
		FactoryInfo fac=new FactoryInfo();
		if(null!=factoryId&&!"".equals(factoryId)){
			fac.setId(Integer.parseInt(factoryId));
		}
		List<FactoryInfo> factoryInfos=factoryInfoService.query(getPageView(pageNow,null), fac).getRecords();
		
		String code=request.getParameter("code");
		OrderSummary orderSummary=new OrderSummary();
		if(""!=delay&&null!=delay){
			orderSummary.setDelayDates(Integer.parseInt(PropertiesUtils.findPropertiesKey("process_delay_dates")));
		}if(!"".equals(code)&&null!=code){
			orderSummary.setCode(code);
		}
		orderSummary.setReturnStatus(11);
		if(null!=factoryId&&!"".equals(factoryId)){
			orderSummary.setFactoryId(Integer.parseInt(factoryId));
		}
		pageView=orderSummaryService.queryVO(getPageView(pageNow,null),orderSummary);
		List<OrderSummaryVO> list=pageView.getRecords();
		List<ReturnGoodsProcess> rlist=null;
		Map<Integer,List<ReturnGoodsProcess>> map=new HashMap<Integer,List<ReturnGoodsProcess>>();
		Integer summaryId=0;
		for(OrderSummaryVO os:list){
			summaryId=os.getId();
			rlist=returnGoodsProcessService.queryBySummaryId(summaryId+"");
			map.put(summaryId, rlist);
		}
		if(factoryInfos.size()==1){
			model.addAttribute("factoryInfo", factoryInfos.get(0));
		}
		String delayDates=returnGoodsProcessService.queryDelayDates(PropertiesUtils.findPropertiesKey("process_delay_dates"));
		final List<ClothInfo> cloths=clothInfoService.queryAll(null);
		model.addAttribute("pageView", pageView);
		model.addAttribute("map", map);
		model.addAttribute("cloths",cloths);
		model.addAttribute("factoryInfos", factoryInfos);
		model.addAttribute("delayDates",delayDates);
		model.addAttribute("bean", orderSummary);
		return Common.BACKGROUND_PATH+"/process/list";
	}
	@RequestMapping("returnpro")
	public String returnpro(String id,HttpServletRequest request){
		FactoryInfo fac1=new FactoryInfo();
		fac1.setIsdefault("是");
		List<FactoryInfo> facs=factoryInfoService.queryAll(fac1);
		if(null!=facs&&facs.size()>0){
			request.setAttribute("facname", facs.get(0).getName());
		}
		String nowTime=DateUtil.date2Str(new Date(), "yyyy-MM-dd");
		request.setAttribute("nowTime", nowTime);
		OrderSummary orderSummary=orderSummaryService.getById(id);
		List<ReturnGoodsProcess> rlist=null;
		rlist=returnGoodsProcessService.queryBySummaryId(id);
		Map<Integer,List<ReturnGoodsProcess>> map=new HashMap<Integer,List<ReturnGoodsProcess>>();
		map.put(Integer.parseInt(id), rlist);
		request.setAttribute("item", orderSummary);
		request.setAttribute("map",map);
		return Common.BACKGROUND_PATH+"/process/returnpro";
	}
	
	/**
	 * 修改回货进度的状态
	 */
	@RequestMapping("updateStatus")
	public String updateStatus(Model model,String delay, String pageNow,HttpServletRequest request){
		String ids=request.getParameter("oids");
		String returnStatus=request.getParameter("rStatus");
		returnGoodsProcessService.updateStatus(ids, returnStatus);
		return list(model, pageNow, pageNow, request);
	}
	
	/**
	 * @param model
	 * 存放返回界面的model
	 * @return
	 */
	@ResponseBody
	@RequestMapping("query")
	public PageView query(ReturnGoodsProcess info,String pageNow,String pagesize) {
		pageView = returnGoodsProcessService.query(getPageView(pageNow,pagesize), info);
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
	public Map<String, Object> add(ReturnGoodsProcess info) {
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			info.setCreateTime(new Date());
			returnGoodsProcessService.add(info);
			map.put("flag", "true");
		} catch (Exception e) {
			map.put("flag", "false");
		}
		return map;
	}

	/**
	 * 保存数据
	 * @param model
	 * @param sampleInput
	 * @param request
	 */
	@ResponseBody
	@RequestMapping("save")
	public String save(Model model,HttpServletRequest request,String summaryId,String returnStatus){
		OrderSummary orderSummary=orderSummaryService.getById(summaryId);
		orderSummary.setReturnStatus(Integer.parseInt(returnStatus));
		returnGoodsProcessService.save(request, orderSummary);
		return "ok";
	}
	
	/**
	 * 跑到新增界面
	 * 
	 * @param model
	 * @return
	 */
	@RequestMapping("addUI")
	public String addUI() {
		return Common.BACKGROUND_PATH+"/process/add";
	}
	

	/**
	 * 跑到新增界面
	 * 
	 * @param model
	 * @return
	 */
	@RequestMapping("editUI")
	public String editUI(Model model,String id) {
		ReturnGoodsProcess info = returnGoodsProcessService.getById(id);
		model.addAttribute("process", info);
		return Common.BACKGROUND_PATH+"/process/edit";
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
	public Map<String, Object> update(Model model, ReturnGoodsProcess info) {
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			returnGoodsProcessService.update(info);
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
					returnGoodsProcessService.delete(string);
				}
			}
			map.put("flag", "true");
		} catch (Exception e) {
			map.put("flag", "false");
		}
		return map;
	}
	
	@RequestMapping("exportExcel")
	public void exportExcel(HttpServletResponse response,ReturnGoodsProcess info) {
		 List<ReturnGoodsProcess> acs = returnGoodsProcessService.queryAll(info);
		POIUtils.exportToExcel(response, "回货进度报表", acs, ReturnGoodsProcess.class, "回货进度", acs.size());
	}
	
	@ResponseBody
	@RequestMapping("queryReturnTime")
	public List<String> queryReturnTime(OrderSummary orderSummary){
		List<OrderSummary> list=orderSummaryService.queryAll(orderSummary);
		if(list.size()>0){
			String summaryId=list.get(0).getId()+"";
			return returnGoodsProcessService.queryReturnTime(summaryId);
		}
		return null;
	}
	
}
