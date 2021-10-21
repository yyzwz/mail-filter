package cn.zwz.xboot.modules.tricycle.entity;

import cn.zwz.xboot.base.XbootBaseEntity;
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
@Table(name = "t_sh_msg")
@TableName("t_sh_msg")
@ApiModel(value = "审核信息")
public class ShMsg extends XbootBaseEntity {

    private static final long serialVersionUID = 1L;

    @ApiModelProperty(value = "审核状态")
    private String status;

    @ApiModelProperty(value = "审核类型") // 卖家资质审核  车辆新增审核  车辆修改审核
    private String type;

    @ApiModelProperty(value = "对应ID")
    private String formId;

    @ApiModelProperty(value = "卖家ID")
    private String sellerId;

    @ApiModelProperty(value = "审核时间")
    private String date;

    @ApiModelProperty(value = "审核意见")
    private String msg;

    @ApiModelProperty(value = "审核内容")
    private String name;
}