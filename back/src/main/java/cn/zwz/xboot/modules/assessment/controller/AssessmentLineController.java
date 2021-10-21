package cn.zwz.xboot.modules.assessment.controller;

import cn.zwz.xboot.common.utils.PageUtil;
import cn.zwz.xboot.common.utils.ResultUtil;
import cn.zwz.xboot.common.vo.PageVo;
import cn.zwz.xboot.common.vo.Result;
import cn.zwz.xboot.modules.assessment.entity.AssessmentLine;
import cn.zwz.xboot.modules.assessment.service.IAssessmentLineService;
import cn.hutool.core.util.StrUtil;
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
@Api(description = "考核线管理接口")
@RequestMapping("/xboot/assessmentLine")
@Transactional
public class AssessmentLineController {

    @Autowired
    private IAssessmentLineService iAssessmentLineService;

    @RequestMapping(value = "/get/{id}", method = RequestMethod.GET)
    @ApiOperation(value = "通过id获取")
    public Result<AssessmentLine> get(@PathVariable String id){

        AssessmentLine assessmentLine = iAssessmentLineService.getById(id);
        return new ResultUtil<AssessmentLine>().setData(assessmentLine);
    }

    @RequestMapping(value = "/getAll", method = RequestMethod.GET)
    @ApiOperation(value = "获取全部数据")
    public Result<List<AssessmentLine>> getAll(){

        List<AssessmentLine> list = iAssessmentLineService.list();
        return new ResultUtil<List<AssessmentLine>>().setData(list);
    }

    @RequestMapping(value = "/getByPage", method = RequestMethod.GET)
    @ApiOperation(value = "分页获取")
    public Result<IPage<AssessmentLine>> getByPage(@ModelAttribute AssessmentLine assessmentLine,@ModelAttribute PageVo page){
        QueryWrapper<AssessmentLine> qw = new QueryWrapper<>();
        if(assessmentLine.getLineName() != null && !NullUtils.isNull(assessmentLine.getLineName())) {
            qw.like("line_name",assessmentLine.getLineName());
        }
        if(assessmentLine.getLineType() != null && !NullUtils.isNull(assessmentLine.getLineType())) {
            qw.like("line_type",assessmentLine.getLineType());
        }
        if(assessmentLine.getLineRemark() != null && !NullUtils.isNull(assessmentLine.getLineRemark())) {
            qw.like("line_remark",assessmentLine.getLineRemark());
        }
        qw.orderByAsc("sort_number");
        IPage<AssessmentLine> data = iAssessmentLineService.page(PageUtil.initMpPage(page),qw);
        return new ResultUtil<IPage<AssessmentLine>>().setData(data);
    }

    @RequestMapping(value = "/insertOrUpdate", method = RequestMethod.POST)
    @ApiOperation(value = "编辑或更新数据")
    public Result<AssessmentLine> saveOrUpdate(AssessmentLine assessmentLine){

        if(iAssessmentLineService.saveOrUpdate(assessmentLine)){
            return new ResultUtil<AssessmentLine>().setData(assessmentLine);
        }
        return new ResultUtil<AssessmentLine>().setErrorMsg("操作失败");
    }

    @RequestMapping(value = "/delByIds", method = RequestMethod.POST)
    @ApiOperation(value = "批量通过id删除")
    public Result<Object> delAllByIds(@RequestParam String[] ids){

        for(String id : ids){
            iAssessmentLineService.removeById(id);
        }
        return ResultUtil.success("批量通过id删除数据成功");
    }
}
