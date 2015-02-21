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
import com.github.hzw.security.entity.ClothInfo;
import com.github.hzw.security.entity.ClothUnit;
import com.github.hzw.security.entity.Resources;
import com.github.hzw.security.service.ClothInfoService;
import com.github.hzw.security.service.ClothUnitService;
import com.github.hzw.util.Common;
import com.github.hzw.util.POIUtils;


@Controller
@RequestMapping("/background/unit/")
public class ClothUnitController extends BaseController {

	@Inject
	private ClothUnitService clothUnitService;
	@Inject
	private ClothInfoService clothInfoService;
	
	@RequestMapping("list")
	public String list(Model model, Resources menu, String pageNow) {
		return Common.BACKGROUND_PATH+"/unit/list";
	}
	
	/**
	 * @param model
	 * 存放返回界面的model
	 * @return
	 */
	@ResponseBody
	@RequestMapping("query")
	public PageView query(ClothUnit clothUnit,String pageNow,String pagesize) {
		pageView = clothUnitService.query(getPageView(pageNow,pagesize), clothUnit);
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
	public Map<String, Object> add(ClothUnit clothUnit) {
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			clothUnitService.add(clothUnit);
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
	public String addUI(Model model) {
		List<ClothInfo> cloths = clothInfoService.queryAll(null);
		model.addAttribute("cloths", cloths);
		return Common.BACKGROUND_PATH+"/unit/add";
	}
	

	/**
	 * 跑到新增界面
	 * 
	 * @param model
	 * @return
	 */
	@RequestMapping("editUI")
	public String editUI(Model model,String id) {
		List<ClothInfo> cloths = clothInfoService.queryAll(null);
		model.addAttribute("cloths", cloths);
		ClothUnit clothUnit = clothUnitService.getById(id);
		model.addAttribute("unit", clothUnit);
		return Common.BACKGROUND_PATH+"/unit/edit";
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
	public Map<String, Object> update(Model model, ClothUnit clothUnit) {
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			clothUnitService.update(clothUnit);
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
					clothUnitService.delete(string);
				}
			}
			map.put("flag", "true");
		} catch (Exception e) {
			map.put("flag", "false");
		}
		return map;
	}
	
	@RequestMapping("exportExcel")
	public void exportExcel(HttpServletResponse response,ClothUnit clothUnit) {
		 List<ClothUnit> acs = clothUnitService.queryAll(clothUnit);
		POIUtils.exportToExcel(response, "布种单位报表", acs, ClothUnit.class, "布种单位", acs.size());
	}
	
	
}
