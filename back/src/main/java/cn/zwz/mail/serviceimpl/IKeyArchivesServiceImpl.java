package cn.zwz.mail.serviceimpl;

import cn.zwz.mail.mapper.KeyArchivesMapper;
import cn.zwz.mail.entity.KeyArchives;
import cn.zwz.mail.service.IKeyArchivesService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * 关键词档案 服务层接口实现
 * @author 郑为中
 */
@Slf4j
@Service
@Transactional
public class IKeyArchivesServiceImpl extends ServiceImpl<KeyArchivesMapper, KeyArchives> implements IKeyArchivesService {

    @Autowired
    private KeyArchivesMapper keyArchivesMapper;
}