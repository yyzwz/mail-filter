<template>
  <div class="search">
    <add v-if="currView=='add'" @close="currView='index'" @submited="submited" />
    <edit v-if="currView=='edit'" @close="currView='index'" @submited="submited" :data="formData" />
    <Card v-show="currView=='index'">
      <Row @keydown.enter.native="handleSearch">
        <Form ref="searchForm" :model="searchForm" inline :label-width="0" class="search-form">
          <Form-item>
            <Input type="text" placeholder="请输入姓名" v-model="searchForm.ownerName" clearable style="width: 200px"/>
          </Form-item>
          <Form-item>
            <Input type="text" placeholder="请输入身份证"  v-model="searchForm.ownerIdcard" clearable style="width: 200px"/>
          </Form-item>
          <Form-item class="br">
            <Button
              @click="handleSearch"
              type="primary"
              icon="ios-search"
              size="small"
            ></Button>
            <Button
              type="warning"
              @click="handleReset"
              size="small"
              icon="md-refresh"
            ></Button>
            <Button
              @click="add"
              type="info"
              size="small"
              icon="md-add"
            ></Button>
            <Button
              @click="delAll"
              type="error"
              icon="md-trash"
              size="small"
            ></Button>
          </Form-item>
        </Form>
      </Row>
      <Row>
        <Table
          :loading="loading"
          border
          :columns="columns"
          :data="data"
          ref="table"
          sortable="custom"
          @on-sort-change="changeSort"
          @on-row-dblclick="lookCarList"
          @on-selection-change="changeSelect"
          :row-class-name="rowClassNmae"
        ></Table>
      </Row>
      <Row type="flex" justify="end" class="page">
        <Page
          :current="searchForm.pageNumber"
          :total="total"
          :page-size="searchForm.pageSize"
          @on-change="changePage"
          @on-page-size-change="changePageSize"
          :page-size-opts="[10,20,50]"
          size="small"
          show-total
          show-elevator
          show-sizer
        ></Page>
      </Row>
    </Card>
    <Card v-show="currView=='index'">
      <div v-if="this.nowSelectCarList.length==0">
        <div class="error404-body-con-title">4<span><Icon type="ios-navigate-outline"></Icon></span>4</div>
        <p class="error404-body-con-message">该车主没有车辆信息</p>
        <div class="error404-btn-con">
          <Button ghost size="large" type="primary" @click="getDataList" icon="ios-loading">刷新</Button>
        </div>
      </div>
      <div v-else>
        <Row :gutter="32">
          <Col span="10">
            <img :src="imgSrc" style="height:500px;width:500px;" @click="lookBigImage" />
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
                <FormItem label="户籍区县">
                  <Input v-model="nowSelectData.re1" style="width: 260px" />
                </FormItem>
                <FormItem label="户籍地址">
                  <Input readonly v-model="nowSelectData.addressHu" style="width: 260px" />
                </FormItem>
                <FormItem label="住址区县">
                  <Input readonly v-model="nowSelectData.re2" style="width: 260px" />
                </FormItem>
                <FormItem label="住址">
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
          <Col span="6">
            <Button ghost size="large" type="info" @click="backData" icon="md-arrow-back">上一个</Button>
          </Col>
          <Col span="6">
            <Button ghost size="large" type="warning" @click="nextData" icon="ios-fastforward">下一个</Button>
          </Col>
          <Col span="6">
            <Button ghost size="large" type="primary" @click="getDataList" icon="ios-loading">刷新</Button>
          </Col>
          <Col span="6">
            <span style="color:#f00;font-size:24px;">当前{{nowSelectIndex + 1}} / {{carListTotal}}</span>
          </Col>
        </Row>
      </div>
    </Card>
    <Modal
        title="查看大图"
        v-model="lookBigImageVisable"
        width="90">
        <Row>
          <img :src="imgSrc" style="height:100%;width:100%;" @click="lookBigImage" />
        </Row>
    </Modal>
  </div>
</template>

<script>
// 根据你的实际请求api.js位置路径修改
import { getCarOwnerList, deleteCar } from "./api.js";
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
      lookBigImageVisable: false,
      imgSrc:'',
      carListTotal: 0,
      nowSelectIndex: 0,
      nowSelectData: {
        sellDate: '',
        jia: '',
        gu: '',
        pinPai: '',
        xingHao: '',
        type: '',
        paiHao: '',
        baoXian: '',
        remark: ''
      },
      nowSelectCarList: [],
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
        align: "center",
        fixed: "left",
      },
      {
        type: "index",
        width: 60,
        align: "center",
        fixed: "left",
      },
      {
        title: "姓名",
        key: "name",
        minWidth: 100,
        sortable: true,
        tooltip: true,
        fixed: "left",
      },
      {
        title: "身份证",
        key: "ownerIdcard",
        minWidth: 250,
        sortable: true,
        tooltip: true,
      },
      {
        title: "手机号",
        key: "mobile",
        minWidth: 200,
        sortable: true,
        tooltip: true,
      },
      {
        title: "户籍区县",
        key: "re1",
        minWidth: 180,
        sortable: true,
        tooltip: true,
      },
      {
        title: "户籍详细地址",
        key: "addressHu",
        minWidth: 300,
        sortable: true,
        tooltip: true,
      },
      {
        title: "住址区县",
        key: "re2",
        minWidth: 180,
        sortable: true,
        tooltip: true,
      },
      {
        title: "详细住址",
        key: "addressZhu",
        minWidth: 300,
        sortable: true,
        tooltip: true,
      },
      {
        title: "驾照号码",
        key: "jiaNumber",
        minWidth: 200,
        sortable: true,
        tooltip: true,
      },
      {
        title: "操作",
        key: "action",
        align: "center",
        width: 200,
        fixed: "right",
        render: (h, params) => {
          return h("div", [
            h(
              "Button",
              {
                props: {
                  type: "primary",
                  size: "small",
                  icon: "ios-create-outline",
                  // disabled: params.row.carPhoto == null
                },
                style: {
                  marginRight: "5px"
                },
                on: {
                  click: () => {
                    this.lookCarList(params.row);
                  }
                }
              },
              "查看车辆"
            )
          ])
        }
      }
    ],
      selectRow: 0,
      data: [], // 表单数据
      pageNumber: 1, // 当前页数
      pageSize: 10, // 页面大小
      total: 0, // 表单数据总数
      sellDateTemp: '',
      baoXianTemp: '',
    };
  },
  methods: {
    init() {
      this.getDataList();
    },
    rowClassNmae(row, index) {
      if (row.id == this.selectRow.id) {
        return "rowClassNmaeColor";
      }
      return "";
    },
    lookBigImage() {
      this.lookBigImageVisable = true;
    },
    lookMa(e) {
      window.open("https://changjienongye.cn/carMa/car_1.png","_blank");
    },
    lookPhoto(e) {
      window.open("https://changjienongye.cn/docs/static/" + e.piaoPhoto,"_blank");
    },
    backData() {
      if(this.nowSelectIndex > 0) {
        this.nowSelectIndex = this.nowSelectIndex - 1;
      }
      this.getCarItem();
    },
    nextData() {
      if(this.nowSelectIndex < this.nowSelectCarList.length - 1) {
        this.nowSelectIndex = this.nowSelectIndex + 1;
      }
      this.getCarItem();
    },
    getCarItem() {
      this.nowSelectData = this.nowSelectCarList[this.nowSelectIndex];
      // this.imgSrc = 'https://changjienongye.cn/docs/static2/' + this.nowSelectData.carPhoto;
      this.imgSrc = "https://changjienongye.cn/docs/carPhoto/" + this.nowSelectData.paiHao + "/" + this.nowSelectData.paiHao + "2.png";
    },
    lookCarList(e) {
      this.selectRow = e;
      this.nowSelectCarList = e.carList;
      this.nowSelectIndex = 0;
      this.carListTotal = e.carList.length;
      if(e.carList.length > 0) {
        this.nowSelectData = e.carList[this.nowSelectIndex];
        // this.imgSrc = 'https://changjienongye.cn/docs/static2/' + this.nowSelectData.carPhoto;
        this.imgSrc = "https://changjienongye.cn/docs/carPhoto/" + this.nowSelectData.paiHao + "/" + this.nowSelectData.paiHao + "2.png";
      }
    },
    changeSellDate(e) {
      this.searchForm.sellDate = e;
      this.sellDateTemp = e;
    },
    changeBaoDate(e) {
      this.searchForm.baoXian = e;
      this.baoXianTemp = e;
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
    getDataList() {
      this.loading = true;
        getCarOwnerList(this.searchForm).then(res => {
          this.loading = false;
          if (res.success) {
            this.data = res.result.records;
            this.total = res.result.total;
          }
        });
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
            deleteCar({ids: v.id}).then(res => {
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
            deleteCar({ids: ids}).then(res => {
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
.filter-panel {
  width: 166px;
  min-height: 120px;
  height: 200px;
  position: absolute;
  background-color: white;
  z-index: 9999;
  margin-left: 1px;
  overflow-y: scroll;
  border: 1px solid blue;
  top: 35px;
  right: 10px;
}
.showFilterPanelFlag {
  position: static !important;
  right: 10px;
  margin-right: 10px;
}
.ivu-table td {
  height: 38px !important;
}
.ivu-table-cell-with-expand {
  height: 38px !important;
  line-height: 38px !important;
}
.ivu-table .rowClassNmaeColor td {
  background-color: #2db7f5 !important;
  color: #fff !important;
  font-size: 18px;
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