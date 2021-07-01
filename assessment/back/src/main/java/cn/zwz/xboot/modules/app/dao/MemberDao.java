 package cn.zwz.xboot.modules.app.dao;

import cn.zwz.xboot.base.XbootBaseDao;
import cn.zwz.xboot.modules.app.entity.Member;

 /**
 * 会员数据处理层
 * @author Exrick
 */
public interface MemberDao extends XbootBaseDao<Member, String> {

    /**
     * 通过用户名获取用户
     * @param username
     * @return
     */
    Member findByUsername(String username);

    /**
     * 通过手机获取用户
     * @param mobile
     * @return
     */
    Member findByMobile(String mobile);
}