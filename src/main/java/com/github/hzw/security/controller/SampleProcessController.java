package com.github.hzw.security.controller;

import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.github.hzw.security.entity.ClothInfo;
import com.github.hzw.security.entity.FactoryInfo;
import com.github.hzw.security.entity.Resources;
import com.github.hzw.security.entity.SampleInput;
import com.github.hzw.security.service.ClothInfoService;
import com.github.hzw.security.service.FactoryInfoService;
import com.github.hzw.security.service.SampleInputService;
import com.github.hzw.util.Common;

/**
 * 开版进度
 * @author wuyb
 *
 */
@Controller
@RequestMapping("/background/sampleProcess/")
public class SampleProcessController extends BaseController{
	
	@Inject
	private SampleInputService sampleInputService;//开版录入service
	
	@Inject
	private FactoryInfoService factoryInfoService;
	
	@Inject
	private ClothInfoService clothInfoService;
	
	@RequestMapping("list")
	public String list(Model model, Resources menu, HttpServletRequest request,String pagesize,SampleInput sampleInput){
		String pageNow=request.getParameter("pageNow");
		pageView = sampleInputService.query(getPageView(pageNow,pagesize), sampleInput);
		List<FactoryInfo> factoryInfos=factoryInfoService.queryAll(null);
		List<ClothInfo> cloths = clothInfoService.queryAll(null);
		if(pageView.getPageNow()>pageView.getPageCount()){
			pageView.setPageNow(Integer.parseInt(pageView.getPageCount()+""));
		}
		model.addAttribute("pageView", pageView);
		model.addAttribute("factoryInfos", factoryInfos);
		model.addAttribute("cloths", cloths);
		model.addAttribute("bean", sampleInput);
		return Common.BACKGROUND_PATH+"/sampleProcess/list";
	}
	@RequestMapping("saveTemp")
	public String saveTemp(SampleInput sampleInput){
		SampleInput bean=new SampleInput();
		try {
			bean=sampleInputService.getById(sampleInput.getId()+"");
			if(null!=sampleInput.getMyCompanyCode()){
				bean.setMyCompanyCode(sampleInput.getMyCompanyCode());
			}
			sampleInputService.add(bean);
		} catch (Exception e) {
			e.printStackTrace();
		}
		System.out.println("2222");
		return null;
	}

}
