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
import org.springframework.web.bind.annotation.ResponseBody;

import com.github.hzw.security.VO.SampleInputVO;
import com.github.hzw.security.entity.ClothInfo;
import com.github.hzw.security.entity.FactoryInfo;
import com.github.hzw.security.entity.Resources;
import com.github.hzw.security.entity.SampleAdditional;
import com.github.hzw.security.entity.SampleInput;
import com.github.hzw.security.service.ClothInfoService;
import com.github.hzw.security.service.FactoryInfoService;
import com.github.hzw.security.service.SampleAdditionalService;
import com.github.hzw.security.service.SampleInputService;
import com.github.hzw.util.Common;
import com.github.hzw.util.CompressPic;
import com.github.hzw.util.PropertiesUtils;
import com.github.hzw.util.UploadFileUtils;

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
	
	@Inject
	private SampleAdditionalService sampleAdditionalService;
	
	@SuppressWarnings("unchecked")
	@RequestMapping("list")
	public String list(Model model,String delay, Resources menu, HttpServletRequest request,String pagesize,SampleInput sampleInput){
		String pageNow=request.getParameter("pageNow");
		
		ClothInfo cloth=new ClothInfo();
		cloth.setId(sampleInput.getClothId());
		List<ClothInfo> cloths = clothInfoService.query(getPageView(pageNow,pagesize), cloth).getRecords();
		
		FactoryInfo fac=new FactoryInfo();
		fac.setId(sampleInput.getFactoryId());
		List<FactoryInfo> factoryInfos=factoryInfoService.query(getPageView(pageNow,pagesize), fac).getRecords();
		
		if(""!=delay&&null!=delay){
			sampleInput.setDelayDates(Integer.parseInt(PropertiesUtils.findPropertiesKey("sample_delay_dates")));
		}
		sampleInput.setStatus(new Integer(0));
		pageView = sampleInputService.query(getPageView(pageNow,pagesize), sampleInput);
		
		if(pageView.getPageNow()>pageView.getPageCount()){
			pageView.setPageNow(Integer.parseInt(pageView.getPageCount()+""));
		}
		
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
		//获取拖延单数
		String delayDates=sampleInputService.queryDelayDates(PropertiesUtils.findPropertiesKey("sample_delay_dates"));
		model.addAttribute("map", map);
		model.addAttribute("replyDate", Common.fromDateY());
		model.addAttribute("pageView", pageView);
		if(factoryInfos.size()==1){
			model.addAttribute("factoryInfo", factoryInfos.get(0));
		}
		if(cloths.size()==1){
			model.addAttribute("cloth", cloths.get(0));
		}
		model.addAttribute("bean", sampleInput);
		model.addAttribute("delayDates",delayDates);
		return Common.BACKGROUND_PATH+"/sampleProcess/list";
	}
	
	/**
	 * 暂存数据
	 * @param model
	 * @param sampleInput
	 * @param request
	 */
	@RequestMapping("saveTemp")
	public void saveTemp(Model model,SampleInput sampleInput,HttpServletRequest request){
		SampleInput bean=new SampleInput();
		try {
			bean=sampleInputService.getById(sampleInput.getId()+"");
			if(null!=sampleInput.getMyCompanyCode()){
				bean.setMyCompanyCode(sampleInput.getMyCompanyCode());
			}
			
			String[] picPaths=UploadFileUtils.saveUploadFile(request);
			String picPath=null;
			if(null!=picPaths){
				picPath=picPaths[0];
				CompressPic compressPic=new CompressPic();
				String inputDir=picPath.substring(0,picPath.lastIndexOf("/"));
				String inputFileName=picPath.substring(picPath.lastIndexOf("/"));
				String outputDir= PropertiesUtils.findPropertiesKey("small_pic_path");
				String outputFileName=inputFileName;
				//压缩图片
				compressPic.compressPic(inputDir, outputDir, inputFileName, outputFileName, 100, 100, true);
				sampleInput.setPicture(picPath);
				sampleInput.setSmallPicture(outputDir+outputFileName);
			}
			sampleInputService.saveTemp(request, sampleInput);
			
//			//再次查询
//			String fid=request.getParameter("fid");
//			String cid=request.getParameter("cid");
//			SampleInput sl=new SampleInput();
//			if(!"".equals(fid)){
//				sl.setFactoryId(Integer.parseInt(fid));
//			}
//			if(!"".equals(cid)){
//				sl.setClothId(Integer.parseInt(cid));
//			}
//			pageView = sampleInputService.query(getPageView("1",null), sl);
//			List<FactoryInfo> factoryInfos=factoryInfoService.queryAll(null);
//			List<ClothInfo> cloths = clothInfoService.queryAll(null);
//			Map<Integer,Map<String,List<SampleAdditional>>> map=new HashMap<Integer,Map<String,List<SampleAdditional>>>();
//			List<SampleInputVO> plist=pageView.getRecords();
//			
//			for(SampleInputVO sample:plist){
//				Map<String,List<SampleAdditional>> facotoryCodeMap=new HashMap<String,List<SampleAdditional>>();
//				SampleAdditional sampleAdditional=new SampleAdditional();
//				sampleAdditional.setSampleId(sample.getId());
//				List<SampleAdditional> list=sampleAdditionalService.queryAll(sampleAdditional);
//				for(SampleAdditional samp:list){
//					if(null==facotoryCodeMap.get(samp.getFactoryCode())){
//						facotoryCodeMap.put(samp.getFactoryCode(), new ArrayList<SampleAdditional>());
//					}
//					facotoryCodeMap.get(samp.getFactoryCode()).add(samp);
//				}
//				map.put(sample.getId(), facotoryCodeMap);
//			}
//			model.addAttribute("map", map);
//			model.addAttribute("pageView", pageView);
//			model.addAttribute("factoryInfos", factoryInfos);
//			model.addAttribute("cloths", cloths);
//			model.addAttribute("bean", sampleInput);
		} catch (Exception e) {
			e.printStackTrace();
		}
		//return Common.BACKGROUND_PATH+"/sampleProcess/list";
	}
	
	/**
	 * 已回
	 * @param model
	 * @param sampleInput
	 * @param request
	 * @return
	 */
	@ResponseBody
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
				SampleInput si=new SampleInput();
				si.setMyCompanyCode(sampleInput.getMyCompanyCode());
				
			}
			sampleInputService.saveTemp(request, sampleInput);
			
//			//再次查询
//			String fid=request.getParameter("fid");
//			String cid=request.getParameter("cid");
//			SampleInput sl=new SampleInput();
//			if(!"".equals(fid)){
//				sl.setFactoryId(Integer.parseInt(fid));
//			}
//			if(!"".equals(cid)){
//				sl.setClothId(Integer.parseInt(cid));
//			}
//			sl.setStatus(new Integer(0));
//			pageView = sampleInputService.query(getPageView("1",null), sl);
//			List<FactoryInfo> factoryInfos=factoryInfoService.queryAll(null);
//			List<ClothInfo> cloths = clothInfoService.queryAll(null);
//			
//			Map<Integer,Map<String,List<SampleAdditional>>> map=new HashMap<Integer,Map<String,List<SampleAdditional>>>();
//			List<SampleInputVO> plist=pageView.getRecords();
//			
//			for(SampleInputVO sample:plist){
//				Map<String,List<SampleAdditional>> facotoryCodeMap=new HashMap<String,List<SampleAdditional>>();
//				SampleAdditional sampleAdditional=new SampleAdditional();
//				sampleAdditional.setSampleId(sample.getId());
//				List<SampleAdditional> list=sampleAdditionalService.queryAll(sampleAdditional);
//				for(SampleAdditional samp:list){
//					if(null==facotoryCodeMap.get(samp.getFactoryCode())){
//						facotoryCodeMap.put(samp.getFactoryCode(), new ArrayList<SampleAdditional>());
//					}
//					facotoryCodeMap.get(samp.getFactoryCode()).add(samp);
//				}
//				map.put(sample.getId(), facotoryCodeMap);
//			}
//			model.addAttribute("map", map);
//			
//			model.addAttribute("pageView", pageView);
//			model.addAttribute("factoryInfos", factoryInfos);
//			model.addAttribute("cloths", cloths);
//			model.addAttribute("bean", sampleInput);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "ok";
	}
	
	/**
	 * 获取状态
	 * @param id
	 * @return
	 */
	@ResponseBody
	@RequestMapping("queryStatus")
	public Integer queryStatus(String id){
		SampleInput sampleInput=sampleInputService.getById(id);
		return sampleInput.getStatus();
	}

}
