package com.github.hzw.security.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.github.hzw.pulgin.mybatis.plugin.PageView;
import com.github.hzw.security.entity.Account;
import com.github.hzw.security.entity.Mark;
import com.github.hzw.security.entity.Resources;
import com.github.hzw.security.service.MarkService;
import com.github.hzw.util.Common;
import com.github.hzw.util.Md5Tool;

@Controller
@RequestMapping("/background/mark/")
public class MarkController extends BaseController{
	
	@Inject
	private MarkService markService;
	
	@RequestMapping("list")
	public String list(Model model, Resources menu, String pageNow,String addFlag) {
		return Common.BACKGROUND_PATH+"/mark/list";
	}
	
	@RequestMapping("addlist")
	public String addlist(Model model,Mark mark, String pageNow) {
		pageView = markService.query(getPageView(pageNow,"100"), mark);
		model.addAttribute("pageView", pageView);
		return Common.BACKGROUND_PATH+"/mark/addlist";
	}
	
	/**
	 * @param model
	 * 存放返回界面的model
	 * @return
	 */
	@ResponseBody
	@RequestMapping("query")
	public PageView query(Mark mark,String pageNow,String pagesize) {
		pageView = markService.query(getPageView(pageNow,pagesize), mark);
		return pageView;
	}
	
	@ResponseBody
	@RequestMapping("queryAll")
	public String queryAll(Model model) {
		List<Mark> list=markService.queryAll(null);
		model.addAttribute("list", list);
		return Common.BACKGROUND_PATH+"/mark/list";
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
	public Map<String, Object> add(Mark mark) {
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			markService.add(mark);
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
		return Common.BACKGROUND_PATH+"/mark/add";
	}
	
	/**
	 * 修改页面
	 * @param model
	 * @param accountId
	 * @return
	 */
	@RequestMapping("editUI")
	public String editUI(Model model,String id) {
		Mark mark = markService.getById(id);
		model.addAttribute("mark", mark);
		return Common.BACKGROUND_PATH+"/mark/edit";
	}
	
	
	@ResponseBody
	@RequestMapping("update")
	public Map<String, Object> update(Model model, Mark mark) {
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			markService.update(mark);
			map.put("flag", "true");
		} catch (Exception e) {
			map.put("flag", "false");
		}
		return map;
	}
	/**
	 * 删除
	 * @param model
	 * @param ids
	 * @return
	 */
	@ResponseBody
	@RequestMapping("deleteById")
	public Map<String, Object> deleteById(Model model, String ids) {
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			String id[] = ids.split(",");
			for (String string : id) {
				if(!Common.isEmpty(string)){
					markService.delete(string);
				}
			}
			map.put("flag", "true");
		} catch (Exception e) {
			map.put("flag", "false");
		}
		return map;
	}
}
