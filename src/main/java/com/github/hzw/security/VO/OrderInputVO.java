package com.github.hzw.security.VO;

import java.util.Date;
import java.util.List;

import org.codehaus.jackson.map.annotate.JsonSerialize;

import com.github.hzw.util.ExcelDataMapper;
import com.github.hzw.util.JsonDate4YYYYMMDD;

public class OrderInputVO {

	private Integer id;

    private Integer clothId;

    /**布种名称**/
    private String clothName;
    
    private String myCompanyCode;
    
    /***我司编号列表**/
    private List<String> myCompanyCodes;

    /***我司颜色**/
    private String myCompanyColor;
    
    private String salesmanId;
    
    private String saleManName;

    /***下单数量**/
    private Integer num;
    
    /***单位**/
    private String unit;
    
    /***单位**/
    private String unitName;
    
    /**备注**/
    private String mark;
    
    private Integer status;

    private Date createTime;
    
    private Integer technologyId;
    
    private String technologyName;
    
    private Integer cityId;

    @ExcelDataMapper(title="id",order=1)
    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    @ExcelDataMapper(title="布种",order=2)
    public Integer getClothId() {
        return clothId;
    }

    public void setClothId(Integer clothId) {
        this.clothId = clothId;
    }

    @ExcelDataMapper(title="我司编号",order=3)
    public String getMyCompanyCode() {
        return myCompanyCode;
    }

    public void setMyCompanyCode(String myCompanyCode) {
        this.myCompanyCode = myCompanyCode;
    }

    public String getClothName() {
		return clothName;
	}

	public void setClothName(String clothName) {
		this.clothName = clothName;
	}

	public String getMyCompanyColor() {
		return myCompanyColor;
	}

	public void setMyCompanyColor(String myCompanyColor) {
		this.myCompanyColor = myCompanyColor;
	}
	
	@ExcelDataMapper(title="业务人员",order=4)
	public String getSaleManName() {
		return saleManName;
	}

	public void setSaleManName(String saleManName) {
		this.saleManName = saleManName;
	}

	public Integer getNum() {
		return num;
	}

	public void setNum(Integer num) {
		this.num = num;
	}

	public String getMark() {
		return mark;
	}

	public void setMark(String mark) {
		this.mark = mark;
	}

	public String getUnitName() {
		if("0".equals(unit)){
			unitName="条";
		}if("1".equals(unit)){
			unitName="KG";
		}if("2".equals(unit)){
			unitName="米";
		}else if("3".equals(unit)||"4".equals(unit)){
			unitName="KG";
		}
		return unitName;
	}

	public void setUnitName(String unitName) {
		this.unitName = unitName;
	}

	/***单位 0条 1KG 2米 3码**/
	public String getUnit() {
		if("0".equals(unit)){
			unit="条";
		}if("1".equals(unit)){
			unit="KG";
		}if("2".equals(unit)){
			unit="米";
		}else if("3".equals(unit)||"4".equals(unit)){
			unit="KG";
		}
		return num+unit;
	}
	/***单位 0条 1KG 2米 3码**/
	public void setUnit(String unit) {
		this.unit = unit;
	}

	public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }
    public String getSalesmanId() {
		return salesmanId;
	}

	public void setSalesmanId(String salesmanId) {
		this.salesmanId = salesmanId;
	}

	@ExcelDataMapper(title="下单日期",order=2)
    @JsonSerialize(using=JsonDate4YYYYMMDD.class)
    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

	public List<String> getMyCompanyCodes() {
		return myCompanyCodes;
	}

	public void setMyCompanyCodes(List<String> myCompanyCodes) {
		this.myCompanyCodes = myCompanyCodes;
	}

	public Integer getTechnologyId() {
		return technologyId;
	}

	public void setTechnologyId(Integer technologyId) {
		this.technologyId = technologyId;
	}

	public String getTechnologyName() {
		return technologyName;
	}

	public void setTechnologyName(String technologyName) {
		this.technologyName = technologyName;
	}

	public Integer getCityId() {
		return cityId;
	}

	public void setCityId(Integer cityId) {
		this.cityId = cityId;
	}
	
	
}