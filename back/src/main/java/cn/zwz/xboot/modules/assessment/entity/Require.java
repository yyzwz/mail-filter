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
@Table(name = "t_require")
@TableName("t_require")
@ApiModel(value = "考核要求")
public class Require extends XbootBaseEntity {

    private static final long serialVersionUID = 1L;

    @ApiModelProperty(value = "提交者")
    private String userName;

    @ApiModelProperty(value = "年")
    private String year;

    @ApiModelProperty(value = "月")
    private String mouth;

    @ApiModelProperty(value = "考核要求")
    private String requireText;

    @ApiModelProperty(value = "考核类型")
    private String requireType;

    @ApiModelProperty(value = "考核标题")
    private String requireTitle;

    @ApiModelProperty(value = "发送日期")
    private String sendDate;

    @ApiModelProperty(value = "查看人")
    private String lookMan;

    @ApiModelProperty(value = "审核日期")
    private String examineDate;

    @ApiModelProperty(value = "审核状态")
    private String examineStatus;

    @ApiModelProperty(value = "审核意见")
    private String examineMsg;

    @ApiModelProperty(value = "备注")
    private String remark;
}