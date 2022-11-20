package cn.zwz.mail.controller;

import cn.zwz.basics.utils.PageUtil;
import cn.zwz.basics.utils.ResultUtil;
import cn.zwz.basics.baseVo.PageVo;
import cn.zwz.basics.baseVo.Result;
import cn.zwz.basics.utils.SecurityUtil;
import cn.zwz.data.entity.User;
import cn.zwz.data.utils.ZwzNullUtils;
import cn.zwz.mail.entity.KeyArchives;
import cn.zwz.mail.service.IKeyArchivesService;
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
@Api(tags = "关键词档案管理接口")
@RequestMapping("/zwz/keyArchives")
@Transactional
public class KeyArchivesController {

    @Autowired
    private IKeyArchivesService iKeyArchivesService;

    @Autowired
    private SecurityUtil securityUtil;

    @RequestMapping(value = "/getOne", method = RequestMethod.GET)
    @ApiOperation(value = "查询单条关键词档案")
    public Result<KeyArchives> get(@RequestParam String id){
        return new ResultUtil<KeyArchives>().setData(iKeyArchivesService.getById(id));
    }

    @RequestMapping(value = "/count", method = RequestMethod.GET)
    @ApiOperation(value = "查询全部关键词档案个数")
    public Result<Long> getCount(){
        return new ResultUtil<Long>().setData(iKeyArchivesService.count());
    }

    @RequestMapping(value = "/getAll", method = RequestMethod.GET)
    @ApiOperation(value = "查询全部关键词档案")
    public Result<List<KeyArchives>> getAll(){
        return new ResultUtil<List<KeyArchives>>().setData(iKeyArchivesService.list());
    }

    @RequestMapping(value = "/getByPage", method = RequestMethod.GET)
    @ApiOperation(value = "查询关键词档案")
    public Result<IPage<KeyArchives>> getByPage(@ModelAttribute KeyArchives keyArchives ,@ModelAttribute PageVo page){
        QueryWrapper<KeyArchives> qw = new QueryWrapper<>();
        User currUser = securityUtil.getCurrUser();
        qw.eq("user_id",currUser.getId());
        if(!ZwzNullUtils.isNull(keyArchives.getTitle())) {
            qw.like("title",keyArchives.getTitle());
        }
        IPage<KeyArchives> data = iKeyArchivesService.page(PageUtil.initMpPage(page),qw);
        return new ResultUtil<IPage<KeyArchives>>().setData(data);
    }

    @RequestMapping(value = "/insertOrUpdate", method = RequestMethod.POST)
    @ApiOperation(value = "增改关键词档案")
    public Result<KeyArchives> saveOrUpdate(KeyArchives keyArchives){
        User currUser = securityUtil.getCurrUser();
        keyArchives.setUserId(currUser.getId());
        if(iKeyArchivesService.saveOrUpdate(keyArchives)){
            return new ResultUtil<KeyArchives>().setData(keyArchives);
        }
        return ResultUtil.error();
    }

    @RequestMapping(value = "/insert", method = RequestMethod.POST)
    @ApiOperation(value = "新增关键词档案")
    public Result<KeyArchives> insert(KeyArchives keyArchives){
        User currUser = securityUtil.getCurrUser();
        keyArchives.setUserId(currUser.getId());
        iKeyArchivesService.saveOrUpdate(keyArchives);
        return new ResultUtil<KeyArchives>().setData(keyArchives);
    }

    @RequestMapping(value = "/update", method = RequestMethod.POST)
    @ApiOperation(value = "编辑关键词档案")
    public Result<KeyArchives> update(KeyArchives keyArchives){
        iKeyArchivesService.saveOrUpdate(keyArchives);
        return new ResultUtil<KeyArchives>().setData(keyArchives);
    }

    @RequestMapping(value = "/delByIds", method = RequestMethod.POST)
    @ApiOperation(value = "删除关键词档案")
    public Result<Object> delByIds(@RequestParam String[] ids){
        for(String id : ids){
            iKeyArchivesService.removeById(id);
        }
        return ResultUtil.success();
    }
}
