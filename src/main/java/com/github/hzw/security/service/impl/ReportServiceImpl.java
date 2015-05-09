package com.github.hzw.security.service.impl;

import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.github.hzw.security.entity.ClothAllowance;
import com.github.hzw.security.entity.ClothInfo;
import com.github.hzw.security.entity.FactoryInfo;
import com.github.hzw.security.entity.FlowerAdditional;
import com.github.hzw.security.entity.FlowerInfo;
import com.github.hzw.security.entity.OrderSummary;
import com.github.hzw.security.entity.TechnologyInfo;
import com.github.hzw.security.service.ClothAllowanceService;
import com.github.hzw.security.service.ClothInfoService;
import com.github.hzw.security.service.FactoryInfoService;
import com.github.hzw.security.service.FlowerAdditionalService;
import com.github.hzw.security.service.FlowerInfoService;
import com.github.hzw.security.service.OrderSummaryService;
import com.github.hzw.security.service.ReportService;
import com.github.hzw.security.service.TechnologyInfoService;
import com.github.hzw.util.DateUtil;
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
	
	@Resource
	private ClothAllowanceService clothAllowanceService;
	
	@Resource
	private OrderSummaryService orderSummaryService;
	
	
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
				factoryInfo.setMark("excel导入");
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
				clothInfo.setMark("excel导入");
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
	
	
	public void importAllowance(List<List<String>> list) throws Exception{
		ClothAllowance allowance = null;
		for(List<String> li : list) {
			allowance = new ClothAllowance();
			
			// 0
			String clothName = (String) li.get(0);
			if (StringUtils.isEmpty(clothName)) {
				continue;
			}

			//3
			String unit = (String) li.get(3);
			Integer i = 0; // 单位条
			if(StringUtils.isNotEmpty(unit)) {
				if("条".equals(unit.trim())){
					i = 0;
				}else if("包".equals(unit.trim())){
					i = 4;
				}else if("公斤".equals(unit.trim())){
					i = 1;
				}else if("米".equals(unit.trim())){
					i = 2;
				}else if("码".equals(unit.trim())) {
					i = 3;
				}
			}
			
			ClothInfo clothInfo = clothInfoService.isExist(clothName.trim());
			if (clothInfo == null) {
				clothInfo = new ClothInfo();
				clothInfo.setClothName(clothName.trim());
				clothInfo.setCreateTime(new Date());
				clothInfo.setLossRate(1);
				clothInfo.setMark("excel导入");
				clothInfo.setOrderName(clothName);
				clothInfo.setPinyin(PinyinUtil.getPinYinHeadChar(clothName)
						.toUpperCase());
				clothInfo.setTiaoKg(1.0);
				clothInfo.setUnit(i);
				// clothInfo.setUnitName(unitName);
				clothInfoService.add(clothInfo);
			}
			allowance.setClothId(clothInfo.getId());
			
			// 1
			String factoryName = (String) li.get(1);
			if (StringUtils.isEmpty(factoryName)) {
				continue;
			}
			
			FactoryInfo factoryInfo = factoryInfoService.isExist(factoryName
					.trim());
			if (factoryInfo == null) {
				factoryInfo = new FactoryInfo();
				factoryInfo.setMark("excel导入");
				factoryInfo.setName(factoryName);
				factoryInfo.setPinyin(PinyinUtil.getPinYinHeadChar(factoryName)
						.toUpperCase());
				factoryInfoService.add(factoryInfo);
			}
			allowance.setFactoryId(factoryInfo.getId());
			
			//2 
			try{
				String allowanceStr = (String) li.get(2);
				Integer allNum = Integer.valueOf(allowanceStr);
				// allowance.setAllowance(allNum);
				allowance.setChangeSum(allNum);
			}catch(Exception ex) {
				ex.printStackTrace();
				continue;
			}
			
			// 4
			try{
				String allowancekg = (String) li.get(4);
				Double akg = Double.valueOf(allowancekg);
				// allowance.setAllowancekg(akg);
				allowance.setChangeSumkg(akg);
			}catch(Exception ex) {
				ex.printStackTrace();
				continue;
			}
			
			allowance.setCreateTime(new Date());
			allowance.setInputDate(new Date());
			clothAllowanceService.add(allowance);
			logger.info("allowance:{}", allowance.toString());
			
		}
		
	}
	
	
	public void importSummary(List<List<String>> list) {
		
		for(List<String> li : list) {
			
			try{
				OrderSummary os = importSummaryItem(li);
				if(os != null) {
					orderSummaryService.add(os);
				}
			}catch(Exception ex) {
				ex.printStackTrace();
			}
		}
		
	}
	
	private OrderSummary importSummaryItem(List<String> list) {
		OrderSummary os = null;
		try{
			os = new OrderSummary();
			// 0
			String orderCode = list.get(0);
			os.setOrderCode(orderCode);
			
			// 1
			String orderDate = list.get(1);
			os.setOrderDate(DateUtil.str2Date(orderDate, "yyyy-MM-dd HH:mm:ss"));
			
			// 2
			String clothName = list.get(2);
			if (StringUtils.isEmpty(clothName)) {
				return null;
			}
			ClothInfo clothInfo = clothInfoService.isExist(clothName.trim());
			if (clothInfo == null) {
				clothInfo = new ClothInfo();
				clothInfo.setClothName(clothName.trim());
				clothInfo.setCreateTime(new Date());
				clothInfo.setLossRate(1);
				clothInfo.setMark("excel导入");
				clothInfo.setOrderName(clothName);
				clothInfo.setPinyin(PinyinUtil.getPinYinHeadChar(clothName).toUpperCase());
				clothInfo.setTiaoKg(1.0);
				clothInfo.setUnit(0);
				clothInfoService.add(clothInfo);
			}
			os.setClothId(clothInfo.getId());
			
			// 3  factoryName
			String factoryName = (String) list.get(3);
			if (StringUtils.isEmpty(factoryName)) {
				return null;
			}
			FactoryInfo factoryInfo = factoryInfoService.isExist(factoryName.trim());
			if (factoryInfo == null) {
				factoryInfo = new FactoryInfo();
				factoryInfo.setMark("excel导入");
				factoryInfo.setName(factoryName);
				factoryInfo.setPinyin(PinyinUtil.getPinYinHeadChar(factoryName).toUpperCase());
				factoryInfoService.add(factoryInfo);
			}
			os.setFactoryId(factoryInfo.getId());
			
			// 4 technologyName
			String technologyName = (String) list.get(4);
			if (StringUtils.isEmpty(technologyName)) {
				return null;
			}
			TechnologyInfo technologyInfo = technologyInfoService.isExist(technologyName.trim());
			if (technologyInfo == null) {
				technologyInfo = new TechnologyInfo();
				technologyInfo.setMark(technologyName);
				technologyInfo.setName(technologyName);
				technologyInfo.setPinyin(PinyinUtil.getPinYinHeadChar(technologyName).toUpperCase());
				technologyInfoService.add(technologyInfo);
			}
			os.setTechnologyId(technologyInfo.getId());
			
			// 5  myCompanyCode
			String myCompanyCode = list.get(5);
			os.setMyCompanyCode(myCompanyCode);
			
			// 6 myCompanyColor
			String myCompanyColor = list.get(6);
			os.setMyCompanyColor(myCompanyColor);
			
			// 7 factoryCode
			String factoryCode = list.get(7);
			os.setFactoryCode(factoryCode);
			
			// 8 factoryColor
			String factoryColor = list.get(8);
			os.setFactoryColor(factoryColor);
			
			// 9 cloth_num
			String clothNum = list.get(9);
			int cloth_num = Integer.parseInt(clothNum.trim());
			os.setClothNum(cloth_num);
			
			// 10 num
			String num = list.get(10);
			Double num_1 = Double.parseDouble(num.trim());
			os.setNum(num_1);
			
			os.setUnit(0);
			 
			// 11 packing_style
			os.setPackingStyle((String)list.get(11).trim());
			
			// 12 mark
			os.setMark(list.get(12));
			
			// 13 差额业务员备注
			os.setBalancemark(list.get(13));
			
			os.setPrintStatus(0);
			os.setPrintNum(0);
			
			// 14  status
			os.setStatus(list.get(14));
			
			os.setReturnStatus(0);
			os.setCreateTime(new Date());
			
			// 15 zhiguan
			String zhiguan = list.get(15);
			Double d = null;
			if(zhiguan != null){
				d = Double.parseDouble(zhiguan);
			}
			os.setZhiguan(d);
			
			// 16 kongcha
			String kongcha = list.get(16);
			Double t = null;
			if(kongcha != null){
				t = Double.parseDouble(kongcha);
			}
			os.setKongcha(t);
			
			// 17 jiaodai
			String jiaodai = list.get(17);
			Double j = null;
			if(jiaodai != null){
				j = Double.parseDouble(jiaodai);
			}
			os.setJiaodai(j);
			
			// 18 balance
			String balance = list.get(18);
			Integer b = null;
			if(balance != null){
				b = Integer.parseInt(balance);
			}
			os.setBalance(b);
			
			// 19 kuanfu
			String kuanfu = list.get(19);
			Integer k = null;
			if( kuanfu != null) {
				k = Integer.parseInt(kuanfu);
			}
			os.setKuanfu(k);
			
			// 20 kuanfufs
			String kuanfufs = list.get(20);
			Integer ks = null;
			if( kuanfufs != null) {
				ks = Integer.parseInt(kuanfufs);
			}
			os.setKuanfufs(ks);
			
			// 21 kezhongUnit
			String kezhongUnit = list.get(21);
			Integer ku = null;
			if( kezhongUnit != null) {
				ku = Integer.parseInt(kezhongUnit);
			}
			os.setKezhongUnit(ku);
			
			// 22 kezhongfs
			String kezhongfs = list.get(22);
			Integer kfs = null;
			if( kezhongfs != null) {
				kfs = Integer.parseInt(kezhongfs);
			}
			os.setKezhongfs(kfs);
			return os;
		}catch(Exception ex){
			ex.printStackTrace();
			return null;
		}

	}
	
}
