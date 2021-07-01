package cn.zwz.xboot.modules.assessment.serviceimpl;

import cn.zwz.xboot.modules.assessment.mapper.VillageManyVoMapper;
import cn.zwz.xboot.modules.assessment.entity.VillageManyVo;
import cn.zwz.xboot.modules.assessment.service.IVillageManyVoService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;

/**
 * 联村关系接口实现
 * @author 郑为中
 */
@Slf4j
@Service
@Transactional
public class IVillageManyVoServiceImpl extends ServiceImpl<VillageManyVoMapper, VillageManyVo> implements IVillageManyVoService {

    @Autowired
    private VillageManyVoMapper villageManyVoMapper;
}