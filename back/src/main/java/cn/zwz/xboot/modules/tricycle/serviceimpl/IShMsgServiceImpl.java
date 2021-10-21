package cn.zwz.xboot.modules.tricycle.serviceimpl;

import cn.zwz.xboot.modules.tricycle.mapper.ShMsgMapper;
import cn.zwz.xboot.modules.tricycle.entity.ShMsg;
import cn.zwz.xboot.modules.tricycle.service.IShMsgService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;

/**
 * 审核信息接口实现
 * @author 郑为中
 */
@Slf4j
@Service
@Transactional
public class IShMsgServiceImpl extends ServiceImpl<ShMsgMapper, ShMsg> implements IShMsgService {

    @Autowired
    private ShMsgMapper shMsgMapper;
}