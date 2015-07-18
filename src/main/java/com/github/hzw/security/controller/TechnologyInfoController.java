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
import com.github.hzw.security.entity.FactoryInfo;
import com.github.hzw.security.entity.Resources;
import com.github.hzw.security.entity.TechnologyInfo;
import com.github.hzw.security.service.TechnologyInfoService;
import com.github.hzw.util.Common;
import com.github.hzw.util.POIUtils;
import com.github.hzw.util.PinyinUtil;


@Controller
@RequestMapping("/background/technology/")
public class TechnologyInfoController extends BaseController {

	@Inject
	private TechnologyInfoService technologyInfoService;
	
	@RequestMapping("list")
	public String list(Model model, TechnologyInfo info,String pageNow,String pagesize) {
		pageView = technologyInfoService.query(getPageView(pageNow,pagesize), info);
		model.addAttribute("pageView", pageView);
		return Common.BACKGROUND_PATH+"/technology/list";
	}
	
	/**
	 * @param model
	 * 存放返回界面的model
	 * @return
	 */
	@ResponseBody
	@RequestMapping("query")
	public PageView query(TechnologyInfo info,String pageNow,String pagesize) {
		pageView = technologyInfoService.query(getPageView(pageNow,pagesize), info);
		return pageView;
	}
	@RequestMapping("addlist")
	public String addlist(Model model, Resources menu, TechnologyInfo info,String pageNow,String pagesize) {
		pageView = technologyInfoService.query(getPageView(pageNow,pagesize), info);
		model.addAttribute("pageView",pageView);
		return Common.BACKGROUND_PATH+"/technology/addlist";
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
	public Map<String, Object> add(TechnologyInfo info) {
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			// pinyin
			info.setPinyin(PinyinUtil.getPinYinHeadChar(info.getName()).toUpperCase());
			technologyInfoService.add(info);
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
		return Common.BACKGROUND_PATH+"/technology/add";
	}
	
	/**
	 * 验证工厂名称是否存在
	 * @param name
	 * @return
	 */
	@RequestMapping("isExist")
	@ResponseBody
	public boolean isExist(String name){
		TechnologyInfo info = technologyInfoService.isExist(name);
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
	public String editUI(Model model,String id) {
		TechnologyInfo info = technologyInfoService.getById(id);
		model.addAttribute("technology", info);
		return Common.BACKGROUND_PATH+"/technology/edit";
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
	public Map<String, Object> update(Model model, TechnologyInfo info) {
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			
			info.setPinyin(PinyinUtil.getPinYinHeadChar(info.getName()).toUpperCase());
			technologyInfoService.update(info);
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
					technologyInfoService.delete(string);
				}
			}
			map.put("flag", "true");
		} catch (Exception e) {
			map.put("flag", "false");
		}
		return map;
	}
	
	@RequestMapping("exportExcel")
	public void exportExcel(HttpServletResponse response,TechnologyInfo info) {
		 List<TechnologyInfo> acs = technologyInfoService.queryAll(info);
		POIUtils.exportToExcel(response, "工艺报表", acs, TechnologyInfo.class, "工艺", acs.size());
	}
	
	
}
