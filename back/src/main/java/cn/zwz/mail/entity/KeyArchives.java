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
@Table(name = "a_key_archives")
@TableName("a_key_archives")
@ApiModel(value = "关键词档案")
public class KeyArchives extends ZwzBaseEntity {

    private static final long serialVersionUID = 1L;

    @ApiModelProperty(value = "关键词")
    private String title;

    @ApiModelProperty(value = "生效用户ID")
    private String userId;
}