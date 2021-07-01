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
@Table(name = "t_roster_user_a")
@TableName("t_roster_user_a")
@ApiModel(value = "考核系统用户")
public class RosterUserA extends XbootBaseEntity {

    private static final long serialVersionUID = 1L;

    @ApiModelProperty(value = "姓名")
    private String userName;

    @ApiModelProperty(value = "手机号")
    private String mobile;

    @ApiModelProperty(value = "账号等级")
    private String level;
}