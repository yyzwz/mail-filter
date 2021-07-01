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
@Table(name = "t_assessment_line_item")
@TableName("t_assessment_line_item")
@ApiModel(value = "考核线要求")
public class AssessmentLineItem extends XbootBaseEntity {

    private static final long serialVersionUID = 1L;

    @ApiModelProperty(value = "考核线Id")
    private String lineId;

    @ApiModelProperty(value = "考核线")
    private String lineName;

    @ApiModelProperty(value = "考核细要求")
    private String itemTitle;

    @ApiModelProperty(value = "排序值")
    private int sortLevel;

    @ApiModelProperty(value = "备注")
    private String remark;
}