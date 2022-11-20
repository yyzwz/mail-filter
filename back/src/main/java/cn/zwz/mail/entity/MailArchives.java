package cn.zwz.mail.entity;

import cn.zwz.basics.baseClass.ZwzBaseEntity;
import com.baomidou.mybatisplus.annotation.TableName;
import io.swagger.annotations.ApiModelProperty;
import io.swagger.annotations.ApiModel;
import lombok.Data;
import org.hibernate.annotations.DynamicInsert;
import org.hibernate.annotations.DynamicUpdate;
import org.hibernate.validator.constraints.Length;

import javax.persistence.Entity;
import javax.persistence.Table;

/**
 * @author 郑为中
 */
@Data
@Entity
@DynamicInsert
@DynamicUpdate
@Table(name = "a_mail_archives")
@TableName("a_mail_archives")
@ApiModel(value = "邮件档案")
public class MailArchives extends ZwzBaseEntity {

    private static final long serialVersionUID = 1L;

    @ApiModelProperty(value = "邮件标题")
    private String title;

    @ApiModelProperty(value = "发件人ID")
    private String fromUser;

    @ApiModelProperty(value = "发件人")
    private String fromId;

    @ApiModelProperty(value = "收件人ID")
    private String toId;

    @ApiModelProperty(value = "收件人")
    private String toUser;

    @Length(max = 2048)
    @ApiModelProperty(value = "邮件内容")
    private String content;

    @ApiModelProperty(value = "发送状态",notes = "0 未发送 | 1 正常接收 | 2 垃圾箱 | 3 回收")
    private int status;

    @ApiModelProperty(value = "过滤原因")
    private String filterReason;
}