package com.github.hzw.security.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.github.hzw.security.VO.SampleInputVO;
import com.github.hzw.security.entity.ClothInfo;
import com.github.hzw.security.entity.FactoryInfo;
import com.github.hzw.security.entity.Resources;
import com.github.hzw.security.entity.SampleAdditional;
import com.github.hzw.security.entity.SampleInput;
import com.github.hzw.security.entity.TechnologyInfo;
import com.github.hzw.security.service.ClothInfoService;
import com.github.hzw.security.service.FactoryInfoService;
import com.github.hzw.security.service.SampleAdditionalService;
import com.github.hzw.security.service.SampleInputService;
import com.github.hzw.security.service.TechnologyInfoService;
import com.github.hzw.util.Common;

/**
 * 开版进度
 * @author wuyb
 *
 */
@Controller
@RequestMapping("/background/sampleProcessList/")
public class SampleProcessListController extends BaseController{
	
	@Inject
	private SampleInputService sampleInputService;//开版录入service
	
	@Inject
	private FactoryInfoService factoryInfoService;
	
	@Inject
	private ClothInfoService clothInfoService;
	
	@Inject
	private SampleAdditionalService sampleAdditionalService;
	
	@Inject
	private TechnologyInfoService technologyInfoService;
	
	@SuppressWarnings("unchecked")
	@RequestMapping("list")
	public String list(Model model, Resources menu, HttpServletRequest request,String pagesize,SampleInput sampleInput){
		String pageNow=request.getParameter("pageNow");
		if(null!=sampleInput.getStatus()&&99==sampleInput.getStatus()){
			sampleInput.setStatus(null);
		}
		
		//过滤查询  查询条件
		ClothInfo cloth=new ClothInfo();
		cloth.setId(sampleInput.getClothId());
		List<ClothInfo> cloths = clothInfoService.query(getPageView(pageNow,pagesize), cloth).getRecords();
		
		FactoryInfo fac=new FactoryInfo();
		fac.setId(sampleInput.getFactoryId());
		List<FactoryInfo> factoryInfos=factoryInfoService.query(getPageView("1","10000"), fac).getRecords();
		//查询条件结束
		
		pageView = sampleInputService.queryReplay(getPageView(pageNow,pagesize), sampleInput);
		List<TechnologyInfo> technologyInfos= technologyInfoService.queryAll(null);
		if(pageView.getPageNow()>pageView.getPageCount()){
			pageView.setPageNow(Integer.parseInt(pageView.getPageCount()+""));
		}
		//解析颜色  存放到map中
		Map<Integer,Map<String,List<SampleAdditional>>> map=new HashMap<Integer,Map<String,List<SampleAdditional>>>();
		List<SampleInputVO> plist=pageView.getRecords();
		
		for(SampleInputVO sample:plist){
			Map<String,List<SampleAdditional>> facotoryCodeMap=new HashMap<String,List<SampleAdditional>>();
			SampleAdditional sampleAdditional=new SampleAdditional();
			sampleAdditional.setSampleId(sample.getId());
			List<SampleAdditional> list=sampleAdditionalService.queryAll(sampleAdditional);
			for(SampleAdditional samp:list){
				if(null==facotoryCodeMap.get(samp.getFactoryCode())){
					facotoryCodeMap.put(samp.getFactoryCode(), new ArrayList<SampleAdditional>());
				}
				facotoryCodeMap.get(samp.getFactoryCode()).add(samp);
			}
			map.put(sample.getId(), facotoryCodeMap);
		}
		model.addAttribute("map", map);
		model.addAttribute("technologyInfos", technologyInfos);
		model.addAttribute("pageView", pageView);
		if(factoryInfos.size()==1){
			model.addAttribute("factoryInfo", factoryInfos.get(0));
		}
		if(cloths.size()==1){
			model.addAttribute("cloth", cloths.get(0));
		}
		model.addAttribute("bean", sampleInput);
		return Common.BACKGROUND_PATH+"/sampleProcessList/list";
	}
	@RequestMapping("saveTemp")
	public void saveTemp(Model model,SampleInput sampleInput,HttpServletRequest request){
		SampleInput bean=new SampleInput();
		try {
			bean=sampleInputService.getById(sampleInput.getId()+"");
			if(null!=sampleInput.getMyCompanyCode()){
				bean.setMyCompanyCode(sampleInput.getMyCompanyCode());
			}
			sampleInputService.saveTemp(request, sampleInput);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	/**
	 * 已回
	 * @param model
	 * @param sampleInput
	 * @param request
	 * @return
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping("answer")
	public String answer(Model model,SampleInput sampleInput,HttpServletRequest request){
		SampleInput bean=new SampleInput();
		try {
			bean=sampleInputService.getById(sampleInput.getId()+"");
			if(null!=sampleInput.getMyCompanyCode()){
				bean.setMyCompanyCode(sampleInput.getMyCompanyCode());
			}
			String type=request.getParameter("type");
			if("1".equals(type)){
				sampleInput.setStatus(4);
			}
			sampleInputService.saveTemp(request, sampleInput);
			
			//再次查询
			String fid=request.getParameter("fid");
			String cid=request.getParameter("cid");
			SampleInput sl=new SampleInput();
			if(!"".equals(fid)){
				sl.setFactoryId(Integer.parseInt(fid));
			}
			if(!"".equals(cid)){
				sl.setClothId(Integer.parseInt(cid));
			}
			pageView = sampleInputService.query(getPageView("1",null), sl);
			List<FactoryInfo> factoryInfos=factoryInfoService.queryAll(null);
			List<ClothInfo> cloths = clothInfoService.queryAll(null);
			Map<Integer,Map<String,List<SampleAdditional>>> map=new HashMap<Integer,Map<String,List<SampleAdditional>>>();
			List<SampleInputVO> plist=pageView.getRecords();
			
			for(SampleInputVO sample:plist){
				Map<String,List<SampleAdditional>> facotoryCodeMap=new HashMap<String,List<SampleAdditional>>();
				SampleAdditional sampleAdditional=new SampleAdditional();
				sampleAdditional.setSampleId(sample.getId());
				List<SampleAdditional> list=sampleAdditionalService.queryAll(sampleAdditional);
				for(SampleAdditional samp:list){
					if(null==facotoryCodeMap.get(samp.getFactoryCode())){
						facotoryCodeMap.put(samp.getFactoryCode(), new ArrayList<SampleAdditional>());
					}
					facotoryCodeMap.get(samp.getFactoryCode()).add(samp);
				}
				map.put(sample.getId(), facotoryCodeMap);
			}
			model.addAttribute("map", map);
			model.addAttribute("pageView", pageView);
			model.addAttribute("factoryInfos", factoryInfos);
			model.addAttribute("cloths", cloths);
			model.addAttribute("bean", sampleInput);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return Common.BACKGROUND_PATH+"/sampleProcess/list";
	}
	
	/**
	 * 跑到新增界面
	 * 
	 * @param model
	 * @return
	 */
	@RequestMapping("addtoFlowerUI")
	public String addtoFlowerUI(Model model,String id) {
		SampleInput sampleInput=new SampleInput();
		sampleInput.setId(Integer.parseInt(id));
		pageView = sampleInputService.queryReplay(getPageView("1","1"), sampleInput);
		List<TechnologyInfo> technologyInfos= technologyInfoService.queryAll(null);
		//flowerInfoService.queryMycompanyCodeByCloth(clothId);
		
		List<FactoryInfo> factoryInfos=factoryInfoService.queryAll(null);
		List<ClothInfo> cloths = clothInfoService.queryAll(null);
		if(pageView.getPageNow()>pageView.getPageCount()){
			pageView.setPageNow(Integer.parseInt(pageView.getPageCount()+""));
		}
		//解析颜色  存放到map中
		SampleInputVO bean=(SampleInputVO) pageView.getRecords().get(0);
		Map<String,List<SampleAdditional>> facotoryCodeMap=new HashMap<String,List<SampleAdditional>>();
		SampleAdditional sampleAdditional=new SampleAdditional();
		sampleAdditional.setSampleId(sampleInput.getId());
		List<SampleAdditional> list=sampleAdditionalService.queryAll(sampleAdditional);
		for(SampleAdditional samp:list){
			if(null==facotoryCodeMap.get(samp.getFactoryCode())){
				facotoryCodeMap.put(samp.getFactoryCode(), new ArrayList<SampleAdditional>());
			}
			facotoryCodeMap.get(samp.getFactoryCode()).add(samp);
		}
		model.addAttribute("facotoryCodeMap", facotoryCodeMap);
		model.addAttribute("technologyInfos", technologyInfos);
		model.addAttribute("bean", bean);
		model.addAttribute("factoryInfos", factoryInfos);
		model.addAttribute("cloths", cloths);
		model.addAttribute("cloths",clothInfoService.queryAll(null));
		model.addAttribute("factorys",factoryInfoService.queryAll(null));
		model.addAttribute("technologys", this.technologyInfoService.queryAll(null));
		return Common.BACKGROUND_PATH+"/sampleProcessList/addtoFlower";
	}
	
	
	

}
