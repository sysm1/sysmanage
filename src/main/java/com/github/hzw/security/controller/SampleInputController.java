package com.github.hzw.security.controller;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
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
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.github.hzw.pulgin.mybatis.plugin.PageView;
import com.github.hzw.security.entity.ClothInfo;
import com.github.hzw.security.entity.FactoryInfo;
import com.github.hzw.security.entity.Resources;
import com.github.hzw.security.entity.SalesmanInfo;
import com.github.hzw.security.entity.SampleInput;
import com.github.hzw.security.entity.TechnologyInfo;
import com.github.hzw.security.service.ClothInfoService;
import com.github.hzw.security.service.FactoryInfoService;
import com.github.hzw.security.service.SalesmanInfoService;
import com.github.hzw.security.service.SampleInputService;
import com.github.hzw.security.service.TechnologyInfoService;
import com.github.hzw.util.Common;
import com.github.hzw.util.PropertiesUtils;

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
	public String list(Model model, Resources menu, String pageNow) {
		return Common.BACKGROUND_PATH+"/sample/list";
	}
	
	/**
	 * @param model
	 * 存放返回界面的model
	 * @return
	 */
	@ResponseBody
	@RequestMapping("query")
	public PageView query(SampleInput sampleInput,String pageNow,String pagesize) {
		pageView = sampleInputService.query(getPageView(pageNow,pagesize), sampleInput);
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
	public Map<String, Object> add(HttpServletRequest request,SampleInput sampleInput) {
		MultipartHttpServletRequest multipartRequest  =  (MultipartHttpServletRequest) request;  
        //  获得第1张图片（根据前台的name名称得到上传的文件）   
        MultipartFile myFile =  multipartRequest.getFile("myFile");
        final int BUFFER_SIZE = 16 * 1024 ;
        OutputStream out = null ;
        InputStream in=null;
        File  dst=null;
        //图片保存目标路径
        String dstPath=PropertiesUtils.findPropertiesKey("pic_path");
        File path=new File(dstPath);
        if(!path.exists()){
        	path.mkdirs();
        }
        String picName=myFile.getOriginalFilename();
        dst=new File(dstPath+picName);
        sampleInput.setPicture(dstPath+picName);
        try {
        	in =myFile.getInputStream();
        	out = new BufferedOutputStream( new FileOutputStream(dst), BUFFER_SIZE);
        	byte [] buffer = new byte [BUFFER_SIZE];
        	while (in.read(buffer) > 0 ) {
        		out.write(buffer);
        	}
		} catch (IOException e1) {
			e1.printStackTrace();
		}finally{
			try {
				if ( null != in) {
				in.close();
				}
				if ( null != out) {
					out.close();
				}
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
        
		Map<String, Object> map = new HashMap<String, Object>();
		try {
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
			map.put("flag", "true");
		} catch (Exception e) {
			map.put("flag", "false");
			e.printStackTrace();
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
	public String editUI(Model model,String id) {
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
		return Common.BACKGROUND_PATH+"/sample/edit";
	}
}
