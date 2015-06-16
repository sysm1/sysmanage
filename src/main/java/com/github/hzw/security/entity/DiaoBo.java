package com.github.hzw.security.entity;

import java.util.Date;

import org.codehaus.jackson.map.annotate.JsonSerialize;

import com.github.hzw.util.JsonDate4YYYYMMDD;

public class DiaoBo implements java.io.Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private Integer id;
	
	private Date riqi;
	
	private Integer dcdanwei;
	
	private String dcdanweiName;
	
	private Integer clothId;
	
	private String clothName;
	
	private Integer num;
	
	private Integer numKg;
	
	private Integer drdanwei;
	
	private String drdanweiName;
	
	private String mark;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Integer getDcdanwei() {
		return dcdanwei;
	}

	public void setDcdanwei(Integer dcdanwei) {
		this.dcdanwei = dcdanwei;
	}

	public Integer getClothId() {
		return clothId;
	}

	public void setClothId(Integer clothId) {
		this.clothId = clothId;
	}

	public Integer getNum() {
		return num;
	}

	public void setNum(Integer num) {
		this.num = num;
	}

	public Integer getNumKg() {
		return numKg;
	}

	public void setNumKg(Integer numKg) {
		this.numKg = numKg;
	}

	public Integer getDrdanwei() {
		return drdanwei;
	}

	public void setDrdanwei(Integer drdanwei) {
		this.drdanwei = drdanwei;
	}

	public String getMark() {
		return mark;
	}

	public void setMark(String mark) {
		this.mark = mark;
	}
	@JsonSerialize(using=JsonDate4YYYYMMDD.class)
	public Date getRiqi() {
		return riqi;
	}

	public void setRiqi(Date riqi) {
		this.riqi = riqi;
	}

	public String getDcdanweiName() {
		return dcdanweiName;
	}

	public void setDcdanweiName(String dcdanweiName) {
		this.dcdanweiName = dcdanweiName;
	}

	public String getDrdanweiName() {
		return drdanweiName;
	}

	public void setDrdanweiName(String drdanweiName) {
		this.drdanweiName = drdanweiName;
	}

	public String getClothName() {
		return clothName;
	}

	public void setClothName(String clothName) {
		this.clothName = clothName;
	}
	
}
