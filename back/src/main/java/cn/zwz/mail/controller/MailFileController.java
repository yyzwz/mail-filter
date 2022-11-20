package cn.zwz.mail.controller;

import cn.zwz.basics.utils.PageUtil;
import cn.zwz.basics.utils.ResultUtil;
import cn.zwz.basics.baseVo.PageVo;
import cn.zwz.basics.baseVo.Result;
import cn.zwz.data.entity.File;
import cn.zwz.data.service.IFileService;
import cn.zwz.data.utils.ZwzNullUtils;
import cn.zwz.mail.entity.MailArchives;
import cn.zwz.mail.entity.MailFile;
import cn.zwz.mail.service.IMailArchivesService;
import cn.zwz.mail.service.IMailFileService;
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
@Api(tags = "邮件附件管理接口")
@RequestMapping("/zwz/mailFile")
@Transactional
public class MailFileController {

    @Autowired
    private IMailFileService iMailFileService;

    @Autowired
    private IFileService iFileService;

    @Autowired
    private IMailArchivesService iMailArchivesService;

    @RequestMapping(value = "/getOne", method = RequestMethod.GET)
    @ApiOperation(value = "查询单条邮件附件")
    public Result<MailFile> get(@RequestParam String id){
        return new ResultUtil<MailFile>().setData(iMailFileService.getById(id));
    }

    @RequestMapping(value = "/count", method = RequestMethod.GET)
    @ApiOperation(value = "查询全部邮件附件个数")
    public Result<Long> getCount(){
        return new ResultUtil<Long>().setData(iMailFileService.count());
    }

    @RequestMapping(value = "/getAll", method = RequestMethod.GET)
    @ApiOperation(value = "根据邮件查询全部附件")
    public Result<List<MailFile>> getAll(@RequestParam String mailId){
        QueryWrapper<MailFile> qw = new QueryWrapper<>();
        qw.eq("mail_id",mailId);
        return new ResultUtil<List<MailFile>>().setData(iMailFileService.list(qw));
    }

    @RequestMapping(value = "/addFile", method = RequestMethod.GET)
    @ApiOperation(value = "新增邮件的附件")
    public Result<Object> addFile(@RequestParam String mailId,@RequestParam String fileId){
        String[] fileSplit = fileId.split("/");
        File file = iFileService.getById(fileSplit[fileSplit.length - 1]);
        if(file == null) {
            return ResultUtil.error("附件文件不存在");
        }
        MailArchives mailArchives = iMailArchivesService.getById(mailId);
        if(mailArchives == null) {
            return ResultUtil.error("邮件不存在");
        }
        MailFile mailFile = new MailFile();
        mailFile.setFileId(fileId);
        mailFile.setMailId(mailId);
        mailFile.setFileSize(file.getSize());
        mailFile.setTitle(file.getName());
        iMailFileService.saveOrUpdate(mailFile);
        return ResultUtil.success();
    }

    @RequestMapping(value = "/getByPage", method = RequestMethod.GET)
    @ApiOperation(value = "查询邮件附件")
    public Result<IPage<MailFile>> getByPage(@ModelAttribute MailFile mailFile ,@ModelAttribute PageVo page){
        QueryWrapper<MailFile> qw = new QueryWrapper<>();
        if(!ZwzNullUtils.isNull(mailFile.getCreateBy())) {
        }
        IPage<MailFile> data = iMailFileService.page(PageUtil.initMpPage(page),qw);
        return new ResultUtil<IPage<MailFile>>().setData(data);
    }

    @RequestMapping(value = "/insertOrUpdate", method = RequestMethod.POST)
    @ApiOperation(value = "增改邮件附件")
    public Result<MailFile> saveOrUpdate(MailFile mailFile){
        if(iMailFileService.saveOrUpdate(mailFile)){
            return new ResultUtil<MailFile>().setData(mailFile);
        }
        return ResultUtil.error();
    }

    @RequestMapping(value = "/insert", method = RequestMethod.POST)
    @ApiOperation(value = "新增邮件附件")
    public Result<MailFile> insert(MailFile mailFile){
        iMailFileService.saveOrUpdate(mailFile);
        return new ResultUtil<MailFile>().setData(mailFile);
    }

    @RequestMapping(value = "/update", method = RequestMethod.POST)
    @ApiOperation(value = "编辑邮件附件")
    public Result<MailFile> update(MailFile mailFile){
        iMailFileService.saveOrUpdate(mailFile);
        return new ResultUtil<MailFile>().setData(mailFile);
    }

    @RequestMapping(value = "/delByIds", method = RequestMethod.POST)
    @ApiOperation(value = "删除邮件附件")
    public Result<Object> delByIds(@RequestParam String[] ids){
        for(String id : ids){
            iMailFileService.removeById(id);
        }
        return ResultUtil.success();
    }
}
