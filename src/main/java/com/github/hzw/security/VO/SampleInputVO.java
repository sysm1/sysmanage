package com.github.hzw.security.VO;

import java.util.Date;

import org.codehaus.jackson.map.annotate.JsonSerialize;

import com.github.hzw.util.DateUtil;
import com.github.hzw.util.ExcelDataMapper;
import com.github.hzw.util.JsonDate4YYYYMMDD;

/**
 * 前台页面显示 开版录入VO类
 * @author wuyb
 *
 */
public class SampleInputVO {
	
    private Integer id;

    private Date sampleDate;

    private String sampleDateStr; // 日期    
    
    private Integer factoryId;
    
    /***工厂名称**/
    private String factoryName;  // 工厂

    private Integer clothId;
    
    /***布种名称**/
    private String clothName;

    private Integer codeType;
    
    /**编号值**/
    private String codeValue;

    private String fileCode;

    private String factoryCode;

    private String myCompanyCode; // 我司编号

    private String factoryCodeStr; // 工厂编号（2）
    
    private String factoryColorStr; // 工厂color(多个)
    
    private Integer technologyId;
    
    private String technologyName;  // 工艺

    private Integer salemanId;

    private String picture;

    private Integer status;
    
    private String statusStr; // 状态
    
    private Date replyDate;

    private String replyDateStr; // 回版日期
    
    private Date createTime;
    
    /**回版备注**/
    private String replyMark;  // 回版备注

    @ExcelDataMapper(title="id",order=1)
    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    
    @JsonSerialize(using=JsonDate4YYYYMMDD.class)
    public Date getSampleDate() {
        return sampleDate;
    }

    public void setSampleDate(Date sampleDate) {
        this.sampleDate = sampleDate;
        this.sampleDateStr = DateUtil.date2Str(sampleDate, "yyyy-MM-dd");
    }
    
    public Integer getFactoryId() {
        return factoryId;
    }

    public void setFactoryId(Integer factoryId) {
        this.factoryId = factoryId;
    }

    @ExcelDataMapper(title="工厂",order=7)
    public String getFactoryName() {
		return factoryName;
	}

	public void setFactoryName(String factoryName) {
		this.factoryName = factoryName;
	}
    
    public Integer getClothId() {
        return clothId;
    }

    public void setClothId(Integer clothId) {
        this.clothId = clothId;
    }
    
    @ExcelDataMapper(title="布种",order=5)
    public String getClothName() {
		return clothName;
	}

	public void setClothName(String clothName) {
		this.clothName = clothName;
	}

    public Integer getCodeType() {
        return codeType;
    }

    public void setCodeType(Integer codeType) {
        this.codeType = codeType;
    }
    
   
    public String getCodeValue() {
		return codeValue;
	}

	public void setCodeValue(String codeValue) {
		this.codeValue = codeValue;
	}

	@ExcelDataMapper(title="分色文件号",order=4)
    public String getFileCode() {
        return fileCode;
    }

    public void setFileCode(String fileCode) {
        this.fileCode = fileCode;
    }

    
    public String getFactoryCode() {
        return factoryCode;
    }

    public void setFactoryCode(String factoryCode) {
        this.factoryCode = factoryCode;
    }

    @ExcelDataMapper(title="我司编号",order=6)
    public String getMyCompanyCode() {
        return myCompanyCode;
    }

    public void setMyCompanyCode(String myCompanyCode) {
        this.myCompanyCode = myCompanyCode;
    }

    
    public Integer getTechnologyId() {
        return technologyId;
    }

    public void setTechnologyId(Integer technologyId) {
        this.technologyId = technologyId;
    }
    
    @ExcelDataMapper(title="工艺",order=8)
    public String getTechnologyName() {
		return technologyName;
	}

	public void setTechnologyName(String technologyName) {
		this.technologyName = technologyName;
	}

	@ExcelDataMapper(title="开版日期",order=3)
    public String getSampleDateStr() {
		return sampleDateStr;
	}

	public void setSampleDateStr(String sampleDateStr) {
		this.sampleDateStr = sampleDateStr;
	}

	@ExcelDataMapper(title="工厂编号",order=10)
	public String getFactoryCodeStr() {
		return factoryCodeStr;
	}

	public void setFactoryCodeStr(String factoryCodeStr) {
		this.factoryCodeStr = factoryCodeStr;
	}

	@ExcelDataMapper(title="工厂颜色",order=11)
	public String getFactoryColorStr() {
		return factoryColorStr;
	}

	public void setFactoryColorStr(String factoryColorStr) {
		this.factoryColorStr = factoryColorStr;
	}

	@ExcelDataMapper(title="状态",order=2)
	public String getStatusStr() {
		return statusStr;
	}

	public void setStatusStr(String statusStr) {
		this.statusStr = statusStr;
	}

	@ExcelDataMapper(title="回版日期",order=12)
	public String getReplyDateStr() {
		return replyDateStr;
	}

	public void setReplyDateStr(String replyDateStr) {
		this.replyDateStr = replyDateStr;
	}

	public Integer getSalemanId() {
        return salemanId;
    }

    public void setSalemanId(Integer salemanId) {
        this.salemanId = salemanId;
    }

    public String getPicture() {
        return picture;
    }

    
    public void setPicture(String picture) {
        this.picture = picture;
    }

    
    public Integer getStatus() {
        return status;
    }

    
    public void setStatus(Integer status) {
        this.status = status;
    }

    
    public Date getReplyDate() {
        return replyDate;
    }

    
    public void setReplyDate(Date replyDate) {
        this.replyDate = replyDate;
    }

    
    public Date getCreateTime() {
        return createTime;
    }

    
    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }
    
    private String demand;

    
    private String mark;  // 开版录入备注

	public String getDemand() {
		return demand;
	}

	public void setDemand(String demand) {
		this.demand = demand;
	}

	@ExcelDataMapper(title="开版备注",order=9)
	public String getMark() {
		return mark;
	}

	public void setMark(String mark) {
		this.mark = mark;
	}

	/**
	 * 回版备注
	 * @return
	 */
	@ExcelDataMapper(title="回版备注",order=13)
	public String getReplyMark() {
		return replyMark;
	}

	/**
	 * 回版备注
	 * @param replyMark 回版备注
	 */
	public void setReplyMark(String replyMark) {
		this.replyMark = replyMark;
	}

	@Override
	public String toString() {
		return "SampleInput [id=" + id + ", sampleDate=" + sampleDate
				+ ", factoryId=" + factoryId + ", clothId=" + clothId
				+ ", codeType=" + codeType + ", fileCode=" + fileCode
				+ ", factoryCode=" + factoryCode + ", myCompanyCode="
				+ myCompanyCode + ", technologyId=" + technologyId
				+ ", salemanId=" + salemanId + ", picture=" + picture
				+ ", status=" + status + ", replyDate=" + replyDate
				+ ", createTime=" + createTime + ", demand=" + demand
				+ ", mark=" + mark + "]";
	}
    
	
    
}