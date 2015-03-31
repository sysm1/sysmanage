package com.github.hzw.security.entity;

import java.util.Date;

import com.github.hzw.util.ExcelDataMapper;

public class ReturnGoodsProcess {
	
    private Integer id;

    private Integer summaryId;

    private Date returnDate;

    private Integer returnNum;

    private String returnUnit;

    private Integer statisticsNum;

    private String returnColor;

    private Date createTime;

    /***备注**/
    private String mark;
    
    /***包装方式 纸管**/
    private Integer zhiguan;
    
    /***包装方式 空差**/
    private Integer kongcha;
    
    /***包装方式 胶袋**/
    private Integer jiaodai;

    @ExcelDataMapper(title="id",order=1)
    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getSummaryId() {
        return summaryId;
    }

    public void setSummaryId(Integer summaryId) {
        this.summaryId = summaryId;
    }

    public Date getReturnDate() {
        return returnDate;
    }

    public void setReturnDate(Date returnDate) {
        this.returnDate = returnDate;
    }

    public Integer getReturnNum() {
        return returnNum;
    }

    public void setReturnNum(Integer returnNum) {
        this.returnNum = returnNum;
    }

    public String getReturnUnit() {
        return returnUnit;
    }

    public void setReturnUnit(String returnUnit) {
        this.returnUnit = returnUnit;
    }

    public Integer getStatisticsNum() {
        return statisticsNum;
    }

    public void setStatisticsNum(Integer statisticsNum) {
        this.statisticsNum = statisticsNum;
    }

    public String getReturnColor() {
        return returnColor;
    }

    public void setReturnColor(String returnColor) {
        this.returnColor = returnColor;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }
    public Integer getZhiguan() {
		return zhiguan;
	}

	public void setZhiguan(Integer zhiguan) {
		this.zhiguan = zhiguan;
	}

	public Integer getKongcha() {
		return kongcha;
	}

	public void setKongcha(Integer kongcha) {
		this.kongcha = kongcha;
	}

	public Integer getJiaodai() {
		return jiaodai;
	}

	public void setJiaodai(Integer jiaodai) {
		this.jiaodai = jiaodai;
	}

	/***备注**/
    public String getMark() {
        return mark;
    }
    /***备注**/
    public void setMark(String mark) {
        this.mark = mark;
    }
}