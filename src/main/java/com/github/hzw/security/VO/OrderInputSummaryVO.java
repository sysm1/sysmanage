package com.github.hzw.security.VO;

import java.sql.Date;

import org.codehaus.jackson.map.annotate.JsonSerialize;

import com.github.hzw.util.ExcelDataMapper;
import com.github.hzw.util.JsonDate4YYYYMMDD;

/**
 * 预下单录入汇总表  关键字  inputsummary
 * @author wuyb
 *
 */
public class OrderInputSummaryVO {
    
	private Integer id;
	
	/**下单汇总ID**/
	private Integer summId;

    private Integer clothId;
    
    /**布种名称**/
    private String clothName;
    
    private Date createTime;
    
    /***我司编号**/
    private String myCompanyCode;

    /***我司颜色**/
    private String myCompanyColor;

    private Integer num;
    
    private String numText;
    
    /***单位*/
    private Integer unit;

    private String orderIds;
    
    private Integer technologyId;
    
    private String technologyName;

    private String mark;
    
    private String saleManName;

    @ExcelDataMapper(title="id",order=1)
    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getClothId() {
        return clothId;
    }

    public void setClothId(Integer clothId) {
        this.clothId = clothId;
    }

    public String getClothName() {
		return clothName;
	}

	public void setClothName(String clothName) {
		this.clothName = clothName;
	}

	public String getMyCompanyCode() {
        return myCompanyCode;
    }

    public void setMyCompanyCode(String myCompanyCode) {
        this.myCompanyCode = myCompanyCode;
    }

    public String getMyCompanyColor() {
        return myCompanyColor;
    }

    public void setMyCompanyColor(String myCompanyColor) {
        this.myCompanyColor = myCompanyColor;
    }

    public Integer getNum() {
        return num;
    }

    public void setNum(Integer num) {
        this.num = num;
    }

    public String getOrderIds() {
        return orderIds;
    }

    public void setOrderIds(String orderIds) {
        this.orderIds = orderIds;
    }

    public String getMark() {
        return mark;
    }

    public void setMark(String mark) {
        this.mark = mark;
    }

	public String getSaleManName() {
		return saleManName;
	}

	public void setSaleManName(String saleManName) {
		this.saleManName = saleManName;
	}
	
	@JsonSerialize(using=JsonDate4YYYYMMDD.class)
	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}

	public Integer getSummId() {
		return summId;
	}

	public void setSummId(Integer summId) {
		this.summId = summId;
	}

	public Integer getUnit() {
		return unit;
	}

	public void setUnit(Integer unit) {
		this.unit = unit;
	}

	public String getNumText() {
		if(null==unit){
			numText="";
		}else if(0==unit){
			numText=num+"条";
		}else{
			numText=num+"KG";
		}
		return numText;
	}

	public void setNumText(String numText) {
		this.numText = numText;
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
}