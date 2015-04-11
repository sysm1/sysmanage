package com.github.hzw.security.controller;

import java.util.ArrayList;
import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.github.hzw.security.entity.ClothInfo;
import com.github.hzw.security.entity.FactoryInfo;
import com.github.hzw.security.entity.TechnologyInfo;
import com.github.hzw.security.service.ClothInfoService;
import com.github.hzw.security.service.FactoryInfoService;
import com.github.hzw.security.service.TechnologyInfoService;


@Controller
@RequestMapping("/background/pinyin/")
public class AutoComboController extends BaseController {

	@Inject
	private ClothInfoService clothInfoService;
	@Inject
	private FactoryInfoService factoryInfoService;
	@Inject
	private TechnologyInfoService technologyInfoService;
	
	// @Inject
	// private SalesmanInfoService salesmanInfoService;
	
	@ResponseBody
	@RequestMapping("cloth")
	public List<ClothInfo> findcloth(String key) {
		System.out.println("cloth:" + key);
		return clothInfoService.queryPinyin(key);
	}
	
	@ResponseBody
	@RequestMapping("factory")
	public List<FactoryInfo> findfactory(String key) {
		System.out.println("factory:" + key);
		return factoryInfoService.queryPinyin(key);
	}
	
	@ResponseBody
	@RequestMapping("technology")
	public List<TechnologyInfo> findtechnology(String key){
		System.out.println("technology:" + key);
		return technologyInfoService.queryPinyin(key);
	}
	
	@ResponseBody
	@RequestMapping("list")
	public List<ReturnObject> find(String t) {
		List<ReturnObject> list = new ArrayList<ReturnObject>();
		ReturnObject r = null;
		for(int i = 1; i< 20; i++) {
			r = new ReturnObject();
			r.setId(i);
			r.setDesc(i + "desc");
			java.util.Random m = new java.util.Random(); 
			int w = m.nextInt(26);
			char c = str.charAt(w);
			System.out.println(c);
			r.setName(c + "" + i + "name");
			list.add(r);
		}
		return list;
	}
	
	String str = "abcdefghijklmnopqrstuvwxyz";
	

	public class ReturnObject {
		private int id;
		private String name;
		private String desc;
		public int getId() {
			return id;
		}
		public void setId(int id) {
			this.id = id;
		}
		public String getName() {
			return name;
		}
		public void setName(String name) {
			this.name = name;
		}
		public String getDesc() {
			return desc;
		}
		public void setDesc(String desc) {
			this.desc = desc;
		}
		
	}
	
	
}
