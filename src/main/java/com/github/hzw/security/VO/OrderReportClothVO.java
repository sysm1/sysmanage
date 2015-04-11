package com.github.hzw.security.VO;

import com.github.hzw.util.ExcelDataMapper;


public class OrderReportClothVO {
    
	
	private int factoryId;
	private String factoryName;
	
	private int clothId;
	private String clothName;
	
	private int num;
	
	private String numstr;
	
	private int clothNum;
	
	private String clothNumStr;
	
	private int unit;
	
	
	public int getFactoryId() {
		return factoryId;
	}
	public void setFactoryId(int factoryId) {
		this.factoryId = factoryId;
	}
	
	@ExcelDataMapper(title="工厂",order=2)
	public String getFactoryName() {
		return factoryName;
	}
	public void setFactoryName(String factoryName) {
		this.factoryName = factoryName;
	}
	public int getClothId() {
		return clothId;
	}
	public void setClothId(int clothId) {
		this.clothId = clothId;
	}
	
	@ExcelDataMapper(title="布种",order=1)
	public String getClothName() {
		return clothName;
	}
	
	public void setClothName(String clothName) {
		this.clothName = clothName;
	}
	
	
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
		if(this.unit == 4) {
			this.setNumstr(num + "包");
		}else{
			this.setNumstr(num + "条");
		}
	}
	
	
	public int getClothNum() {
		return clothNum;
	}
	
	public void setClothNum(int clothNum) {
		this.clothNum = clothNum;
		if(this.unit == 4) {
			this.setClothNumStr(num + "包");
		}else{
			this.setClothNumStr(num + "条");
		}
	}
	
	
	public int getUnit() {
		return unit;
	}
	public void setUnit(int unit) {
		this.unit = unit;
	}
	
	@ExcelDataMapper(title="数量",order=3)
	public String getNumstr() {
		return numstr;
	}
	public void setNumstr(String numstr) {
		this.numstr = numstr;
	}
	
	@ExcelDataMapper(title="工厂余",order=4)
	public String getClothNumStr() {
		return clothNumStr;
	}
	public void setClothNumStr(String clothNumStr) {
		this.clothNumStr = clothNumStr;
	}
	
	
}
