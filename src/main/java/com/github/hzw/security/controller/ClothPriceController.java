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
import com.github.hzw.security.entity.ClothPrice;
import com.github.hzw.security.entity.Resources;
import com.github.hzw.security.service.ClothInfoService;
import com.github.hzw.security.service.ClothPriceService;
import com.github.hzw.util.Common;
import com.github.hzw.util.POIUtils;

@Controller
@RequestMapping("/background/price/")
public class ClothPriceController extends BaseController {

	@Inject
	private ClothPriceService clothPriceService;
	@Inject
	private ClothInfoService clothInfoService;
	
	@RequestMapping("list")
	public String list(Model model, Resources menu, String pageNow) {
		model.addAttribute("cloths",clothInfoService.queryAll(null));
		return Common.BACKGROUND_PATH+"/price/list";
	}
	
	
	/**
	 * @param model
	 * 存放返回界面的model
	 * @return
	 */
	@ResponseBody
	@RequestMapping("query")
	public PageView query(ClothPrice info,String pageNow,String pagesize) {
		if(info == null) {
			info = new ClothPrice();
		}
		if(info.getClothId() == null) {
			info.setClothId(-1);
		}
		
		pageView = clothPriceService.query(getPageView(pageNow,pagesize), info);
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
	public Map<String, Object> add(HttpServletRequest request , HttpServletResponse response, ClothPrice info) {
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			info.setCreateTime(new Date());
			clothPriceService.add(info);
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
		return Common.BACKGROUND_PATH + "/price/add";
	}
	

	/**
	 * 跑到新增界面
	 * 
	 * @param model
	 * @return
	 */
	@RequestMapping("editUI")
	public String editUI(Model model,String id) {
		ClothPrice info = clothPriceService.getById(id);
		model.addAttribute("price", info);
		return Common.BACKGROUND_PATH+"/price/edit";
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
	public Map<String, Object> update(Model model, ClothPrice info) {
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			
			clothPriceService.update(info);
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
					clothPriceService.delete(string);
				}
			}
			map.put("flag", "true");
		} catch (Exception e) {
			map.put("flag", "false");
		}
		return map;
	}
	
	@RequestMapping("exportExcel")
	public void exportExcel(HttpServletResponse response,ClothPrice info) {
		 List<ClothPrice> acs = clothPriceService.queryAll(info);
		POIUtils.exportToExcel(response, "布种价格报表", acs, ClothPrice.class, "布种价格", acs.size());
	}
}
