package cn.zwz.xboot.modules.tricycle.serviceimpl;

import cn.zwz.xboot.modules.base.entity.User;
import cn.zwz.xboot.modules.tricycle.mapper.UserMapper;
import cn.zwz.xboot.modules.tricycle.service.IUserService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * 登入用户接口实现
 * @author 郑为中
 */
@Slf4j
@Service
@Transactional
public class IUserServiceImpl extends ServiceImpl<UserMapper, User> implements IUserService {

    @Autowired
    private UserMapper userMapper;
}