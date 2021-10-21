package cn.zwz.xboot.modules.open.service;

import cn.zwz.xboot.base.XbootBaseService;
import cn.zwz.xboot.modules.open.entity.Client;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import cn.zwz.xboot.common.vo.SearchVo;

/**
 * 客户端接口
 * @author Exrick
 */
public interface ClientService extends XbootBaseService<Client,String> {

    /**
    * 多条件分页获取
    * @param client
    * @param searchVo
    * @param pageable
    * @return
    */
    Page<Client> findByCondition(Client client, SearchVo searchVo, Pageable pageable);

}