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
import com.github.hzw.security.entity.Account;
import com.github.hzw.security.entity.Notebook;
import com.github.hzw.security.entity.Resources;
import com.github.hzw.security.service.NotebookService;
import com.github.hzw.util.Common;
import com.github.hzw.util.DateUtil;
import com.github.hzw.util.POIUtils;

@Controller
@RequestMapping("/background/notebook/")
public class NotebookController extends BaseController {

	
	@Inject
	private NotebookService notebookService;
	
	@RequestMapping("list")
	public String list(Model model, Resources menu, String pageNow) {
		return Common.BACKGROUND_PATH+"/notebook/list";
	}
	
	/**
	 * @param model
	 * 存放返回界面的model
	 * @return
	 */
	@ResponseBody
	@RequestMapping("query")
	public PageView query(Notebook notebook,String pageNow,String pagesize) {
		pageView = notebookService.query(getPageView(pageNow,pagesize), notebook);
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
	public Map<String, Object> add(HttpServletRequest request, Notebook info) {
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			Account account = (Account)Common.findUserSession(request);
			info.setUserid(account.getId());
			info.setCreateTime(new Date());
			info.setTime(DateUtil.date2Str(new Date(), "yyyy-MM-dd"));
			notebookService.add(info);
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
		
		return Common.BACKGROUND_PATH+"/notebook/add";
	}
	

	/**
	 * 跑到新增界面
	 * 
	 * @param model
	 * @return
	 */
	@RequestMapping("editUI")
	public String editUI(Model model,String id) {
		Notebook notebook = notebookService.getById(id);
		model.addAttribute("notebook", notebook);
		return Common.BACKGROUND_PATH+"/notebook/edit";
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
	public Map<String, Object> update(Model model, Notebook info, HttpServletRequest request) {
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			Account account = (Account)Common.findUserSession(request);
			info.setUserid(account.getId());
			notebookService.update(info);
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
					notebookService.delete(string);
				}
			}
			map.put("flag", "true");
		} catch (Exception e) {
			map.put("flag", "false");
		}
		return map;
	}
	
	@RequestMapping("exportExcel")
	public void exportExcel(HttpServletResponse response,Notebook notebook) {
		 List<Notebook> acs = notebookService.queryAll(notebook);
		POIUtils.exportToExcel(response, "记事本报表", acs, Notebook.class, "记事本", acs.size());
	}
	
	
}
