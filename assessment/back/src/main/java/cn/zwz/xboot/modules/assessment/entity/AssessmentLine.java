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
@Table(name = "t_assessment_line")
@TableName("t_assessment_line")
@ApiModel(value = "考核线")
public class AssessmentLine extends XbootBaseEntity {

    private static final long serialVersionUID = 1L;

    @ApiModelProperty(value = "考核线名称")
    private String lineName;

    @ApiModelProperty(value = "考核线类型")
    private String lineType;

    @ApiModelProperty(value = "考核线备注")
    private String lineRemark;

    @ApiModelProperty(value = "排序值")
    private int sortNumber;

    @ApiModelProperty(value = "分值")
    private String grade;

    @ApiModelProperty(value = "责任人")
    private String lineDuty;
}