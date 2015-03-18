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
import com.github.hzw.security.entity.ClothAllowance;
import com.github.hzw.security.entity.Resources;
import com.github.hzw.security.service.ClothAllowanceService;
import com.github.hzw.security.service.ClothInfoService;
import com.github.hzw.security.service.FactoryInfoService;
import com.github.hzw.util.Common;
import com.github.hzw.util.DateUtil;
import com.github.hzw.util.POIUtils;

@Controller
@RequestMapping("/background/allowance/")
public class ClothAllowanceController extends BaseController {

	@Inject
	private ClothAllowanceService clothAllowanceService;
	@Inject
	private ClothInfoService clothInfoService;
	@Inject
	private FactoryInfoService factoryInfoService;
	
	
	@RequestMapping("list")
	public String list(Model model, Resources menu, String pageNow) {
		model.addAttribute("cloths",clothInfoService.queryAll(null));
		model.addAttribute("factorys",factoryInfoService.queryAll(null));
		return Common.BACKGROUND_PATH+"/allowance/list";
	}
	
	
	/**
	 * @param model
	 * 存放返回界面的model
	 * @return
	 */
	@ResponseBody
	@RequestMapping("query")
	public PageView query(ClothAllowance info,String pageNow,String pagesize) {
		pageView = clothAllowanceService.query(getPageView(pageNow,pagesize), info);
		return pageView;
	}
	
	
	/**
	 * @param model
	 * 存放返回界面的model
	 * @return
	 */
	@ResponseBody
	@RequestMapping("queryByFind")
	public PageView queryByFind(HttpServletRequest request, HttpServletResponse response, String pageNow,String pagesize) {
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("clothId", request.getParameter("clothId"));
		map.put("factoryId", request.getParameter("factoryId"));
		map.put("mark", request.getParameter("mark"));
		map.put("beginTime", DateUtil.str2Date(request.getParameter("beginTime"), "yyyy-MM-dd"));
		map.put("endTime", DateUtil.str2Date(request.getParameter("endTime"), "yyyy-MM-dd"));
		map.put("change", request.getParameter("change"));
		map.put("unit", request.getParameter("unit"));
		pageView = clothAllowanceService.queryByFind(getPageView(pageNow,pagesize), map);
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
	public Map<String, Object> add(HttpServletRequest request , HttpServletResponse response, ClothAllowance info) {
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			
			info.setCreateTime(new Date());
			clothAllowanceService.add(info);
			map.put("flag", "true");
		} catch (Exception e) {
			map.put("flag", "false");
			map.put("msg", e.getMessage());
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
	public String addUI(Model model) {
		model.addAttribute("cloths",clothInfoService.queryAll(null));
		model.addAttribute("factorys",factoryInfoService.queryAll(null));
		return Common.BACKGROUND_PATH+"/allowance/add";
	}
	

	/**
	 * 跑到新增界面
	 * 
	 * @param model
	 * @return
	 */
	@RequestMapping("editUI")
	public String editUI(Model model,String id) {
		ClothAllowance info = clothAllowanceService.getById(id);
		model.addAttribute("allowance", info);
		return Common.BACKGROUND_PATH+"/allowance/edit";
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
	public Map<String, Object> update(Model model, ClothAllowance info) {
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			clothAllowanceService.update(info);
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
					clothAllowanceService.delete(string);
				}
			}
			map.put("flag", "true");
		} catch (Exception e) {
			map.put("flag", "false");
		}
		return map;
	}
	
	@RequestMapping("exportExcel")
	public void exportExcel(HttpServletResponse response,ClothAllowance info) {
		 List<ClothAllowance> acs = clothAllowanceService.queryAll(info);
		POIUtils.exportToExcel(response, "余量报表", acs, ClothAllowance.class, "余量", acs.size());
	}
	
}
