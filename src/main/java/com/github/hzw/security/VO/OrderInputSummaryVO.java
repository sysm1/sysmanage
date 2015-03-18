package com.github.hzw.security.VO;

import com.github.hzw.util.ExcelDataMapper;

/**
 * 预下单录入汇总表  关键字  inputsummary
 * @author wuyb
 *
 */
public class OrderInputSummaryVO {
    
	private Integer id;

    private Integer clothId;
    
    /**布种名称**/
    private String clothName;
    
    private String createTime;
    
    /***我司编号**/
    private String myCompanyCode;

    /***我司颜色**/
    private String myCompanyColor;

    private Integer num;

    private String orderIds;

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

	public String getCreateTime() {
		return createTime;
	}

	public void setCreateTime(String createTime) {
		this.createTime = createTime;
	}
}