package cn.zwz.xboot.modules.base.vo;

import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.io.Serializable;

/**
 * @author 郑为中
 */
@Data
public class EmailSetting implements Serializable{

    @ApiModelProperty(value = "邮箱服务器")
    private String host;

    @ApiModelProperty(value = "发送者邮箱账号")
    private String username;

    @ApiModelProperty(value = "邮箱授权码")
    private String password;

    @ApiModelProperty(value = "是否改变secrectKey")
    private Boolean changed;
}
