package cn.zwz.xboot.modules.tricycle.entity;

import cn.zwz.xboot.base.XbootBaseEntity;
import com.baomidou.mybatisplus.annotation.TableName;
import io.swagger.annotations.ApiModelProperty;
import io.swagger.annotations.ApiModel;
import lombok.Data;
import org.hibernate.annotations.DynamicInsert;
import org.hibernate.annotations.DynamicUpdate;
import javax.persistence.Entity;
import javax.persistence.Table;

/**
 * @author 郑为中
 */
@Data
@Entity
@DynamicInsert
@DynamicUpdate
@Table(name = "t_update_record")
@TableName("t_update_record")
@ApiModel(value = "车主信息修改记录")
public class UpdateRecord extends XbootBaseEntity {

    private static final long serialVersionUID = 1L;

    @ApiModelProperty(value = "出售日期")
    private String oldId;

    @ApiModelProperty(value = "出售日期")
    private String sellDate;

    @ApiModelProperty(value = "车架号")
    private String jia;

    @ApiModelProperty(value = "车骨号")
    private String gu;

    @ApiModelProperty(value = "车品牌")
    private String pinPai;

    @ApiModelProperty(value = "车型号")
    private String xingHao;

    @ApiModelProperty(value = "车类型")
    private String type;

    @ApiModelProperty(value = "姓名")
    private String name;

    @ApiModelProperty(value = "手机号")
    private String mobile;

    @ApiModelProperty(value = "身份证号")
    private String ownerIdcard;

    @ApiModelProperty(value = "户籍地址")
    private String addressHu;

    @ApiModelProperty(value = "住址")
    private String addressZhu;

    @ApiModelProperty(value = "户籍地址")
    private String re1;

    @ApiModelProperty(value = "户籍地址")
    private String re2;

    // 更改后

    @ApiModelProperty(value = "出售日期")
    private String sellDate1;

    @ApiModelProperty(value = "车架号")
    private String jia1;

    @ApiModelProperty(value = "车骨号")
    private String gu1;

    @ApiModelProperty(value = "车品牌")
    private String pinPai1;

    @ApiModelProperty(value = "车型号")
    private String xingHao1;

    @ApiModelProperty(value = "车类型")
    private String type1;

    @ApiModelProperty(value = "姓名")
    private String name1;

    @ApiModelProperty(value = "手机号")
    private String mobile1;

    @ApiModelProperty(value = "身份证号")
    private String ownerIdcard1;

    @ApiModelProperty(value = "户籍地址")
    private String addressHu1;

    @ApiModelProperty(value = "住址")
    private String addressZhu1;

    @ApiModelProperty(value = "户籍地址")
    private String re11;

    @ApiModelProperty(value = "户籍地址")
    private String re21;

    // 审核人
    @ApiModelProperty(value = "审核人")
    private String lookPeople;

    @ApiModelProperty(value = "是否审核") // 0 未审核  , 1  已通过  , 2 未通过    5 删除未审核  6 删除通过  7  删除不通过
    private String lookFlag;

    @ApiModelProperty(value = "申请卖家")
    private String sellerId;

    @ApiModelProperty(value = "申请卖家")
    private String sellerName;

    @ApiModelProperty(value = "提交日期")
    private String sendDate;
}