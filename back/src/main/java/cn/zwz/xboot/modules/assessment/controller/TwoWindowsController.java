package cn.zwz.xboot.modules.assessment.controller;

import cn.zwz.xboot.common.utils.PageUtil;
import cn.zwz.xboot.common.utils.ResultUtil;
import cn.zwz.xboot.common.vo.PageVo;
import cn.zwz.xboot.common.vo.Result;
import cn.zwz.xboot.modules.assessment.entity.AssessmentLine;
import cn.zwz.xboot.modules.assessment.entity.AssessmentLineItem;
import cn.zwz.xboot.modules.assessment.entity.TwoWindows;
import cn.zwz.xboot.modules.assessment.entity.Village;
import cn.zwz.xboot.modules.assessment.service.IAssessmentLineItemService;
import cn.zwz.xboot.modules.assessment.service.IAssessmentLineService;
import cn.zwz.xboot.modules.assessment.service.ITwoWindowsService;
import cn.hutool.core.util.StrUtil;
import cn.zwz.xboot.modules.assessment.service.IVillageService;
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
@Api(description = "二级页面管理接口")
@RequestMapping("/xboot/twoWindows")
@Transactional
public class TwoWindowsController {

    @Autowired
    private ITwoWindowsService iTwoWindowsService;

    @Autowired
    private IAssessmentLineService iAssessmentLineService;

    @Autowired
    private IAssessmentLineItemService iAssessmentLineItemService;

    @Autowired
    private IVillageService iVillageService;


    @RequestMapping(value = "/init", method = RequestMethod.GET)
    @ApiOperation(value = "获取全部数据")
    public Result<List<TwoWindows>> init(){
        String timeId = "1376067966306750464";
        List<AssessmentLine> lineList = iAssessmentLineService.list();
        for (AssessmentLine line : lineList) {
            QueryWrapper<AssessmentLineItem> qww = new QueryWrapper<>();
            qww.eq("line_id", line.getId());
            qww.orderByAsc("sort_level");
            List<AssessmentLineItem> itemList = iAssessmentLineItemService.list(qww);
            for (AssessmentLineItem item : itemList) {
                TwoWindows t = new TwoWindows();
                t.setLineId(line.getId());
                t.setTimeId(timeId);
                t.setItemId(item.getId());
                t.setItemName(item.getItemTitle());
                t.setAa("无");
                t.setCc("无");
                t.setEe("无");
                t.setGg("无");
                t.setIi("无");
                t.setKk("无");
                t.setMm("无");
                t.setOo("无");
                t.setQq("无");
                t.setSs("无");
                t.setUu("无");
                t.setWw("无");
                t.setYy("无");
                t.setAaa("无");
                t.setCcc("无");
                t.setEee("无");
                t.setGgg("无");
                t.setIii("无");
                t.setKkk("无");
                t.setMmm("无");
                t.setOoo("无");
                t.setQqq("无");
                t.setSss("无");
                t.setUuu("无");
                t.setWww("无");
                t.setYyy("无");
                t.setAaaa("无");
                t.setCccc("无");
                t.setEeee("无");
                t.setGggg("无");
                t.setIiii("无");
                t.setKkkk("无");
                t.setMmmm("无");
                t.setOooo("无");
                t.setQqqq("无");
                t.setSsss("无");
                t.setUuuu("无");
                t.setWwww("无");
                t.setYyyy("无");
                t.setAaaaa("无");
                t.setCcccc("无");
                t.setEeeee("无");
                t.setGgggg("无");
                t.setIiiii("无");
                t.setKkkkk("无");
                iTwoWindowsService.saveOrUpdate(t);
            }
        }
        return new ResultUtil<List<TwoWindows>>().setSuccessMsg("OK");
    }

    @RequestMapping(value = "/get/{id}", method = RequestMethod.GET)
    @ApiOperation(value = "通过id获取")
    public Result<TwoWindows> get(@PathVariable String id){

        TwoWindows twoWindows = iTwoWindowsService.getById(id);
        return new ResultUtil<TwoWindows>().setData(twoWindows);
    }

    @RequestMapping(value = "/getAll", method = RequestMethod.GET)
    @ApiOperation(value = "获取全部数据")
    public Result<List<TwoWindows>> getAll(@RequestParam String lineId,@RequestParam String timeId){
        QueryWrapper<TwoWindows> qw = new QueryWrapper<>();
        qw.eq("line_id",lineId);
        qw.eq("time_id",timeId);
        List<TwoWindows> list = iTwoWindowsService.list(qw);
        return new ResultUtil<List<TwoWindows>>().setData(list);
    }


    @RequestMapping(value = "/getByPage", method = RequestMethod.GET)
    @ApiOperation(value = "分页获取")
    public Result<IPage<TwoWindows>> getByPage(PageVo page){

        IPage<TwoWindows> data = iTwoWindowsService.page(PageUtil.initMpPage(page));
        return new ResultUtil<IPage<TwoWindows>>().setData(data);
    }

    @RequestMapping(value = "/insertOrUpdate", method = RequestMethod.POST)
    @ApiOperation(value = "编辑或更新数据")
    public Result<TwoWindows> saveOrUpdate(TwoWindows twoWindows){

        if(iTwoWindowsService.saveOrUpdate(twoWindows)){
            return new ResultUtil<TwoWindows>().setData(twoWindows);
        }
        return new ResultUtil<TwoWindows>().setErrorMsg("操作失败");
    }

    @RequestMapping(value = "/update", method = RequestMethod.POST)
    @ApiOperation(value = "编辑或更新数据")
    public Result<TwoWindows> update(TwoWindows twoWindows){
        iTwoWindowsService.saveOrUpdate(twoWindows);
        return new ResultUtil<TwoWindows>().setSuccessMsg("OK");
    }

    @RequestMapping(value = "/delByIds", method = RequestMethod.POST)
    @ApiOperation(value = "批量通过id删除")
    public Result<Object> delAllByIds(@RequestParam String[] ids){

        for(String id : ids){
            iTwoWindowsService.removeById(id);
        }
        return ResultUtil.success("批量通过id删除数据成功");
    }
}
