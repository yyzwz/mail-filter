package cn.zwz.xboot.modules.assessment.controller;

import cn.zwz.xboot.common.utils.PageUtil;
import cn.zwz.xboot.common.utils.ResultUtil;
import cn.zwz.xboot.common.vo.PageVo;
import cn.zwz.xboot.common.vo.Result;
import cn.zwz.xboot.modules.assessment.entity.VillageMany;
import cn.zwz.xboot.modules.assessment.service.IVillageManyService;
import cn.hutool.core.util.StrUtil;
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
@Api(description = "联村档案管理接口")
@RequestMapping("/xboot/villageMany")
@Transactional
public class VillageManyController {

    @Autowired
    private IVillageManyService iVillageManyService;

    @RequestMapping(value = "/get/{id}", method = RequestMethod.GET)
    @ApiOperation(value = "通过id获取")
    public Result<VillageMany> get(@PathVariable String id){

        VillageMany villageMany = iVillageManyService.getById(id);
        return new ResultUtil<VillageMany>().setData(villageMany);
    }

    @RequestMapping(value = "/getAll", method = RequestMethod.GET)
    @ApiOperation(value = "获取全部数据")
    public Result<List<VillageMany>> getAll(){

        List<VillageMany> list = iVillageManyService.list();
        return new ResultUtil<List<VillageMany>>().setData(list);
    }

    @RequestMapping(value = "/getByPage", method = RequestMethod.GET)
    @ApiOperation(value = "分页获取")
    public Result<IPage<VillageMany>> getByPage(PageVo page){

        IPage<VillageMany> data = iVillageManyService.page(PageUtil.initMpPage(page));
        return new ResultUtil<IPage<VillageMany>>().setData(data);
    }

    @RequestMapping(value = "/insertOrUpdate", method = RequestMethod.POST)
    @ApiOperation(value = "编辑或更新数据")
    public Result<VillageMany> saveOrUpdate(VillageMany villageMany){

        if(iVillageManyService.saveOrUpdate(villageMany)){
            return new ResultUtil<VillageMany>().setData(villageMany);
        }
        return new ResultUtil<VillageMany>().setErrorMsg("操作失败");
    }

    @RequestMapping(value = "/delByIds", method = RequestMethod.POST)
    @ApiOperation(value = "批量通过id删除")
    public Result<Object> delAllByIds(@RequestParam String[] ids){

        for(String id : ids){
            iVillageManyService.removeById(id);
        }
        return ResultUtil.success("批量通过id删除数据成功");
    }
}
