package cn.zwz.mail.serviceimpl;

import cn.zwz.mail.mapper.BlacklistMapper;
import cn.zwz.mail.entity.Blacklist;
import cn.zwz.mail.service.IBlacklistService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * 黑名单档案 服务层接口实现
 * @author 郑为中
 */
@Slf4j
@Service
@Transactional
public class IBlacklistServiceImpl extends ServiceImpl<BlacklistMapper, Blacklist> implements IBlacklistService {

    @Autowired
    private BlacklistMapper blacklistMapper;
}