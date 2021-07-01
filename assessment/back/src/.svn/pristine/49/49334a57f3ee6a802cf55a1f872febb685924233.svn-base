package cn.zwz.xboot.modules.activiti.serviceimpl.mybatis;

import cn.zwz.xboot.modules.activiti.dao.mapper.HistoryIdentityMapper;
import cn.zwz.xboot.modules.activiti.service.mybatis.IHistoryIdentityService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * @author 郑为中
 */
@Service
public class IHistoryIdentityServiceImpl implements IHistoryIdentityService {

    @Autowired
    private HistoryIdentityMapper historyIdentityMapper;

    @Override
    public Integer insert(String id, String type, String userId, String taskId, String procInstId) {

        return historyIdentityMapper.insert(id, type, userId, taskId, procInstId);
    }

    @Override
    public String findUserIdByTypeAndTaskId(String type, String taskId) {

        return historyIdentityMapper.findUserIdByTypeAndTaskId(type, taskId);
    }
}
