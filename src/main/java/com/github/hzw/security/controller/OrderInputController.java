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
import com.github.hzw.security.VO.OrderInputVO;
import com.github.hzw.security.entity.ClothInfo;
import com.github.hzw.security.entity.FlowerInfo;
import com.github.hzw.security.entity.OrderInput;
import com.github.hzw.security.entity.OrderInputAdditional;
import com.github.hzw.security.entity.Resources;
import com.github.hzw.security.entity.SalesmanInfo;
import com.github.hzw.security.entity.TechnologyInfo;
import com.github.hzw.security.service.AccountService;
import com.github.hzw.security.service.ClothInfoService;
import com.github.hzw.security.service.FactoryInfoService;
import com.github.hzw.security.service.FlowerInfoService;
import com.github.hzw.security.service.OrderInputAdditionalService;
import com.github.hzw.security.service.OrderInputService;
import com.github.hzw.security.service.SalesmanInfoService;
import com.github.hzw.security.service.SampleInputService;
import com.github.hzw.security.service.TechnologyInfoService;
import com.github.hzw.util.Common;
import com.github.hzw.util.POIUtils;

@Controller
@RequestMapping("/background/input/")
public class OrderInputController extends BaseController {

	@Inject
	private OrderInputService orderInputService;
	
	@Inject
	private OrderInputAdditionalService orderInputAdditionalService;
	
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
	
	@Inject
	private FlowerInfoService flowerInfoService;
	
	@RequestMapping("list")
	public String list(Model model, Resources menu, OrderInputVO info,String pageNow,String pagesize) {
		List<ClothInfo> cloths = clothInfoService.queryAll(null);
		System.out.println("下单预录入查询 布种："+cloths.size());
		List<SalesmanInfo> salesmanInfos= salesmanInfoService.queryAll(null);
		System.out.println("下单预录入查询 业务员："+salesmanInfos.size());
		List<String> myCompanyCodes=flowerInfoService.queryMycompanyCodeByCloth(null);
		List<TechnologyInfo> technologys=technologyInfoService.queryAll(null);
		pageView = orderInputService.queryVO(getPageView(pageNow,pagesize), info);
		model.addAttribute("pageView", pageView);
		model.addAttribute("cloths", cloths);
		model.addAttribute("technologys", technologys);
		model.addAttribute("salesmanInfos", salesmanInfos);
		model.addAttribute("myCompanyCodes", myCompanyCodes);
		return Common.BACKGROUND_PATH+"/input/list";
	}
	
	/**
	 * @param model
	 * 存放返回界面的model
	 * @return
	 */
	@ResponseBody
	@RequestMapping("query")
	public PageView query(OrderInputVO info,String pageNow,String pagesize) {
		//System.out.println("==========xiadan==============：");
		pageView = orderInputService.queryVO(getPageView(pageNow,pagesize), info);
		//System.out.println("下单预录入查询："+pageView.getPageSize());
		return pageView;
	}
	
	/**
	 * @param model
	 * 查询我司编号
	 * @return
	 */
	@ResponseBody
	@RequestMapping("queryMyCode")
	public List<FlowerInfo> queryMyCode(String kw,Integer clothId,Integer technologyId) {
		//System.out.println("==========xiadan==============：");
		FlowerInfo info =new FlowerInfo();
		info.setClothId(clothId);
		info.setTechnologyId(technologyId);
		info.setMyCompanyCode(kw);
		List<FlowerInfo> list=flowerInfoService.queryMyCode(info);
		
		if(list.size()>0){
			return list;
		}
		//System.out.println("下单预录入查询："+pageView.getPageSize());
		return null;
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
	public Map<String, Object> add(HttpServletRequest request) {
		OrderInput info=new OrderInput();
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			info.setCreateTime(new Date());
			info.setStatus(0);
			info.setClothId(Integer.parseInt(request.getParameterValues("clothId")[0]));
			info.setSalesmanId(Integer.parseInt(request.getParameterValues("salesmanId")[0]));
			info.setMyCompanyCode(request.getParameterValues("myCompanyCode")[0]);
			
			orderInputService.addOrderInput(request);
			//orderInputAdditionalService.saveAddition(request,info);
			map.put("flag", "true");
		} catch (Exception e) {
			map.put("flag", "false");
			e.printStackTrace();
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
		List<ClothInfo> cloths = clothInfoService.queryAll(null);
		List<SalesmanInfo> salesmanInfos= salesmanInfoService.queryAll(null);
		List<TechnologyInfo> technologys=technologyInfoService.queryAll(null);
		model.addAttribute("cloths", cloths);
		model.addAttribute("technologys", technologys);
		model.addAttribute("salesmanInfos", salesmanInfos);
		return Common.BACKGROUND_PATH+"/input/add";
	}
	

	/**
	 * 跑到修改界面
	 * 
	 * @param model
	 * @return
	 */
	@RequestMapping("editUI")
	public String editUI(Model model,String id,String addId,HttpServletRequest request) {
		if(null!=addId&&!"".equals(addId)){
			id=orderInputAdditionalService.getById(addId).getInputId()+"";
		}
		String type=request.getParameter("type");
		OrderInput info = orderInputService.getById(id);
		List<ClothInfo> cloths = clothInfoService.queryAll(null);
		List<SalesmanInfo> salesmanInfos= salesmanInfoService.queryAll(null);
		OrderInputAdditional orderInputAdditional=new OrderInputAdditional();
		orderInputAdditional.setInputId(info.getId());
		List<OrderInputAdditional> addtionlist=orderInputAdditionalService.queryAll(orderInputAdditional);
		model.addAttribute("input", info);
		model.addAttribute("type", type);
		model.addAttribute("addtionlist", addtionlist);
		model.addAttribute("cloths", cloths);
		model.addAttribute("salesmanInfos", salesmanInfos);
		if("view".equals(type)){
			return Common.BACKGROUND_PATH+"/input/view";
		}
		return Common.BACKGROUND_PATH+"/input/edit";
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
	public Map<String, Object> update(HttpServletRequest request,Model model, OrderInput info) {
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			if(null==info.getId()){
				info.setCreateTime(new Date());
				orderInputService.add(info);//复制新增
			}else{
				orderInputService.update(info);
			}
			orderInputAdditionalService.saveAddition(request,info);
			map.put("flag", "true");
		} catch (Exception e) {
			map.put("flag", "false");
			e.printStackTrace();
		}
		return map;
	}
	
	/**
	 * 更新
	 * 
	 * @param model
	 * @return
	 * @throws Exception 
	 */
	@ResponseBody
	@RequestMapping("update2")
	public Map<String, Object> update2(HttpServletRequest request,Model model, OrderInput info) {
		orderInputService.updateOrderInput(request);
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			map.put("flag", "true");
		} catch (Exception e) {
			map.put("flag", "false");
			e.printStackTrace();
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
					orderInputService.delete(string);
				}
			}
			map.put("flag", "true");
		} catch (Exception e) {
			map.put("flag", "false");
		}
		return map;
	}
	
	@RequestMapping("exportExcel")
	public void exportExcel(HttpServletResponse response,OrderInput info) {
		 List<OrderInput> acs = orderInputService.queryAll(info);
		POIUtils.exportToExcel(response, "下单预录入报表", acs, OrderInput.class, "下单预录入", acs.size());
	}
	
	public static void main(String[] args){
		OrderInputController oc=new OrderInputController();
		oc.queryMyCode("1", 1, 1);
	}
	
}
