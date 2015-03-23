package com.github.hzw.security.VO;

import java.util.Date;

import org.codehaus.jackson.map.annotate.JsonSerialize;

import com.github.hzw.util.ExcelDataMapper;
import com.github.hzw.util.JsonDate4MMDD;

// 下单录入  关键字  ordersummary
public class OrderSummaryVO {
    
    private Integer id;

    private String orderCode;

    private Date orderDate;

    private Integer clothId;
    
    /**布种名称**/
    private String clothName;

    private Integer factoryId;
    
    /***工厂名称**/
    private String factoryName;

    private Integer technologyId;
    
    /***工艺名称**/
    private String technologyName;

    private String myCompanyCode;

    private String myCompanyColor;

    private String factoryCode;

    private String factoryColor;

    private Integer clothNum;

    private Integer num;
    
    /***包装方式 纸管**/
    private Integer zhiguan;
    
    /***包装方式 空差**/
    private Integer kongcha;
    
    /***包装方式 胶袋**/
    private Integer jiaodai;
    
    /**差额**/
    private Integer balance;
    
    /**差额业务员**/
    private Integer balanceSalemanId;
    
    /***业务员名字**/
    private String saleMansName;

    private String standard;

    private String packingStyle;

    private Integer printStatus;

    private Integer printNum;

    private String status;

    private Integer returnStatus;

    private Date createtime;

    @ExcelDataMapper(title="id",order=1)
    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getOrderCode() {
        return orderCode;
    }

    public void setOrderCode(String orderCode) {
        this.orderCode = orderCode;
    }
    @ExcelDataMapper(title="下单日期",order=2)
    @JsonSerialize(using=JsonDate4MMDD.class)
    public Date getOrderDate() {
        return orderDate;
    }

    public void setOrderDate(Date orderDate) {
        this.orderDate = orderDate;
    }

    public Integer getClothId() {
        return clothId;
    }

    public void setClothId(Integer clothId) {
        this.clothId = clothId;
    }

    public Integer getFactoryId() {
        return factoryId;
    }

    public void setFactoryId(Integer factoryId) {
        this.factoryId = factoryId;
    }

    public Integer getTechnologyId() {
        return technologyId;
    }

    public void setTechnologyId(Integer technologyId) {
        this.technologyId = technologyId;
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

	/**包装方式空差**/
	public void setKongcha(Integer kongcha) {
		this.kongcha = kongcha;
	}

	/**包装方式胶袋**/
	public Integer getJiaodai() {
		return jiaodai;
	}

	/**包装方式胶袋**/
	public void setJiaodai(Integer jiaodai) {
		this.jiaodai = jiaodai;
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

    public String getFactoryCode() {
        return factoryCode;
    }

    public void setFactoryCode(String factoryCode) {
        this.factoryCode = factoryCode;
    }

    public String getFactoryColor() {
        return factoryColor;
    }

    public void setFactoryColor(String factoryColor) {
        this.factoryColor = factoryColor;
    }

    public Integer getClothNum() {
        return clothNum;
    }

    public void setClothNum(Integer clothNum) {
        this.clothNum = clothNum;
    }

    public Integer getNum() {
        return num;
    }

    public void setNum(Integer num) {
        this.num = num;
    }

    public String getStandard() {
        return standard;
    }

    public void setStandard(String standard) {
        this.standard = standard;
    }

    public String getPackingStyle() {
        return packingStyle;
    }

    public void setPackingStyle(String packingStyle) {
        this.packingStyle = packingStyle;
    }

    public Integer getPrintStatus() {
        return printStatus;
    }

    public void setPrintStatus(Integer printStatus) {
        this.printStatus = printStatus;
    }

    public Integer getBalance() {
		return balance;
	}

	public void setBalance(Integer balance) {
		this.balance = balance;
	}

	public Integer getBalanceSalemanId() {
		return balanceSalemanId;
	}

	public void setBalanceSalemanId(Integer balanceSalemanId) {
		this.balanceSalemanId = balanceSalemanId;
	}

	public Integer getPrintNum() {
        return printNum;
    }

    public void setPrintNum(Integer printNum) {
        this.printNum = printNum;
    }

    public String getStatus() {
        return status;
    }

    public String getSaleMansName() {
		return saleMansName;
	}

	public void setSaleMansName(String saleMansName) {
		this.saleMansName = saleMansName;
	}

	public void setStatus(String status) {
        this.status = status;
    }

    public Integer getReturnStatus() {
        return returnStatus;
    }

    public void setReturnStatus(Integer returnStatus) {
        this.returnStatus = returnStatus;
    }

    public Date getCreatetime() {
        return createtime;
    }

    public void setCreatetime(Date createtime) {
        this.createtime = createtime;
    }
    
    private String salesmans;

    private String mark;

	public String getSalesmans() {
		return salesmans;
	}

	public void setSalesmans(String salesmans) {
		this.salesmans = salesmans;
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

	public String getTechnologyName() {
		return technologyName;
	}

	public void setTechnologyName(String technologyName) {
		this.technologyName = technologyName;
	}

	public String getFactoryName() {
		return factoryName;
	}

	public void setFactoryName(String factoryName) {
		this.factoryName = factoryName;
	}

	@Override
	public String toString() {
		return "OrderSummary [id=" + id + ", orderCode=" + orderCode
				+ ", orderDate=" + orderDate + ", clothId=" + clothId
				+ ", factoryId=" + factoryId + ", technologyId=" + technologyId
				+ ", myCompanyCode=" + myCompanyCode + ", myCompanyColor="
				+ myCompanyColor + ", factoryCode=" + factoryCode
				+ ", factoryColor=" + factoryColor + ", clothNum=" + clothNum
				+ ", num=" + num + ", standard=" + standard + ", packingStyle="
				+ packingStyle + ", printStatus=" + printStatus + ", printNum="
				+ printNum + ", status=" + status + ", returnStatus="
				+ returnStatus + ", createtime=" + createtime + ", salesmans="
				+ salesmans + ", mark=" + mark + "]";
	}
    
    
}