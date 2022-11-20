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
@Table(name = "a_mail_file")
@TableName("a_mail_file")
@ApiModel(value = "邮件附件")
public class MailFile extends ZwzBaseEntity {

    private static final long serialVersionUID = 1L;

    @ApiModelProperty(value = "邮件ID")
    private String mailId;

    @ApiModelProperty(value = "附件名称")
    private String title;

    @ApiModelProperty(value = "附件大小")
    private Long fileSize;

    @ApiModelProperty(value = "附件ID")
    private String fileId;
}