package cn.zwz.mail.serviceimpl;

import cn.zwz.mail.mapper.MailFileMapper;
import cn.zwz.mail.entity.MailFile;
import cn.zwz.mail.service.IMailFileService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * 邮件附件 服务层接口实现
 * @author 郑为中
 */
@Slf4j
@Service
@Transactional
public class IMailFileServiceImpl extends ServiceImpl<MailFileMapper, MailFile> implements IMailFileService {

    @Autowired
    private MailFileMapper mailFileMapper;
}