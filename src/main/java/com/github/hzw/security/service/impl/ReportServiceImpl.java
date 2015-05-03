package com.github.hzw.security.service.impl;

import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.github.hzw.security.entity.ClothInfo;
import com.github.hzw.security.entity.FactoryInfo;
import com.github.hzw.security.entity.FlowerAdditional;
import com.github.hzw.security.entity.FlowerInfo;
import com.github.hzw.security.entity.TechnologyInfo;
import com.github.hzw.security.service.ClothInfoService;
import com.github.hzw.security.service.FactoryInfoService;
import com.github.hzw.security.service.FlowerAdditionalService;
import com.github.hzw.security.service.FlowerInfoService;
import com.github.hzw.security.service.ReportService;
import com.github.hzw.security.service.TechnologyInfoService;
import com.github.hzw.util.PinyinUtil;


@Transactional
@Service("reportService")
public class ReportServiceImpl implements ReportService {

	public static final Logger logger = LoggerFactory.getLogger(ReportServiceImpl.class);  
	
	@Resource
	private ClothInfoService clothInfoService;
	@Resource
	private FactoryInfoService factoryInfoService;
	@Resource
	private FlowerInfoService flowerInfoService;
	
	@Resource
	private TechnologyInfoService technologyInfoService;
	@Resource
	private FlowerAdditionalService flowerAdditionalService;
	
	public void importFlower(List<List<String>> list) throws Exception{
		
		FlowerInfo info = null;
		for (List<String> l1 : list) {
			info = new FlowerInfo();
			if (l1 == null) {
				continue;
			}

			// 0
			String factoryName = (String) l1.get(0);
			if (StringUtils.isEmpty(factoryName)) {
				continue;
			}
			
			FactoryInfo factoryInfo = factoryInfoService.isExist(factoryName
					.trim());
			if (factoryInfo == null) {
				factoryInfo = new FactoryInfo();
				factoryInfo.setMark(factoryName);
				factoryInfo.setName(factoryName);
				factoryInfo.setPinyin(PinyinUtil.getPinYinHeadChar(factoryName)
						.toUpperCase());
				factoryInfoService.add(factoryInfo);
			}
			info.setFactoryId(factoryInfo.getId());

			// 1
			String myCompanyCode = (String) l1.get(1);
			if (StringUtils.isEmpty(myCompanyCode)) {
				continue;
			}
			info.setMyCompanyCode(myCompanyCode);

			// 2
			String clothName = (String) l1.get(2);
			if (StringUtils.isEmpty(clothName)) {
				continue;
			}

			ClothInfo clothInfo = clothInfoService.isExist(clothName.trim());
			if (clothInfo == null) {
				clothInfo = new ClothInfo();
				clothInfo.setClothName(clothName.trim());
				clothInfo.setCreateTime(new Date());
				clothInfo.setLossRate(1);
				clothInfo.setMark(clothName);
				clothInfo.setOrderName(clothName);
				clothInfo.setPinyin(PinyinUtil.getPinYinHeadChar(clothName)
						.toUpperCase());
				clothInfo.setTiaoKg(1.0);
				clothInfo.setUnit(0);
				// clothInfo.setUnitName(unitName);
				clothInfoService.add(clothInfo);
			}
			info.setClothId(clothInfo.getId());

			// 3
			String fileColor = (String) l1.get(3);
			info.setFileColor(fileColor);

			// 4
			String technologyName = (String) l1.get(4);
			if (StringUtils.isEmpty(technologyName)) {
				continue;
			}
			TechnologyInfo technologyInfo = technologyInfoService
					.isExist(technologyName.trim());
			if (technologyInfo == null) {
				technologyInfo = new TechnologyInfo();
				technologyInfo.setMark(technologyName);
				// technologyInfo.setMark(technologyName);
				technologyInfo.setName(technologyName);
				technologyInfo.setPinyin(PinyinUtil.getPinYinHeadChar(
						technologyName).toUpperCase());
				technologyInfoService.add(technologyInfo);
			}
			info.setTechnologyId(technologyInfo.getId());

			// 5 8
			String factoryCode1 = (String) l1.get(5);
			String factoryCode2 = (String) l1.get(8);
			String factoryCode = null;
			if (StringUtils.isNotEmpty(factoryCode1)) {
				factoryCode = factoryCode1;
			}
			if (StringUtils.isNotEmpty(factoryCode2)) {
				if (StringUtils.isNotEmpty(factoryCode)) {
					factoryCode = "," + factoryCode2;
				} else {
					factoryCode = factoryCode2;
				}
			}
			info.setFactoryCode(factoryCode);
			info.setStatus(1);
			info.setCreateTime(new Date());
			// /uploadFiles/46aaf656-80ef-43d6-8ff3-01f8379f1fd4.jpg|/uploadFiles/1cdba6f1-69b4-45c4-a088-c01f6a7706da.jpg
			info.setPicture("/uploadFiles/big.jpg|/uploadFiles/small.jpg");
			
			flowerInfoService.add(info);
			Integer flowerId = info.getId();

			// 保存附加表
			String myCompanyColor1 = (String) l1.get(6);
			String factoryColor1 = (String) l1.get(7);
			saveFlowerAdditional(flowerId, factoryCode1, myCompanyCode, myCompanyColor1, factoryColor1);
			
			String myCompanyColor2 = (String) l1.get(9);
			String factoryColor2 = (String) l1.get(10);
			saveFlowerAdditional(flowerId, factoryCode2, myCompanyCode, myCompanyColor2, factoryColor2);
			logger.info("保存成功：{} --> {}", l1, info.toString());
		}
		
		
	}
	
	private void saveFlowerAdditional(Integer flowerId, String factoryCode,
			String myCompanyCode, String myCompanyColor1, String factoryColor1) {
		try {
			if (flowerId == null || StringUtils.isEmpty(factoryCode)) {
				return;
			}
			if (StringUtils.isEmpty(myCompanyColor1)
					|| StringUtils.isEmpty(factoryColor1)) {
				return;
			}
			String[] myCompanyColor = StringUtils.split(myCompanyColor1, ",");
			String[] factoryColor = StringUtils.split(factoryColor1, ",");
			if (myCompanyColor.length != factoryColor.length) {
				return;
			}
			int m = myCompanyColor.length;
			FlowerAdditional fadd = null;
			for (int i = 0; i < m; i++) {
				fadd = new FlowerAdditional();
				fadd.setFlowerId(flowerId);
				fadd.setFactoryCode(factoryCode);
				fadd.setMyCompanyCode(myCompanyCode);
				fadd.setFactoryColor(factoryColor[i]);
				fadd.setMyCompanyColor(myCompanyColor[i]);
				fadd.setMark("excel导入");
				flowerAdditionalService.add(fadd);
				logger.info("保存add成功：{} ", fadd);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

	}
	
}
