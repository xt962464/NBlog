package top.naccl.util;

import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.autoconfigure.mail.MailProperties;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.scheduling.annotation.Async;
import org.springframework.scheduling.annotation.EnableAsync;
import org.springframework.stereotype.Component;
import org.thymeleaf.TemplateEngine;
import org.thymeleaf.context.Context;

import javax.mail.internet.MimeMessage;
import java.util.Map;

/**
 * @Description: 邮件工具类
 * @Author: Naccl
 * @Date: 2020-10-10
 */
@Slf4j
@EnableAsync
@Component
public class MailUtils {
    @Autowired
    private JavaMailSender javaMailSender;
    @Autowired
    private MailProperties mailProperties;
    @Autowired
    TemplateEngine templateEngine;

    @Async
    public void sendSimpleMail(String toAccount, String subject, String content) {
        try {
            SimpleMailMessage message = new SimpleMailMessage();
            message.setFrom(mailProperties.getUsername());
            message.setTo(toAccount);
            message.setSubject(subject);
            message.setText(content);
            javaMailSender.send(message);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Async
    public void sendHtmlTemplateMail(Map<String, Object> map, String toAccount, String subject, String template) {
        try {
            log.info("开始发送邮件: toAccount: [{}}],内容: [{}]", toAccount, template);
            MimeMessage mimeMessage = javaMailSender.createMimeMessage();
            MimeMessageHelper messageHelper = new MimeMessageHelper(mimeMessage);
            Context context = new Context();
            context.setVariables(map);
            String process = templateEngine.process(template, context);
            messageHelper.setFrom(mailProperties.getUsername());
            messageHelper.setTo(toAccount);
            messageHelper.setSubject(subject);
            messageHelper.setText(process, true);
            javaMailSender.send(mimeMessage);
            log.info("邮件发送完成: toAccount: [{}]", toAccount);
        } catch (Exception e) {
            log.error("邮件发送失败: toAccount: [{}}],内容: [{}], 错误: [{}]", toAccount, template, e.getMessage());
        }
    }
}
