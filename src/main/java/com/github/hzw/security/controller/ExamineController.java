package com.github.hzw.security.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.github.hzw.pulgin.mybatis.plugin.PageView;
import com.github.hzw.security.entity.CodePicture;
import com.github.hzw.security.entity.FactoryInfo;
import com.github.hzw.security.entity.TechnologyInfo;
import com.github.hzw.security.entity.Unsub;
import com.github.hzw.security.service.CodePictureService;
import com.github.hzw.security.service.FactoryInfoService;
import com.github.hzw.security.service.TechnologyInfoService;
import com.github.hzw.security.service.UnsubInputService;
import com.github.hzw.util.Common;

/**
 * 次品验货
 * @author wuyb
 *
 */
@Controller
@RequestMapping("/background/examine/")
public class ExamineController extends BaseController{
	
	@Inject
	private UnsubInputService unsubInputService;
	
	@Inject
	private FactoryInfoService factoryInfoService;
	
	@Resource
	private CodePictureService codePictureService;
	
	@Inject
	private TechnologyInfoService technologyInfoService;

	@RequestMapping("list")
	public String list(Model model, HttpServletRequest request,String pagesize,Unsub unsub){
		List<TechnologyInfo> technologyInfos=technologyInfoService.queryAll(null);
		String pageNow=request.getParameter("pageNow");
		if(unsub.getYsresult()==null){
			unsub.setYsresult("0");
		}
		
		pageView = unsubInputService.query(getPageView(pageNow,pagesize), unsub);
		List<CodePicture> codes=codePictureService.queryAllCode(request);
		FactoryInfo factoryInfo=factoryInfoService.getById(unsub.getFactoryId()+"");
		request.setAttribute("codes", codes);
		model.addAttribute("factoryInfo",factoryInfo);
		request.setAttribute("pageView", pageView);
		request.setAttribute("bean", unsub);
		model.addAttribute("technologyInfos", technologyInfos);
		return Common.BACKGROUND_PATH+"/examine/list";
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
	 * 跑到修改界面
	 * 
	 * @param model
	 * @return
	 */
	@RequestMapping("editUI")
	public String editUI(Model model,String id) {
		Unsub unsub = unsubInputService.getById(id);
		List<FactoryInfo> factoryInfos=factoryInfoService.queryAll(null);
		model.addAttribute("unsub", unsub);
		model.addAttribute("factoryInfos", factoryInfos);
		return Common.BACKGROUND_PATH+"/examine/edit";
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
	public Map<String, Object> update(HttpServletRequest request) {
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			unsubInputService.addUnsub(request);
			map.put("flag", "true");
		} catch (Exception e) {
			map.put("flag", "false");
		}
		return map;
	}
}
