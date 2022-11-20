package cn.zwz.mail.serviceimpl;

import cn.zwz.mail.mapper.MailArchivesMapper;
import cn.zwz.mail.entity.MailArchives;
import cn.zwz.mail.service.IMailArchivesService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * 邮件档案 服务层接口实现
 * @author 郑为中
 */
@Slf4j
@Service
@Transactional
public class IMailArchivesServiceImpl extends ServiceImpl<MailArchivesMapper, MailArchives> implements IMailArchivesService {

    @Autowired
    private MailArchivesMapper mailArchivesMapper;
}