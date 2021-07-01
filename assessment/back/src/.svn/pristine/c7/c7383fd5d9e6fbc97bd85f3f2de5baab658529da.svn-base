package cn.zwz.xboot.modules.assessment.controller;

import cn.zwz.xboot.common.utils.PageUtil;
import cn.zwz.xboot.common.utils.ResultUtil;
import cn.zwz.xboot.common.vo.PageVo;
import cn.zwz.xboot.common.vo.Result;
import cn.zwz.xboot.modules.assessment.entity.Require;
import cn.zwz.xboot.modules.assessment.entity.S4ShenShu;
import cn.zwz.xboot.modules.assessment.entity.Village;
import cn.zwz.xboot.modules.assessment.entity.VillageRequireVo;
import cn.zwz.xboot.modules.assessment.service.IRequireService;
import cn.zwz.xboot.modules.assessment.service.IS4ShenShuService;
import cn.zwz.xboot.modules.assessment.service.IVillageRequireVoService;
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
@Api(description = "考核情况管理接口")
@RequestMapping("/xboot/villageRequireVo")
@Transactional
public class VillageRequireVoController {

    @Autowired
    private IVillageRequireVoService iVillageRequireVoService;

    @Autowired
    private IVillageService iVillageService;

    @Autowired
    private IRequireService iRequireService;

    @Autowired
    private IS4ShenShuService is4ShenShuService;

    @RequestMapping(value = "/init", method = RequestMethod.GET)
    @ApiOperation(value = "初始化")
    public Result<VillageRequireVo> init(){
        List<VillageRequireVo> list = iVillageRequireVoService.list();
        for (VillageRequireVo v1 : list) {
            iVillageRequireVoService.removeById(v1.getId());
        }
        List<Village> villageList = iVillageService.list();
        List<Require> requireList = iRequireService.list();
        for (Village village : villageList) {
            for (Require require : requireList) {
                VillageRequireVo vo = new VillageRequireVo();
                vo.setVillageId(village.getId());
                vo.setVillageName(village.getVillageName());
                vo.setGrade(0);
                vo.setGrade1(0);
                vo.setRequireId(require.getId());
                vo.setRequireTitle(require.getRequireText());
                vo.setRequireType(require.getRequireType());
                vo.setReason("未填写");
                vo.setReason1("未填写");
                iVillageRequireVoService.save(vo);
            }
        }
        return new ResultUtil<VillageRequireVo>().setSuccessMsg("OK");
    }

    @RequestMapping(value = "/getGradeByRequireId", method = RequestMethod.GET)
    @ApiOperation(value = "根据考核规则ID获取成绩")
    public Result<List<VillageRequireVo>> getGradeByRequireId(@RequestParam String id,@RequestParam(required = false) String type){
        QueryWrapper<VillageRequireVo> qw = new QueryWrapper<VillageRequireVo>();
        qw.eq("require_id",id);
        if(type!= null) {
            qw.eq("require_type",type);
        }
        List<VillageRequireVo> voList = iVillageRequireVoService.list(qw);
        return new ResultUtil<List<VillageRequireVo>>().setData(voList);
    }

    @RequestMapping(value = "/getGradeByVillName", method = RequestMethod.GET)
    @ApiOperation(value = "根据村名获取成绩")
    public Result<List<VillageRequireVo>> getGradeByVillName(@RequestParam String name){
        QueryWrapper<VillageRequireVo> qw = new QueryWrapper<VillageRequireVo>();
        qw.eq("village_name",name);
        List<VillageRequireVo> voList = iVillageRequireVoService.list(qw);
        return new ResultUtil<List<VillageRequireVo>>().setData(voList);
    }

    @RequestMapping(value = "/setGradeByRequireId", method = RequestMethod.GET)
    @ApiOperation(value = "根据考核规则ID获取成绩")
    public Result<List<VillageRequireVo>> setGradeByRequireId(@RequestParam String id,@RequestParam String grade,@RequestParam String type,@RequestParam String reason){
        VillageRequireVo vo = iVillageRequireVoService.getById(id);
        if(vo != null) {
            if(type.equals("1")) {
                vo.setGrade(Float.parseFloat(grade));
                vo.setGrade1(Float.parseFloat(grade));
                vo.setReason(reason);
                vo.setReason1(reason);
            }else {
                vo.setGrade1(Float.parseFloat(grade));
                vo.setReason1(reason);
            }
            iVillageRequireVoService.saveOrUpdate(vo);
            return new ResultUtil<List<VillageRequireVo>>().setSuccessMsg("OK");
        }
        return new ResultUtil<List<VillageRequireVo>>().setErrorMsg("FAIL");
    }

    @RequestMapping(value = "/get", method = RequestMethod.GET)
    @ApiOperation(value = "通过id获取")
    public Result<VillageRequireVo> get(@RequestParam String id){

        VillageRequireVo villageRequireVo = iVillageRequireVoService.getById(id);
        return new ResultUtil<VillageRequireVo>().setData(villageRequireVo);
    }

    @RequestMapping(value = "/shenShu", method = RequestMethod.GET)
    @ApiOperation(value = "通过id获取")
    public Result<VillageRequireVo> shenShu(@RequestParam String id,@RequestParam(required = false) String reason){
        if(reason == null) {
            reason = "未填写理由";
        }
        VillageRequireVo v0 = iVillageRequireVoService.getById(id);
        if(v0 != null) {
            S4ShenShu shu = new S4ShenShu();
            shu.setRequireId(v0.getRequireId());
            shu.setRequireText(v0.getRequireTitle());
            shu.setVillageId(v0.getVillageId());
            shu.setVillageName(v0.getVillageName());
            is4ShenShuService.save(shu);
            return new ResultUtil<VillageRequireVo>().setSuccessMsg("OK");
        }
        return new ResultUtil<VillageRequireVo>().setErrorMsg("FAIL");
    }

    @RequestMapping(value = "/getAll", method = RequestMethod.GET)
    @ApiOperation(value = "获取全部数据")
    public Result<List<VillageRequireVo>> getAll(){

        List<VillageRequireVo> list = iVillageRequireVoService.list();
        return new ResultUtil<List<VillageRequireVo>>().setData(list);
    }

    @RequestMapping(value = "/getByPage", method = RequestMethod.GET)
    @ApiOperation(value = "分页获取")
    public Result<IPage<VillageRequireVo>> getByPage(PageVo page){

        IPage<VillageRequireVo> data = iVillageRequireVoService.page(PageUtil.initMpPage(page));
        return new ResultUtil<IPage<VillageRequireVo>>().setData(data);
    }

    @RequestMapping(value = "/insertOrUpdate", method = RequestMethod.POST)
    @ApiOperation(value = "编辑或更新数据")
    public Result<VillageRequireVo> saveOrUpdate(VillageRequireVo villageRequireVo){

        if(iVillageRequireVoService.saveOrUpdate(villageRequireVo)){
            return new ResultUtil<VillageRequireVo>().setData(villageRequireVo);
        }
        return new ResultUtil<VillageRequireVo>().setErrorMsg("操作失败");
    }

    @RequestMapping(value = "/delByIds", method = RequestMethod.POST)
    @ApiOperation(value = "批量通过id删除")
    public Result<Object> delAllByIds(@RequestParam String[] ids){

        for(String id : ids){
            iVillageRequireVoService.removeById(id);
        }
        return ResultUtil.success("批量通过id删除数据成功");
    }
}
