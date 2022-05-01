package top.naccl.aliyun;

//import com.aliyuncs.DefaultAcsClient;
//import com.aliyuncs.IAcsClient;
//import com.aliyuncs.dysmsapi.model.v20170525.SendSmsRequest;
//import com.aliyuncs.dysmsapi.model.v20170525.SendSmsResponse;
//import com.aliyuncs.exceptions.ClientException;
//import com.aliyuncs.http.MethodType;
//import com.aliyuncs.profile.DefaultProfile;
//import com.aliyuncs.profile.IClientProfile;

import com.aliyun.dysmsapi20170525.Client;
import lombok.Data;
import com.aliyun.dysmsapi20170525.models.*;
import com.aliyun.teaopenapi.models.*;
import lombok.extern.slf4j.Slf4j;

/**
 * @Description 阿里云短信工具类
 * @Author 故人听雨
 * @Date 2022/4/28 1:44
 * @Version 1.0
 */
@Data
@Slf4j
public class AliYunMessage {

    private String accessKeyId;
    private String accessKeySecret;
    private String signName;
    private String templateCode;
    private com.aliyun.dysmsapi20170525.Client client;

    public AliYunMessage(String accessKeyId, String accessKeySecret, String signName, String templateCode) {
        this.accessKeyId = accessKeyId;
        this.accessKeySecret = accessKeySecret;
        this.signName = signName;
        this.templateCode = templateCode;
        init();
    }

    /**
     * 使用AK&SK初始化账号Client
     */
    private void init() {
        Config config = new Config()
                // 您的AccessKey ID
                .setAccessKeyId(this.accessKeyId)
                // 您的AccessKey Secret
                .setAccessKeySecret(this.accessKeySecret);
        // 访问的域名
        config.endpoint = "dysmsapi.aliyuncs.com";
        try {
            this.client = new Client(config);
        } catch (Exception e) {
            log.error("阿里云短信初始化失败: [{}]", e.getMessage());
        }
    }

    public Boolean send(String phone, String params) {
        Boolean result = true;
        try {
            SendSmsRequest sendSmsRequest = new SendSmsRequest()
                    .setPhoneNumbers(phone)
                    .setSignName(this.signName)
                    .setTemplateCode(this.templateCode)
                    .setTemplateParam(params);
            // 复制代码运行请自行打印 API 的返回值
            SendSmsResponse sendSms = this.client.sendSms(sendSmsRequest);
            if ("OK".equalsIgnoreCase(sendSms.body.getCode())) {
                log.info("短信发送成功,发送状态: [{}], 响应消息: [{}]", sendSms.getBody().getCode(), sendSms.getBody().getMessage());
            } else {
                log.warn("短信发送失败,发送状态: [{}], 响应消息: [{}]", sendSms.getBody().getCode(), sendSms.getBody().getMessage());
                result = false;
            }
        } catch (Exception e) {
            log.error("短信发送失败: [{}]", e.getMessage());
            result = false;
        }
        return result;
    }

}
