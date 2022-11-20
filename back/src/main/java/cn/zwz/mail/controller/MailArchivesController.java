package cn.zwz.mail.controller;

import cn.zwz.basics.utils.PageUtil;
import cn.zwz.basics.utils.ResultUtil;
import cn.zwz.basics.baseVo.PageVo;
import cn.zwz.basics.baseVo.Result;
import cn.zwz.basics.utils.SecurityUtil;
import cn.zwz.data.entity.User;
import cn.zwz.data.service.IUserService;
import cn.zwz.data.utils.ZwzNullUtils;
import cn.zwz.mail.entity.Blacklist;
import cn.zwz.mail.entity.KeyArchives;
import cn.zwz.mail.entity.MailArchives;
import cn.zwz.mail.entity.Whitelist;
import cn.zwz.mail.service.IBlacklistService;
import cn.zwz.mail.service.IKeyArchivesService;
import cn.zwz.mail.service.IMailArchivesService;
import cn.hutool.core.util.StrUtil;
import cn.zwz.mail.service.IWhitelistService;
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
@Api(tags = "邮件档案管理接口")
@RequestMapping("/zwz/mailArchives")
@Transactional
public class MailArchivesController {

    @Autowired
    private IMailArchivesService iMailArchivesService;

    @Autowired
    private SecurityUtil securityUtil;

    @Autowired
    private IUserService iUserService;

    @Autowired
    private IWhitelistService iWhitelistService;

    @Autowired
    private IBlacklistService iBlacklistService;

    @Autowired
    private IKeyArchivesService iKeyArchivesService;

    @RequestMapping(value = "/getOne", method = RequestMethod.GET)
    @ApiOperation(value = "查询单条邮件档案")
    public Result<MailArchives> get(@RequestParam String id){
        return new ResultUtil<MailArchives>().setData(iMailArchivesService.getById(id));
    }

    @RequestMapping(value = "/count", method = RequestMethod.GET)
    @ApiOperation(value = "查询全部邮件档案个数")
    public Result<Long> getCount(){
        return new ResultUtil<Long>().setData(iMailArchivesService.count());
    }

    @RequestMapping(value = "/getAll", method = RequestMethod.GET)
    @ApiOperation(value = "查询全部邮件档案")
    public Result<List<MailArchives>> getAll(){
        return new ResultUtil<List<MailArchives>>().setData(iMailArchivesService.list());
    }

    @RequestMapping(value = "/getByPage", method = RequestMethod.GET)
    @ApiOperation(value = "查询邮件档案")
    public Result<IPage<MailArchives>> getByPage(@ModelAttribute MailArchives mailArchives ,@ModelAttribute PageVo page){
        QueryWrapper<MailArchives> qw = new QueryWrapper<>();
        if(!ZwzNullUtils.isNull(mailArchives.getCreateBy())) {
        }
        IPage<MailArchives> data = iMailArchivesService.page(PageUtil.initMpPage(page),qw);
        return new ResultUtil<IPage<MailArchives>>().setData(data);
    }

    @RequestMapping(value = "/getByShouPage", method = RequestMethod.GET)
    @ApiOperation(value = "查询收件箱档案")
    public Result<IPage<MailArchives>> getByShouPage(@ModelAttribute MailArchives mailArchives ,@ModelAttribute PageVo page){
        User currUser = securityUtil.getCurrUser();
        QueryWrapper<MailArchives> qw = new QueryWrapper<>();
        qw.eq("to_id",currUser.getId());
        if(!ZwzNullUtils.isNull(mailArchives.getFromUser())) {
            qw.like("from_user",mailArchives.getFromUser());
        }
        if(mailArchives.getStatus() > 0) {
            qw.eq("status",mailArchives.getStatus() - 1);
        }
        qw.ne("status",3);
        IPage<MailArchives> data = iMailArchivesService.page(PageUtil.initMpPage(page),qw);
        return new ResultUtil<IPage<MailArchives>>().setData(data);
    }

    @RequestMapping(value = "/getByLaJiPage", method = RequestMethod.GET)
    @ApiOperation(value = "查询回收站档案")
    public Result<IPage<MailArchives>> getByLaJiPage(@ModelAttribute MailArchives mailArchives ,@ModelAttribute PageVo page){
        User currUser = securityUtil.getCurrUser();
        QueryWrapper<MailArchives> qw = new QueryWrapper<>();
        qw.eq("to_id",currUser.getId());
        if(!ZwzNullUtils.isNull(mailArchives.getFromUser())) {
            qw.like("from_user",mailArchives.getFromUser());
        }
        qw.eq("status",3);
        IPage<MailArchives> data = iMailArchivesService.page(PageUtil.initMpPage(page),qw);
        return new ResultUtil<IPage<MailArchives>>().setData(data);
    }

    @RequestMapping(value = "/getByFaPage", method = RequestMethod.GET)
    @ApiOperation(value = "查询发件箱档案")
    public Result<IPage<MailArchives>> getByFaPage(@ModelAttribute MailArchives mailArchives ,@ModelAttribute PageVo page){
        User currUser = securityUtil.getCurrUser();
        QueryWrapper<MailArchives> qw = new QueryWrapper<>();
        qw.eq("from_id",currUser.getId());
        if(!ZwzNullUtils.isNull(mailArchives.getToUser())) {
            qw.like("to_user",mailArchives.getToUser());
        }
        if(mailArchives.getStatus() > 0) {
            qw.eq("status",mailArchives.getStatus() - 1);
        }
        IPage<MailArchives> data = iMailArchivesService.page(PageUtil.initMpPage(page),qw);
        return new ResultUtil<IPage<MailArchives>>().setData(data);
    }

    @RequestMapping(value = "/insertOrUpdate", method = RequestMethod.POST)
    @ApiOperation(value = "增改邮件档案")
    public Result<MailArchives> saveOrUpdate(MailArchives mailArchives){
        User currUser = securityUtil.getCurrUser();
        mailArchives.setFromId(currUser.getId());
        if(iMailArchivesService.saveOrUpdate(mailArchives)){
            return new ResultUtil<MailArchives>().setData(mailArchives);
        }
        return ResultUtil.error();
    }

    @RequestMapping(value = "/saveCao", method = RequestMethod.POST)
    @ApiOperation(value = "保存为草稿")
    public Result<MailArchives> saveCao(MailArchives mailArchives){
        User currUser = securityUtil.getCurrUser();
        mailArchives.setFromId(currUser.getId());
        mailArchives.setFromUser(currUser.getNickname());
        User toUser = iUserService.getById(mailArchives.getToId());
        if(toUser == null) {
            return ResultUtil.error("接收方账号不存在");
        }
        mailArchives.setToUser(toUser.getNickname());
        mailArchives.setStatus(0);
        mailArchives.setFilterReason("");
        iMailArchivesService.saveOrUpdate(mailArchives);
        return new ResultUtil<MailArchives>().setData(mailArchives);
    }

    @RequestMapping(value = "/editCao", method = RequestMethod.POST)
    @ApiOperation(value = "更新草稿邮件")
    public Result<MailArchives> editCao(MailArchives mailArchives){
        MailArchives mail = iMailArchivesService.getById(mailArchives.getId());
        if(mail == null) {
            return ResultUtil.error("草稿邮件已被删除");
        }
        User currUser = securityUtil.getCurrUser();
        mailArchives.setFromId(currUser.getId());
        mailArchives.setFromUser(currUser.getNickname());
        User toUser = iUserService.getById(mailArchives.getToId());
        if(toUser == null) {
            return ResultUtil.error("接收方账号不存在");
        }
        mailArchives.setToUser(toUser.getNickname());
        mailArchives.setStatus(0);
        mailArchives.setFilterReason("");
        iMailArchivesService.saveOrUpdate(mailArchives);
        return new ResultUtil<MailArchives>().setData(mailArchives);
    }

    @RequestMapping(value = "/insert", method = RequestMethod.POST)
    @ApiOperation(value = "发送邮件")
    public Result<MailArchives> insert(MailArchives mailArchives){
        User currUser = securityUtil.getCurrUser();
        mailArchives.setFromId(currUser.getId());
        mailArchives.setFromUser(currUser.getNickname());
        User toUser = iUserService.getById(mailArchives.getToId());
        if(toUser == null) {
            return ResultUtil.error("接收方账号不存在");
        }
        mailArchives.setToUser(toUser.getNickname());
        // 白名单过滤
        QueryWrapper<Whitelist> wQw = new QueryWrapper<>();
        wQw.eq("user_id",mailArchives.getToId());
        wQw.eq("mail_id",mailArchives.getFromId());
        long whiteCount = iWhitelistService.count(wQw);
        if(whiteCount > 0) {
            mailArchives.setStatus(1);
            mailArchives.setFilterReason("正常");
        } else {
            // 白名单过滤
            QueryWrapper<Blacklist> bQw = new QueryWrapper<>();
            bQw.eq("user_id",mailArchives.getToId());
            bQw.eq("mail_id",mailArchives.getFromId());
            long blackCount = iBlacklistService.count(bQw);
            if(blackCount > 0) {
                mailArchives.setStatus(2);
                mailArchives.setFilterReason("黑名单拦截");
            } else {
                // 关键词过滤
                QueryWrapper<KeyArchives> kQw = new QueryWrapper<>();
                kQw.eq("user_id",mailArchives.getToId());
                List<KeyArchives> archivesList = iKeyArchivesService.list(kQw);
                String content = mailArchives.getContent();
                String msg = "关键词过滤: ";
                boolean msgFlag = false;
                for (KeyArchives key : archivesList) {
                    if(content.indexOf(key.getTitle()) > -1) {
                        msg += key.getTitle()+ " ";
                        msgFlag = true;
                    }
                }
                if(msgFlag) {
                    mailArchives.setStatus(2);
                    mailArchives.setFilterReason(msg);
                } else {
                    mailArchives.setStatus(1);
                    mailArchives.setFilterReason("正常");
                }
            }
        }
        iMailArchivesService.saveOrUpdate(mailArchives);
        return new ResultUtil<MailArchives>().setData(mailArchives);
    }

    @RequestMapping(value = "/update", method = RequestMethod.POST)
    @ApiOperation(value = "编辑邮件档案")
    public Result<MailArchives> update(MailArchives mailArchives){
        iMailArchivesService.saveOrUpdate(mailArchives);
        return new ResultUtil<MailArchives>().setData(mailArchives);
    }

    @RequestMapping(value = "/deleteOnUser", method = RequestMethod.POST)
    @ApiOperation(value = "逻辑删除邮件档案")
    public Result<Object> deleteOnUser(@RequestParam String[] ids){
        for(String id : ids){
            MailArchives ma = iMailArchivesService.getById(id);
            if(ma != null) {
                ma.setStatus(3);
                iMailArchivesService.saveOrUpdate(ma);
            }
        }
        return ResultUtil.success();
    }


    @RequestMapping(value = "/delByIds", method = RequestMethod.POST)
    @ApiOperation(value = "删除邮件档案")
    public Result<Object> delByIds(@RequestParam String[] ids){
        for(String id : ids){
            iMailArchivesService.removeById(id);
        }
        return ResultUtil.success();
    }
}
