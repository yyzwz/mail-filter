package cn.zwz.xboot.modules.app.service;

import cn.zwz.xboot.base.XbootBaseService;
import cn.zwz.xboot.modules.app.entity.Member;
import cn.zwz.xboot.common.vo.SearchVo;
import org.springframework.cache.annotation.CacheConfig;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

/**
 * 会员接口
 * @author Exrick
 */
@CacheConfig(cacheNames = "member")
public interface MemberService extends XbootBaseService<Member, String> {

    /**
    * 多条件分页获取
    * @param member
    * @param searchVo
    * @param pageable
    * @return
    */
    Page<Member> findByCondition(Member member, SearchVo searchVo, Pageable pageable);

    /**
     * 通过用户名获取用户
     * @param username
     * @return
     */
    @Cacheable(key = "#username")
    Member findByUsername(String username);

    /**
     * 通过手机获取用户
     * @param mobile
     * @return
     */
    Member findByMobile(String mobile);
}