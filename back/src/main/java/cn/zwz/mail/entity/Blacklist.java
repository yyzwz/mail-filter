package cn.zwz.mail.entity;

import cn.zwz.basics.baseClass.ZwzBaseEntity;
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
@Table(name = "a_blacklist")
@TableName("a_blacklist")
@ApiModel(value = "黑名单档案")
public class Blacklist extends ZwzBaseEntity {

    private static final long serialVersionUID = 1L;

    @ApiModelProperty(value = "黑名单规则名称")
    private String title;

    @ApiModelProperty(value = "生效用户ID")
    private String userId;

    @ApiModelProperty(value = "拦截邮箱")
    private String mailAddress;

    @ApiModelProperty(value = "拦截用户ID")
    private String mailId;
}