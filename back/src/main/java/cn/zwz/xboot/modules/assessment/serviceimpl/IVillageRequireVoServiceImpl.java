package cn.zwz.xboot.modules.assessment.serviceimpl;

import cn.zwz.xboot.modules.assessment.mapper.VillageRequireVoMapper;
import cn.zwz.xboot.modules.assessment.entity.VillageRequireVo;
import cn.zwz.xboot.modules.assessment.service.IVillageRequireVoService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;

/**
 * 考核情况接口实现
 * @author 郑为中
 */
@Slf4j
@Service
@Transactional
public class IVillageRequireVoServiceImpl extends ServiceImpl<VillageRequireVoMapper, VillageRequireVo> implements IVillageRequireVoService {

    @Autowired
    private VillageRequireVoMapper villageRequireVoMapper;
}