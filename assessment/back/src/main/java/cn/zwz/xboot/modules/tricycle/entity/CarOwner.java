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
import java.util.List;

/**
 * @author 郑为中
 */
@Data
@Entity
@DynamicInsert
@DynamicUpdate
@Table(name = "t_car_owner")
@TableName("t_car_owner")
@ApiModel(value = "买家信息")
public class CarOwner extends XbootBaseEntity {

    private static final long serialVersionUID = 1L;

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

    @Transient
    @TableField(exist=false)
    @ApiModelProperty(value = "车辆列表")
    private List<Car> carList;
}