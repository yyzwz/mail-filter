package cn.zwz.xboot.modules.assessment.serviceimpl;

import cn.zwz.xboot.modules.assessment.mapper.RosterUserAMapper;
import cn.zwz.xboot.modules.assessment.entity.RosterUserA;
import cn.zwz.xboot.modules.assessment.service.IRosterUserAService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;

/**
 * 考核系统用户接口实现
 * @author 郑为中
 */
@Slf4j
@Service
@Transactional
public class IRosterUserAServiceImpl extends ServiceImpl<RosterUserAMapper, RosterUserA> implements IRosterUserAService {

    @Autowired
    private RosterUserAMapper rosterUserAMapper;
}