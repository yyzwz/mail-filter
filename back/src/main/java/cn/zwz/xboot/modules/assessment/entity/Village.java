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
@Table(name = "t_village")
@TableName("t_village")
@ApiModel(value = "村庄")
public class Village extends XbootBaseEntity {

    private static final long serialVersionUID = 1L;

    @ApiModelProperty(value = "村名")
    private String villageName;

    @ApiModelProperty(value = "得分临时字段")
    private float grade;

    @ApiModelProperty(value = "数据库字段名")
    private String fieldName;

    @ApiModelProperty(value = "数据库数值")
    private String fieldGrade;

    @ApiModelProperty(value = "备注")
    private String remark;
}