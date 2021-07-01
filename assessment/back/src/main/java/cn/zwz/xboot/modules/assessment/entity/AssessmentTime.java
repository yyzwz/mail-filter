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
@Table(name = "t_assessment_time")
@TableName("t_assessment_time")
@ApiModel(value = "考核期")
public class AssessmentTime extends XbootBaseEntity {

    private static final long serialVersionUID = 1L;

    @ApiModelProperty(value = "考核期名称")
    private String timeName;

    @ApiModelProperty(value = "考核期名称")
    private String timeRemark;

    @ApiModelProperty(value = "排序值")
    private int sortLevel;

    @ApiModelProperty(value = "排序值")
    private String startDate;

    @ApiModelProperty(value = "排序值")
    private String endDate;

    @ApiModelProperty(value = "排序值")
    private long startCuo;

    @ApiModelProperty(value = "排序值")
    private long endCuo;
}