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
import com.github.hzw.security.entity.OrderSummary;
import com.github.hzw.security.entity.Resources;
import com.github.hzw.security.entity.ReturnGoodsProcess;
import com.github.hzw.security.entity.SampleInput;
import com.github.hzw.security.service.OrderSummaryService;
import com.github.hzw.security.service.ReturnGoodsProcessService;
import com.github.hzw.util.Common;
import com.github.hzw.util.CompressPic;
import com.github.hzw.util.DateUtil;
import com.github.hzw.util.POIUtils;
import com.github.hzw.util.PropertiesUtils;
import com.github.hzw.util.UploadFileUtils;

@Controller
@RequestMapping("/background/process/")
public class ReturnGoodsProcessController extends BaseController {

	@Inject
	private ReturnGoodsProcessService returnGoodsProcessService;
	
	@Inject
	private OrderSummaryService orderSummaryService;
	
	@RequestMapping("list")
	public String list(Model model, Resources menu, String pageNow,HttpServletRequest request) {
		OrderSummary OrderSummary=new OrderSummary();
		pageView=orderSummaryService.query(getPageView(pageNow,null),OrderSummary);
		List<OrderSummaryVO> list=pageView.getRecords();
		List<ReturnGoodsProcess> rlist=null;
		Map<Integer,List<ReturnGoodsProcess>> map=new HashMap<Integer,List<ReturnGoodsProcess>>();
		Integer summaryId=0;
		for(OrderSummaryVO os:list){
			summaryId=os.getId();
			rlist=returnGoodsProcessService.queryBySummaryId(summaryId+"");
			map.put(summaryId, rlist);
		}
		model.addAttribute("pageView", pageView);
		model.addAttribute("map", map);
		return Common.BACKGROUND_PATH+"/process/list";
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
	@RequestMapping("save")
	public void save(HttpServletRequest request,String summaryId,String status){
		OrderSummary orderSummary=orderSummaryService.getById(summaryId);
		orderSummary.setStatus(status);
		returnGoodsProcessService.save(request, orderSummary);
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
	
}
