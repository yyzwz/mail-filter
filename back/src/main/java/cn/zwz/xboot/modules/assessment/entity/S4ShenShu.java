package cn.zwz.xboot.modules.assessment.entity;

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
@Table(name = "t_s4_shen_shu")
@TableName("t_s4_shen_shu")
@ApiModel(value = "考核申述")
public class S4ShenShu extends XbootBaseEntity {

    private static final long serialVersionUID = 1L;

    @ApiModelProperty(value = "条线ID")
    private String requireId;

    @ApiModelProperty(value = "条线")
    private String requireText;

    @ApiModelProperty(value = "村庄ID")
    private String villageId;

    @ApiModelProperty(value = "村庄名")
    private String villageName;

    @ApiModelProperty(value = "子项ID")
    private String itemId;

    @ApiModelProperty(value = "子项")
    private String itemName;

    @ApiModelProperty(value = "考核意见")
    private String requireReason;

    @ApiModelProperty(value = "成绩")
    private float grade;

    @ApiModelProperty(value = "考核期")
    private String timeId;
}