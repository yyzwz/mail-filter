package cn.zwz.xboot.modules.tricycle.entity;

import cn.zwz.xboot.base.XbootBaseEntity;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableName;
import io.swagger.annotations.ApiModelProperty;
import io.swagger.annotations.ApiModel;
import lombok.Data;
import org.hibernate.annotations.DynamicInsert;
import org.hibernate.annotations.DynamicUpdate;
import javax.persistence.Entity;
import javax.persistence.Table;
import javax.persistence.Transient;
import java.util.ArrayList;
import java.util.List;

/**
 * @author 郑为中
 */
@Data
@Entity
@DynamicInsert
@DynamicUpdate
@Table(name = "t_seller")
@TableName("t_seller")
@ApiModel(value = "卖家")
public class Seller extends XbootBaseEntity {

    private static final long serialVersionUID = 1L;

    @ApiModelProperty(value = "店名")
    private String shopName;

    @ApiModelProperty(value = "店铺负责人")
    private String shopDuty;

    @ApiModelProperty(value = "负责人手机号")
    private String mobile;

    @ApiModelProperty(value = "负责人身份证号")
    private String idCard;

    @ApiModelProperty(value = "店铺地址")
    private String address;

    @ApiModelProperty(value = "店铺地址")
    private String addressFile;

    @ApiModelProperty(value = "工商营业执照号码")
    private String yyzz;

    @ApiModelProperty(value = "工商营业执照号码")
    private String yyzzFile;

    @ApiModelProperty(value = "备注")
    private String remark;

    @ApiModelProperty(value = "注册时间")
    private String date;

    @ApiModelProperty(value = "微信唯一标志")
    private String openId;

    @ApiModelProperty(value = "审核")
    private String sh;

    @ApiModelProperty(value = "审核")
    private String tj;

    @Transient
    @TableField(exist=false)
    @ApiModelProperty(value = "审核")
    private List<Car> carList;
}