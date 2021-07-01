package cn.zwz.xboot.modules.assessment.controller;

import cn.zwz.xboot.common.utils.PageUtil;
import cn.zwz.xboot.common.utils.ResultUtil;
import cn.zwz.xboot.common.vo.PageVo;
import cn.zwz.xboot.common.vo.Result;
import cn.zwz.xboot.modules.assessment.entity.*;
import cn.zwz.xboot.modules.assessment.service.*;
import cn.hutool.core.util.StrUtil;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.transaction.annotation.Transactional;

import java.lang.reflect.Field;
import java.util.ArrayList;
import java.util.List;

/**
 * @author 郑为中
 */
@Slf4j
@RestController
@Api(description = "考核申述管理接口")
@RequestMapping("/xboot/s4ShenShu")
@Transactional
public class S4ShenShuController {

    @Autowired
    private IS4ShenShuService iS4ShenShuService;

    @Autowired
    private IVillageService iVillageService;

    @Autowired
    private ITwoWindowsService iTwoWindowsService;

    @Autowired
    private IAssessmentLineService iAssessmentLineService;

    @Autowired
    private IAssessmentLineItemService iAssessmentLineItemService;


    @RequestMapping(value = "/get/{id}", method = RequestMethod.GET)
    @ApiOperation(value = "通过id获取")
    public Result<S4ShenShu> get(@PathVariable String id){

        S4ShenShu s4ShenShu = iS4ShenShuService.getById(id);
        return new ResultUtil<S4ShenShu>().setData(s4ShenShu);
    }

    @RequestMapping(value = "/getAll", method = RequestMethod.GET)
    @ApiOperation(value = "获取全部数据")
    public Result<List<S4ShenShu>> getAll(){

        List<S4ShenShu> list = iS4ShenShuService.list();
        return new ResultUtil<List<S4ShenShu>>().setData(list);
    }

    @RequestMapping(value = "/getByVillage", method = RequestMethod.GET)
    @ApiOperation(value = "分页获取")
    public Result<List<S4ShenShu>> getByVillage(@RequestParam String villageId,@RequestParam String timeId) {
        List<S4ShenShu> ans = new ArrayList<>();
        Village village = iVillageService.getById(villageId);
        QueryWrapper<TwoWindows> qw = new QueryWrapper<>();
        qw.eq("time_id",timeId);
        List<TwoWindows> twoWindowsList = iTwoWindowsService.list(qw);
        List<AssessmentLine> assessmentLineList = iAssessmentLineService.list();
        List<AssessmentLineItem> assessmentLineItemAllList = iAssessmentLineItemService.list();

        if(village != null) {
            try {
                for (AssessmentLine assessmentLine : assessmentLineList) { // 条线
                    List<AssessmentLineItem> assessmentLineItemList = new ArrayList<>();
                    for (AssessmentLineItem assessmentLineItem : assessmentLineItemAllList) {
                        if(assessmentLineItem.getLineId().equals(assessmentLine.getId())) {
                            assessmentLineItemList.add(assessmentLineItem);
                        }
                    }
                    for (AssessmentLineItem assessmentLineItem : assessmentLineItemList) { // 子项
                        S4ShenShu s4ShenShu = new S4ShenShu();
                        s4ShenShu.setVillageId(village.getId());
                        s4ShenShu.setVillageName(village.getVillageName());
                        s4ShenShu.setRequireId(assessmentLine.getId());
                        s4ShenShu.setRequireText(assessmentLine.getLineName());
                        s4ShenShu.setItemId(assessmentLineItem.getId());
                        s4ShenShu.setItemName(assessmentLineItem.getItemTitle());

                        for (TwoWindows twoWindows : twoWindowsList) {
                            if(twoWindows.getItemId().equals(assessmentLineItem.getId())) {
                                Field field1 = TwoWindows.class.getDeclaredField(village.getFieldName()); // 原因
                                Field field2 = TwoWindows.class.getDeclaredField(village.getFieldGrade()); // 扣分
                                field1.setAccessible(true);
                                field2.setAccessible(true);
                                String msg = (String) field1.get(twoWindows);
                                float grade = (float) field2.get(twoWindows);
                                s4ShenShu.setRequireReason(msg);
                                s4ShenShu.setGrade(grade);
                                break;
                            }
                        }
                        ans.add(s4ShenShu);
                    }
                }
            }catch (Exception e) {
                System.out.println(e);
            }
        }
        return new ResultUtil<List<S4ShenShu>>().setData(ans);
    }

    @RequestMapping(value = "/getByPage", method = RequestMethod.GET)
    @ApiOperation(value = "分页获取")
    public Result<IPage<S4ShenShu>> getByPage(PageVo page){

        IPage<S4ShenShu> data = iS4ShenShuService.page(PageUtil.initMpPage(page));
        return new ResultUtil<IPage<S4ShenShu>>().setData(data);
    }

    @RequestMapping(value = "/insertOrUpdate", method = RequestMethod.POST)
    @ApiOperation(value = "编辑或更新数据")
    public Result<S4ShenShu> saveOrUpdate(S4ShenShu s4ShenShu){

        if(iS4ShenShuService.saveOrUpdate(s4ShenShu)){
            return new ResultUtil<S4ShenShu>().setData(s4ShenShu);
        }
        return new ResultUtil<S4ShenShu>().setErrorMsg("操作失败");
    }

    @RequestMapping(value = "/delByIds", method = RequestMethod.POST)
    @ApiOperation(value = "批量通过id删除")
    public Result<Object> delAllByIds(@RequestParam String[] ids){

        for(String id : ids){
            iS4ShenShuService.removeById(id);
        }
        return ResultUtil.success("批量通过id删除数据成功");
    }
}
