package com.github.hzw.security.controller;

import java.util.Date;
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
import com.github.hzw.security.entity.TechnologyInfo;
import com.github.hzw.security.entity.Unsub;
import com.github.hzw.security.service.ClothInfoService;
import com.github.hzw.security.service.TechnologyInfoService;
import com.github.hzw.security.service.UnsubInputService;
import com.github.hzw.util.Common;

/**
 * 退货次品预登记
 * @author wuyb
 *
 */
@Controller
@RequestMapping("/background/unsubInput/")
public class UnsubInputController extends BaseController{
	
	@Inject
	private UnsubInputService unsubInputService;
	
	@Inject
	private ClothInfoService clothInfoService;
	
	@Inject
	private TechnologyInfoService technologyInfoService;
	
	@RequestMapping("list")
	public String list(Model model, Unsub unsub,String pageNow,String pagesize){
		List<TechnologyInfo> technologyInfos=technologyInfoService.queryAll(null);
		pageView = unsubInputService.query(getPageView(pageNow,pagesize), unsub);
		model.addAttribute("pageView", pageView);
		model.addAttribute("technologyInfos", technologyInfos);
		return Common.BACKGROUND_PATH+"/unsubInput/list";
	}
	
	/**
	 * @param model
	 * 存放返回界面的model
	 * @return
	 */
	@ResponseBody
	@RequestMapping("query")
	public PageView query(Unsub unsub,String pageNow,String pagesize) {
		pageView = unsubInputService.query(getPageView(pageNow,pagesize), unsub);
		return pageView;
	}
	
	/**
	 * 跑到新增界面
	 * 
	 * @param model
	 * @return
	 */
	@RequestMapping("addUI")
	public String addUI(Model model) {
		List<ClothInfo> clothInfos=clothInfoService.queryAll(null);
		List<TechnologyInfo> technologyInfos=technologyInfoService.queryAll(null);
		model.addAttribute("now",new Date());
		model.addAttribute("clothInfos",clothInfos);
		model.addAttribute("technologyInfos",technologyInfos);
		return Common.BACKGROUND_PATH+"/unsubInput/add";
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
	public Map<String, Object> add(Unsub unsub) {
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			unsub.setYsresult("0");
			unsubInputService.add(unsub);
			map.put("flag", "true");
		} catch (Exception e) {
			e.printStackTrace();
			map.put("flag", "false");
		}
		return map;
	}
	
	/**
	 * 跑到修改界面
	 * 
	 * @param model
	 * @return
	 */
	@RequestMapping("editUI")
	public String editUI(Model model,String id,String type) {
		List<TechnologyInfo> technologyInfos=technologyInfoService.queryAll(null);
		Unsub unsub = unsubInputService.getById(id);
		model.addAttribute("unsub", unsub);
		if("view".equals(type)){
			return Common.BACKGROUND_PATH+"/unsubInput/view";
		}
		model.addAttribute("technologyInfos",technologyInfos);
		return Common.BACKGROUND_PATH+"/unsubInput/edit";
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
	public Map<String, Object> update(Model model, Unsub unsub) {
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			unsub.setYsresult("0");
			unsubInputService.update(unsub);
			map.put("flag", "true");
		} catch (Exception e) {
			map.put("flag", "false");
		}
		return map;
	}
	@ResponseBody
	@RequestMapping("deleteById")
	public Map<String, Object> deleteById(Model model, String ids) {
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			String id[] = ids.split(",");
			for (String string : id) {
				if(!Common.isEmpty(string)){
					unsubInputService.delete(string);
				}
			}
			map.put("flag", "true");
		} catch (Exception e) {
			map.put("flag", "false");
		}
		return map;
	}
}
