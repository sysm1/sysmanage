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
import com.github.hzw.security.entity.FlowerInfo;
import com.github.hzw.security.entity.Resources;
import com.github.hzw.security.service.FlowerInfoService;
import com.github.hzw.util.Common;
import com.github.hzw.util.POIUtils;

@Controller
@RequestMapping("/background/flower/")
public class FlowerInfoController extends BaseController{

	@Inject
	private FlowerInfoService flowerInfoService;
	
	@RequestMapping("list")
	public String list(Model model, Resources menu, String pageNow) {
		return Common.BACKGROUND_PATH+"/flower/list";
	}
	
	/**
	 * @param model
	 * 存放返回界面的model
	 * @return
	 */
	@ResponseBody
	@RequestMapping("query")
	public PageView query(FlowerInfo info,String pageNow,String pagesize) {
		pageView = flowerInfoService.query(getPageView(pageNow,pagesize), info);
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
	public Map<String, Object> add(FlowerInfo info) {
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			flowerInfoService.add(info);
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
		return Common.BACKGROUND_PATH+"/flower/add";
	}
	

	/**
	 * 跑到新增界面
	 * 
	 * @param model
	 * @return
	 */
	@RequestMapping("editUI")
	public String editUI(Model model,String id) {
		FlowerInfo info = flowerInfoService.getById(id);
		model.addAttribute("flower", info);
		return Common.BACKGROUND_PATH+"/flower/edit";
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
	public Map<String, Object> update(Model model, FlowerInfo info) {
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			flowerInfoService.update(info);
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
					flowerInfoService.delete(string);
				}
			}
			map.put("flag", "true");
		} catch (Exception e) {
			map.put("flag", "false");
		}
		return map;
	}
	
	@RequestMapping("exportExcel")
	public void exportExcel(HttpServletResponse response,FlowerInfo info) {
		 List<FlowerInfo> acs = flowerInfoService.queryAll(info);
		POIUtils.exportToExcel(response, "花号报表", acs, FlowerInfo.class, "花号", acs.size());
	}
	
}
