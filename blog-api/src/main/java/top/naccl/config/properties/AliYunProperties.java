package top.naccl.config.properties;

import lombok.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.annotation.Configuration;

/**
 * 阿里云配置
 */
@NoArgsConstructor
@Data
@ToString
@Configuration
@ConfigurationProperties(prefix = "aliyun")
public class AliYunProperties {

    private String accessKeyId;

    private String accessKeySecret;

    @Autowired
    private message message;
    /**
     * 短信配置
     */
    @Data
    @Configuration
    @ConfigurationProperties(prefix = "aliyun.message")
    public static class message {

        private String signName;

        private String templateCode;
    }


}
