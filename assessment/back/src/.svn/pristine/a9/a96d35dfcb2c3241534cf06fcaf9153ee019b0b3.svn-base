package cn.zwz.xboot.modules.assessment.controller;

import cn.zwz.xboot.common.utils.PageUtil;
import cn.zwz.xboot.common.utils.ResultUtil;
import cn.zwz.xboot.common.vo.PageVo;
import cn.zwz.xboot.common.vo.Result;
import cn.zwz.xboot.modules.assessment.entity.VillageManyVo;
import cn.zwz.xboot.modules.assessment.service.IVillageManyVoService;
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
@Api(description = "联村关系管理接口")
@RequestMapping("/xboot/villageManyVo")
@Transactional
public class VillageManyVoController {

    @Autowired
    private IVillageManyVoService iVillageManyVoService;

    @RequestMapping(value = "/get/{id}", method = RequestMethod.GET)
    @ApiOperation(value = "通过id获取")
    public Result<VillageManyVo> get(@PathVariable String id){

        VillageManyVo villageManyVo = iVillageManyVoService.getById(id);
        return new ResultUtil<VillageManyVo>().setData(villageManyVo);
    }

    @RequestMapping(value = "/getAll", method = RequestMethod.GET)
    @ApiOperation(value = "获取全部数据")
    public Result<List<VillageManyVo>> getAll(){

        List<VillageManyVo> list = iVillageManyVoService.list();
        return new ResultUtil<List<VillageManyVo>>().setData(list);
    }

    @RequestMapping(value = "/getByPage", method = RequestMethod.GET)
    @ApiOperation(value = "分页获取")
    public Result<IPage<VillageManyVo>> getByPage(@ModelAttribute VillageManyVo villageManyVo,@ModelAttribute PageVo page){
        QueryWrapper<VillageManyVo> qw = new QueryWrapper<>();
        if(villageManyVo.getManyId() != null && !NullUtils.isNull(villageManyVo.getManyId())) {
            qw.eq("many_id",villageManyVo.getManyId());
        }
        if(villageManyVo.getVillageId() != null && !NullUtils.isNull(villageManyVo.getVillageId())) {
            qw.eq("village_id",villageManyVo.getVillageId());
        }
        IPage<VillageManyVo> data = iVillageManyVoService.page(PageUtil.initMpPage(page),qw);
        return new ResultUtil<IPage<VillageManyVo>>().setData(data);
    }

    @RequestMapping(value = "/insertOrUpdate", method = RequestMethod.POST)
    @ApiOperation(value = "编辑或更新数据")
    public Result<VillageManyVo> saveOrUpdate(VillageManyVo villageManyVo){

        if(iVillageManyVoService.saveOrUpdate(villageManyVo)){
            return new ResultUtil<VillageManyVo>().setData(villageManyVo);
        }
        return new ResultUtil<VillageManyVo>().setErrorMsg("操作失败");
    }

    @RequestMapping(value = "/insert", method = RequestMethod.POST)
    @ApiOperation(value = "编辑或更新数据")
    public Result<VillageManyVo> insert(@RequestParam String villageId,@RequestParam String manyId){
        String[] split = villageId.split(",");
        for (String s : split) {
            VillageManyVo vo = new VillageManyVo();
            vo.setVillageId(s);
            vo.setManyId(manyId);
            iVillageManyVoService.saveOrUpdate(vo);
        }
        return new ResultUtil<VillageManyVo>().setSuccessMsg("OK");
    }

    @RequestMapping(value = "/delByIds", method = RequestMethod.POST)
    @ApiOperation(value = "批量通过id删除")
    public Result<Object> delAllByIds(@RequestParam String[] ids){

        for(String id : ids){
            iVillageManyVoService.removeById(id);
        }
        return ResultUtil.success("批量通过id删除数据成功");
    }
}
