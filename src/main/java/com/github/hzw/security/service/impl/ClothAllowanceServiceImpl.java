package com.github.hzw.security.service.impl;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.github.hzw.pulgin.mybatis.plugin.PageView;
import com.github.hzw.security.entity.ClothAllowance;
import com.github.hzw.security.entity.ClothInfo;
import com.github.hzw.security.entity.ClothUnit;
import com.github.hzw.security.mapper.ClothAllowanceMapper;
import com.github.hzw.security.service.ClothAllowanceService;
import com.github.hzw.security.service.ClothInfoService;
import com.github.hzw.security.service.ClothUnitService;
import com.github.hzw.util.MathUtil;

@Transactional
@Service("clothAllowanceService")
public class ClothAllowanceServiceImpl implements ClothAllowanceService {

	@Autowired
	private ClothAllowanceMapper clothAllowanceMapper;
	
	@Autowired
	private ClothUnitService clothUnitService;
	@Autowired
	private ClothInfoService clothInfoService;
	
	
	@Override
	public PageView query(PageView pageView, ClothAllowance t) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("paging", pageView);
		map.put("t", t);
		List<ClothAllowance> list = clothAllowanceMapper.query(map);
		pageView.setRecords(list);
		return pageView;
	}

	@Override
	public PageView queryByFind(PageView pageView, Map<String, Object> map) {
		map.put("paging", pageView);
		List<ClothAllowance> list = clothAllowanceMapper.queryByFind(map);
		pageView.setRecords(list);
		return pageView;
	}
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public ClothAllowance queryByClothAndFactory(Integer clothId, Integer factoryId,String color) {
		Map map = new HashMap();
		map.put("clothId", clothId);
		map.put("factoryId", factoryId);
		//map.put("color", color);
		return clothAllowanceMapper.queryByClothAndFactory(map);
	}
	
	@Override
	public List<ClothAllowance> queryAll(ClothAllowance t) {
		return clothAllowanceMapper.queryAll(t);
	}

	@Override
	public void delete(String id) throws Exception {
		clothAllowanceMapper.delete(id);
		
	}

	@Override
	public void update(ClothAllowance t) throws Exception {
		this.add(t);
	}

	@Override
	public ClothAllowance getById(String id) {
		return this.clothAllowanceMapper.getById(id);
	}

	/**
	 * 先从库里查找clothId,factoryId唯一的值
	 */
	@Override
	public void add(ClothAllowance t) throws Exception {
		ClothAllowance tm = this.queryByClothAndFactory(t.getClothId(), t.getFactoryId(),null);
		ClothInfo cloth = clothInfoService.getById(t.getClothId() + "");
		if(tm == null) {
			
			// 按布种单位计算
			//t.setOldSum(0.0);
			// t.setAllowance(this.changeUnit(t.getClothId(), t.getUnit(), t.getChangeSum()));
			//t.setAllowance(null==t.getChangeSum()?0:t.getChangeSum().intValue());
			t.setUnit(cloth.getUnit());
			t.setCreateTime(new Date());
			
			// 公斤
			//t.setOldSumkg(0.0);
			//t.setAllowancekg(t.getChangeSumkg());
			
			this.clothAllowanceMapper.add(t);
		} else {
			
			t.setId(tm.getId());
			/**t.setOldSum(null==tm.getAllowance()?0:tm.getAllowance().doubleValue());
			//t.setAllowance(this.changeUnit(t.getClothId(), t.getUnit(), t.getChangeSum()) + tm.getAllowance());
			t.setAllowance((null==t.getChangeSum()?0:t.getChangeSum().intValue()) + tm.getAllowance());
			t.setUnit(cloth.getUnit());
			
			// 公斤
			t.setOldSumkg(tm.getAllowancekg());
			t.setAllowancekg(tm.getAllowancekg());

			t.setCreateTime(new Date());*/
			this.clothAllowanceMapper.update(t);
		}
	}
	
	/**
	 * 先从库里查找clothId,factoryId唯一的值
	 */
	@Override
	public void addAllowance(ClothAllowance t) throws Exception {
		ClothAllowance tm = this.queryByClothAndFactory(t.getClothId(), t.getFactoryId(),null);
		ClothInfo cloth = clothInfoService.getById(t.getClothId() + "");
		if(tm == null) {
			// 按布种单位计算
			t.setOldSum(0.0);
			//t.setAllowance(null==t.getChangeSum()?0:t.getChangeSum().intValue());
			//t.setAllowancekg(t.getAllowancekg());
			t.setUnit(cloth.getUnit());
			t.setCreateTime(new Date());
			
			// 公斤
			t.setOldSumkg(0.0);
			//t.setAllowancekg(t.getChangeSumkg());
			
			this.clothAllowanceMapper.add(t);
		} else {
			t.setId(tm.getId());
			t.setUnit(cloth.getUnit());
			t.setCreateTime(new Date());
			this.clothAllowanceMapper.update(t);
		}
	}
	
	public void updateClothAllowance(ClothAllowance t){
		try {
			this.clothAllowanceMapper.update(t);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	
	// 单位转换 把（米，码，公斤转为条）
	/**
	 * 
	 * @param clothId  布种
	 * @param unitname  单位
	 * @param sum    量
	 * @throws Exception 
	 */
	public Double changeUnit(Integer clothId, String unitname, Double sum) throws Exception {
		if(sum == null) return 0.0;
		ClothUnit clothUnit = clothUnitService.queryClothId(clothId);
		if(clothUnit == null) throw new Exception("没有该布种单位");
		Double rase = 1.0;
		switch (unitname) {
		case "cm":
			rase = clothUnit.getCm();
			break;
		case "kg":
			rase = clothUnit.getKg();
			break;
		case "yard":
			rase = clothUnit.getYard();
			break;
		default:
			break;
		}
		return MathUtil.formate(sum / rase, 2); // 返回两位小数
	}

	/**
	@Override
	public ClothAllowance queryByCloth(String clothId) {
		return clothAllowanceMapper.queryByCloth(clothId);
	}
	**/
	
}
