package cn.zwz.xboot.modules.assessment.serviceimpl;

import cn.zwz.xboot.modules.assessment.mapper.AssessmentLineItemMapper;
import cn.zwz.xboot.modules.assessment.entity.AssessmentLineItem;
import cn.zwz.xboot.modules.assessment.service.IAssessmentLineItemService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;

/**
 * 考核线要求接口实现
 * @author 郑为中
 */
@Slf4j
@Service
@Transactional
public class IAssessmentLineItemServiceImpl extends ServiceImpl<AssessmentLineItemMapper, AssessmentLineItem> implements IAssessmentLineItemService {

    @Autowired
    private AssessmentLineItemMapper assessmentLineItemMapper;
}