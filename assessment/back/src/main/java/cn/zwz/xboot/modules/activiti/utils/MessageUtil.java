package cn.zwz.xboot.modules.activiti.utils;

import cn.zwz.xboot.common.constant.ActivitiConstant;
import cn.zwz.xboot.common.constant.SettingConstant;
import cn.zwz.xboot.common.exception.XbootException;
import cn.zwz.xboot.common.utils.EmailUtil;
import cn.zwz.xboot.common.utils.SmsUtil;
import cn.zwz.xboot.modules.activiti.vo.EmailMessage;
import cn.zwz.xboot.modules.base.entity.MessageSend;
import cn.zwz.xboot.modules.base.entity.User;
import cn.zwz.xboot.modules.base.service.MessageSendService;
import cn.zwz.xboot.modules.base.service.UserService;
import cn.zwz.xboot.modules.base.vo.OtherSetting;
import cn.hutool.core.util.StrUtil;
import com.aliyuncs.exceptions.ClientException;
import com.google.gson.Gson;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

/**
 * @author 郑为中
 */
@Transactional
@Component
@Slf4j
public class MessageUtil {

    @Autowired
    private SmsUtil smsUtil;

    @Autowired
    private EmailUtil emailUtil;

    @Autowired
    private UserService userService;

    @Autowired
    private MessageSendService messageSendService;

    @Autowired
    private StringRedisTemplate redisTemplate;

    public OtherSetting getOtherSetting(){

        String v = redisTemplate.opsForValue().get(SettingConstant.OTHER_SETTING);
        if(StrUtil.isBlank(v)){
            throw new XbootException("系统未配置访问域名");
        }
        return new Gson().fromJson(v, OtherSetting.class);
    }

    /**
     * 发送工作流消息
     * @param userId 发送用户
     * @param content 消息内容
     * @param sendMessage 是否发站内信息
     * @param sendSms 是否发短信
     * @param sendEmail 是否发邮件
     */
    @Async
    public void sendActMessage(String userId, String content, Boolean sendMessage, Boolean sendSms, Boolean sendEmail){

        User user = userService.get(userId);
        if(user==null){
            return;
        }
        MessageSend messageSend = new MessageSend();
        messageSend.setUserId(user.getId());
        if(sendMessage&& ActivitiConstant.MESSAGE_TODO_CONTENT.equals(content)){
            // 待办
            messageSend.setMessageId(ActivitiConstant.MESSAGE_TODO_ID);
            messageSendService.send(messageSend);
        }else if(sendMessage&&ActivitiConstant.MESSAGE_PASS_CONTENT.equals(content)){
            // 通过
            messageSend.setMessageId(ActivitiConstant.MESSAGE_PASS_ID);
            messageSendService.send(messageSend);
        }else if(sendMessage&&ActivitiConstant.MESSAGE_BACK_CONTENT.equals(content)){
            // 驳回
            messageSend.setMessageId(ActivitiConstant.MESSAGE_BACK_ID);
            messageSendService.send(messageSend);
        }else if(sendMessage&&ActivitiConstant.MESSAGE_DELEGATE_CONTENT.equals(content)){
            // 委托
            messageSend.setMessageId(ActivitiConstant.MESSAGE_DELEGATE_ID);
            messageSendService.send(messageSend);
        }
        if(StrUtil.isNotBlank(user.getMobile())&&sendSms){
            try {
                smsUtil.sendActMessage(user.getMobile(), content);
            } catch (ClientException e) {
                log.error(e.toString());
            }
        }
        if(StrUtil.isNotBlank(user.getEmail())&&sendEmail){
            EmailMessage e = new EmailMessage();
            e.setUsername(user.getUsername());
            e.setContent(content);
            e.setFullUrl(getOtherSetting().getDomain());
            emailUtil.sendTemplateEmail(user.getEmail(), "【XBoot】工作流通知提醒", "act-message-email", e);
        }
    }
}
