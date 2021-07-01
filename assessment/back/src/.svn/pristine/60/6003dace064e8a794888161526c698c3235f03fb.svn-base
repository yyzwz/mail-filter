package cn.zwz.xboot.modules.assessment.controller;

import cn.zwz.xboot.common.utils.PageUtil;
import cn.zwz.xboot.common.utils.ResultUtil;
import cn.zwz.xboot.common.vo.PageVo;
import cn.zwz.xboot.common.vo.Result;
import cn.zwz.xboot.modules.assessment.entity.AssessmentLineItem;
import cn.zwz.xboot.modules.assessment.entity.AssessmentTime;
import cn.zwz.xboot.modules.assessment.service.IAssessmentTimeService;
import cn.hutool.core.util.StrUtil;
import cn.zwz.xboot.modules.utils.DateUtils;
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
@Api(description = "考核期管理接口")
@RequestMapping("/xboot/assessmentTime")
@Transactional
public class AssessmentTimeController {

    @Autowired
    private IAssessmentTimeService iAssessmentTimeService;

    @RequestMapping(value = "/get/{id}", method = RequestMethod.GET)
    @ApiOperation(value = "通过id获取")
    public Result<AssessmentTime> get(@PathVariable String id){

        AssessmentTime assessmentTime = iAssessmentTimeService.getById(id);
        return new ResultUtil<AssessmentTime>().setData(assessmentTime);
    }

    @RequestMapping(value = "/getAll", method = RequestMethod.GET)
    @ApiOperation(value = "获取全部数据")
    public Result<List<AssessmentTime>> getAll(){

        List<AssessmentTime> list = iAssessmentTimeService.list();
        return new ResultUtil<List<AssessmentTime>>().setData(list);
    }

    @RequestMapping(value = "/getNowTimes", method = RequestMethod.GET)
    @ApiOperation(value = "获取当前考核期")
    public Result<List<AssessmentTime>> getNowTimes(){
        QueryWrapper<AssessmentTime> qw = new QueryWrapper<>();
        qw.eq("is_run","1");
        List<AssessmentTime> list = iAssessmentTimeService.list(qw);
        return new ResultUtil<List<AssessmentTime>>().setData(list);
    }

    @RequestMapping(value = "/getByPage", method = RequestMethod.GET)
    @ApiOperation(value = "分页获取")
    public Result<IPage<AssessmentTime>> getByPage(@ModelAttribute AssessmentTime assessmentTime,@ModelAttribute PageVo page){
        QueryWrapper<AssessmentTime> qw = new QueryWrapper<>();
        if(assessmentTime.getTimeName() != null && !NullUtils.isNull(assessmentTime.getTimeName())) {
            qw.like("time_name",assessmentTime.getTimeName());
        }
        if(assessmentTime.getTimeRemark() != null && !NullUtils.isNull(assessmentTime.getTimeRemark())) {
            qw.like("time_remark",assessmentTime.getTimeRemark());
        }
        IPage<AssessmentTime> data = iAssessmentTimeService.page(PageUtil.initMpPage(page),qw);
        return new ResultUtil<IPage<AssessmentTime>>().setData(data);
    }

    @RequestMapping(value = "/insertOrUpdate", method = RequestMethod.POST)
    @ApiOperation(value = "编辑或更新数据")
    public Result<AssessmentTime> saveOrUpdate(AssessmentTime assessmentTime){
        if(assessmentTime.getStartDate() != null && !NullUtils.isNull(assessmentTime.getStartDate())) {
            long startCuo = DateUtils.dateToStampLong(assessmentTime.getStartDate());
            assessmentTime.setStartCuo(startCuo);
        }
        if(assessmentTime.getEndDate() != null && !NullUtils.isNull(assessmentTime.getEndDate())) {
            long endCuo = DateUtils.dateToStampLong(assessmentTime.getEndDate());
            assessmentTime.setStartCuo(endCuo);
        }
        if(iAssessmentTimeService.saveOrUpdate(assessmentTime)){
            return new ResultUtil<AssessmentTime>().setData(assessmentTime);
        }
        return new ResultUtil<AssessmentTime>().setErrorMsg("操作失败");
    }

    @RequestMapping(value = "/delByIds", method = RequestMethod.POST)
    @ApiOperation(value = "批量通过id删除")
    public Result<Object> delAllByIds(@RequestParam String[] ids){

        for(String id : ids){
            iAssessmentTimeService.removeById(id);
        }
        return ResultUtil.success("批量通过id删除数据成功");
    }
}
