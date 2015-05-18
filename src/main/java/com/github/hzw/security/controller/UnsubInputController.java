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
import com.github.hzw.security.entity.Account;
import com.github.hzw.security.entity.ClothAllowance;
import com.github.hzw.security.entity.ClothInfo;
import com.github.hzw.security.entity.Unsub;
import com.github.hzw.security.service.ClothInfoService;
import com.github.hzw.security.service.UnsubInputService;
import com.github.hzw.util.Common;
import com.github.hzw.util.Md5Tool;

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
	
	@RequestMapping("list")
	public String list(Model model, HttpServletRequest request,String pagesize){
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
		model.addAttribute("now",new Date());
		model.addAttribute("clothInfos",clothInfos);
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
	public String editUI(Model model,String id) {
		Unsub unsub = unsubInputService.getById(id);
		model.addAttribute("unsub", unsub);
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
			unsubInputService.update(unsub);
			map.put("flag", "true");
		} catch (Exception e) {
			map.put("flag", "false");
		}
		return map;
	}
}
