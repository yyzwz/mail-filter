package cn.zwz.xboot.config.properties;

import lombok.Data;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.annotation.Configuration;

/**
 * @author 郑为中
 */
@Data
@Configuration
@ConfigurationProperties(prefix = "xboot.iplimit")
public class XbootIpLimitProperties {

    /**
     * 是否开启IP限流
     */
    private Boolean enable = false;

    /**
     * 限制请求个数
     */
    private Integer limit = 100;

    /**
     * 每单位时间内（毫秒）
     */
    private Long timeout = 1000L;
}
