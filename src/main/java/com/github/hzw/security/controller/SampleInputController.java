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
import com.github.hzw.security.entity.ClothInfo;
import com.github.hzw.security.entity.FactoryInfo;
import com.github.hzw.security.entity.FlowerInfo;
import com.github.hzw.security.entity.Resources;
import com.github.hzw.security.entity.SalesmanInfo;
import com.github.hzw.security.entity.SampleInput;
import com.github.hzw.security.entity.TechnologyInfo;
import com.github.hzw.security.service.ClothInfoService;
import com.github.hzw.security.service.FactoryInfoService;
import com.github.hzw.security.service.FlowerInfoService;
import com.github.hzw.security.service.SalesmanInfoService;
import com.github.hzw.security.service.SampleInputService;
import com.github.hzw.security.service.TechnologyInfoService;
import com.github.hzw.util.Common;
import com.github.hzw.util.CompressPic;
import com.github.hzw.util.DateUtil;
import com.github.hzw.util.PropertiesUtils;
import com.github.hzw.util.UploadFileUtils;

@Controller
@RequestMapping("/background/sample/")
public class SampleInputController extends BaseController {
	
	@Inject
	private SampleInputService sampleInputService;//开版录入service
	
	@Inject
	private ClothInfoService clothInfoService;
	
	@Inject
	private FactoryInfoService factoryInfoService;
	
	@Inject
	private TechnologyInfoService technologyInfoService;
	
	@Inject
	private FlowerInfoService flowerInfoService;
	
	@Inject
	private SalesmanInfoService salesmanInfoService;
	
	private String imageFileName;

	public String getImageFileName() {
		return imageFileName;
	}
	/**
	 * 列表页面 wuyb
	 * @param model
	 * @param menu
	 * @param pageNow
	 * @return
	 */
	@RequestMapping("list")
	public String list(Model model, Resources menu, HttpServletRequest request,String pagesize,SampleInput sampleInput) {
		String pageNow=request.getParameter("pageNow");
		List<ClothInfo> cloths = clothInfoService.queryAll(null);
		List<FactoryInfo> factoryInfos=factoryInfoService.queryAll(null);
		List<TechnologyInfo> technologyInfos= technologyInfoService.queryAll(null);
		List<SalesmanInfo> salesmanInfos= salesmanInfoService.queryAll(null);
		pageView = sampleInputService.query(getPageView(pageNow,pagesize), sampleInput);
		if(pageView.getPageNow()>pageView.getPageCount()){
			pageView.setPageNow(Integer.parseInt(pageView.getPageCount()+""));
		}
		model.addAttribute("cloths", cloths);
		model.addAttribute("salesmanInfos", salesmanInfos);
		model.addAttribute("bean", sampleInput);
		model.addAttribute("factoryInfos", factoryInfos);
		model.addAttribute("technologyInfos", technologyInfos);
		model.addAttribute("pageView", pageView);
		return Common.BACKGROUND_PATH+"/sample/list";
	}
	
	/**
	 * @param model
	 * 存放返回界面的model
	 * @return
	 */
	@ResponseBody
	@RequestMapping("query")
	public PageView query(SampleInput sampleInput,String pageNow,String pagesize,Model model) {
		pageView = sampleInputService.query(getPageView(pageNow,pagesize), sampleInput);
		model.addAttribute("bean", sampleInput);
		return pageView;
	}
	
	/**
	 * 跳转到新增界面 wuyb
	 * 
	 * @param model
	 * @return
	 */
	@RequestMapping("addUI")
	public String addUI(Model model) {
		List<ClothInfo> cloths = clothInfoService.queryAll(null);
		List<FactoryInfo> factoryInfos=factoryInfoService.queryAll(null);
		List<TechnologyInfo> technologyInfos= technologyInfoService.queryAll(null);
		List<SalesmanInfo> salesmanInfos= salesmanInfoService.queryAll(null);
		model.addAttribute("cloths", cloths);
		model.addAttribute("salesmanInfos", salesmanInfos);
		model.addAttribute("factoryInfos", factoryInfos);
		model.addAttribute("technologyInfos", technologyInfos);
		model.addAttribute("nowDate", Common.fromDateY());
		return Common.BACKGROUND_PATH+"/sample/add";
	}
	
	/**
	 * 保存开版录入 wuyb
	 * @param model
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping("add")
	@ResponseBody
	public Map<String, Object> add(HttpServletRequest request) {
		Map<String, Object> map = new HashMap<String, Object>();
		String[] picPaths=UploadFileUtils.saveUploadFile(request);
		String[] sampleDates=request.getParameterValues("sampleDate");
		String[] factoryIds=request.getParameterValues("factoryId");
		String[] clothIds=request.getParameterValues("clothId");
		String[] codeTypes=request.getParameterValues("codeType");
		String[] codeValues=request.getParameterValues("codeValue");
		String[] technologyIds=request.getParameterValues("technologyId");
		String[] salemanIds=request.getParameterValues("salemanId");
		String[] marks=request.getParameterValues("mark");
		String picPath="";
		SampleInput sampleInput=new SampleInput();
		for(int i=0;i<picPaths.length;i++){
			picPath=picPaths[i];
			sampleInput=new SampleInput();
			CompressPic compressPic=new CompressPic();
			String inputDir=picPath.substring(0,picPath.lastIndexOf("/"));
			String inputFileName=picPath.substring(picPath.lastIndexOf("/"));
			String outputDir= PropertiesUtils.findPropertiesKey("small_pic_path");
			String outputFileName=inputFileName;
			//压缩图片
			compressPic.compressPic(inputDir, outputDir, inputFileName, outputFileName, 100, 100, true);
			try {
				sampleInput.setPicture(picPath);
				sampleInput.setClothId(Integer.parseInt(clothIds[i]));
				sampleInput.setSmallPicture(outputDir+outputFileName);
				sampleInput.setCodeType(Integer.parseInt(codeTypes[i]));
				sampleInput.setFactoryId(Integer.parseInt(factoryIds[i]));
				sampleInput.setSampleDate(DateUtil.str2Date(sampleDates[i],"YYYY-MM-DD"));
				sampleInput.setCodeValue(codeValues[i]);
				sampleInput.setTechnologyId(Integer.parseInt(technologyIds[i]));
				sampleInput.setSalemanId(Integer.parseInt(salemanIds[i]));
				sampleInput.setMark(marks[i]);
				sampleInput.setStatus(0);
				sampleInput.setCreateTime(new Date());
				int codeType=sampleInput.getCodeType();
				if(codeType==0){
					sampleInput.setFileCode(sampleInput.getCodeValue());
				}else if(codeType==1){
					sampleInput.setFactoryCode(sampleInput.getCodeValue());
				}else if(codeType==2){
					sampleInput.setMyCompanyCode(sampleInput.getCodeValue());
				}
				sampleInputService.add(sampleInput);
				map.put("flag", "保存成功");
			} catch (Exception e) {
				map.put("flag", "false");
				e.printStackTrace();
			}
		}
		return map;
	}
	
	/**
	 * 跳转到新增界面 wuyb
	 * 
	 * @param model
	 * @return
	 */
	@RequestMapping("editUI")
	public String editUI(Model model,String id,HttpServletRequest request ) {
		SampleInput sampleInput = sampleInputService.getById(id);
		List<ClothInfo> cloths = clothInfoService.queryAll(null);
		List<FactoryInfo> factoryInfos=factoryInfoService.queryAll(null);
		List<TechnologyInfo> technologyInfos= technologyInfoService.queryAll(null);
		List<SalesmanInfo> salesmanInfos= salesmanInfoService.queryAll(null);
		model.addAttribute("cloths", cloths);
		model.addAttribute("salesmanInfos", salesmanInfos);
		model.addAttribute("factoryInfos", factoryInfos);
		model.addAttribute("technologyInfos", technologyInfos);
		model.addAttribute("bean", sampleInput);
		model.addAttribute("copyadd", request.getParameter("copyadd"));
		return Common.BACKGROUND_PATH+"/sample/edit";
	}
	/**
	 * 更新开版录入 wuyb
	 */
	@ResponseBody
	@RequestMapping("update")
	public Map<String, Object> update(Model model, SampleInput sampleInput,HttpServletRequest request) {
		
		String picPath=UploadFileUtils.saveUploadFile(request)[0];
		if(null!=picPath){
			CompressPic compressPic=new CompressPic();
			String inputDir=picPath.substring(0,picPath.lastIndexOf("/"));
			String inputFileName=picPath.substring(picPath.lastIndexOf("/"));
			String outputDir= PropertiesUtils.findPropertiesKey("small_pic_path");
			String outputFileName=inputFileName;
			//压缩图片
			compressPic.compressPic(inputDir, outputDir, inputFileName, outputFileName, 100, 100, true);
			sampleInput.setPicture(picPath);
			sampleInput.setSmallPicture(outputDir+outputFileName);
		}else{
			SampleInput bean=new SampleInput();
			bean=sampleInputService.getById(sampleInput.getId()+"");
			sampleInput.setPicture(bean.getPicture());
			sampleInput.setSmallPicture(bean.getSmallPicture());
		}
		
		String copyadd= request.getParameter("copyadd");
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			if("copyadd".equals(copyadd)){//如果不为空  则此数据为复制新增的数据
				sampleInput.setId(null);
				sampleInput.setStatus(0);
				sampleInput.setCreateTime(new Date());
				int codeType=sampleInput.getCodeType();
				if(codeType==0){
					sampleInput.setFileCode(sampleInput.getCodeValue());
				}else if(codeType==1){
					sampleInput.setFactoryCode(sampleInput.getCodeValue());
				}else if(codeType==2){
					sampleInput.setMyCompanyCode(sampleInput.getCodeValue());
				}
				sampleInputService.add(sampleInput);
			}else{
				sampleInputService.update(sampleInput);
			}
			map.put("flag", "true");
		} catch (Exception e) {
			map.put("flag", "false");
			e.printStackTrace();
		}
		return map;
	}
	/**
	 * 删除 wuyb
	 */
	@ResponseBody
	@RequestMapping("deleteById")
	public Map<String, Object> deleteById(Model model, String ids) {
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			String id[] = ids.split(",");
			for (String string : id) {
				if(!Common.isEmpty(string)){
					sampleInputService.delete(string);
				}
			}
			map.put("flag", "true");
		} catch (Exception e) {
			map.put("flag", "false");
		}
		return map;
	}
}
