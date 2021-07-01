package cn.zwz.xboot.modules.activiti.dao;

import cn.zwz.xboot.base.XbootBaseDao;
import cn.zwz.xboot.modules.activiti.entity.ActBusiness;

import java.util.List;

/**
 * 申请业务数据处理层
 * @author Exrick
 */
public interface ActBusinessDao extends XbootBaseDao<ActBusiness,String> {

    /**
     * 通过流程定义id获取
     * @param procDefId
     * @return
     */
    List<ActBusiness> findByProcDefId(String procDefId);
}