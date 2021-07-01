package cn.zwz.xboot.modules.tricycle.serviceimpl;

import cn.zwz.xboot.modules.tricycle.mapper.UpdateRecordMapper;
import cn.zwz.xboot.modules.tricycle.entity.UpdateRecord;
import cn.zwz.xboot.modules.tricycle.service.IUpdateRecordService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;

/**
 * 车主信息修改记录接口实现
 * @author 郑为中
 */
@Slf4j
@Service
@Transactional
public class IUpdateRecordServiceImpl extends ServiceImpl<UpdateRecordMapper, UpdateRecord> implements IUpdateRecordService {

    @Autowired
    private UpdateRecordMapper updateRecordMapper;
}