<template>
  <div class="search">
    <Card v-show="currView=='index'">
      <div v-if="this.total==0">
        <div class="error404-body-con-title">4<span><Icon type="ios-navigate-outline"></Icon></span>4</div>
        <p class="error404-body-con-message">没有需要审核的卖家哦！</p>
        <div class="error404-btn-con">
          <Button ghost size="large" type="primary" @click="getDataList" icon="ios-loading">刷新</Button>
        </div>
      </div>
      <div v-if="this.total!=0">
        <Row :gutter="32">
          <Col span="10">
            <img :src="imgSrc" style="height:500px;width:500px;" />
          </Col>
          <Col span="7">
            <Row :gutter="10">
              <Form label-colon :label-width="90">
                <FormItem label="出售日期">
                  <Input readonly v-model="nowSelectData.sellDate" style="width: 260px" />
                </FormItem>
                <FormItem label="车架号">
                  <Input readonly v-model="nowSelectData.jia" style="width: 260px" />
                </FormItem>
                <FormItem label="车骨号">
                  <Input readonly v-model="nowSelectData.gu" style="width: 260px" />
                </FormItem>
                <FormItem label="车品牌">
                  <Input readonly v-model="nowSelectData.pinPai" style="width: 260px" />
                </FormItem>
                <FormItem label="车型号">
                  <Input v-model="nowSelectData.xingHao" style="width: 260px" />
                </FormItem>
                <FormItem label="车类型">
                  <Input readonly v-model="nowSelectData.type" style="width: 260px" />
                </FormItem>
                <FormItem label="防盗车牌号">
                  <Input readonly v-model="nowSelectData.paiHao" style="width: 260px" />
                </FormItem>
                <FormItem label="上保险时间">
                  <Input readonly v-model="nowSelectData.baoXian" style="width: 260px" />
                </FormItem>
                <FormItem label="备注">
                  <Input readonly v-model="nowSelectData.remark" style="width: 260px" />
                </FormItem>
              </Form>
            </Row>
          </Col>
          <Col span="7">
            <Row :gutter="10">
              <Form label-colon :label-width="90">
                <FormItem label="卖家店铺">
                  <Input readonly v-model="nowSelectData.sellerName" style="width: 260px" />
                </FormItem>
                <FormItem label="买家姓名">
                  <Input readonly v-model="nowSelectData.name" style="width: 260px" />
                </FormItem>
                <FormItem label="手机号">
                  <Input readonly v-model="nowSelectData.mobile" style="width: 260px" />
                </FormItem>
                <FormItem label="身份证号">
                  <Input readonly v-model="nowSelectData.ownerIdcard" style="width: 260px" />
                </FormItem>
                <FormItem label="户籍地址1">
                  <Input v-model="nowSelectData.re1" style="width: 260px" />
                </FormItem>
                <FormItem label="户籍地址2">
                  <Input readonly v-model="nowSelectData.addressHu" style="width: 260px" />
                </FormItem>
                <FormItem label="住址1">
                  <Input readonly v-model="nowSelectData.re2" style="width: 260px" />
                </FormItem>
                <FormItem label="住址2">
                  <Input readonly v-model="nowSelectData.addressZhu" style="width: 260px" />
                </FormItem>
                <FormItem label="驾照号码">
                  <Input readonly v-model="nowSelectData.jiaNumber" style="width: 260px" />
                </FormItem>
              </Form>
            </Row>
          </Col>
        </Row>
        <Row :gutter="32">
          <Col span="4">
            <Button ghost size="large" type="success" @click="passFx" icon="md-checkmark">通过</Button>
          </Col>
          <Col span="4">
            <Button ghost size="large" type="error" @click="openDisPassFxWindow" icon="md-close">退回</Button>
          </Col>
          <Col span="4">
            <Button ghost size="large" type="info" @click="backData" icon="md-arrow-back">上一个</Button>
          </Col>
          <Col span="4">
            <Button ghost size="large" type="warning" @click="nextData" icon="ios-fastforward">下一个</Button>
          </Col>
          <Col span="4">
            <Button ghost size="large" type="primary" @click="getDataList" icon="ios-loading">刷新</Button>
          </Col>
          <Col span="4">
            <span style="color:#f00;font-size:24px;">当前{{nowSelectNumber + 1}} / {{total}}</span>
          </Col>
        </Row>
      </div>
    </Card>
    <Modal
        v-model="isShowdisPassReasonFlag"
        title="退回"
        @on-ok="passFx2"
        @on-cancel="updateFuJiancancel">
        <Form label-colon v-show="type!='2'">
          <Row :gutter="32">
            <Col span="12">
              <FormItem label="退回理由">
                <input v-model="disPassReason" />
              </FormItem>
            </Col>
          </Row>
        </Form>
    </Modal>
  </div>
</template>

<script>
// 根据你的实际请求api.js位置路径修改
import { getSellerNotShList, deleteElectricAudit, getAllNot, pass, dispass } from "./api.js";
// 根据你的实际添加编辑组件位置路径修改
import add from "./add.vue";
import edit from "./edit.vue";
export default {
  name: "single-window",
  components: {
    add,
    edit
  },
  data() {
    return {
      imgSrc:'',
      isShowdisPassReasonFlag: false,
      disPassReason:'',
      nowSelectNumber: 0,
      nowSelectData:{
        type: "",
        year: "",
        mouth: "",
        money: "",
        doId: "",
        doName: "",
        userId: "",
        userName: "",
        userMobile: "",
        remark: "",
        status: "",
        hasImage: "",
        time: "",
        id: "",
      },
      test: 'djhsdjs',
      openSearch: true, // 显示搜索
      openTip: true, // 显示提示
      formData: {},
      currView: "index",
      loading: true, // 表单加载状态
      drop: false,
      dropDownContent: "展开",
      dropDownIcon: "ios-arrow-down",
      searchForm: { // 搜索框初始化对象
        pageNumber: 1, // 当前页数
        pageSize: 10, // 页面大小
        sort: "createTime", // 默认排序字段
        order: "desc", // 默认排序方式
      },
      selectList: [], // 多选数据
      selectCount: 0, // 多选计数
      columns: [
      // 表头
      {
        type: "selection",
        width: 60,
        align: "center"
      },
      {
        type: "index",
        width: 60,
        align: "center"
      },
      {
        title: "类型",
        key: "type",
        minWidth: 120,
        sortable: false,
      },
      {
        title: "年份",
        key: "year",
        minWidth: 120,
        sortable: false,
      },
      {
        title: "月份",
        key: "mouth",
        minWidth: 120,
        sortable: false,
      },
      {
        title: "金额",
        key: "money",
        minWidth: 120,
        sortable: false,
      },
      {
        title: "宿舍名称",
        key: "doName",
        minWidth: 120,
        sortable: false,
      },
      {
        title: "租户姓名",
        key: "userName",
        minWidth: 120,
        sortable: false,
      },
      {
        title: "租户电话",
        key: "userMobile",
        minWidth: 120,
        sortable: false,
      },
      {
        title: "备注",
        key: "remark",
        minWidth: 120,
        sortable: false,
      },
      {
        title: "是否审核",
        key: "status",
        minWidth: 120,
        sortable: false,
      },
      {
        title: "操作",
        key: "action",
        align: "center",
        width: 200,
        render: (h, params) => {
          return h("div", [
            h(
              "Button",
              {
                props: {
                  type: "primary",
                  size: "small",
                  icon: "ios-create-outline"
                },
                style: {
                  marginRight: "5px"
                },
                on: {
                  click: () => {
                    this.edit(params.row);
                  }
                }
              },
              "编辑"
            ),
            h(
              "Button",
              {
                props: {
                  type: "error",
                  size: "small",
                  icon: "md-trash"
                },
                on: {
                  click: () => {
                    this.remove(params.row);
                  }
                }
              },
              "删除"
            )
          ]);
        }
      }
    ],
      data: [], // 表单数据
      pageNumber: 1, // 当前页数
      pageSize: 10, // 页面大小
      total: 0 // 表单数据总数
    };
  },
  methods: {
    init() {
      this.getDataList();
    },
    backData(){
      if(this.nowSelectNumber == 0){
        this.$Message.error("已经是第一条记录啦!");
      }else{
        this.nowSelectNumber -= 1;
        this.nowSelectData = this.data[this.nowSelectNumber];
        this.imgSrc = 'https://changjienongye.cn/docs/static/' + this.nowSelectData.piaoPhoto;
      }
    },
    nextData(){
      if(this.nowSelectNumber == this.total - 1){
        this.$Message.error("已经是最后一条记录啦!");
        this.getDataList();
      }else{
        this.nowSelectNumber += 1;
        this.nowSelectData = this.data[this.nowSelectNumber];
        this.imgSrc = 'https://changjienongye.cn/docs/static/' + this.nowSelectData.piaoPhoto;
      }
    },
    passFx(){
      var that = this;
      // console.log(this.nowSelectData.id);
      // console.log(this.nowSelectData.money);
      pass({id:this.nowSelectData.id,msg:'OK'}).then(res => {
        that.nextData();
      })
    },
    passFx2(){
      var that = this;
      // console.log(this.nowSelectData.id);
      // console.log(this.nowSelectData.money);
      pass({id:this.nowSelectData.id,msg:this.disPassReason}).then(res => {
        that.nextData();
      })
    },
    openDisPassFxWindow(){
      this.isShowdisPassReasonFlag = true;
    },
    disPassFx(){
      var that = this;
      // console.log(this.nowSelectData.id);
      // console.log(this.disPassReason);
      dispass({id:this.nowSelectData.id,msg:this.disPassReason}).then(res => {
        // console.log(res);
        that.nextData();
      })
    },
    getDataList() {
      var that = this;
      this.loading = true;
      getSellerNotShList().then(res => {
        console.log(res);
        if (res.success) {
          that.data = res.result;
          that.total = res.result.length;
          that.nowSelectNumber = 0;
          that.nowSelectData = that.data[0];
          this.imgSrc = 'https://changjienongye.cn/docs/static/' + this.nowSelectData.piaoPhoto;
          this.$Message.success("数据获取成功!");
        }
      });
      
    },
    submited() {
      this.currView = "index";
      this.getDataList();
    },
    changePage(v) {
      this.searchForm.pageNumber = v;
      this.getDataList();
      this.clearSelectAll();
    },
    changePageSize(v) {
      this.searchForm.pageSize = v;
      this.getDataList();
    },
    handleSearch() {
      this.searchForm.pageNumber = 1;
      this.searchForm.pageSize = 10;
      this.getDataList();
    },
    handleReset() {
      this.$refs.searchForm.resetFields();
      this.searchForm.pageNumber = 1;
      this.searchForm.pageSize = 10;
      // 重新加载数据
      this.getDataList();
    },
    changeSort(e) {
      this.searchForm.sort = e.key;
      this.searchForm.order = e.order;
      if (e.order === "normal") {
        this.searchForm.order = "";
      }
      this.getDataList();
    },
    dropDown() {
      if (this.drop) {
        this.dropDownContent = "展开";
        this.dropDownIcon = "ios-arrow-down";
      } else {
        this.dropDownContent = "收起";
        this.dropDownIcon = "ios-arrow-up";
      }
      this.drop = !this.drop;
    },
    clearSelectAll() {
      this.$refs.table.selectAll(false);
    },
    changeSelect(e) {
      this.selectList = e;
      this.selectCount = e.length;
    },
    add() {
      this.currView = "add";
    },
    edit(v) {
      // 转换null为""
      for (let attr in v) {
        if (v[attr] == null) {
          v[attr] = "";
        }
      }
      let str = JSON.stringify(v);
      let data = JSON.parse(str);
      this.formData = data;
      this.currView = "edit";
    },
    remove(v) {
      this.$Modal.confirm({
        title: "确认删除",
        // 记得确认修改此处
        content: "您确认要删除 " + v.name + " ?",
        loading: true,
        onOk: () => {
          // 删除
            deleteElectricAudit({ids: v.id}).then(res => {
              this.$Modal.remove();
              if (res.success) {
                this.$Message.success("操作成功");
                this.getDataList();
              }
            });
        }
      });
    },
    delAll() {
      if (this.selectCount <= 0) {
        this.$Message.warning("您还未选择要删除的数据");
        return;
      }
      this.$Modal.confirm({
        title: "确认删除",
        content: "您确认要删除所选的 " + this.selectCount + " 条数据?",
        loading: true,
        onOk: () => {
          let ids = "";
          this.selectList.forEach(function(e) {
            ids += e.id + ",";
          });
          ids = ids.substring(0, ids.length - 1);
          // 批量删除
            deleteElectricAudit({ids: ids}).then(res => {
              this.$Modal.remove();
              if (res.success) {
                this.$Message.success("操作成功");
                this.clearSelectAll();
                this.getDataList();
              }
            });
        }
      });
    }
  },
  mounted() {
    this.init();
  }
};
</script>
<style lang="less">
// 建议引入通用样式 具体路径自行修改 可删除下面样式代码
// @import "../../../styles/table-common.less";
.search {
    .operation {
        margin-bottom: 2vh;
    }
    .select-count {
        font-weight: 600;
        color: #40a9ff;
    }
    .select-clear {
        margin-left: 10px;
    }
    .page {
        margin-top: 2vh;
    }
    .drop-down {
        margin-left: 5px;
    }
}
@keyframes error404animation {
    0% {
        transform: rotateZ(0deg);
    }
    20% {
        transform: rotateZ(-60deg);
    }
    40% {
        transform: rotateZ(-10deg);
    }
    60% {
        transform: rotateZ(50deg);
    }
    80% {
        transform: rotateZ(-20deg);
    }
    100% {
        transform: rotateZ(0deg);
    }
}
.error404{
    &-body-con{
        width: 700px;
        height: 500px;
        position: absolute;
        left: 50%;
        top: 50%;
        transform: translate(-50%,-50%);
        &-title{
            text-align: center;
            font-size: 240px;
            font-weight: 700;
            color: #2d8cf0;
            height: 260px;
            line-height: 260px;
            margin-top: 40px;
            span{
                display: inline-block;
                color: #19be6b;
                font-size: 230px;
                animation: error404animation 3s ease 0s infinite alternate;
            }
        }
        &-message{
            display: block;
            text-align: center;
            font-size: 30px;
            font-weight: 500;
            letter-spacing: 12px;
            color: #dddde2;
        }
    }
    &-btn-con{
        text-align: center;
        padding: 20px 0;
        margin-bottom: 40px;
    }
}
</style>