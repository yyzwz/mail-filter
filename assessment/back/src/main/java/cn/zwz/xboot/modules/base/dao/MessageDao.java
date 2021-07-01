package cn.zwz.xboot.modules.base.dao;

import cn.zwz.xboot.base.XbootBaseDao;
import cn.zwz.xboot.modules.base.entity.Message;

import java.util.List;

/**
 * 消息内容数据处理层
 * @author Exrick
 */
public interface MessageDao extends XbootBaseDao<Message,String> {

    /**
     * 通过创建发送标识获取
     * @param createSend
     * @return
     */
    List<Message> findByCreateSend(Boolean createSend);
}