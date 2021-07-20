package cn.zwz.xboot.modules.tricycle.entity;

import cn.zwz.xboot.base.XbootBaseEntity;
import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import io.swagger.annotations.ApiModelProperty;
import io.swagger.annotations.ApiModel;
import lombok.Data;
import org.hibernate.annotations.DynamicInsert;
import org.hibernate.annotations.DynamicUpdate;
import javax.persistence.Entity;
import javax.persistence.Table;

/**
 * @author 郑为中
 */
@Data
@Entity
@DynamicInsert
@DynamicUpdate
@Table(name = "t_car")
@TableName("t_car")
@ApiModel(value = "车辆")
public class Car extends XbootBaseEntity {

    private static final long serialVersionUID = 1L;

    @ApiModelProperty(value = "保单号")
    private String bdh;

    @ApiModelProperty(value = "起保时间")
    private String baoXian;

    @ApiModelProperty(value = "保险终止时间")
    private String baoXian2;

    @ApiModelProperty(value = "文件编号")
    private int fileId;

    @ApiModelProperty(value = "出售日期")
    private String sellDate;

    @ApiModelProperty(value = "车架号")
    private String jia;

    @ApiModelProperty(value = "车骨号")
    private String gu;

    @ApiModelProperty(value = "车品牌")
    private String pinPai;

    @ApiModelProperty(value = "车型号")
    private String xingHao;

    @ApiModelProperty(value = "车类型")
    private String type;

    @ApiModelProperty(value = "发票照片")
    private String piaoPhoto;

    @ApiModelProperty(value = "车辆照片")
    private String carPhoto;

    @ApiModelProperty(value = "防盗车牌号")
    private String paiHao;

    @ApiModelProperty(value = "备注")
    private String remark;

    @ApiModelProperty(value = "违章情况")
    private String violation;

    // 卖家
    @ApiModelProperty(value = "出售日期")
    private String sellerId;

    @ApiModelProperty(value = "出售日期")
    private String sellerName;

    // 买家

    @ApiModelProperty(value = "姓名")
    private String name;

    @ApiModelProperty(value = "手机号")
    private String mobile;

    @ApiModelProperty(value = "身份证号")
    private String ownerIdcard;

    @ApiModelProperty(value = "户籍地址")
    private String addressHu;

    @ApiModelProperty(value = "住址")
    private String addressZhu;

    @ApiModelProperty(value = "户籍地址")
    private String re1;

    @ApiModelProperty(value = "户籍地址")
    private String re2;

    @ApiModelProperty(value = "是否有驾照")
    private String isJia;

    @ApiModelProperty(value = "驾照号码")
    private String jiaNumber;

    @ApiModelProperty(value = "审核")
    private String sh;

    @ApiModelProperty(value = "二维码")
    private String qrCode;
}