package cn.zwz.xboot.modules.activiti.serviceimpl.mybatis;

import cn.zwz.xboot.modules.activiti.dao.mapper.RunIdentityMapper;
import cn.zwz.xboot.modules.activiti.service.mybatis.IRunIdentityService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @author 郑为中
 */
@Service
public class IRunIdentityServiceImpl implements IRunIdentityService {

    @Autowired
    private RunIdentityMapper runIdentityMapper;

    @Override
    public List<String> selectByConditions(String taskId, String type) {
        return runIdentityMapper.selectByConditions(taskId, type);
    }
}
