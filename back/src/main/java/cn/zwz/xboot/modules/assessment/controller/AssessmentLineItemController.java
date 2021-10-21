package cn.zwz.xboot.modules.assessment.controller;

import cn.zwz.xboot.common.utils.PageUtil;
import cn.zwz.xboot.common.utils.ResultUtil;
import cn.zwz.xboot.common.vo.PageVo;
import cn.zwz.xboot.common.vo.Result;
import cn.zwz.xboot.modules.assessment.entity.AssessmentLine;
import cn.zwz.xboot.modules.assessment.entity.AssessmentLineItem;
import cn.zwz.xboot.modules.assessment.entity.AssessmentTime;
import cn.zwz.xboot.modules.assessment.service.IAssessmentLineItemService;
import cn.hutool.core.util.StrUtil;
import cn.zwz.xboot.modules.assessment.service.IAssessmentLineService;
import cn.zwz.xboot.modules.assessment.service.IAssessmentTimeService;
import cn.zwz.xboot.modules.utils.NullUtils;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * @author 郑为中
 */
@Slf4j
@RestController
@Api(description = "考核线要求管理接口")
@RequestMapping("/xboot/assessmentLineItem")
@Transactional
public class AssessmentLineItemController {

    @Autowired
    private IAssessmentLineItemService iAssessmentLineItemService;

    @Autowired
    private IAssessmentLineService iAssessmentLineService;

    @Autowired
    private IAssessmentTimeService iAssessmentTimeService;

    @RequestMapping(value = "/get/{id}", method = RequestMethod.GET)
    @ApiOperation(value = "通过id获取")
    public Result<AssessmentLineItem> get(@PathVariable String id){

        AssessmentLineItem assessmentLineItem = iAssessmentLineItemService.getById(id);
        return new ResultUtil<AssessmentLineItem>().setData(assessmentLineItem);
    }

    @RequestMapping(value = "/getAll", method = RequestMethod.GET)
    @ApiOperation(value = "获取全部数据")
    public Result<List<AssessmentLineItem>> getAll(){

        List<AssessmentLineItem> list = iAssessmentLineItemService.list();
        return new ResultUtil<List<AssessmentLineItem>>().setData(list);
    }

    @RequestMapping(value = "/getByPage", method = RequestMethod.GET)
    @ApiOperation(value = "分页获取")
    public Result<IPage<AssessmentLineItem>> getByPage(@ModelAttribute AssessmentLineItem assessmentLineItem,@ModelAttribute PageVo page){
        QueryWrapper<AssessmentLineItem> qw = new QueryWrapper<>();
        if(assessmentLineItem.getLineId() != null && !NullUtils.isNull(assessmentLineItem.getLineId())) {
            qw.eq("line_id",assessmentLineItem.getLineId());
        }
        if(assessmentLineItem.getLineName() != null && !NullUtils.isNull(assessmentLineItem.getLineName())) {
            qw.eq("line_name",assessmentLineItem.getLineName());
        }
        if(assessmentLineItem.getItemTitle() != null && !NullUtils.isNull(assessmentLineItem.getItemTitle())) {
            qw.like("item_title",assessmentLineItem.getItemTitle());
        }
        if(assessmentLineItem.getRemark() != null && !NullUtils.isNull(assessmentLineItem.getRemark())) {
            qw.like("remark",assessmentLineItem.getRemark());
        }
        IPage<AssessmentLineItem> data = iAssessmentLineItemService.page(PageUtil.initMpPage(page),qw);
        return new ResultUtil<IPage<AssessmentLineItem>>().setData(data);
    }

    @RequestMapping(value = "/insertOrUpdate", method = RequestMethod.POST)
    @ApiOperation(value = "编辑或更新数据")
    public Result<AssessmentLineItem> saveOrUpdate(AssessmentLineItem assessmentLineItem){
        String lineId = assessmentLineItem.getLineId();
        AssessmentLine line = iAssessmentLineService.getById(lineId);
        if(line != null) {
            assessmentLineItem.setLineName(line.getLineName());
        }
        List<AssessmentLineItem> itemList = iAssessmentLineItemService.list();
//        int sort = 0;
//        for (AssessmentLineItem lineItem : itemList) {
//            if(sort < lineItem.getSortLevel()) {
//                sort = lineItem.getSortLevel();
//            }
//        }
//        assessmentLineItem.setSortLevel(sort + 1);
        if(iAssessmentLineItemService.saveOrUpdate(assessmentLineItem)){
            return new ResultUtil<AssessmentLineItem>().setData(assessmentLineItem);
        }
        return new ResultUtil<AssessmentLineItem>().setErrorMsg("操作失败");
    }

    @RequestMapping(value = "/delByIds", method = RequestMethod.POST)
    @ApiOperation(value = "批量通过id删除")
    public Result<Object> delAllByIds(@RequestParam String[] ids){

        for(String id : ids){
            iAssessmentLineItemService.removeById(id);
        }
        return ResultUtil.success("批量通过id删除数据成功");
    }
}
