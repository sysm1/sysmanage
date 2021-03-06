package com.github.hzw.security.entity;

import java.util.Date;

import org.codehaus.jackson.map.annotate.JsonSerialize;

import com.github.hzw.util.ExcelDataMapper;
import com.github.hzw.util.JsonDateSerializer;

public class ClothInfo {
	
    private Integer id;

    private String pinyin;

    private String clothName;

    private String orderName;

    private Date createTime;
    
    /**布种颜色**/
    private String colors;

    private String mark;
    
    /**布种单位 0条 1 kg 2cm 3码 4包***/
    private Integer unit;
    
    /***单位名字**/
    private String unitName;
    
    private Double tiaoKg;
    
    private String tiaoKgStr;
    
    /**这损率**/
    private int lossRate;

    /**2 停用  1正常**/
    private Integer status;
    
    private String statusName;
    
    @ExcelDataMapper(title="id",order=1)
    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    @ExcelDataMapper(title="布种名称",order=2)
    public String getClothName() {
        return clothName;
    }

    public void setClothName(String clothName) {
        this.clothName = clothName;
    }

    @ExcelDataMapper(title="下单名称",order=3)
    public String getOrderName() {
        return orderName;
    }

    public void setOrderName(String orderName) {
        this.orderName = orderName;
    }

    @ExcelDataMapper(title="创建时间",order=4)
	@JsonSerialize(using=JsonDateSerializer.class)
    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public String getMark() {
        return mark;
    }

    /**布种单位0条 1 kg 2cm 3码   4包 */
    public Integer getUnit() {
		return unit;
	}
    /**布种单位 0条 1 kg 2cm 3码   4包*/
	public void setUnit(Integer unit) {
		this.unit = unit;
	}
	/**损耗率    */
	public int getLossRate() {
		return lossRate;
	}
	/**损耗率    */
	public void setLossRate(int lossRate) {
		this.lossRate = lossRate;
	}

    public void setMark(String mark) {
        this.mark = mark;
    }
    /**单位名称**/
	public String getUnitName() {
		if(null==unit){
			unitName="";
		}else if(0==unit){
			unitName="条";
		}else if(1==unit){
			unitName="KG";
		}else if(2==unit){
			unitName="米";
		}else if(3==unit){
			unitName="码";
		}else if(4==unit){
			unitName="包";
		}
		return unitName;
	}
	/**单位名称**/
	public void setUnitName(String unitName) {
		this.unitName = unitName;
	}

	

	@Override
	public String toString() {
		return "ClothInfo [id=" + id + ", pinyin=" + pinyin + ", clothName="
				+ clothName + ", orderName=" + orderName + ", createTime="
				+ createTime + ", colors=" + colors + ", mark=" + mark
				+ ", unit=" + unit + ", unitName=" + unitName + ", tiaoKg="
				+ tiaoKg + ", tiaoKgStr=" + tiaoKgStr + ", lossRate="
				+ lossRate + ", status=" + status + ", statusName="
				+ statusName + "]";
	}

	public String getPinyin() {
		return pinyin;
	}

	public void setPinyin(String pinyin) {
		this.pinyin = pinyin;
	}

	public Double getTiaoKg() {
		return tiaoKg;
	}

	public void setTiaoKg(Double tiaoKg) {
		this.tiaoKg = tiaoKg;
	}

	public String getColors() {
		return colors;
	}

	public void setColors(String colors) {
		this.colors = colors;
	}

	public String getTiaoKgStr() {
		if(null==tiaoKg){
			tiaoKgStr="-";
		}else{
			tiaoKgStr=tiaoKg+"";
		}
		return tiaoKgStr;
	}

	public void setTiaoKgStr(String tiaoKgStr) {
		this.tiaoKgStr = tiaoKgStr;
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
	
	
}