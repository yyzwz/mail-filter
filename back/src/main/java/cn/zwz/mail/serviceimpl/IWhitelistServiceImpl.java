package cn.zwz.mail.serviceimpl;

import cn.zwz.mail.mapper.WhitelistMapper;
import cn.zwz.mail.entity.Whitelist;
import cn.zwz.mail.service.IWhitelistService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * 白名单档案 服务层接口实现
 * @author 郑为中
 */
@Slf4j
@Service
@Transactional
public class IWhitelistServiceImpl extends ServiceImpl<WhitelistMapper, Whitelist> implements IWhitelistService {

    @Autowired
    private WhitelistMapper whitelistMapper;
}