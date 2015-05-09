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
import com.github.hzw.security.entity.Resources;
import com.github.hzw.security.entity.Supplier;
import com.github.hzw.security.service.SupplierService;
import com.github.hzw.util.Common;
import com.github.hzw.util.POIUtils;
import com.github.hzw.util.PinyinUtil;

@Controller
@RequestMapping("/background/supplier/")
public class SupplierController extends BaseController{
	
	@Inject
	private SupplierService supplierService;

	@RequestMapping("list")
	public String list(Model model, Resources menu, String pageNow) {
		return Common.BACKGROUND_PATH+"/supplier/list";
	}
	
	/**
	 * @param model
	 * 存放返回界面的model
	 * @return
	 */
	@ResponseBody
	@RequestMapping("query")
	public PageView query(Supplier info,String pageNow,String pagesize) {
		pageView = supplierService.query(getPageView(pageNow,pagesize), info);
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
	public Map<String, Object> add(Supplier info) {
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			// pinyin
			info.setPinyin(PinyinUtil.getPinYinHeadChar(info.getName()).toUpperCase());
			supplierService.add(info);
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
		return Common.BACKGROUND_PATH+"/supplier/add";
	}
	
	/**
	 * 验证工厂名称是否存在
	 * @param name
	 * @return
	 */
	@RequestMapping("isExist")
	@ResponseBody
	public boolean isExist(String name){
		Supplier info = supplierService.isExist(name);
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
		Supplier info = supplierService.getById(id);
		model.addAttribute("factory", info);
		return Common.BACKGROUND_PATH+"/supplier/edit";
	}
	
	/**
	 * 跑到查看界面
	 * 
	 * @param model
	 * @return
	 */
	@RequestMapping("viewUI")
	public String viewUI(Model model,String id) {
		Supplier info = supplierService.getById(id);
		model.addAttribute("factory", info);
		return Common.BACKGROUND_PATH+"/supplier/view";
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
	public Map<String, Object> update(Model model, Supplier info) {
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			// pinyin
			info.setPinyin(PinyinUtil.getPinYinHeadChar(info.getName()).toUpperCase());
			supplierService.update(info);
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
					supplierService.delete(string);
				}
			}
			map.put("flag", "true");
		} catch (Exception e) {
			map.put("flag", "false");
		}
		return map;
	}
	
	@RequestMapping("exportExcel")
	public void exportExcel(HttpServletResponse response,Supplier info) {
		 List<Supplier> acs =supplierService.queryAll(info);
		POIUtils.exportToExcel(response, "工厂报表", acs, Supplier.class, "工厂", acs.size());
	}
}
