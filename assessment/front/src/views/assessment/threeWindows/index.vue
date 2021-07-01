<template>
  <div class="search">
    <Card v-show="currView=='index'">
        <Row @keydown.enter.native="handleSearch">
          <Form ref="searchForm" :model="searchForm" inline :label-width="70" class="search-form">
            <FormItem label="联村" prop="lineId"  >
              <Select v-model="searchForm.lineId" placeholder="请选择" clearable style="width: 200px" @on-change="changeLine">
                <Option v-for="item in villageManyList" :value="item.id" :key="item.id">{{ item.villageName }}</Option>
              </Select>
            </FormItem>
            <FormItem label="考核期" prop="timeName"  >
              <Input v-model="searchForm.timeName" disabled clearable style="width:200px"/>
            </FormItem>
            <FormItem label="">
              <span style="color:#f00;font-size:20px"> 请先选择联村 </span>
            </FormItem>
            <Form-item style="margin-left:-35px;" class="br">
              <Button @click="handleSearch" type="primary" icon="ios-search">搜索</Button>
              <Button @click="handleReset">重置</Button>
              <a class="drop-down" @click="dropDown">
                {{dropDownContent}}
                <Icon :type="dropDownIcon"></Icon>
              </a>
            </Form-item>
          </Form>
        </Row>
      <Row class="operation">
        <Button @click="add" type="primary" icon="md-add">添加</Button>
        <Button @click="delAll" icon="md-trash">批量删除</Button>
        <Button @click="getDataList" icon="md-refresh">刷新</Button>
        <Button type="dashed" @click="openTip=!openTip">{{openTip ? "关闭提示" : "开启提示"}}</Button>
      </Row>
      <Row v-show="openTip">
        <Alert show-icon>
          已选择
          <span class="select-count">{{selectCount}}</span> 项
          <a class="select-clear" @click="clearSelectAll">清空</a>
        </Alert>
      </Row>
      <Row>
        <!-- :span-method="handleSpan" -->
        <Table
          :loading="loading"
          border
          :columns="columns"
          :data="data"
          ref="table"
          sortable="custom"
          @on-sort-change="changeSort"
          @on-selection-change="changeSelect"
        ></Table>
      </Row>
      <!-- <Row type="flex" justify="end" class="page">
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
      </Row> -->
    </Card>
  </div>
</template>

<script>
import { getTwoWindowsList, deleteTwoWindows,getOneWindowByLine,getAllAssessmentLine,updateTwoWindows,
getvillageManyList } from "./api.js";
export default {
  name: "single-window",
  components: {
  },
  data() {
    return {
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
        timeId: '1376067966306750464',
        timeName: '',
        lineId: '',
        lineName: ''
      },
      selectList: [], // 多选数据
      selectCount: 0, // 多选计数
      columns: [
      // 表头
      // {
      //   type: "selection",
      //   width: 60,
      //   align: "center"
      // },
      {
        type: "index",
        width: 60,
        align: "center",
        fixed: 'left'
      },
      {
        title: "细则内容",
        key: "itemName",
        minWidth: 360,
        sortable: false,
        align: "center",
        fixed: 'left'
      },
      {
        title: "长街村",
        key: "bb",
        minWidth: 120,
        sortable: false,
      },
      {
        title: "九江村",
        key: "dd",
        minWidth: 120,
        sortable: false,
      },
      {
        title: "洋湖村",
        key: "ff",
        minWidth: 120,
        sortable: false,
      },
      {
        title: "车岙村",
        key: "hh",
        minWidth: 120,
        sortable: false,
      },
      {
        title: "石桥头村",
        key: "jj",
        minWidth: 120,
        sortable: false,
      },
      {
        title: "环河社区",
        key: "ll",
        minWidth: 120,
        sortable: false,
      },
      {
        title: "西岙村扣",
        key: "nn",
        minWidth: 120,
        sortable: false,
      },
      {
        title: "城塘村",
        key: "pp",
        minWidth: 120,
        sortable: false,
      },
      {
        title: "山前村",
        key: "rr",
        minWidth: 120,
        sortable: false,
      },
      {
        title: "大祝村",
        key: "tt",
        minWidth: 120,
        sortable: false,
      },
      {
        title: "大湖村",
        key: "vv",
        minWidth: 120,
        sortable: false,
      },
      {
        title: "南塘村",
        key: "xx",
        minWidth: 120,
        sortable: false,
      },
      {
        title: "塘里村",
        key: "zz",
        minWidth: 120,
        sortable: false,
      },
      {
        title: "浦东村",
        key: "bbb",
        minWidth: 120,
        sortable: false,
      },
      {
        title: "新塘村",
        key: "ddd",
        minWidth: 120,
        sortable: false,
      },
      {
        title: "隔洋塘村",
        key: "fff",
        minWidth: 120,
        sortable: false,
      },
      {
        title: "李家庄村",
        key: "hhh",
        minWidth: 120,
        sortable: false,
      },
      {
        title: "岳井村",
        key: "jjj",
        minWidth: 120,
        sortable: false,
      },
      {
        title: "岳墩村",
        key: "lll",
        minWidth: 120,
        sortable: false,
      },
      {
        title: "对岙洞村",
        key: "nnn",
        minWidth: 120,
        sortable: false,
      },
      {
        title: "上塘村",
        key: "ppp",
        minWidth: 120,
        sortable: false,
      },
      {
        title: "伍山村",
        key: "rrr",
        minWidth: 120,
        sortable: false,
      },
      {
        title: "下湾塘村",
        key: "ttt",
        minWidth: 120,
        sortable: false,
      },
      {
        title: "月兰村",
        key: "vvv",
        minWidth: 120,
        sortable: false,
      },
      {
        title: "向阳村",
        key: "xxx",
        minWidth: 120,
        sortable: false,
      },
      {
        title: "长胜村",
        key: "zzz",
        minWidth: 120,
        sortable: false,
      },
      {
        title: "下塘村",
        key: "bbbb",
        minWidth: 120,
        sortable: false,
      },
      {
        title: "总浦塘村",
        key: "dddd",
        minWidth: 120,
        sortable: false,
      },
      {
        title: "宁东村",
        key: "ffff",
        minWidth: 120,
        sortable: false,
      },
      {
        title: "新城村",
        key: "hhhh",
        minWidth: 120,
        sortable: false,
      },
      {
        title: "龙山村",
        key: "jjjj",
        minWidth: 120,
        sortable: false,
      },
      {
        title: "连浦村",
        key: "llll",
        minWidth: 120,
        sortable: false,
      },
      {
        title: "湘田山村",
        key: "nnnn",
        minWidth: 120,
        sortable: false,
      },
      {
        title: "五福村",
        key: "pppp",
        minWidth: 120,
        sortable: false,
      },
      {
        title: "山头村",
        key: "rrrr",
        minWidth: 120,
        sortable: false,
      },
      {
        title: "港中村",
        key: "tttt",
        minWidth: 120,
        sortable: false,
      },
      {
        title: "平原村",
        key: "vvvv",
        minWidth: 120,
        sortable: false,
      },
      {
        title: "大青村",
        key: "xxxx",
        minWidth: 120,
        sortable: false,
      },
      {
        title: "东港村",
        key: "zzzz",
        minWidth: 120,
        sortable: false,
      },
      {
        title: "双家村",
        key: "bbbbb",
        minWidth: 120,
        sortable: false,
      },
      {
        title: "青珠村",
        key: "ddddd",
        minWidth: 120,
        sortable: false,
      },
      {
        title: "新南村",
        key: "fffff",
        minWidth: 120,
        sortable: false,
      },
      {
        title: "新五星村",
        key: "hhhhh",
        minWidth: 120,
        sortable: false,
      },
      {
        title: "文围村",
        key: "jjjjj",
        minWidth: 120,
        sortable: false,
      },
      {
        title: "青农社区",
        key: "lllll",
        minWidth: 120,
        sortable: false,
      },
    ],
      data: [], // 表单数据
      pageNumber: 1, // 当前页数
      pageSize: 10, // 页面大小
      total: 0,// 表单数据总数
      nowTimeList: [],
      lineList: [],
      nowInputRow: {},
      villageManyList: []
    };
  },
  methods: {
    init() {
      // this.getOneWindowByLineFx();
      // this.getNowTimesFx();
      this.getDataList();
      this.getvillageManyListFx();
    },
    getvillageManyListFx() {
      var that = this;
      getvillageManyList().then(res => {
        that.villageManyList = res.result;
      })
    },
    getDataList() {
      this.loading = true;
        getOneWindowByLine({timeId: '1376067966306750464'}).then(res => {
          this.loading = false;
          if (res.success) {
            this.data = res.result;
            this.total = res.result.length;
          }
        });
    },
    saveByInput() {
      delete(this.nowInputRow["updateBy","updateTime"]);
      updateTwoWindows(this.nowInputRow).then(res => {
        if(!res.success) {
          this.$Message.error("保存失败");
        }
      })
    },
    getAllAssessmentLineFx() {
      var that = this;
      getAllAssessmentLine().then(res => {
        that.lineList = res.result;
      })
    },
    changeLine(e) {
      this.searchForm.lineId = e;
      this.getDataList();
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
            deleteTwoWindows({ids: v.id}).then(res => {
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
            deleteTwoWindows({ids: ids}).then(res => {
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
    handleSpan ({ row, column, rowIndex, columnIndex }) {
        if (rowIndex === 0 && columnIndex === 0) {
            return {
                rowspan: 1,
                colspan: 1
            };
        } else if (rowIndex === 0 && columnIndex % 2 === 1) {
            return {
                rowspan: 1,
                colspan: 2
            };
        } else if (rowIndex === 0 && columnIndex % 2 === 0) {
            return {
                rowspan: 0,
                colspan: 0
            };
        }
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
</style>