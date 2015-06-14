package com.github.hzw.security.controller;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.github.hzw.pulgin.mybatis.plugin.PageView;
import com.github.hzw.security.entity.FlowerAdditional;
import com.github.hzw.security.entity.FlowerInfo;
import com.github.hzw.security.entity.Resources;
import com.github.hzw.security.service.ClothInfoService;
import com.github.hzw.security.service.FactoryInfoService;
import com.github.hzw.security.service.FlowerAdditionalService;
import com.github.hzw.security.service.FlowerInfoService;
import com.github.hzw.security.service.TechnologyInfoService;
import com.github.hzw.util.Common;
import com.github.hzw.util.POIUtils;

@Controller
@RequestMapping("/background/flower/")
public class FlowerInfoController extends BaseController{

	@Inject
	private FlowerInfoService flowerInfoService;
	
	@Inject
	private ClothInfoService clothInfoService;
	@Inject
	private FactoryInfoService factoryInfoService;
	@Inject
	private TechnologyInfoService technologyInfoService;
	@Inject
	private FlowerAdditionalService flowerAdditionalService;
	
	@RequestMapping("list")
	public String list(Model model, Resources menu, String pageNow, HttpServletRequest request, FlowerInfo info) {
		
		model.addAttribute("cloths",clothInfoService.queryAll(null));
		model.addAttribute("factorys",factoryInfoService.queryAll(null));
		model.addAttribute("technologys", this.technologyInfoService.queryAll(null));
		// Map<String, Object> map = new HashMap<String, Object>();
		// String pagesize = "2";
		// pageView = flowerInfoService.queryFind(getPageView(pageNow,pagesize), map);
		String pagesize = "10";
		pageView = flowerInfoService.query(getPageView(pageNow,pagesize), info);
		model.addAttribute("info", info);
		model.addAttribute("pageView", pageView);
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
	public Map<String, Object> add(HttpServletRequest request, FlowerInfo info) {
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			String factoryCodes = request.getParameter("factoryCodes"); // 第1工厂编号
			String factoryCodes2 = request.getParameter("factoryCodes2"); // 第2工厂编号

			String[] myCompanyColors = request.getParameterValues("myCompanyColors"); // 第1工厂编号对应的着色
			String[] factoryColors = request.getParameterValues("factoryColors");
			String[] marks = request.getParameterValues("marks");
			
			String[] myCompanyColors2 = request.getParameterValues("myCompanyColors2"); // 第2工厂编号对应的着色
			String[] factoryColors2 = request.getParameterValues("factoryColors2");
			String[] mark2 = request.getParameterValues("marks2");
			
			List<FlowerAdditional> fas = new ArrayList<FlowerAdditional>();
			FlowerAdditional fa = null;
			if(StringUtils.isNotEmpty(factoryCodes)) {
				int l = myCompanyColors.length;
				for(int i = 0; i < l; i++) {
					fa = new FlowerAdditional();
					fa.setFactoryCode(factoryCodes);
					fa.setFactoryColor(factoryColors[i]);
					fa.setMyCompanyColor(myCompanyColors[i]);
					if("我司编号".equals(myCompanyColors[i])){
						continue;
					}
					fa.setMark(marks[i].equals("备注")?"":marks[i]);
					fa.setMyCompanyCode(info.getMyCompanyCode());
					fas.add(fa);
				}
			}
			
			if(StringUtils.isNotEmpty(factoryCodes2)) {
				int l = myCompanyColors2.length;
				for(int i = 0; i < l; i++) {
					fa = new FlowerAdditional();
					fa.setFactoryCode(factoryCodes2);
					fa.setFactoryColor(factoryColors2[i]);
					fa.setMyCompanyColor(myCompanyColors2[i]);
					if("我司编号".equals(myCompanyColors2[i])){
						continue;
					}
					fa.setMark(mark2[i].equals("备注")?"":mark2[i]);
					fa.setMyCompanyCode(info.getMyCompanyCode());
					fas.add(fa);
				}
			}
			
			info.setList(fas);
			info.setStatus(1);
			info.setPicture(info.getPicture()==null?"http://www.baidu.com/img/bdlogo.png":info.getPicture());
			info.setCreateTime(new Date());
			//验证是否资料是否重复
			List<FlowerInfo> list=flowerInfoService.queryAll(info);
			if(list.size()>0){
				List<FlowerAdditional> flist=flowerAdditionalService.queryAll(fa);
				if(flist.size()==0){
					flowerInfoService.add(info);
				}
			}else{
				flowerInfoService.add(info);
			}
			map.put("flag", "true");
		} catch (Exception e) {
			map.put("flag", "false");
			e.printStackTrace();
		}
		return map;
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
	public Map<String, Object> update(Model model, FlowerInfo info, HttpServletRequest request) {
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			
			String factoryCodes = request.getParameter("factoryCodes"); // 第1工厂编号
			String factoryCodes2 = request.getParameter("factoryCodes2"); // 第2工厂编号

			String[] myCompanyColors = request.getParameterValues("myCompanyColors"); // 第1工厂编号对应的着色
			String[] factoryColors = request.getParameterValues("factoryColors");
			
			String[] myCompanyColors2 = request.getParameterValues("myCompanyColors2"); // 第2工厂编号对应的着色
			String[] factoryColors2 = request.getParameterValues("factoryColors2");
			
			List<FlowerAdditional> fas = new ArrayList<FlowerAdditional>();
			FlowerAdditional fa = null;
			if(StringUtils.isNotEmpty(factoryCodes)) {
				if(myCompanyColors == null || factoryColors == null || myCompanyColors.length != factoryColors.length) {
					map.put("flag", "false");
					return map;
				}
				int l = myCompanyColors.length;
				for(int i = 0; i < l; i++) {
					fa = new FlowerAdditional();
					fa.setFactoryCode(factoryCodes);
					fa.setFactoryColor(factoryColors[i]);
					fa.setMyCompanyColor(myCompanyColors[i]);
					fa.setMyCompanyCode(info.getMyCompanyCode());
					fas.add(fa);
				}
			}
			
			if(StringUtils.isNotEmpty(factoryCodes2)) {
				if(myCompanyColors2 == null || factoryColors2 == null || myCompanyColors2.length != factoryColors2.length) {
					map.put("flag", "false");
					return map;
				}
				int l = myCompanyColors2.length;
				for(int i = 0; i < l; i++) {
					fa = new FlowerAdditional();
					fa.setFactoryCode(factoryCodes2);
					fa.setFactoryColor(factoryColors2[i]);
					fa.setMyCompanyColor(myCompanyColors2[i]);
					fa.setMyCompanyCode(info.getMyCompanyCode());
					fas.add(fa);
				}
			}
			info.setList(fas);
			info.setStatus(1);
			info.setPicture(info.getPicture()==null?"http://www.baidu.com/img/bdlogo.png":info.getPicture());
			flowerInfoService.update(info);
			
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
	public String addUI(Model model) {
		
		model.addAttribute("cloths",clothInfoService.queryAll(null));
		model.addAttribute("factorys",factoryInfoService.queryAll(null));
		model.addAttribute("technologys", this.technologyInfoService.queryAll(null));
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
		
		model.addAttribute("cloths",clothInfoService.queryAll(null));
		model.addAttribute("factorys",factoryInfoService.queryAll(null));
		model.addAttribute("technologys", this.technologyInfoService.queryAll(null));
		
		FlowerInfo info = flowerInfoService.getById(id);
		String[] factoryCodes = info.getFactoryCode().split("[,]");
		if(factoryCodes.length == 2) {
			model.addAttribute("factoryCode", factoryCodes[0]);
			model.addAttribute("factoryCode2", factoryCodes[1]);
		} else if(factoryCodes.length == 1) {
			model.addAttribute("factoryCode", factoryCodes[0]);
			model.addAttribute("factoryCode2", null);
		} else {
			model.addAttribute("factoryCode", null);
			model.addAttribute("factoryCode2", null);
		}
		model.addAttribute("flower", info);
		return Common.BACKGROUND_PATH+"/flower/edit";
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
	
	@RequestMapping("colorDetail")
	public String colorDetail(Model model,Integer flowerId) {
		
		List<FlowerAdditional> list = flowerAdditionalService.findByFlowerId(flowerId);
		model.addAttribute("list", list);
		
		return Common.BACKGROUND_PATH+"/flower/colorDetail";
	}
	
	@RequestMapping("exportExcel")
	public void exportExcel(HttpServletRequest request, HttpServletResponse response) {
		String beginTime = request.getParameter("beginTime");
		String endTime = request.getParameter("endTime");
		//List<FlowerInfo> acs = flowerInfoService.queryAll(info);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("beginTime", beginTime);
		map.put("endTime", endTime);
		List<FlowerInfo> acs = flowerInfoService.queryReport(map);
		POIUtils.exportToExcel(response, "花号报表", acs, FlowerInfo.class, "花号", acs.size());
	}
	

}
