package cn.zwz.xboot.modules.tricycle.controller;

import cn.zwz.xboot.common.utils.PageUtil;
import cn.zwz.xboot.common.utils.ResultUtil;
import cn.zwz.xboot.common.vo.PageVo;
import cn.zwz.xboot.common.vo.Result;
import cn.zwz.xboot.modules.tricycle.entity.Car;
import cn.zwz.xboot.modules.tricycle.entity.Seller;
import cn.zwz.xboot.modules.tricycle.entity.UpdateRecord;
import cn.zwz.xboot.modules.tricycle.service.ICarService;
import cn.zwz.xboot.modules.tricycle.service.ISellerService;
import cn.zwz.xboot.modules.tricycle.service.IUpdateRecordService;
import cn.zwz.xboot.modules.utils.DateUtils;
import cn.zwz.xboot.modules.utils.NullUtils;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.MultipartResolver;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.List;
import java.util.UUID;

/**
 * @author 郑为中
 */
@Slf4j
@RestController
@Api(description = "车辆管理接口")
@RequestMapping("/xboot/fileUpload")
@Transactional
public class FileUploadController {

    @Autowired
    private ICarService iCarService;

    @Autowired
    private ISellerService iSellerService;

    @Autowired
    private IUpdateRecordService iUpdateRecordService;

    @RequestMapping(value = "/uploadSellerFile", method = RequestMethod.POST)
    public ModelAndView uploadImage(HttpServletRequest request, HttpServletResponse response) throws IOException {
        //MultipartResolver resolver = new CommonsMultipartResolver(request.getSession().getServletContext());
        //MultipartHttpServletRequest req = resolver.resolveMultipart(request);

        MultipartHttpServletRequest req =(MultipartHttpServletRequest)request;
        MultipartFile file =  req.getFile("file");
        String id = (String)request.getParameter("id");
        String type = (String)request.getParameter("type");
        if(file != null){
            System.out.println("获取图片成功");
        }
        // String realPath = "C:\\java\\tomcat\\webapps\\docs\\static\\";
        String realPath = "C:\\test\\";
        if(type.equals("1")) {
            realPath = "C:\\java\\tomcat\\webapps\\ROOT\\yyzz\\";
        } else {
            realPath = "C:\\java\\tomcat\\webapps\\ROOT\\dp\\";
        }
        try {
            File dir = new File(realPath);
            if (!dir.exists()) {
                dir.mkdir();
            }
            String uuid = UUID.randomUUID().toString().replaceAll("-","");
            System.out.println(uuid);
            String name =uuid + ".jpg";
            System.out.println(name);
            Seller seller = iSellerService.getById(id);
            if(seller != null) {
                if(type.equals("1")) {
                    seller.setYyzzFile(name);
                }
                else {
                    seller.setAddressFile(name);
                }
                iSellerService.saveOrUpdate(seller);
            }
            File files  =  new File(realPath, name);
            file.transferTo(files);
            byte[] data = null;
            try {
                InputStream in = new FileInputStream(realPath + name);
                data = new byte[in.available()];
                in.read(data);
                in.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
        } catch (IOException e) {
            e.printStackTrace();
        } catch (IllegalStateException e) {
            e.printStackTrace();
        }
        return null;
    }
}
