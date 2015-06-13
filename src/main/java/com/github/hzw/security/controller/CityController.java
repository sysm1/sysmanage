package com.github.hzw.security.controller;

import java.util.HashMap;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.github.hzw.pulgin.mybatis.plugin.PageView;
import com.github.hzw.security.entity.City;
import com.github.hzw.security.entity.Resources;
import com.github.hzw.security.service.CityService;
import com.github.hzw.util.Common;

@Controller
@RequestMapping("/background/city/")
public class CityController extends BaseController{
	
	@Inject
	private CityService cityService;
	
	@RequestMapping("list")
	public String list(Model model, Resources menu, String pageNow) {
		return Common.BACKGROUND_PATH+"/city/list";
	}
	
	@ResponseBody
	@RequestMapping("query")
	public PageView query(City info,String pageNow,String pagesize) {
		pageView = cityService.query(getPageView(pageNow,pagesize), info);
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
	public Map<String, Object> add(City account) {
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			cityService.add(account);
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
		return Common.BACKGROUND_PATH+"/city/add";
	}
	
	@RequestMapping("editUI")
	public String editUI(Model model,String accountId) {
		City bean = cityService.getById(accountId);
		model.addAttribute("bean", bean);
		return Common.BACKGROUND_PATH+"/city/edit";
	}
	
	@ResponseBody
	@RequestMapping("deleteById")
	public Map<String, Object> deleteById(Model model, String ids) {
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			String id[] = ids.split(",");
			for (String string : id) {
				if(!Common.isEmpty(string)){
					cityService.delete(string);
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
	public Map<String, Object> update(Model model, City account) {
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			cityService.update(account);
			map.put("flag", "true");
		} catch (Exception e) {
			map.put("flag", "false");
		}
		return map;
	}

}
