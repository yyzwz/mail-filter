package cn.zwz.xboot.modules.activiti.service.mybatis;

/**
 * @author 郑为中
 */
public interface IActService {

    /**
     * 删除关联业务表
     * @param table
     * @param id
     * @return
     */
    Integer deleteBusiness(String table, String id);
}