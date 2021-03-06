package com.github.hzw.security.controller;

import java.io.UnsupportedEncodingException;
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
import com.github.hzw.security.VO.GlVo;
import com.github.hzw.security.entity.Account;
import com.github.hzw.security.entity.FlowerAdditional;
import com.github.hzw.security.entity.FlowerInfo;
import com.github.hzw.security.entity.Resources;
import com.github.hzw.security.entity.TechnologyInfo;
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
		Account account = (Account) request.getSession().getAttribute("userSession");
		info.setCityId(account.getCityId());
		model.addAttribute("cloths",clothInfoService.queryAll(null));
		model.addAttribute("factorys",factoryInfoService.queryAll(null));
		model.addAttribute("technologys", this.technologyInfoService.queryAll(null));
		// Map<String, Object> map = new HashMap<String, Object>();
		// String pagesize = "2";
		// pageView = flowerInfoService.queryFind(getPageView(pageNow,pagesize), map);
		String pagesize = "10";
		pageNow = StringUtils.isEmpty(pageNow) ? "1":pageNow;
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
	 * @param model
	 * 存放返回界面的model
	 * @return
	 */
	@ResponseBody
	@RequestMapping("queryColorMark")
	public String queryColorMark(FlowerAdditional flowerAdditional,String factoryCode) {
		List<FlowerAdditional> list=flowerAdditionalService.queryFind(flowerAdditional);
		if(null!=list&&list.size()>0){
			return list.get(0).getMark();
		}
		return null;
	}
	
	/**
	 * @param model
	 * 存放返回界面的model
	 * @return
	 */
	@ResponseBody
	@RequestMapping("queryFindLike")
	public List<FlowerInfo> queryFindLike(FlowerInfo info,String factoryCode,Integer clothId,String key) {
		info.setClothId(clothId);
		info.setFactoryCode(key);
		List<FlowerInfo> list=flowerInfoService.queryFindLike(info);
		List<FlowerInfo> list2=new ArrayList<FlowerInfo>();
		System.out.println(list.size());
		if(null!=list&&list.size()>0){
			for(FlowerInfo fi:list){
				if(fi.getFactoryCode().contains(",")){
					String[] code=fi.getFactoryCode().split(",");
					FlowerInfo fl=getFlowerInfo(fi);
					FlowerInfo fl2=getFlowerInfo(fi);
					fl.setFactoryCode(code[0]);
					list2.add(fl);
					fl2.setFactoryCode(code[1]);
					list2.add(fl2);
				}else{
					list2.add(fi);
				}
			}
		}
		return list2;
	}
	
	@ResponseBody
	@RequestMapping("queryFindLikeMyCode")
	public List<FlowerInfo> queryFindLikeMyCode(FlowerInfo info,String factoryCode,Integer clothId,String key) {
		info.setClothId(clothId);
		info.setMyCompanyCode(key);
		List<FlowerInfo> list=flowerInfoService.queryFindLike(info);
		return list;
	}
	
	public FlowerInfo getFlowerInfo(FlowerInfo info){
		FlowerInfo fi=new FlowerInfo();
		fi.setMyCompanyCode(info.getMyCompanyCode());
		fi.setFactoryCode(info.getFactoryCode());
		return fi;
	}
	
	@ResponseBody
	@RequestMapping("queryGlFactoryCode")
	public List<GlVo> queryGlFactoryCode(Model model,String factoryId,String technologyId,String clothId,String myCompanyCode,String myCompanyColor,String factoryCode) {
		Map<String,Object> map=new HashMap<String,Object>();
		map.put("myCompanyCode", myCompanyCode);
		map.put("myCompanyColor", myCompanyColor);
		map.put("technologyId", technologyId);
		map.put("clothId", clothId);
		map.put("factoryId", factoryId);
		map.put("factoryCode",factoryCode);
		List<GlVo> glList=flowerInfoService.queryGlFactoryCode(map);
		List<GlVo> llist=new ArrayList<GlVo>();
		for(GlVo vo:glList){
			GlVo vot=vo;
			String[] as=vo.getFactoryCode().split(",");
			System.out.println(as.length);
			if(as.length==2){
				vot=vo;
				vot.setFactoryCode(as[0]);
				llist.add(vot);
				vot=new GlVo();
				vot.setFactoryCode(as[1]);
				llist.add(vot);
			}else{
				llist.add(vo);
			}
		}
		return llist;
	}
	
	@ResponseBody
	@RequestMapping("queryGl")
	public List<GlVo> queryGl(Model model,String factoryId,String technologyId,String clothId,String myCompanyCode,String myCompanyColor,String factoryCode) {
		Map<String,Object> map=new HashMap<String,Object>();
		map.put("myCompanyCode", myCompanyCode);
		map.put("myCompanyColor", myCompanyColor);
		map.put("technologyId", technologyId);
		map.put("clothId", clothId);
		map.put("factoryId", factoryId);
		map.put("factoryCode",factoryCode);
		List<GlVo> glList=flowerInfoService.queryGl(map);
		List<GlVo> llist=new ArrayList<GlVo>();
		for(GlVo vo:glList){
			GlVo vot=vo;
			String[] as=vo.getFactoryCode().split(",");
			System.out.println(as.length);
			if(as.length==2){
				vot=vo;
				vot.setFactoryCode(as[0]);
				llist.add(vot);
				vot=new GlVo();
				vot.setFactoryCode(as[1]);
				llist.add(vot);
			}else{
				llist.add(vo);
			}
		}
		return llist;
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
			info.setStatus(0);//修改花号基本资料初始状态为0 为可以删除的状态
			info.setPicture(info.getPicture()==null?"http://www.baidu.com/img/bdlogo.png":info.getPicture());
			info.setCreateTime(new Date());
			//验证是否资料是否重复
			List<FlowerInfo> list=flowerInfoService.queryAll(info);
			if(list.size()>0){
				List<FlowerAdditional> flist=flowerAdditionalService.queryAll(fa);
				if(flist.size()==0){
					flowerInfoService.add(info);
				}
				map.put("flag", "true");
				map.put("msg", "存在此花号基本资料");
				
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
			String[] marks = request.getParameterValues("marks");
			
			String[] myCompanyColors2 = request.getParameterValues("myCompanyColors2"); // 第2工厂编号对应的着色
			String[] factoryColors2 = request.getParameterValues("factoryColors2");
			String[] marks2 = request.getParameterValues("marks2");
			
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
					fa.setMark(marks[i]);
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
					fa.setMark(marks2[i]);
					fas.add(fa);
				}
			}
			info.setList(fas);
			//info.setStatus(1);
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
			model.addAttribute("factoryCode", factoryCodes[1]);
			model.addAttribute("factoryCode2", factoryCodes[0]);
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
					FlowerInfo flowerInfo=flowerInfoService.getById(string);
					if(flowerInfo.getStatus()==1){
						map.put("flag", "nodelete");
					}else{
						map.put("flag", "true");
						flowerInfoService.delete(string);
					}
				}
			}
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
	
	
	/**
	 * 删除
	 * 
	 * @param model
	 * @param videoTypeId
	 * @return
	 * @throws Exception 
	 */
	@ResponseBody
	@RequestMapping("updateStatus")
	public Map<String, Object> updateStatus(String ids) {
		System.out.println("ids:" + ids);
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			String id[] = ids.split(",");
			for (String string : id) {
				if(!Common.isEmpty(string)){
					FlowerInfo info = flowerInfoService.getById(string);
					int status = 1;
					if(info != null && info.getStatus() != null) {
						if(info.getStatus() == 1) {
							status = 0;
						}
					}
					flowerInfoService.updateByStatus(new Integer(string), status);
				}
			}
			
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
	@RequestMapping("addMyCompanyCode")
	public String addMyCompanyCode(Model model,Integer clothId,Integer technologyId,String code,String pageNow,String pagesize) {
		FlowerInfo flowerInfo=new FlowerInfo();
		flowerInfo.setClothId(clothId);
		flowerInfo.setTechnologyId(technologyId);
		flowerInfo.setMyCompanyCode(code);
		pageView=flowerInfoService.queryMycompanyCodeByCloth(getPageView(pageNow,pagesize), flowerInfo);
		model.addAttribute("pageView", pageView);
		model.addAttribute("clothId", clothId);
		model.addAttribute("technologyId", technologyId);
		return Common.BACKGROUND_PATH+"/flower/addMyCompanyCode";
	}
	/**
	 * 跑到新增界面
	 * 
	 * @param model
	 * @return
	 */
	@RequestMapping("addMyCompanyColor")
	public String addMyCompanyColor(Model model,Integer clothId,Integer technologyId,String code,String color,String pageNow,String pagesize) {
		FlowerInfo flowerInfo=new FlowerInfo();
		flowerInfo.setClothId(clothId);
		flowerInfo.setTechnologyId(technologyId);
		try {
			code= java.net.URLDecoder.decode(code,"UTF-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		} 
		flowerInfo.setMyCompanyCode(code);
		flowerInfo.setFactoryCode(color);
		pageView=flowerInfoService.queryMycompanyColor(getPageView(pageNow,pagesize), flowerInfo);
		model.addAttribute("pageView", pageView);
		model.addAttribute("clothId", clothId);
		model.addAttribute("color", color);
		model.addAttribute("technologyId", technologyId);
		return Common.BACKGROUND_PATH+"/flower/addMyCompanyColor";
	}
	
	/**
	 * 根据布种 关联我司编号
	 * @param clothId
	 * @return
	 */
	@ResponseBody
	@RequestMapping("queryMycompanyCodeByCloth")
	public List<String> queryMycompanyCodeByCloth(Integer clothId,Integer technologyId,String kw){
		FlowerInfo flowerInfo=new FlowerInfo();
		flowerInfo.setClothId(clothId);
		flowerInfo.setTechnologyId(technologyId);
		flowerInfo.setMyCompanyCode(kw);
		List<String> list=flowerInfoService.queryMycompanyCodeByCloth1(flowerInfo);
		return list;
	}
	
	/**
	 * 根据布种 关联我司颜色
	 * @param clothId
	 * @return
	 */
	@ResponseBody
	@RequestMapping("queryMycompanyColor")
	public List<String> queryMycompanyColor(Integer clothId,Integer technologyId,String myCompanyCode,String myCompanyColor){
		FlowerInfo flowerInfo=new FlowerInfo();
		flowerInfo.setClothId(clothId);
		flowerInfo.setTechnologyId(technologyId);
		flowerInfo.setMyCompanyCode(myCompanyCode);
		if(null!=myCompanyColor&&!"".equals(myCompanyColor)){
			flowerInfo.setFactoryCode(myCompanyColor);
		}
		List<String> list=flowerInfoService.queryMycompanyColor1(flowerInfo);
		return list;
	}
	
	/**
	 * 根据布种 关联我司颜色
	 * @param clothId
	 * @return
	 */
	@ResponseBody
	@RequestMapping("queryTechnology")
	public List<TechnologyInfo> queryTechnology(Integer clothId){
		FlowerInfo flowerInfo=new FlowerInfo();
		flowerInfo.setClothId(clothId);
		List<TechnologyInfo> list=flowerInfoService.queryTechnology(flowerInfo);
		return list;
	}
	
	/**
	 * 验证数据
	 * @param type
	 * @param value
	 * @return
	 */
	@ResponseBody
	@RequestMapping("checkValue")
	public String checkValue(Integer type,String value){
		String flag="0";
		if(type<=2){
			FlowerInfo fi=new FlowerInfo();
			
			if(type==1){
				fi.setFactoryCode(value);
			}else if(type==2){
				fi.setMyCompanyCode(value);
			}
			List<FlowerInfo> list=new ArrayList<FlowerInfo>();
			list=flowerInfoService.queryAll(fi);
			if(null!=list&&list.size()>0){
				flag="1";
			}
		}else{
			FlowerAdditional flowerAdditional=new FlowerAdditional();
			if(type==3){//我司颜色
				flowerAdditional.setMyCompanyColor(value);
			}else if(type==4){//工厂颜色
				flowerAdditional.setFactoryColor(value);
			}
			List<FlowerAdditional> lista=flowerAdditionalService.queryFind(flowerAdditional);
			if(null!=lista&&lista.size()>0){
				flag="1";
			}
		}
		return flag;
	}

}
