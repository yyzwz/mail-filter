package cn.zwz.xboot.modules.base.dao;

import cn.zwz.xboot.base.XbootBaseDao;
import cn.zwz.xboot.modules.base.entity.Role;

import java.util.List;

/**
 * 角色数据处理层
 * @author 郑为中
 */
public interface RoleDao extends XbootBaseDao<Role,String> {

    /**
     * 获取默认角色
     * @param defaultRole
     * @return
     */
    List<Role> findByDefaultRole(Boolean defaultRole);
}
