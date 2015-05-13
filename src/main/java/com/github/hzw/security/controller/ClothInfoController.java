package com.github.hzw.security.controller;

import java.util.ArrayList;
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
import com.github.hzw.security.entity.ClothColor;
import com.github.hzw.security.entity.ClothInfo;
import com.github.hzw.security.entity.Resources;
import com.github.hzw.security.service.ClothInfoService;
import com.github.hzw.util.Common;
import com.github.hzw.util.POIUtils;
import com.github.hzw.util.PinyinUtil;

@Controller
@RequestMapping("/background/cloth/")
public class ClothInfoController extends BaseController {

	@Inject
	private ClothInfoService clothInfoService;
	
	@RequestMapping("list")
	public String list(Model model, Resources menu, String pageNow) {
		return Common.BACKGROUND_PATH+"/cloth/list";
	}
	
	/**
	 * @param model
	 * 存放返回界面的model
	 * @return
	 */
	@ResponseBody
	@RequestMapping("query")
	public PageView query(ClothInfo clothInfo,String pageNow,String pagesize) {
		pageView = clothInfoService.query(getPageView(pageNow,pagesize), clothInfo);
		return pageView;
	}
	@SuppressWarnings("unchecked")
	@ResponseBody
	@RequestMapping("getClothUnit")
	public String getClothUnit(ClothInfo clothInfo,String pageNow,String pagesize){
		pageView = clothInfoService.query(getPageView(pageNow,pagesize), clothInfo);
		List<ClothInfo> list=pageView.getRecords();
		String unitName="无单位";
		if(null!=list.get(0).getUnitName()&&!"".equals(list.get(0).getUnitName())){
			unitName=list.get(0).getUnitName();
		}
		return unitName;
	}
	
	@ResponseBody
	@RequestMapping("getClothColor")
	public List<ClothColor> getClothColor(String clothId){
		List<ClothColor> list = clothInfoService.queryColorsById(clothId);
		return list;
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
	public Map<String, Object> add(ClothInfo info,HttpServletRequest request) {
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			info.setCreateTime(new Date());
			// pinyin
			info.setPinyin(PinyinUtil.getPinYinHeadChar(info.getClothName()).toUpperCase());
			List<ClothColor> list=new ArrayList<ClothColor>();
			/**String[] colors=request.getParameterValues("color");
			ClothColor clothColor=new ClothColor();
			for(String color:colors){
				clothColor=new ClothColor();
				clothColor.setColor(color);
				list.add(clothColor);
			}*/
			clothInfoService.addClothInfo(info,list);
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
	public String addUI() {
		return Common.BACKGROUND_PATH+"/cloth/add";
	}
	

	/**
	 * 跑到新增界面
	 * 
	 * @param model
	 * @return
	 */
	@RequestMapping("editUI")
	public String editUI(Model model,String id) {
		ClothInfo clothInfo = clothInfoService.getById(id);
		List<ClothColor> clothColors=clothInfoService.queryColorsById(id);
		model.addAttribute("cloth", clothInfo);
		model.addAttribute("clothColors", clothColors);
		return Common.BACKGROUND_PATH+"/cloth/edit";
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
	public Map<String, Object> update(Model model, ClothInfo info) {
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			// pinyin
			info.setPinyin(PinyinUtil.getPinYinHeadChar(info.getClothName()).toUpperCase());
			clothInfoService.update(info);
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
					clothInfoService.delete(string);
				}
			}
			map.put("flag", "true");
		} catch (Exception e) {
			map.put("flag", "false");
		}
		return map;
	}
	
	@RequestMapping("exportExcel")
	public void exportExcel(HttpServletResponse response,ClothInfo clothInfo) {
		 List<ClothInfo> acs = clothInfoService.queryAll(clothInfo);
		POIUtils.exportToExcel(response, "布种报表", acs, ClothInfo.class, "布种", acs.size());
	}
	
	
}
