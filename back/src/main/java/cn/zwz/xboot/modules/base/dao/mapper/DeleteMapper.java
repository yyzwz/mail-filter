package cn.zwz.xboot.modules.base.dao.mapper;

import org.apache.ibatis.annotations.Param;

/**
 * @author 郑为中
 */
public interface DeleteMapper {
    /**
     * 关联删除社交账号
     * @param username
     */
    void deleteSocial(@Param("username") String username);

    /**
     * 关联删除工作流数据
     * @param relateId
     */
    void deleteActNode(@Param("relateId") String relateId);

    /**
     * 关联删除工作流数据
     * @param userId
     */
    void deleteActStarter(@Param("userId") String userId);
}
