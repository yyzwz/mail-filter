<template>
  <div>
    <Card>
      <div slot="title">
        <div class="edit-head">
          <a @click="close" class="back-title">
            <Icon type="ios-arrow-back" />返回
          </a>
          <div class="head-name">添加</div>
          <span></span>
          <a @click="close" class="window-close">
            <Icon type="ios-close" size="31" class="ivu-icon-ios-close" />
          </a>
        </div>
      </div>
      <Form ref="form" :model="form" :label-width="100" :rules="formValidate" label-position="left" >
          <FormItem label="卖家" prop="jia"  >
            当前选择卖家: {{form.sellerName}} 
            <Button type="error" @click="showSellerWindowFx">导入卖家</Button>
          </FormItem>
          <!-- <FormItem label="车主" prop="jia"  >
            当前选择车主: {{form.ownerName}} 
            <Button type="error" @click="showOwnerWindowFx">导入卖家</Button>
          </FormItem> -->
          <FormItem label="买家身份证" prop="jia"  >
            <Input v-model="form.ownerIdcard" clearable style="width:570px"/>
            <Button type="error" @click="getOwnerByIdCardFx">检测</Button>
          </FormItem>
          <FormItem label="买家姓名" prop="jia"  >
            <Input v-model="form.name" clearable style="width:570px"/>
          </FormItem>
          <FormItem label="买家手机号" prop="jia"  >
            <Input v-model="form.mobile" clearable style="width:570px"/>
          </FormItem>
          <FormItem label="户籍地址" prop="jia"  >
            <Input v-model="form.addressHu" clearable style="width:570px"/>
          </FormItem>
          <FormItem label="住址" prop="jia"  >
            <Input v-model="form.addressZhu" clearable style="width:570px"/>
          </FormItem>
          <FormItem label="出售日期" prop="sellDate"  >
            <DatePicker type="date" format="yyyy-MM-dd" v-model="sellDateTemp" @on-change="changeSellDate" clearable style="width:570px"></DatePicker>
          </FormItem>
          <FormItem label="车架号" prop="jia"  >
            <Input v-model="form.jia" clearable style="width:570px"/>
          </FormItem>
          <FormItem label="车骨号" prop="gu"  >
            <Input v-model="form.gu" clearable style="width:570px"/>
          </FormItem>
          <FormItem label="车品牌" prop="pinPai"  >
            <Input v-model="form.pinPai" clearable style="width:570px"/>
          </FormItem>
          <FormItem label="车型号" prop="xingHao"  >
            <Input v-model="form.xingHao" clearable style="width:570px"/>
          </FormItem>
          <FormItem label="车类型" prop="type"  >
            <Select v-model="form.type" clearable style="width:570px">
              <Option value="电动三轮车">电动三轮车</Option>
              <Option value="汽油三轮车">汽油三轮车</Option>
              <Option value="其他">其他</Option>
            </Select>
          </FormItem>
          <FormItem label="发票照片" prop="piaoPhoto"  >
            <Upload action="https://changjienongye.cn:8080/xboot/car/uploadPhoto" :format="['jpg','png','jpeg']" :on-success="fileSummit"> 
              <Button icon="ios-cloud-upload-outline">上传发票照片</Button>
            </Upload>
          </FormItem>
          <FormItem label="车辆照片" prop="piaoPhoto"  >
            <Upload action="https://changjienongye.cn:8080/xboot/car/uploadPhoto2" :format="['jpg','png','jpeg']" :on-success="fileSummit2"> 
              <Button icon="ios-cloud-upload-outline">上传车辆照片</Button>
            </Upload>
          </FormItem>
          <FormItem label="防盗车牌号" prop="paiHao"  >
            <Input v-model="form.paiHao" clearable style="width:570px"/>
          </FormItem>
          <FormItem label="上保险时间" prop="baoXian"  > 
            <DatePicker type="date" v-model="baoXianTemp" @on-change="changeBaoDate" clearable style="width:570px"></DatePicker>
          </FormItem>
          <FormItem label="备注" prop="remark"  >
            <Input v-model="form.remark" clearable style="width:570px"/>
          </FormItem>
          <FormItem label="处罚情况" prop="violation"  >
            <Input v-model="form.violation" clearable style="width:570px"/>
          </FormItem>
          <Form-item class="br">
            <Button
              @click="handleSubmit"
              :loading="submitLoading"
              type="primary"
            >提交并保存</Button>
            <Button @click="handleReset">重置</Button>
            <Button type="dashed" @click="close">关闭</Button>
          </Form-item>
        </Form>
    </Card>
    <userSelect v-model="showSellerWindowFlag" @submited="sellerSubmited"/>
    <userSelectOwner v-model="showOwnerWindowFlag" @submited="ownerSubmited"/>
  </div>
</template>

<script>
// 根据你的实际请求api.js位置路径修改
import { 
  addCar,
  getOwnerByIdCard,
} from "./api.js";
import userSelect from './userSelect.vue';
import userSelectOwner from './userSelectOwner.vue';
export default {
  name: "add",
  components: {
    userSelect,
    userSelectOwner
  },
  data() {
    return {
      submitLoading: false, // 表单提交状态
      form: { // 添加或编辑表单对象初始化数据
        sellDate: "",
        jia: "",
        gu: "",
        pinPai: "",
        xingHao: "",
        type: "",
        piaoPhoto: "",
        paiHao: "",
        baoXian: "",
        remark: "",
        ownerId: '',
        ownerName: '未选择',
        sellerId: '',
        sellerName: '未选择',
        ownerIdcard: '',
        name: '',
        mobile: '',
        addressHu: '',
        addressZhu: '',
        carPhoto: '',
        sh: '1',
        violation: ''
      },
      // 表单验证规则
      formValidate: {
      },
      sellDateTemp: '',
      baoXianTemp: '',
      showOwnerWindowFlag: false,
      showSellerWindowFlag: false
    };
  },
  methods: {
    init() {},
    fileSummit(e) {
      if(e.success) {
        this.form.piaoPhoto = e.result;
        this.$Message.success("发票上传成功!");
      }else {
        this.$Message.error("发票上传失败!");
      }
    },
    fileSummit2(e) {
      if(e.success) {
        this.form.carPhoto = e.result;
        this.$Message.success("发票上传成功!");
      }else {
        this.$Message.error("发票上传失败!");
      }
    },
    getOwnerByIdCardFx() {
      var that = this;
      if(this.form.ownerIdcard != undefined) {
        getOwnerByIdCard({idCard: this.form.ownerIdcard}).then(res => {
          if(res.result == null) {
            this.$Message.error("买家不存在!");
          } else {
            this.form.name = res.result.name;
            this.form.mobile = res.result.mobile;
            this.form.addressHu = res.result.addressHu;
            this.form.addressZhu = res.result.addressZhu;
            this.$Message.success("自动填充成功!");
          }
        })
      }
      
    },
    ownerSubmited(e) {
      this.form.ownerId = e.id;
      this.form.ownerName = e.name;
      this.form.ownerIdcard = e.idcard;
      this.showOwnerWindowFlag = false;
    },
    sellerSubmited(e) {
      this.form.sellerId = e.id;
      this.form.sellerName = e.shopName;
      this.showSellerWindowFlag = false;
    },
    showOwnerWindowFx() {
      this.showOwnerWindowFlag = true;
    },
    showSellerWindowFx() {
      this.showSellerWindowFlag = true;
    },
    changeSellDate(e) {
      this.form.sellDate = e;
      this.sellDateTemp = e;
    },
    changeBaoDate(e) {
      this.form.baoXian = e;
      this.baoXianTemp = e;
    },
    handleReset() {
      this.$refs.form.resetFields();
    },
    handleSubmit() {
      this.$refs.form.validate(valid => {
        if (valid) {
          addCar(this.form).then(res => {
            this.submitLoading = false;
            if (res.success) {
              this.$Message.success("操作成功");
              this.submited();
            }
          });
        }
      });
    },
    close() {
      this.$emit("close", true);
    },
    submited() {
      this.$emit("submited", true);
    }
  },
  mounted() {
    this.init();
  }
};
</script>
<style lang="less">
// 建议引入通用样式 具体路径自行修改 可删除下面样式代码
// @import "../../../styles/single-common.less";
.edit-head {
    display: flex;
    align-items: center;
    justify-content: space-between;
    position: relative;

    .back-title {
        color: #515a6e;
        display: flex;
        align-items: center;
    }

    .head-name {
        display: inline-block;
        height: 20px;
        line-height: 20px;
        font-size: 16px;
        color: #17233d;
        font-weight: 500;
        overflow: hidden;
        text-overflow: ellipsis;
        white-space: nowrap;
    }

    .window-close {
        z-index: 1;
        font-size: 12px;
        position: absolute;
        right: 0px;
        top: -5px;
        overflow: hidden;
        cursor: pointer;

        .ivu-icon-ios-close {
            color: #999;
            transition: color .2s ease;
        }
    }

    .window-close .ivu-icon-ios-close:hover {
        color: #444;
    }
}
</style>