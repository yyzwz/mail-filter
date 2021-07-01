package cn.zwz.xboot.modules.base.dao;

import cn.zwz.xboot.base.XbootBaseDao;
import cn.zwz.xboot.modules.base.entity.UserRole;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

/**
 * 用户角色数据处理层
 * @author 郑为中
 */
public interface UserRoleDao extends XbootBaseDao<UserRole,String> {

    /**
     * 通过roleId查找
     * @param roleId
     * @return
     */
    List<UserRole> findByRoleId(String roleId);

    /**
     * 删除用户角色
     * @param userId
     */
    @Modifying
    @Query("delete from UserRole u where u.userId = ?1")
    void deleteByUserId(String userId);
}
