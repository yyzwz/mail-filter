package cn.zwz.xboot.modules.assessment.controller;

import cn.zwz.xboot.common.utils.PageUtil;
import cn.zwz.xboot.common.utils.ResultUtil;
import cn.zwz.xboot.common.vo.PageVo;
import cn.zwz.xboot.common.vo.Result;
import cn.zwz.xboot.modules.assessment.entity.Village;
import cn.zwz.xboot.modules.assessment.entity.VillageManyVo;
import cn.zwz.xboot.modules.assessment.service.IVillageManyService;
import cn.zwz.xboot.modules.assessment.service.IVillageManyVoService;
import cn.zwz.xboot.modules.assessment.service.IVillageService;
import cn.hutool.core.util.StrUtil;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;

/**
 * @author 郑为中
 */
@Slf4j
@RestController
@Api(description = "村庄管理接口")
@RequestMapping("/xboot/village")
@Transactional
public class VillageController {

    @Autowired
    private IVillageService iVillageService;

    @Autowired
    private IVillageManyVoService iVillageManyVoService;


    @RequestMapping(value = "/getByManyId", method = RequestMethod.GET)
    @ApiOperation(value = "分页获取")
    public Result<List<Village>> getByManyId(@RequestParam String manyId){
        QueryWrapper<VillageManyVo> qw = new QueryWrapper<>();
        qw.eq("many_id",manyId);
        List<VillageManyVo> villageManyVoList = iVillageManyVoService.list(qw);
        List<Village> ansList = new ArrayList<>();
        for (VillageManyVo villageManyVo : villageManyVoList) {
            Village village = iVillageService.getById(villageManyVo.getVillageId());
            if(village != null) {
                ansList.add(village);
            }
        }
        return new ResultUtil<List<Village>>().setData(ansList);
    }

    @RequestMapping(value = "/get/{id}", method = RequestMethod.GET)
    @ApiOperation(value = "通过id获取")
    public Result<Village> get(@PathVariable String id){

        Village village = iVillageService.getById(id);
        return new ResultUtil<Village>().setData(village);
    }

    @RequestMapping(value = "/getAll", method = RequestMethod.GET)
    @ApiOperation(value = "获取全部数据")
    public Result<List<Village>> getAll(){

        List<Village> list = iVillageService.list();
        return new ResultUtil<List<Village>>().setData(list);
    }

    @RequestMapping(value = "/getByPage", method = RequestMethod.GET)
    @ApiOperation(value = "分页获取")
    public Result<IPage<Village>> getByPage(PageVo page){

        IPage<Village> data = iVillageService.page(PageUtil.initMpPage(page));
        return new ResultUtil<IPage<Village>>().setData(data);
    }

    @RequestMapping(value = "/insertOrUpdate", method = RequestMethod.POST)
    @ApiOperation(value = "编辑或更新数据")
    public Result<Village> saveOrUpdate(Village village){

        if(iVillageService.saveOrUpdate(village)){
            return new ResultUtil<Village>().setData(village);
        }
        return new ResultUtil<Village>().setErrorMsg("操作失败");
    }

    @RequestMapping(value = "/save", method = RequestMethod.GET)
    public Result<Village> save(@RequestParam String title){
        if(!title.endsWith("社区")) {
            title += "村";
        }
        title = title.trim();
        Village village = new Village();
        village.setVillageName(title);
        iVillageService.save(village);
        return new ResultUtil<Village>().setSuccessMsg("OK");
    }

    @RequestMapping(value = "/delByIds", method = RequestMethod.POST)
    @ApiOperation(value = "批量通过id删除")
    public Result<Object> delAllByIds(@RequestParam String[] ids){

        for(String id : ids){
            iVillageService.removeById(id);
        }
        return ResultUtil.success("批量通过id删除数据成功");
    }
}
