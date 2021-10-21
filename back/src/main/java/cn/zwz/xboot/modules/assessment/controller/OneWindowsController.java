package cn.zwz.xboot.modules.assessment.controller;

import cn.zwz.xboot.common.utils.PageUtil;
import cn.zwz.xboot.common.utils.ResultUtil;
import cn.zwz.xboot.common.vo.PageVo;
import cn.zwz.xboot.common.vo.Result;
import cn.zwz.xboot.modules.assessment.entity.*;
import cn.zwz.xboot.modules.assessment.service.IAssessmentLineItemService;
import cn.zwz.xboot.modules.assessment.service.IAssessmentLineService;
import cn.zwz.xboot.modules.assessment.service.ITwoWindowsService;
import cn.zwz.xboot.modules.assessment.service.IVillageService;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.*;

import java.lang.reflect.Field;
import java.util.ArrayList;
import java.util.List;

/**
 * @author 郑为中
 */
@Slf4j
@RestController
@Api(description = "二级页面管理接口")
@RequestMapping("/xboot/oneWindows")
@Transactional
public class OneWindowsController {

    @Autowired
    private ITwoWindowsService iTwoWindowsService;

    @Autowired
    private IAssessmentLineService iAssessmentLineService;

    @Autowired
    private IAssessmentLineItemService iAssessmentLineItemService;

    @Autowired
    private IVillageService iVillageService;



    @RequestMapping(value = "/getByLine", method = RequestMethod.GET)
    @ApiOperation(value = "一级页面")
    public Result<List<TwoWindows>> getByLine(@RequestParam String timeId) throws Exception {
        List<TwoWindows> ans = new ArrayList<>();
        List<Village> villageList = iVillageService.list();
        TwoWindows ansItemSum = new TwoWindows(); // 汇总
        ansItemSum.setItemName("总计");
        ans.add(ansItemSum);
        // 所有条线
        List<AssessmentLine> assessmentLineList = iAssessmentLineService.list();
        for (AssessmentLine assessmentLine : assessmentLineList) {
            TwoWindows ansItem = new TwoWindows(); // 汇总
            ansItem.setItemName(assessmentLine.getLineName());

            QueryWrapper<TwoWindows> qw = new QueryWrapper<>();
            qw.eq("line_id",assessmentLine.getId());
            qw.eq("time_id",timeId);
            List<TwoWindows> twoWindowsList = iTwoWindowsService.list(qw);
            for (Village village : villageList) { // 村庄
                float gradeSum = 0.0f;
                for (TwoWindows twoWindows : twoWindowsList) { // 评分结果
                    Field field2 = TwoWindows.class.getDeclaredField(village.getFieldGrade()); // 扣分
                    field2.setAccessible(true);
                    float grade = (float) field2.get(twoWindows);
                    gradeSum += grade;
                }
                // TwoWindows.class.getDeclaredField(village.getFieldGrade());
                Field field2 = TwoWindows.class.getDeclaredField(village.getFieldGrade()); // 扣分
                field2.setAccessible(true);
                field2.set(ansItem, gradeSum);
                Field field3 = TwoWindows.class.getDeclaredField(village.getFieldGrade()); // 扣分
                field3.setAccessible(true);
                float ansItemSumNumber = (float)field3.get(ansItemSum);
                ansItemSumNumber += gradeSum;
                field3.set(ansItemSum, ansItemSumNumber);
            }
            ans.add(ansItem);
        }
        ans.set(0,ansItemSum);
        return new ResultUtil<List<TwoWindows>>().setData(ans);
    }

    @RequestMapping(value = "/getByVillage", method = RequestMethod.GET)
    @ApiOperation(value = "分页获取")
    public Result<List<S4ShenShu>> getByVillage(@RequestParam String villageId, @RequestParam String timeId) {
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

}
