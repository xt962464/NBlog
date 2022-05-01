package top.naccl.task;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import top.naccl.aliyun.AliYunMessage;
import top.naccl.config.properties.AliYunProperties;

import java.util.Calendar;
import java.util.Map;

/**
 * @Description 提醒服务
 * @Author 故人听雨
 * @Date 2022/4/26 22:13
 * @Version 1.0
 */
@Slf4j
@Component
public class AttentionSyncScheduleTask {

    @Autowired
    private AliYunProperties aliYunProperties;

    /**
     * 发送阿里云短信
     */
    public void sendAliYunMessageInfo(String jobParams) {
        log.info("开始执行提醒服务,发送阿里云短信提醒...");
        if (StringUtils.isNotBlank(jobParams)) {
            JSONObject object = JSONObject.parseObject(jobParams);
            String phone = object.getString("phone");
            JSONObject message = object.getJSONObject("message");
            if (StringUtils.isBlank(message.getString("date"))) {
                // 获取当前月
                Calendar calendar = Calendar.getInstance();
                int month = calendar.get(Calendar.MONTH) + 1;
                message.put("date", calendar.get(Calendar.YEAR) + "-" + month + "-" + "15");
            }
            log.info("手机号: " + phone + " 消息: " + message);
            if (StringUtils.isNotBlank(phone) && StringUtils.isNotBlank(message.toJSONString())) {
                AliYunProperties.message messageProperties = aliYunProperties.getMessage();
                AliYunMessage aliYunMessage = new AliYunMessage(aliYunProperties.getAccessKeyId(), aliYunProperties.getAccessKeySecret(), messageProperties.getSignName(), messageProperties.getTemplateCode());
                if (aliYunMessage.send(phone, message.toJSONString())) {
                    log.info("发送短信提醒成功...");
                } else {
                    log.info("发送短信提醒失败...");
                }

            } else {
                log.warn("参数为空,定时服务任务结束...");
            }
        } else {
            log.warn("参数为空,定时服务任务结束...");
        }
    }

}
