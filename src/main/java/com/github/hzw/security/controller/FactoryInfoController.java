package com.github.hzw.security.controller;

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
import com.github.hzw.security.entity.Account;
import com.github.hzw.security.entity.City;
import com.github.hzw.security.entity.ClothInfo;
import com.github.hzw.security.entity.FactoryInfo;
import com.github.hzw.security.entity.Resources;
import com.github.hzw.security.service.CityService;
import com.github.hzw.security.service.FactoryInfoService;
import com.github.hzw.util.Common;
import com.github.hzw.util.POIUtils;
import com.github.hzw.util.PinyinUtil;


@Controller
@RequestMapping("/background/factory/")
public class FactoryInfoController extends BaseController {

	@Inject
	private FactoryInfoService factoryInfoService;
	
	@Inject
	private CityService cityService;
	
	@RequestMapping("list")
	public String list(Model model, Resources menu, String pageNow,HttpServletRequest request) {
		List<City> citys=cityService.getCitys(request);
		request.setAttribute("citys", citys);
		return Common.BACKGROUND_PATH+"/factory/list";
	}
	
	@RequestMapping("addlist")
	public String addlist(Model model, Resources menu, FactoryInfo info,String pageNow,String pagesize) {
		pageView = factoryInfoService.query(getPageView(pageNow,pagesize), info);
		model.addAttribute("pageView",pageView);
		return Common.BACKGROUND_PATH+"/factory/addlist";
	}
	
	/**
	 * @param model
	 * 存放返回界面的model
	 * @return
	 */
	@ResponseBody
	@RequestMapping("query")
	public PageView query(FactoryInfo info,String pageNow,String pagesize) {
		pageView = factoryInfoService.query(getPageView(pageNow,pagesize), info);
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
	public Map<String, Object> add(FactoryInfo info) {
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			// pinyin
			info.setPinyin(PinyinUtil.getPinYinHeadChar(info.getName()).toUpperCase());
			factoryInfoService.add(info);
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
	public String addUI(HttpServletRequest request) {
		List<City> citys=cityService.getCitys(request);
		request.setAttribute("citys", citys);
		return Common.BACKGROUND_PATH+"/factory/add";
	}
	
	/**
	 * 验证工厂名称是否存在
	 * @param name
	 * @return
	 */
	@RequestMapping("isExist")
	@ResponseBody
	public boolean isExist(String name){
		FactoryInfo info = factoryInfoService.isExist(name);
		if(info == null){
			return true;
		}else{
			return false;
		}
	}
	
	/**
	 * 跑到新增界面
	 * 
	 * @param model
	 * @return
	 */
	@RequestMapping("editUI")
	public String editUI(HttpServletRequest request,Model model,String id) {
		Account user=(Account) request.getSession().getAttribute("userSession");
		City t=new City();
		t.setId(user.getCityId());
		t.setStatus(1);
		List<City> citys=cityService.queryAll(t);
		request.setAttribute("citys", citys);
		
		FactoryInfo info = factoryInfoService.getById(id);
		model.addAttribute("factory", info);
		return Common.BACKGROUND_PATH+"/factory/edit";
	}
	
	/**
	 * 跑到查看界面
	 * 
	 * @param model
	 * @return
	 */
	@RequestMapping("viewUI")
	public String viewUI(Model model,String id) {
		FactoryInfo info = factoryInfoService.getById(id);
		model.addAttribute("factory", info);
		return Common.BACKGROUND_PATH+"/factory/view";
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
	public Map<String, Object> update(Model model, FactoryInfo info) {
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			// pinyin
			info.setPinyin(PinyinUtil.getPinYinHeadChar(info.getName()).toUpperCase());
			factoryInfoService.update(info);
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
					factoryInfoService.delete(string);
				}
			}
			map.put("flag", "true");
		} catch (Exception e) {
			map.put("flag", "false");
		}
		return map;
	}
	
	@RequestMapping("exportExcel")
	public void exportExcel(HttpServletResponse response,FactoryInfo info) {
		 List<FactoryInfo> acs =factoryInfoService.queryAll(info);
		POIUtils.exportToExcel(response, "工厂报表", acs, FactoryInfo.class, "工厂", acs.size());
	}
	
	
}
