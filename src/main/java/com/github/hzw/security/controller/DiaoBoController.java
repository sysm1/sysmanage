package com.github.hzw.security.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.github.hzw.pulgin.mybatis.plugin.PageView;
import com.github.hzw.security.entity.ClothInfo;
import com.github.hzw.security.entity.DiaoBo;
import com.github.hzw.security.entity.FactoryInfo;
import com.github.hzw.security.entity.Resources;
import com.github.hzw.security.service.ClothInfoService;
import com.github.hzw.security.service.DiaoBoService;
import com.github.hzw.security.service.FactoryInfoService;
import com.github.hzw.util.Common;

@Controller
@RequestMapping("/background/diaobo/")
public class DiaoBoController extends BaseController{
	
	@Inject
	private DiaoBoService diaoBoService;
	
	@Inject
	private FactoryInfoService factoryInfoService;
	
	@Inject
	private ClothInfoService clothInfoService;
	
	@RequestMapping("list")
	public String list(Model model, Resources menu, DiaoBo info,String pageNow,String pagesize) {
		pageView = diaoBoService.query(getPageView(pageNow,pagesize), info);
		model.addAttribute("pageView", pageView);
		return Common.BACKGROUND_PATH+"/diaobo/list";
	}
	
	@ResponseBody
	@RequestMapping("query")
	public PageView query(DiaoBo info,String pageNow,String pagesize) {
		pageView = diaoBoService.query(getPageView(pageNow,pagesize), info);
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
	public Map<String, Object> add(DiaoBo info) {
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			diaoBoService.add(info);
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
	public String addUI(Model model) {
		List<FactoryInfo> factorys=factoryInfoService.queryAll(null);
		List<ClothInfo> cloths=clothInfoService.queryAll(null);
		model.addAttribute("factorys", factorys);
		model.addAttribute("cloths", cloths);
		return Common.BACKGROUND_PATH+"/diaobo/add";
	}
	
	@RequestMapping("editUI")
	public String editUI(Model model,String id) {
		List<FactoryInfo> factorys=factoryInfoService.queryAll(null);
		List<ClothInfo> cloths=clothInfoService.queryAll(null);
		model.addAttribute("factorys", factorys);
		model.addAttribute("cloths", cloths);
		DiaoBo bean = diaoBoService.getById(id);
		ClothInfo clothInfo=clothInfoService.getById(bean.getClothId()+"");
		model.addAttribute("clothInfo", clothInfo);
		model.addAttribute("bean", bean);
		return Common.BACKGROUND_PATH+"/diaobo/edit";
	}
	
	@ResponseBody
	@RequestMapping("deleteById")
	public Map<String, Object> deleteById(Model model, String ids) {
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			String id[] = ids.split(",");
			for (String string : id) {
				if(!Common.isEmpty(string)){
					diaoBoService.delete(string);
				}
			}
			map.put("flag", "true");
		} catch (Exception e) {
			map.put("flag", "false");
		}
		return map;
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
	public Map<String, Object> update(Model model, DiaoBo info) {
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			diaoBoService.update(info);
			map.put("flag", "true");
		} catch (Exception e) {
			map.put("flag", "false");
		}
		return map;
	}
}
