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
@Table(name = "t_village_require_vo")
@TableName("t_village_require_vo")
@ApiModel(value = "考核情况")
public class VillageRequireVo extends XbootBaseEntity {

    private static final long serialVersionUID = 1L;

    @ApiModelProperty(value = "年")
    private String year;

    @ApiModelProperty(value = "月")
    private String mouth;

    @ApiModelProperty(value = "考核规则ID")
    private String requireId;

    @ApiModelProperty(value = "考核规则标题")
    private String requireTitle;

    @ApiModelProperty(value = "考核类型")
    private String requireType;

    @ApiModelProperty(value = "原因")
    private String reason;

    @ApiModelProperty(value = "原因1")
    private String reason1;

    @ApiModelProperty(value = "村ID")
    private String villageId;

    @ApiModelProperty(value = "村名")
    private String villageName;

    @ApiModelProperty(value = "考核成绩")
    private float grade;

    @ApiModelProperty(value = "考核保存成绩")
    private float grade1;
}