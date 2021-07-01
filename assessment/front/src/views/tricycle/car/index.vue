<template>
  <div class="search">
    <add v-if="currView=='add'" @close="currView='index'" @submited="submited" />
    <edit v-if="currView=='edit'" @close="currView='index'" @submited="submited" :data="formData" />
    <Card v-show="currView=='index'">
      <Row @keydown.enter.native="handleSearch">
        <Form ref="searchForm" :model="searchForm" inline :label-width="0" class="search-form">
          <Form-item prop="sellDate">
            <DatePicker placeholder="出售日期" type="date" format="yyyy-MM-dd" v-model="sellDateTemp" @on-change="changeSellDate" clearable style="width:200px"></DatePicker>
          </Form-item>
          <Form-item prop="ownerName">
            <Input type="text" placeholder="车主姓名" v-model="searchForm.ownerName" clearable style="width: 200px"/>
          </Form-item>
          <Form-item prop="ownerName">
            <Input type="text" placeholder="车主身份证" v-model="searchForm.ownerIdcard" clearable style="width: 200px"/>
          </Form-item>
          <Form-item prop="sellerName">
            <Input type="text" placeholder="卖家姓名" v-model="searchForm.sellerName" clearable style="width: 200px"/>
          </Form-item>
          <Form-item prop="jia">
            <Input type="text" v-model="searchForm.jia" placeholder="车架号" clearable style="width: 200px"/>
          </Form-item>
          <Form-item prop="gu">
            <Input type="text" v-model="searchForm.gu" placeholder="车骨号" clearable style="width: 200px"/>
          </Form-item>
          <Form-item prop="pinPai">
            <Input type="text" v-model="searchForm.pinPai" placeholder="车品牌" clearable style="width: 200px"/>
          </Form-item>
          <Form-item prop="xingHao">
            <Input type="text" v-model="searchForm.xingHao" placeholder="车型号" clearable style="width: 200px"/>
          </Form-item>
          <Form-item prop="type">
            <Select v-model="searchForm.type" placeholder="车类型" clearable style="width: 200px">
              <Option value="电动三轮车">电动三轮车</Option>
              <Option value="汽油三轮车">汽油三轮车</Option>
              <Option value="其他">其他</Option>
            </Select>
          </Form-item>
          <Form-item prop="paiHao">
            <Input type="text" v-model="searchForm.paiHao" placeholder="防盗车牌号" clearable style="width: 200px"/>
          </Form-item>
          <Form-item prop="baoXian">
            <DatePicker type="date" v-model="baoXianTemp" placeholder="上保险时间" @on-change="changeBaoDate" clearable style="width:200px"></DatePicker>
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
            <Button
              @click="startImportData"
              type="success"
              icon="ios-add"
              size="small"
            >导入</Button>
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
          @on-selection-change="changeSelect"
          @on-row-click="rowClick"
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
          :page-size-opts="[10,15,20,50]"
          size="small"
          show-total
          show-elevator
          show-sizer
        ></Page>
      </Row>
    </Card>
    <Drawer title="导入数据" closable v-model="importModalVisible" width="1000">
      <div
        style="
          display: flex;
          justify-content: space-between;
          align-items: center;
        "
      >
        <Upload action :before-upload="beforeUploadImport" accept=".xls, .xlsx">
          <Button
            :loading="reading"
            icon="ios-cloud-upload-outline"
            style="margin-right: 10px"
            >上传Excel文件</Button
          >
          <span v-if="uploadfile.name"
            >当前选择文件：{{ uploadfile.name }}</span
          >
        </Upload>
        <Button @click="clearImportData" icon="md-trash">清空数据</Button>
      </div>
      <Alert type="warning" show-icon
        >导入前请下载查看导入模版数据文件查看所需字段及说明，确保数据格式正确，不得修改列英文名称</Alert
      >
      <Table
        :columns="importColumns"
        border
        :height="height"
        :data="importTableData"
        ref="importTable"
      ></Table>
      <div class="drawer-footer">
        <Button @click="downloadTemple" type="info">下载导入模板</Button>
        <div style="position: absolute; right: 15px; display: inline-block">
          <Button @click="importModalVisible = false">关闭</Button>
          <Button
            :loading="importLoading"
            :disabled="importTableData.length <= 0"
            @click="importData"
            style="margin-left: 8px"
            type="primary"
          >
            确认导入
            <span v-if="importTableData.length > 0"
              >{{ importTableData.length }} 条数据</span
            >
          </Button>
        </div>
      </div>
    </Drawer>
  </div>
</template>

<script>
import { getCarList, deleteCar } from "./api.js";
import { importData } from "./api.js";
import excel from "@/libs/excel";
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
      importModalVisible: false,
      importTableData: [],
      importColumns: [],
      reading: false,
      uploadfile: {
        name: "",
      },
      importLoading: false,
      imgSrc: '',
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
        title: "车主姓名",
        key: "name",
        minWidth: 120,
        sortable: false,
        tooltip: true,
        fixed: "left",
      },
      {
        title: "车主身份证",
        key: "ownerIdcard",
        minWidth: 200,
        sortable: false,
        tooltip: true,
      },
      {
        title: "卖家店铺",
        key: "sellerName",
        minWidth: 120,
        sortable: false,
        tooltip: true,
      },
      {
        title: "二维码",
        key: "action1",
        align: "center",
        width: 120,
        render: (h, params) => {
          return h('img', {
              style: {//设置样式
                  width: '100px',
                  'height': '80px',
                  'border-radius': '5%'
              },
              attrs: {//设置属性
                  src: "https://changjienongye.cn/carMa/" + params.row.fileId + ".png"
              }
          });
        }
      },
      {
        title: "出售日期",
        key: "sellDate",
        minWidth: 120,
        sortable: false,
        tooltip: true,
      },
      {
        title: "车架号",
        key: "jia",
        minWidth: 120,
        sortable: false,
        tooltip: true,
      },
      {
        title: "车骨号",
        key: "gu",
        minWidth: 120,
        sortable: false,
        tooltip: true,
      },
      {
        title: "车品牌",
        key: "pinPai",
        minWidth: 120,
        sortable: false,
        tooltip: true,
      },
      {
        title: "车型号",
        key: "xingHao",
        minWidth: 120,
        sortable: false,
        tooltip: true,
      },
      {
        title: "车类型",
        key: "type",
        minWidth: 120,
        sortable: false,
        tooltip: true,
      },
      {
        title: "防盗车牌号",
        key: "paiHao",
        minWidth: 120,
        sortable: false,
        tooltip: true,
      },
      {
        title: "上保险时间",
        key: "baoXian",
        minWidth: 120,
        sortable: false,
        tooltip: true,
      },
      {
        title: "照片",
        key: "action",
        align: "center",
        width: 240,
        render: (h, params) => {
          return h("div", [
            h(
              "Button",
              {
                props: {
                  type: "success",
                  size: "small",
                  icon: "ios-create-outline"
                },
                style: {
                  marginRight: "5px"
                },
                on: {
                  click: () => {
                    this.lookPhoto(params.row);
                  }
                }
              },
              "发票照片"
            ),
            h(
              "Button",
              {
                props: {
                  type: "info",
                  size: "small",
                  icon: "ios-create-outline"
                },
                style: {
                  marginRight: "5px"
                },
                on: {
                  click: () => {
                    this.lookPhoto2(params.row);
                  }
                }
              },
              "车辆照片"
            )
          ]);
        }
      },
      {
        title: "编辑删除",
        key: "action3",
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
    rowClick(row, index) {
      this.selectRow = row;
    },
    rowClassNmae(row, index) {
      if (row.id == this.selectRow.id) {
        return "rowClassNmaeColor";
      }
      return "";
    },
    lookMa(e) {
      window.open("https://changjienongye.cn/carMa/" + e.fileId + ".png","_blank");
    },
    lookPhoto(e) {
      window.open("https://changjienongye.cn/docs/static/" + e.piaoPhoto,"_blank");
    },
    lookPhoto2(e) {
      window.open("https://changjienongye.cn/docs/static2/" + e.carPhoto,"_blank");
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
        getCarList(this.searchForm).then(res => {
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
    },
    startImportData() {
      console.log("startImportData");
      this.importModalVisible = true;
    },
    beforeUploadImport(file) {
      this.uploadfile = file;
      const fileExt = file.name.split(".").pop().toLocaleLowerCase();
      if (fileExt == "xlsx" || fileExt == "xls") {
        this.readFile(file);
        this.file = file;
      } else {
        this.$Notice.warning({
          title: "文件类型错误",
          desc:
            "所选文件‘ " +
            file.name +
            " ’不是EXCEL文件，请选择后缀为.xlsx或者.xls的EXCEL文件。",
        });
      }
      return false;
    },
    // 读取文件
    readFile(file) {
      this.reading = true;
      const reader = new FileReader();
      reader.readAsArrayBuffer(file);
      reader.onerror = (e) => {
        this.reading = false;
        this.$Message.error("文件读取出错");
      };
      reader.onload = (e) => {
        const data = e.target.result;
        const { header, results } = excel.read(data, "array");
        const tableTitle = header.map((item) => {
          return { title: item, key: item, minWidth: 130, align: "center" };
        });
        this.importTableData = results;
        this.importColumns = tableTitle;
        this.reading = false;
        this.$Message.success("读取数据成功");
      };
    },
    clearImportData() {
      this.importTableData = [];
      this.importColumns = [];
      this.uploadfile = {};
    },
    importData() {
      this.importLoading = true;
      importData(this.importTableData).then((res) => {
        this.importLoading = false;
        if (res.success) {
          this.importModalVisible = false;
          this.$Modal.info({
            title: "导入结果",
            content: res.message,
          });
        }
      });
    },
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
</style>