package com.github.hzw.security.entity;

import java.util.Date;

import org.codehaus.jackson.map.annotate.JsonSerialize;

import com.github.hzw.util.JsonDate4YYYYMMDD;

@SuppressWarnings("serial")
public class ClothManage implements java.io.Serializable{
	
	private Integer id;
	
	private Integer factoryId;
	
	private Integer clothId;
	
	private String color;
	
	private String clothName;
	
	private String factoryName;
	
	/**实际数量条***/
	private Integer factNum;
	
	/***实际数量KG**/
	private Double factNumKg;
	
	/**账面条数**/
	private Integer paperNum;
	
	/**账面公斤数**/
	private Double paperNumKg;
	
	/***调整条数**/
	private Integer adjustNum;
	
	private Double adjustNumKg;
	
	private Date createTime;
	
	private String mark;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Integer getFactoryId() {
		return factoryId;
	}

	public void setFactoryId(Integer factoryId) {
		this.factoryId = factoryId;
	}

	public Integer getClothId() {
		return clothId;
	}

	public void setClothId(Integer clothId) {
		this.clothId = clothId;
	}

	public String getColor() {
		return color;
	}

	public void setColor(String color) {
		this.color = color;
	}
	/**实际数量条***/
	public Integer getFactNum() {
		factNum=null==factNum?0:factNum;
		return factNum;
	}

	public void setFactNum(Integer factNum) {
		this.factNum = factNum;
	}
	/**实际数量条***/
	public Double getFactNumKg() {
		factNumKg=null==factNumKg?0.0:factNumKg;
		return factNumKg;
	}
	/**实际数量KG***/
	public void setFactNumKg(Double factNumKg) {
		this.factNumKg = factNumKg;
	}
	/**实际数量KG***/
	@JsonSerialize(using=JsonDate4YYYYMMDD.class)
	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}

	public String getMark() {
		return mark;
	}

	public void setMark(String mark) {
		this.mark = mark;
	}

	public String getClothName() {
		return clothName;
	}

	public void setClothName(String clothName) {
		this.clothName = clothName;
	}

	public String getFactoryName() {
		return factoryName;
	}

	public void setFactoryName(String factoryName) {
		this.factoryName = factoryName;
	}
	/**账面条数**/
	public Integer getPaperNum() {
		return paperNum;
	}
	/**账面条数**/
	public void setPaperNum(Integer paperNum) {
		this.paperNum = paperNum;
	}
	/**账面KG数**/
	public Double getPaperNumKg() {
		return paperNumKg;
	}
	/**账面KG数**/
	public void setPaperNumKg(Double paperNumKg) {
		this.paperNumKg = paperNumKg;
	}
	/***调整条数**/
	public Integer getAdjustNum() {
		adjustNum=factNum-(null==paperNum?0:paperNum);
		return adjustNum;
	}
	/***调整条数**/
	public void setAdjustNum(Integer adjustNum) {
		this.adjustNum = adjustNum;
	}

	public Double getAdjustNumKg() {
		adjustNumKg=factNumKg-(null==paperNumKg?0D:paperNumKg);
		return adjustNumKg;
	}

	public void setAdjustNumKg(Double adjustNumKg) {
		this.adjustNumKg = adjustNumKg;
	}
}
