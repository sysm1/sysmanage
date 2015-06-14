package com.github.hzw.security.controller;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.github.hzw.pulgin.mybatis.plugin.PageView;
import com.github.hzw.security.entity.ClothColor;
import com.github.hzw.security.entity.ClothInfo;
import com.github.hzw.security.entity.ClothManage;
import com.github.hzw.security.entity.Resources;
import com.github.hzw.security.service.ClothInfoService;
import com.github.hzw.security.service.ClothManageService;
import com.github.hzw.security.service.FactoryInfoService;
import com.github.hzw.util.Common;

/**
 * 坯布管理  坯布盘点
 * @author wuyb
 */
@Controller
@RequestMapping("/background/clothManage/")
public class ClothManageController extends BaseController{
	
	@Inject
	private ClothManageService clothManageService;
	
	@Inject
	private ClothInfoService clothInfoService;
	
	@Inject
	private FactoryInfoService factoryInfoService;
	
	@RequestMapping("list")
	public String list(Model model, Resources menu, ClothManage clothManage,String pageNow,String pagesize) {
		pageView = clothManageService.query(getPageView(pageNow,pagesize), clothManage);
		model.addAttribute("clothManage", clothManage);
		model.addAttribute("pageView", pageView);
		return Common.BACKGROUND_PATH+"/clothManage/list";
	}
	
	@ResponseBody
	@RequestMapping("query")
	public PageView query(ClothManage clothManage,String pageNow,String pagesize) {
		try{
			pageView = clothManageService.query(getPageView(pageNow,pagesize), clothManage);
		}catch(Exception e){
			e.printStackTrace();
		}
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
	public Map<String, Object> add(ClothManage info,HttpServletRequest request) {
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			info.setCreateTime(new Date());
			clothManageService.add(info);
			map.put("flag", "true");
		} catch (Exception e) {
			e.printStackTrace();
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
		model.addAttribute("cloths",clothInfoService.queryAll(null));
		model.addAttribute("factorys",factoryInfoService.queryAll(null));
		return Common.BACKGROUND_PATH+"/clothManage/add";
	}
	

	/**
	 * 跳转到修改界面
	 * 
	 * @param model
	 * @return
	 */
	@RequestMapping("editUI")
	public String editUI(Model model,String id) {
		
		ClothManage clothManage=clothManageService.getById(id);
		
		ClothInfo clothInfo = clothInfoService.getById(id);
		List<ClothColor> clothColors=clothInfoService.queryColorsById(id);
		model.addAttribute("cloth", clothInfo);
		model.addAttribute("clothManage", clothManage);
		model.addAttribute("clothColors", clothColors);
		return Common.BACKGROUND_PATH+"/clothManage/edit";
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
	public Map<String, Object> update(Model model, ClothManage info) {
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			clothManageService.update(info);
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
					clothManageService.delete(string);
				}
			}
			map.put("flag", "true");
		} catch (Exception e) {
			map.put("flag", "false");
		}
		return map;
	}
}
