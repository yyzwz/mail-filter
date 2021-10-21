package cn.zwz.xboot.modules.assessment.serviceimpl;

import cn.zwz.xboot.modules.assessment.mapper.SystemUserRoleMapper;
import cn.zwz.xboot.modules.assessment.entity.SystemUserRole;
import cn.zwz.xboot.modules.assessment.service.ISystemUserRoleService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;

/**
 * 考核系统权限接口实现
 * @author 郑为中
 */
@Slf4j
@Service
@Transactional
public class ISystemUserRoleServiceImpl extends ServiceImpl<SystemUserRoleMapper, SystemUserRole> implements ISystemUserRoleService {

    @Autowired
    private SystemUserRoleMapper systemUserRoleMapper;
}