package com.github.hzw.security.entity;

import java.util.Date;

import com.github.hzw.util.ExcelDataMapper;

public class ReturnGoodsProcess {
	
    private Integer id;

    private Integer summaryId;

    private Date returnDate;

    private Integer returnNum;
    
    /***回货数量KG**/
    private Double returnNumKg;

    private String returnUnit;
    
    private String clothName;
    
    private String clothId;

    private Integer statisticsNum;

    private String technologyName;
    
    private String returnColor;
    
    private String returnCode;
    
    private String myCompanyColor;
    
    private String myCompanyCode;

    private Date createTime;

    /***备注**/
    private String mark;
    
    /***包装方式 纸管**/
    private Double zhiguan;
    
    /***包装方式 空差**/
    private Double kongcha;
    
    /***包装方式 胶袋**/
    private Double jiaodai;

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
    public Double getZhiguan() {
		return zhiguan;
	}

	public void setZhiguan(Double zhiguan) {
		this.zhiguan = zhiguan;
	}

	public Double getKongcha() {
		return kongcha;
	}

	public void setKongcha(Double kongcha) {
		this.kongcha = kongcha;
	}

	public Double getJiaodai() {
		return jiaodai;
	}

	public void setJiaodai(Double jiaodai) {
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
    /***回货数量KG**/
	public Double getReturnNumKg() {
		return returnNumKg;
	}
	/***回货数量KG**/
	public void setReturnNumKg(Double returnNumKg) {
		this.returnNumKg = returnNumKg;
	}

	public String getReturnCode() {
		return returnCode;
	}

	public void setReturnCode(String returnCode) {
		this.returnCode = returnCode;
	}

	public String getClothName() {
		return clothName;
	}

	public void setClothName(String clothName) {
		this.clothName = clothName;
	}

	public String getClothId() {
		return clothId;
	}

	public void setClothId(String clothId) {
		this.clothId = clothId;
	}

	public String getMyCompanyColor() {
		return myCompanyColor;
	}

	public void setMyCompanyColor(String myCompanyColor) {
		this.myCompanyColor = myCompanyColor;
	}

	public String getMyCompanyCode() {
		return myCompanyCode;
	}

	public void setMyCompanyCode(String myCompanyCode) {
		this.myCompanyCode = myCompanyCode;
	}

	public String getTechnologyName() {
		return technologyName;
	}

	public void setTechnologyName(String technologyName) {
		this.technologyName = technologyName;
	}
}