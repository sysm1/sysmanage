package com.github.hzw.security.entity;

import com.github.hzw.util.ExcelDataMapper;

public class FactoryInfo {

	private Integer id;

    private String name;

    private String pinyin;
    
    private String mark;
    
    private Integer cityId;
    
    private String cityName;
    
    private Integer status;
    
    private String statusName;
    
    private String isdefault;

    @ExcelDataMapper(title="id",order=1)
    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    @ExcelDataMapper(title="工厂名称",order=2)
    public String getName() {
        return name;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column factory_info.name
     *
     * @param name the value for factory_info.name
     *
     * @mbggenerated Fri Feb 20 21:33:50 CST 2015
     */
    public void setName(String name) {
        this.name = name;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column factory_info.code
     *
     * @return the value of factory_info.code
     *
     * @mbggenerated Fri Feb 20 21:33:50 CST 2015
     */
    /**
    @ExcelDataMapper(title="工厂编号",order=3)
    public String getCode() {
        return code;
    }
	**/
    
    
    

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column factory_info.mark
     *
     * @return the value of factory_info.mark
     *
     * @mbggenerated Fri Feb 20 21:33:50 CST 2015
     */
    @ExcelDataMapper(title="备注",order=5)
    public String getMark() {
        return mark;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column factory_info.mark
     *
     * @param mark the value for factory_info.mark
     *
     * @mbggenerated Fri Feb 20 21:33:50 CST 2015
     */
    public void setMark(String mark) {
        this.mark = mark;
    }

	public String getPinyin() {
		return pinyin;
	}

	public void setPinyin(String pinyin) {
		this.pinyin = pinyin;
	}

	@Override
	public String toString() {
		return "FactoryInfo [id=" + id + ", name=" + name + ", pinyin="
				+ pinyin + ", mark=" + mark + "]";
	}

	public Integer getCityId() {
		return cityId;
	}

	public void setCityId(Integer cityId) {
		this.cityId = cityId;
	}

	public String getCityName() {
		return cityName;
	}

	public void setCityName(String cityName) {
		this.cityName = cityName;
	}

	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}

	public String getStatusName() {
		return statusName;
	}

	public void setStatusName(String statusName) {
		this.statusName = statusName;
	}

	public String getIsdefault() {
		return isdefault;
	}

	public void setIsdefault(String isdefault) {
		this.isdefault = isdefault;
	}
    
}