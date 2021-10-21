<template>
  <div class="search">
    <add v-if="currView=='add'" @close="currView='index'" @submited="submited" />
    <edit v-if="currView=='edit'" @close="currView='index'" @submited="submited" :data="formData" />
    <Card v-show="currView=='index'">
        <Row @keydown.enter.native="handleSearch">
          <Form ref="searchForm" :model="searchForm" inline :label-width="70" class="search-form">
            <FormItem label="考核线" prop="lineId"  >
              <Select v-model="searchForm.lineId" placeholder="请选择" clearable style="width: 200px" @on-change="changeLine">
                <Option v-for="item in lineList" :value="item.id" :key="item.id">{{ item.lineName }}</Option>
              </Select>
            </FormItem>
            <FormItem label="考核期" prop="timeName"  >
              <Input v-model="searchForm.timeName" disabled clearable style="width:200px"/>
            </FormItem>
            <FormItem label="">
              <span style="color:#f00;font-size:20px"> 请先选择条线 </span>
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
        ></Page>-->
      </Row> 
    </Card>
  </div>
</template>

<script>
// 根据你的实际请求api.js位置路径修改
import { getTwoWindowsList, deleteTwoWindows,getNowTimes,getAllAssessmentLine,updateTwoWindows } from "./api.js";
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
      // {
      //   type: "index",
      //   width: 60,
      //   align: "center"
      // },
      {
        title: "细则内容",
        key: "itemName",
        minWidth: 360,
        sortable: false,
        align: "center",
        fixed: 'left'
      },
      { 
        title: "长街村扣分原因",
        key: "aa",
        minWidth: 200,
        sortable: false,
        render: (h, params) => {
          var that = this;
          return h('div', [
            h('Input', {
              props: {
                type: 'text',
                size: 'small',
                value: params.row.aa
              },
              on: {
                "on-blur": function(){
                  that.nowInputRow = params.row;
                  that.saveByInput();
                },
                input: (e) => {
                  params.row.aa = e;
                }
              }
            })
          ])
        }
      },
      {
        title: "长街村扣分值",
        key: "bb",
        minWidth: 110,
        sortable: false,
        render: (h, params) => {
          var that = this;
          return h('div', [
            h('InputNumber', {
              props: {
                max: 10,
                min: -10,
                size: 'small',
                value: params.row.bb
              },
              on: {
                "on-blur": function(){
                  that.nowInputRow = params.row;
                  that.saveByInput();
                },
                input: (e) => {
                  params.row.bb = e;
                }
              }
            })
          ])
        }
      },
      {
        title: "九江村扣分原因",
        key: "cc",
        minWidth: 200,
        sortable: false,
        render: (h, params) => {
          var that = this;
          return h('div', [
            h('Input', {
              props: {
                type: 'text',
                size: 'small',
                value: params.row.cc
              },
              on: {
                "on-blur": function(){
                  that.nowInputRow = params.row;
                  that.saveByInput();
                },
                input: (e) => {
                  params.row.cc = e;
                }
              }
            })
          ])
        }
      },
      {
        title: "九江村扣分值",
        key: "dd",
        minWidth: 110,
        sortable: false,
        render: (h, params) => {
          var that = this;
          return h('div', [
            h('InputNumber', {
              props: {
                max: 10,
                min: -10,
                size: 'small',
                value: params.row.dd
              },
              on: {
                "on-blur": function(){
                  that.nowInputRow = params.row;
                  that.saveByInput();
                },
                input: (e) => {
                  params.row.dd = e;
                }
              }
            })
          ])
        }
      },
      {
        title: "洋湖村扣分原因",
        key: "ee",
        minWidth: 200,
        sortable: false,
        render: (h, params) => {
          var that = this;
          return h('div', [
            h('Input', {
              props: {
                type: 'text',
                size: 'small',
                value: params.row.ee
              },
              on: {
                "on-blur": function(){
                  that.nowInputRow = params.row;
                  that.saveByInput();
                },
                input: (e) => {
                  params.row.ee = e;
                }
              }
            })
          ])
        }
      },
      {
        title: "洋湖村扣分值",
        key: "ff",
        minWidth: 110,
        sortable: false,
        render: (h, params) => {
          var that = this;
          return h('div', [
            h('InputNumber', {
              props: {
                max: 10,
                min: -10,
                size: 'small',
                value: params.row.ff
              },
              on: {
                "on-blur": function(){
                  that.nowInputRow = params.row;
                  that.saveByInput();
                },
                input: (e) => {
                  params.row.ff = e;
                }
              }
            })
          ])
        }
      },
      {
        title: "车岙村扣分原因",
        key: "gg",
        minWidth: 200,
        sortable: false,
        render: (h, params) => {
          var that = this;
          return h('div', [
            h('Input', {
              props: {
                type: 'text',
                size: 'small',
                value: params.row.gg
              },
              on: {
                "on-blur": function(){
                  that.nowInputRow = params.row;
                  that.saveByInput();
                },
                input: (e) => {
                  params.row.gg = e;
                }
              }
            })
          ])
        }
      },
      {
        title: "车岙村扣分值",
        key: "hh",
        minWidth: 110,
        sortable: false,
        render: (h, params) => {
          var that = this;
          return h('div', [
            h('InputNumber', {
              props: {
                max: 10,
                min: -10,
                size: 'small',
                value: params.row.hh
              },
              on: {
                "on-blur": function(){
                  that.nowInputRow = params.row;
                  that.saveByInput();
                },
                input: (e) => {
                  params.row.hh = e;
                }
              }
            })
          ])
        }
      },
      {
        title: "石桥头村扣分原因",
        key: "ii",
        minWidth: 200,
        sortable: false,
        render: (h, params) => {
          var that = this;
          return h('div', [
            h('Input', {
              props: {
                type: 'text',
                size: 'small',
                value: params.row.ii
              },
              on: {
                "on-blur": function(){
                  that.nowInputRow = params.row;
                  that.saveByInput();
                },
                input: (e) => {
                  params.row.ii = e;
                }
              }
            })
          ])
        }
      },
      {
        title: "石桥头村扣分值",
        key: "jj",
        minWidth: 110,
        sortable: false,
        render: (h, params) => {
          var that = this;
          return h('div', [
            h('InputNumber', {
              props: {
                max: 10,
                min: -10,
                size: 'small',
                value: params.row.jj
              },
              on: {
                "on-blur": function(){
                  that.nowInputRow = params.row;
                  that.saveByInput();
                },
                input: (e) => {
                  params.row.jj = e;
                }
              }
            })
          ])
        }
      },
      {
        title: "环河社区扣分原因",
        key: "kk",
        minWidth: 200,
        sortable: false,
        render: (h, params) => {
          var that = this;
          return h('div', [
            h('Input', {
              props: {
                type: 'text',
                size: 'small',
                value: params.row.kk
              },
              on: {
                "on-blur": function(){
                  that.nowInputRow = params.row;
                  that.saveByInput();
                },
                input: (e) => {
                  params.row.kk = e;
                }
              }
            })
          ])
        }
      },
      {
        title: "环河社区扣分值",
        key: "ll",
        minWidth: 110,
        sortable: false,
        render: (h, params) => {
          var that = this;
          return h('div', [
            h('InputNumber', {
              props: {
                max: 10,
                min: -10,
                size: 'small',
                value: params.row.ll
              },
              on: {
                "on-blur": function(){
                  that.nowInputRow = params.row;
                  that.saveByInput();
                },
                input: (e) => {
                  params.row.ll = e;
                }
              }
            })
          ])
        }
      },
      {
        title: "西岙村扣分原因",
        key: "mm",
        minWidth: 200,
        sortable: false,
        render: (h, params) => {
          var that = this;
          return h('div', [
            h('Input', {
              props: {
                type: 'text',
                size: 'small',
                value: params.row.mm
              },
              on: {
                "on-blur": function(){
                  that.nowInputRow = params.row;
                  that.saveByInput();
                },
                input: (e) => {
                  params.row.mm = e;
                }
              }
            })
          ])
        }
      },
      {
        title: "西岙村扣扣分值",
        key: "nn",
        minWidth: 110,
        sortable: false,
        render: (h, params) => {
          var that = this;
          return h('div', [
            h('InputNumber', {
              props: {
                max: 10,
                min: -10,
                size: 'small',
                value: params.row.nn
              },
              on: {
                "on-blur": function(){
                  that.nowInputRow = params.row;
                  that.saveByInput();
                },
                input: (e) => {
                  params.row.nn = e;
                }
              }
            })
          ])
        }
      },
      {
        title: "城塘村扣分原因",
        key: "oo",
        minWidth: 200,
        sortable: false,
        render: (h, params) => {
          var that = this;
          return h('div', [
            h('Input', {
              props: {
                type: 'text',
                size: 'small',
                value: params.row.oo
              },
              on: {
                "on-blur": function(){
                  that.nowInputRow = params.row;
                  that.saveByInput();
                },
                input: (e) => {
                  params.row.oo = e;
                }
              }
            })
          ])
        }
      },
      {
        title: "城塘村扣分值",
        key: "pp",
        minWidth: 110,
        sortable: false,
        render: (h, params) => {
          var that = this;
          return h('div', [
            h('InputNumber', {
              props: {
                max: 10,
                min: -10,
                size: 'small',
                value: params.row.pp
              },
              on: {
                "on-blur": function(){
                  that.nowInputRow = params.row;
                  that.saveByInput();
                },
                input: (e) => {
                  params.row.pp = e;
                }
              }
            })
          ])
        }
      },
      {
        title: "山前村扣分原因",
        key: "qq",
        minWidth: 200,
        sortable: false,
        render: (h, params) => {
          var that = this;
          return h('div', [
            h('Input', {
              props: {
                type: 'text',
                size: 'small',
                value: params.row.qq
              },
              on: {
                "on-blur": function(){
                  that.nowInputRow = params.row;
                  that.saveByInput();
                },
                input: (e) => {
                  params.row.qq = e;
                }
              }
            })
          ])
        }
      },
      {
        title: "山前村扣分值",
        key: "rr",
        minWidth: 110,
        sortable: false,
        render: (h, params) => {
          var that = this;
          return h('div', [
            h('InputNumber', {
              props: {
                max: 10,
                min: -10,
                size: 'small',
                value: params.row.rr
              },
              on: {
                "on-blur": function(){
                  that.nowInputRow = params.row;
                  that.saveByInput();
                },
                input: (e) => {
                  params.row.rr = e;
                }
              }
            })
          ])
        }
      },
      {
        title: "大祝村扣分原因",
        key: "ss",
        minWidth: 200,
        sortable: false,
        render: (h, params) => {
          var that = this;
          return h('div', [
            h('Input', {
              props: {
                type: 'text',
                size: 'small',
                value: params.row.ss
              },
              on: {
                "on-blur": function(){
                  that.nowInputRow = params.row;
                  that.saveByInput();
                },
                input: (e) => {
                  params.row.ss = e;
                }
              }
            })
          ])
        }
      },
      {
        title: "大祝村扣分值",
        key: "tt",
        minWidth: 110,
        sortable: false,
        render: (h, params) => {
          var that = this;
          return h('div', [
            h('InputNumber', {
              props: {
                max: 10,
                min: -10,
                size: 'small',
                value: params.row.tt
              },
              on: {
                "on-blur": function(){
                  that.nowInputRow = params.row;
                  that.saveByInput();
                },
                input: (e) => {
                  params.row.tt = e;
                }
              }
            })
          ])
        }
      },
      {
        title: "大湖村扣分原因",
        key: "uu",
        minWidth: 200,
        sortable: false,
        render: (h, params) => {
          var that = this;
          return h('div', [
            h('Input', {
              props: {
                type: 'text',
                size: 'small',
                value: params.row.uu
              },
              on: {
                "on-blur": function(){
                  that.nowInputRow = params.row;
                  that.saveByInput();
                },
                input: (e) => {
                  params.row.uu = e;
                }
              }
            })
          ])
        }
      },
      {
        title: "大湖村扣分值",
        key: "vv",
        minWidth: 110,
        sortable: false,
        render: (h, params) => {
          var that = this;
          return h('div', [
            h('InputNumber', {
              props: {
                max: 10,
                min: -10,
                size: 'small',
                value: params.row.vv
              },
              on: {
                "on-blur": function(){
                  that.nowInputRow = params.row;
                  that.saveByInput();
                },
                input: (e) => {
                  params.row.vv = e;
                }
              }
            })
          ])
        }
      },
      {
        title: "南塘村扣分原因",
        key: "ww",
        minWidth: 200,
        sortable: false,
        render: (h, params) => {
          var that = this;
          return h('div', [
            h('Input', {
              props: {
                type: 'text',
                size: 'small',
                value: params.row.ww
              },
              on: {
                "on-blur": function(){
                  that.nowInputRow = params.row;
                  that.saveByInput();
                },
                input: (e) => {
                  params.row.ww = e;
                }
              }
            })
          ])
        }
      },
      {
        title: "南塘村扣分值",
        key: "xx",
        minWidth: 110,
        sortable: false,
        render: (h, params) => {
          var that = this;
          return h('div', [
            h('InputNumber', {
              props: {
                max: 10,
                min: -10,
                size: 'small',
                value: params.row.xx
              },
              on: {
                "on-blur": function(){
                  that.nowInputRow = params.row;
                  that.saveByInput();
                },
                input: (e) => {
                  params.row.xx = e;
                }
              }
            })
          ])
        }
      },
      {
        title: "塘里村扣分原因",
        key: "yy",
        minWidth: 200,
        sortable: false,
        render: (h, params) => {
          var that = this;
          return h('div', [
            h('Input', {
              props: {
                type: 'text',
                size: 'small',
                value: params.row.yy
              },
              on: {
                "on-blur": function(){
                  that.nowInputRow = params.row;
                  that.saveByInput();
                },
                input: (e) => {
                  params.row.yy = e;
                }
              }
            })
          ])
        }
      },
      {
        title: "塘里村扣分值",
        key: "zz",
        minWidth: 110,
        sortable: false,
        render: (h, params) => {
          var that = this;
          return h('div', [
            h('InputNumber', {
              props: {
                max: 10,
                min: -10,
                size: 'small',
                value: params.row.zz
              },
              on: {
                "on-blur": function(){
                  that.nowInputRow = params.row;
                  that.saveByInput();
                },
                input: (e) => {
                  params.row.zz = e;
                }
              }
            })
          ])
        }
      },
      {
        title: "浦东村扣分原因",
        key: "aaa",
        minWidth: 200,
        sortable: false,
        render: (h, params) => {
          var that = this;
          return h('div', [
            h('Input', {
              props: {
                type: 'text',
                size: 'small',
                value: params.row.aaa
              },
              on: {
                "on-blur": function(){
                  that.nowInputRow = params.row;
                  that.saveByInput();
                },
                input: (e) => {
                  params.row.aaa = e;
                }
              }
            })
          ])
        }
      },
      {
        title: "浦东村扣分值",
        key: "bbb",
        minWidth: 110,
        sortable: false,
        render: (h, params) => {
          var that = this;
          return h('div', [
            h('InputNumber', {
              props: {
                max: 10,
                min: -10,
                size: 'small',
                value: params.row.bbb
              },
              on: {
                "on-blur": function(){
                  that.nowInputRow = params.row;
                  that.saveByInput();
                },
                input: (e) => {
                  params.row.bbb = e;
                }
              }
            })
          ])
        }
      },
      {
        title: "新塘村扣分原因",
        key: "ccc",
        minWidth: 200,
        sortable: false,
        render: (h, params) => {
          var that = this;
          return h('div', [
            h('Input', {
              props: {
                type: 'text',
                size: 'small',
                value: params.row.ccc
              },
              on: {
                "on-blur": function(){
                  that.nowInputRow = params.row;
                  that.saveByInput();
                },
                input: (e) => {
                  params.row.ccc = e;
                }
              }
            })
          ])
        }
      },
      {
        title: "新塘村扣分值",
        key: "ddd",
        minWidth: 110,
        sortable: false,
        render: (h, params) => {
          var that = this;
          return h('div', [
            h('InputNumber', {
              props: {
                max: 10,
                min: -10,
                size: 'small',
                value: params.row.ddd
              },
              on: {
                "on-blur": function(){
                  that.nowInputRow = params.row;
                  that.saveByInput();
                },
                input: (e) => {
                  params.row.ddd = e;
                }
              }
            })
          ])
        }
      },
      {
        title: "隔洋塘村扣分原因",
        key: "eee",
        minWidth: 200,
        sortable: false,
        render: (h, params) => {
          var that = this;
          return h('div', [
            h('Input', {
              props: {
                type: 'text',
                size: 'small',
                value: params.row.eee
              },
              on: {
                "on-blur": function(){
                  that.nowInputRow = params.row;
                  that.saveByInput();
                },
                input: (e) => {
                  params.row.eee = e;
                }
              }
            })
          ])
        }
      },
      {
        title: "隔洋塘村扣分值",
        key: "fff",
        minWidth: 110,
        sortable: false,
        render: (h, params) => {
          var that = this;
          return h('div', [
            h('InputNumber', {
              props: {
                max: 10,
                min: -10,
                size: 'small',
                value: params.row.fff
              },
              on: {
                "on-blur": function(){
                  that.nowInputRow = params.row;
                  that.saveByInput();
                },
                input: (e) => {
                  params.row.fff = e;
                }
              }
            })
          ])
        }
      },
      {
        title: "李家庄村扣分原因",
        key: "ggg",
        minWidth: 200,
        sortable: false,
        render: (h, params) => {
          var that = this;
          return h('div', [
            h('Input', {
              props: {
                type: 'text',
                size: 'small',
                value: params.row.ggg
              },
              on: {
                "on-blur": function(){
                  that.nowInputRow = params.row;
                  that.saveByInput();
                },
                input: (e) => {
                  params.row.ggg = e;
                }
              }
            })
          ])
        }
      },
      {
        title: "李家庄村扣分值",
        key: "hhh",
        minWidth: 110,
        sortable: false,
        render: (h, params) => {
          var that = this;
          return h('div', [
            h('InputNumber', {
              props: {
                max: 10,
                min: -10,
                size: 'small',
                value: params.row.hhh
              },
              on: {
                "on-blur": function(){
                  that.nowInputRow = params.row;
                  that.saveByInput();
                },
                input: (e) => {
                  params.row.hhh = e;
                }
              }
            })
          ])
        }
      },
      {
        title: "岳井村扣分原因",
        key: "iii",
        minWidth: 200,
        sortable: false,
        render: (h, params) => {
          var that = this;
          return h('div', [
            h('Input', {
              props: {
                type: 'text',
                size: 'small',
                value: params.row.iii
              },
              on: {
                "on-blur": function(){
                  that.nowInputRow = params.row;
                  that.saveByInput();
                },
                input: (e) => {
                  params.row.iii = e;
                }
              }
            })
          ])
        }
      },
      {
        title: "岳井村扣分值",
        key: "jjj",
        minWidth: 110,
        sortable: false,
        render: (h, params) => {
          var that = this;
          return h('div', [
            h('InputNumber', {
              props: {
                max: 10,
                min: -10,
                size: 'small',
                value: params.row.jjj
              },
              on: {
                "on-blur": function(){
                  that.nowInputRow = params.row;
                  that.saveByInput();
                },
                input: (e) => {
                  params.row.jjj = e;
                }
              }
            })
          ])
        }
      },
      {
        title: "岳墩村扣分原因",
        key: "kkk",
        minWidth: 200,
        sortable: false,
        render: (h, params) => {
          var that = this;
          return h('div', [
            h('Input', {
              props: {
                type: 'text',
                size: 'small',
                value: params.row.kkk
              },
              on: {
                "on-blur": function(){
                  that.nowInputRow = params.row;
                  that.saveByInput();
                },
                input: (e) => {
                  params.row.kkk = e;
                }
              }
            })
          ])
        }
      },
      {
        title: "岳墩村扣分值",
        key: "lll",
        minWidth: 110,
        sortable: false,
        render: (h, params) => {
          var that = this;
          return h('div', [
            h('InputNumber', {
              props: {
                max: 10,
                min: -10,
                size: 'small',
                value: params.row.lll
              },
              on: {
                "on-blur": function(){
                  that.nowInputRow = params.row;
                  that.saveByInput();
                },
                input: (e) => {
                  params.row.lll = e;
                }
              }
            })
          ])
        }
      },
      {
        title: "对岙洞村扣分原因",
        key: "mmm",
        minWidth: 200,
        sortable: false,
        render: (h, params) => {
          var that = this;
          return h('div', [
            h('Input', {
              props: {
                type: 'text',
                size: 'small',
                value: params.row.mmm
              },
              on: {
                "on-blur": function(){
                  that.nowInputRow = params.row;
                  that.saveByInput();
                },
                input: (e) => {
                  params.row.mmm = e;
                }
              }
            })
          ])
        }
      },
      {
        title: "对岙洞村扣分值",
        key: "nnn",
        minWidth: 110,
        sortable: false,
        render: (h, params) => {
          var that = this;
          return h('div', [
            h('InputNumber', {
              props: {
                max: 10,
                min: -10,
                size: 'small',
                value: params.row.nnn
              },
              on: {
                "on-blur": function(){
                  that.nowInputRow = params.row;
                  that.saveByInput();
                },
                input: (e) => {
                  params.row.nnn = e;
                }
              }
            })
          ])
        }
      },
      {
        title: "上塘村扣分原因",
        key: "ooo",
        minWidth: 200,
        sortable: false,
        render: (h, params) => {
          var that = this;
          return h('div', [
            h('Input', {
              props: {
                type: 'text',
                size: 'small',
                value: params.row.ooo
              },
              on: {
                "on-blur": function(){
                  that.nowInputRow = params.row;
                  that.saveByInput();
                },
                input: (e) => {
                  params.row.ooo = e;
                }
              }
            })
          ])
        }
      },
      {
        title: "上塘村扣分值",
        key: "ppp",
        minWidth: 110,
        sortable: false,
        render: (h, params) => {
          var that = this;
          return h('div', [
            h('InputNumber', {
              props: {
                max: 10,
                min: -10,
                size: 'small',
                value: params.row.ppp
              },
              on: {
                "on-blur": function(){
                  that.nowInputRow = params.row;
                  that.saveByInput();
                },
                input: (e) => {
                  params.row.ppp = e;
                }
              }
            })
          ])
        }
      },
      {
        title: "伍山村扣分原因",
        key: "qqq",
        minWidth: 200,
        sortable: false,
        render: (h, params) => {
          var that = this;
          return h('div', [
            h('Input', {
              props: {
                type: 'text',
                size: 'small',
                value: params.row.qqq
              },
              on: {
                "on-blur": function(){
                  that.nowInputRow = params.row;
                  that.saveByInput();
                },
                input: (e) => {
                  params.row.qqq = e;
                }
              }
            })
          ])
        }
      },
      {
        title: "伍山村扣分值",
        key: "rrr",
        minWidth: 110,
        sortable: false,
        render: (h, params) => {
          var that = this;
          return h('div', [
            h('InputNumber', {
              props: {
                max: 10,
                min: -10,
                size: 'small',
                value: params.row.rrr
              },
              on: {
                "on-blur": function(){
                  that.nowInputRow = params.row;
                  that.saveByInput();
                },
                input: (e) => {
                  params.row.rrr = e;
                }
              }
            })
          ])
        }
      },
      {
        title: "下湾塘村扣分原因",
        key: "sss",
        minWidth: 200,
        sortable: false,
        render: (h, params) => {
          var that = this;
          return h('div', [
            h('Input', {
              props: {
                type: 'text',
                size: 'small',
                value: params.row.sss
              },
              on: {
                "on-blur": function(){
                  that.nowInputRow = params.row;
                  that.saveByInput();
                },
                input: (e) => {
                  params.row.sss = e;
                }
              }
            })
          ])
        }
      },
      {
        title: "下湾塘村扣分值",
        key: "ttt",
        minWidth: 110,
        sortable: false,
        render: (h, params) => {
          var that = this;
          return h('div', [
            h('InputNumber', {
              props: {
                max: 10,
                min: -10,
                size: 'small',
                value: params.row.ttt
              },
              on: {
                "on-blur": function(){
                  that.nowInputRow = params.row;
                  that.saveByInput();
                },
                input: (e) => {
                  params.row.ttt = e;
                }
              }
            })
          ])
        }
      },
      {
        title: "月兰村扣分原因",
        key: "uuu",
        minWidth: 200,
        sortable: false,
        render: (h, params) => {
          var that = this;
          return h('div', [
            h('Input', {
              props: {
                type: 'text',
                size: 'small',
                value: params.row.uuu
              },
              on: {
                "on-blur": function(){
                  that.nowInputRow = params.row;
                  that.saveByInput();
                },
                input: (e) => {
                  params.row.uuu = e;
                }
              }
            })
          ])
        }
      },
      {
        title: "月兰村扣分值",
        key: "vvv",
        minWidth: 110,
        sortable: false,
        render: (h, params) => {
          var that = this;
          return h('div', [
            h('InputNumber', {
              props: {
                max: 10,
                min: -10,
                size: 'small',
                value: params.row.vvv
              },
              on: {
                "on-blur": function(){
                  that.nowInputRow = params.row;
                  that.saveByInput();
                },
                input: (e) => {
                  params.row.vvv = e;
                }
              }
            })
          ])
        }
      },
      {
        title: "向阳村扣分原因",
        key: "www",
        minWidth: 200,
        sortable: false,
        render: (h, params) => {
          var that = this;
          return h('div', [
            h('Input', {
              props: {
                type: 'text',
                size: 'small',
                value: params.row.www
              },
              on: {
                "on-blur": function(){
                  that.nowInputRow = params.row;
                  that.saveByInput();
                },
                input: (e) => {
                  params.row.www = e;
                }
              }
            })
          ])
        }
      },
      {
        title: "向阳村扣分值",
        key: "xxx",
        minWidth: 110,
        sortable: false,
        render: (h, params) => {
          var that = this;
          return h('div', [
            h('InputNumber', {
              props: {
                max: 10,
                min: -10,
                size: 'small',
                value: params.row.xxx
              },
              on: {
                "on-blur": function(){
                  that.nowInputRow = params.row;
                  that.saveByInput();
                },
                input: (e) => {
                  params.row.xxx = e;
                }
              }
            })
          ])
        }
      },
      {
        title: "长胜村扣分原因",
        key: "yyy",
        minWidth: 200,
        sortable: false,
        render: (h, params) => {
          var that = this;
          return h('div', [
            h('Input', {
              props: {
                type: 'text',
                size: 'small',
                value: params.row.yyy
              },
              on: {
                "on-blur": function(){
                  that.nowInputRow = params.row;
                  that.saveByInput();
                },
                input: (e) => {
                  params.row.yyy = e;
                }
              }
            })
          ])
        }
      },
      {
        title: "长胜村扣分值",
        key: "zzz",
        minWidth: 110,
        sortable: false,
        render: (h, params) => {
          var that = this;
          return h('div', [
            h('InputNumber', {
              props: {
                max: 10,
                min: -10,
                size: 'small',
                value: params.row.zzz
              },
              on: {
                "on-blur": function(){
                  that.nowInputRow = params.row;
                  that.saveByInput();
                },
                input: (e) => {
                  params.row.zzz = e;
                }
              }
            })
          ])
        }
      },
      {
        title: "下塘村扣分原因",
        key: "aaaa",
        minWidth: 200,
        sortable: false,
        render: (h, params) => {
          var that = this;
          return h('div', [
            h('Input', {
              props: {
                type: 'text',
                size: 'small',
                value: params.row.aaaa
              },
              on: {
                "on-blur": function(){
                  that.nowInputRow = params.row;
                  that.saveByInput();
                },
                input: (e) => {
                  params.row.aaaa = e;
                }
              }
            })
          ])
        }
      },
      {
        title: "下塘村扣分值",
        key: "bbbb",
        minWidth: 110,
        sortable: false,
        render: (h, params) => {
          var that = this;
          return h('div', [
            h('InputNumber', {
              props: {
                max: 10,
                min: -10,
                size: 'small',
                value: params.row.bbbb
              },
              on: {
                "on-blur": function(){
                  that.nowInputRow = params.row;
                  that.saveByInput();
                },
                input: (e) => {
                  params.row.bbbb = e;
                }
              }
            })
          ])
        }
      },
      {
        title: "总浦塘村扣分原因",
        key: "cccc",
        minWidth: 200,
        sortable: false,
        render: (h, params) => {
          var that = this;
          return h('div', [
            h('Input', {
              props: {
                type: 'text',
                size: 'small',
                value: params.row.cccc
              },
              on: {
                "on-blur": function(){
                  that.nowInputRow = params.row;
                  that.saveByInput();
                },
                input: (e) => {
                  params.row.cccc = e;
                }
              }
            })
          ])
        }
      },
      {
        title: "总浦塘村扣分值",
        key: "dddd",
        minWidth: 110,
        sortable: false,
        render: (h, params) => {
          var that = this;
          return h('div', [
            h('InputNumber', {
              props: {
                max: 10,
                min: -10,
                size: 'small',
                value: params.row.dddd
              },
              on: {
                "on-blur": function(){
                  that.nowInputRow = params.row;
                  that.saveByInput();
                },
                input: (e) => {
                  params.row.dddd = e;
                }
              }
            })
          ])
        }
      },
      {
        title: "宁东村扣分原因",
        key: "eeee",
        minWidth: 200,
        sortable: false,
        render: (h, params) => {
          var that = this;
          return h('div', [
            h('Input', {
              props: {
                type: 'text',
                size: 'small',
                value: params.row.eeee
              },
              on: {
                "on-blur": function(){
                  that.nowInputRow = params.row;
                  that.saveByInput();
                },
                input: (e) => {
                  params.row.eeee = e;
                }
              }
            })
          ])
        }
      },
      {
        title: "宁东村扣分值",
        key: "ffff",
        minWidth: 110,
        sortable: false,
        render: (h, params) => {
          var that = this;
          return h('div', [
            h('InputNumber', {
              props: {
                max: 10,
                min: -10,
                size: 'small',
                value: params.row.ffff
              },
              on: {
                "on-blur": function(){
                  that.nowInputRow = params.row;
                  that.saveByInput();
                },
                input: (e) => {
                  params.row.ffff = e;
                }
              }
            })
          ])
        }
      },
      {
        title: "新城村扣分原因",
        key: "gggg",
        minWidth: 200,
        sortable: false,
        render: (h, params) => {
          var that = this;
          return h('div', [
            h('Input', {
              props: {
                type: 'text',
                size: 'small',
                value: params.row.gggg
              },
              on: {
                "on-blur": function(){
                  that.nowInputRow = params.row;
                  that.saveByInput();
                },
                input: (e) => {
                  params.row.gggg = e;
                }
              }
            })
          ])
        }
      },
      {
        title: "新城村扣分值",
        key: "hhhh",
        minWidth: 110,
        sortable: false,
        render: (h, params) => {
          var that = this;
          return h('div', [
            h('InputNumber', {
              props: {
                max: 10,
                min: -10,
                size: 'small',
                value: params.row.hhhh
              },
              on: {
                "on-blur": function(){
                  that.nowInputRow = params.row;
                  that.saveByInput();
                },
                input: (e) => {
                  params.row.hhhh = e;
                }
              }
            })
          ])
        }
      },
      {
        title: "龙山村扣分原因",
        key: "iiii",
        minWidth: 200,
        sortable: false,
        render: (h, params) => {
          var that = this;
          return h('div', [
            h('Input', {
              props: {
                type: 'text',
                size: 'small',
                value: params.row.iiii
              },
              on: {
                "on-blur": function(){
                  that.nowInputRow = params.row;
                  that.saveByInput();
                },
                input: (e) => {
                  params.row.iiii = e;
                }
              }
            })
          ])
        }
      },
      {
        title: "龙山村扣分值",
        key: "jjjj",
        minWidth: 110,
        sortable: false,
        render: (h, params) => {
          var that = this;
          return h('div', [
            h('InputNumber', {
              props: {
                max: 10,
                min: -10,
                size: 'small',
                value: params.row.jjjj
              },
              on: {
                "on-blur": function(){
                  that.nowInputRow = params.row;
                  that.saveByInput();
                },
                input: (e) => {
                  params.row.jjjj = e;
                }
              }
            })
          ])
        }
      },
      {
        title: "连浦村扣分原因",
        key: "kkkk",
        minWidth: 200,
        sortable: false,
        render: (h, params) => {
          var that = this;
          return h('div', [
            h('Input', {
              props: {
                type: 'text',
                size: 'small',
                value: params.row.kkkk
              },
              on: {
                "on-blur": function(){
                  that.nowInputRow = params.row;
                  that.saveByInput();
                },
                input: (e) => {
                  params.row.kkkk = e;
                }
              }
            })
          ])
        }
      },
      {
        title: "连浦村扣分值",
        key: "llll",
        minWidth: 110,
        sortable: false,
        render: (h, params) => {
          var that = this;
          return h('div', [
            h('InputNumber', {
              props: {
                max: 10,
                min: -10,
                size: 'small',
                value: params.row.llll
              },
              on: {
                "on-blur": function(){
                  that.nowInputRow = params.row;
                  that.saveByInput();
                },
                input: (e) => {
                  params.row.llll = e;
                }
              }
            })
          ])
        }
      },
      {
        title: "湘田山村扣分原因",
        key: "mmmm",
        minWidth: 200,
        sortable: false,
        render: (h, params) => {
          var that = this;
          return h('div', [
            h('Input', {
              props: {
                type: 'text',
                size: 'small',
                value: params.row.mmmm
              },
              on: {
                "on-blur": function(){
                  that.nowInputRow = params.row;
                  that.saveByInput();
                },
                input: (e) => {
                  params.row.mmmm = e;
                }
              }
            })
          ])
        }
      },
      {
        title: "湘田山村扣分值",
        key: "nnnn",
        minWidth: 110,
        sortable: false,
        render: (h, params) => {
          var that = this;
          return h('div', [
            h('InputNumber', {
              props: {
                max: 10,
                min: -10,
                size: 'small',
                value: params.row.nnnn
              },
              on: {
                "on-blur": function(){
                  that.nowInputRow = params.row;
                  that.saveByInput();
                },
                input: (e) => {
                  params.row.nnnn = e;
                }
              }
            })
          ])
        }
      },
      {
        title: "五福村扣分原因",
        key: "oooo",
        minWidth: 200,
        sortable: false,
        render: (h, params) => {
          var that = this;
          return h('div', [
            h('Input', {
              props: {
                type: 'text',
                size: 'small',
                value: params.row.oooo
              },
              on: {
                "on-blur": function(){
                  that.nowInputRow = params.row;
                  that.saveByInput();
                },
                input: (e) => {
                  params.row.oooo = e;
                }
              }
            })
          ])
        }
      },
      {
        title: "五福村扣分值",
        key: "pppp",
        minWidth: 110,
        sortable: false,
        render: (h, params) => {
          var that = this;
          return h('div', [
            h('InputNumber', {
              props: {
                max: 10,
                min: -10,
                size: 'small',
                value: params.row.pppp
              },
              on: {
                "on-blur": function(){
                  that.nowInputRow = params.row;
                  that.saveByInput();
                },
                input: (e) => {
                  params.row.pppp = e;
                }
              }
            })
          ])
        }
      },
      {
        title: "山头村扣分原因",
        key: "qqqq",
        minWidth: 200,
        sortable: false,
        render: (h, params) => {
          var that = this;
          return h('div', [
            h('Input', {
              props: {
                type: 'text',
                size: 'small',
                value: params.row.qqqq
              },
              on: {
                "on-blur": function(){
                  that.nowInputRow = params.row;
                  that.saveByInput();
                },
                input: (e) => {
                  params.row.qqqq = e;
                }
              }
            })
          ])
        }
      },
      {
        title: "山头村扣分值",
        key: "rrrr",
        minWidth: 110,
        sortable: false,
        render: (h, params) => {
          var that = this;
          return h('div', [
            h('InputNumber', {
              props: {
                max: 10,
                min: -10,
                size: 'small',
                value: params.row.rrrr
              },
              on: {
                "on-blur": function(){
                  that.nowInputRow = params.row;
                  that.saveByInput();
                },
                input: (e) => {
                  params.row.rrrr = e;
                }
              }
            })
          ])
        }
      },
      {
        title: "港中村扣分原因",
        key: "ssss",
        minWidth: 200,
        sortable: false,
        render: (h, params) => {
          var that = this;
          return h('div', [
            h('Input', {
              props: {
                type: 'text',
                size: 'small',
                value: params.row.ssss
              },
              on: {
                "on-blur": function(){
                  that.nowInputRow = params.row;
                  that.saveByInput();
                },
                input: (e) => {
                  params.row.ssss = e;
                }
              }
            })
          ])
        }
      },
      {
        title: "港中村扣分值",
        key: "tttt",
        minWidth: 110,
        sortable: false,
        render: (h, params) => {
          var that = this;
          return h('div', [
            h('InputNumber', {
              props: {
                max: 10,
                min: -10,
                size: 'small',
                value: params.row.tttt
              },
              on: {
                "on-blur": function(){
                  that.nowInputRow = params.row;
                  that.saveByInput();
                },
                input: (e) => {
                  params.row.tttt = e;
                }
              }
            })
          ])
        }
      },
      {
        title: "平原村扣分原因",
        key: "uuuu",
        minWidth: 200,
        sortable: false,
        render: (h, params) => {
          var that = this;
          return h('div', [
            h('Input', {
              props: {
                type: 'text',
                size: 'small',
                value: params.row.uuuu
              },
              on: {
                "on-blur": function(){
                  that.nowInputRow = params.row;
                  that.saveByInput();
                },
                input: (e) => {
                  params.row.uuuu = e;
                }
              }
            })
          ])
        }
      },
      {
        title: "平原村扣分值",
        key: "vvvv",
        minWidth: 110,
        sortable: false,
        render: (h, params) => {
          var that = this;
          return h('div', [
            h('InputNumber', {
              props: {
                max: 10,
                min: -10,
                size: 'small',
                value: params.row.vvvv
              },
              on: {
                "on-blur": function(){
                  that.nowInputRow = params.row;
                  that.saveByInput();
                },
                input: (e) => {
                  params.row.vvvv = e;
                }
              }
            })
          ])
        }
      },
      {
        title: "大青村扣分原因",
        key: "wwww",
        minWidth: 200,
        sortable: false,
        render: (h, params) => {
          var that = this;
          return h('div', [
            h('Input', {
              props: {
                type: 'text',
                size: 'small',
                value: params.row.wwww
              },
              on: {
                "on-blur": function(){
                  that.nowInputRow = params.row;
                  that.saveByInput();
                },
                input: (e) => {
                  params.row.wwww = e;
                }
              }
            })
          ])
        }
      },
      {
        title: "大青村扣分值",
        key: "xxxx",
        minWidth: 110,
        sortable: false,
        render: (h, params) => {
          var that = this;
          return h('div', [
            h('InputNumber', {
              props: {
                max: 10,
                min: -10,
                size: 'small',
                value: params.row.xxxx
              },
              on: {
                "on-blur": function(){
                  that.nowInputRow = params.row;
                  that.saveByInput();
                },
                input: (e) => {
                  params.row.xxxx = e;
                }
              }
            })
          ])
        }
      },
      {
        title: "东港村扣分原因",
        key: "yyyy",
        minWidth: 200,
        sortable: false,
        render: (h, params) => {
          var that = this;
          return h('div', [
            h('Input', {
              props: {
                type: 'text',
                size: 'small',
                value: params.row.yyyy
              },
              on: {
                "on-blur": function(){
                  that.nowInputRow = params.row;
                  that.saveByInput();
                },
                input: (e) => {
                  params.row.yyyy = e;
                }
              }
            })
          ])
        }
      },
      {
        title: "东港村扣分值",
        key: "zzzz",
        minWidth: 110,
        sortable: false,
        render: (h, params) => {
          var that = this;
          return h('div', [
            h('InputNumber', {
              props: {
                max: 10,
                min: -10,
                size: 'small',
                value: params.row.zzzz
              },
              on: {
                "on-blur": function(){
                  that.nowInputRow = params.row;
                  that.saveByInput();
                },
                input: (e) => {
                  params.row.zzzz = e;
                }
              }
            })
          ])
        }
      },
      {
        title: "双家村扣分原因",
        key: "aaaaa",
        minWidth: 200,
        sortable: false,
        render: (h, params) => {
          var that = this;
          return h('div', [
            h('Input', {
              props: {
                type: 'text',
                size: 'small',
                value: params.row.aaaaa
              },
              on: {
                "on-blur": function(){
                  that.nowInputRow = params.row;
                  that.saveByInput();
                },
                input: (e) => {
                  params.row.aaaaa = e;
                }
              }
            })
          ])
        }
      },
      {
        title: "双家村扣分值",
        key: "bbbbb",
        minWidth: 110,
        sortable: false,
        render: (h, params) => {
          var that = this;
          return h('div', [
            h('InputNumber', {
              props: {
                max: 10,
                min: -10,
                size: 'small',
                value: params.row.bbbbb
              },
              on: {
                "on-blur": function(){
                  that.nowInputRow = params.row;
                  that.saveByInput();
                },
                input: (e) => {
                  params.row.bbbbb = e;
                }
              }
            })
          ])
        }
      },
      {
        title: "青珠村扣分原因",
        key: "ccccc",
        minWidth: 200,
        sortable: false,
        render: (h, params) => {
          var that = this;
          return h('div', [
            h('Input', {
              props: {
                type: 'text',
                size: 'small',
                value: params.row.ccccc
              },
              on: {
                "on-blur": function(){
                  that.nowInputRow = params.row;
                  that.saveByInput();
                },
                input: (e) => {
                  params.row.ccccc = e;
                }
              }
            })
          ])
        }
      },
      {
        title: "青珠村扣分值",
        key: "ddddd",
        minWidth: 110,
        sortable: false,
        render: (h, params) => {
          var that = this;
          return h('div', [
            h('InputNumber', {
              props: {
                max: 10,
                min: -10,
                size: 'small',
                value: params.row.ddddd
              },
              on: {
                "on-blur": function(){
                  that.nowInputRow = params.row;
                  that.saveByInput();
                },
                input: (e) => {
                  params.row.ddddd = e;
                }
              }
            })
          ])
        }
      },
      {
        title: "新南村扣分原因",
        key: "eeeee",
        minWidth: 200,
        sortable: false,
        render: (h, params) => {
          var that = this;
          return h('div', [
            h('Input', {
              props: {
                type: 'text',
                size: 'small',
                value: params.row.eeeee
              },
              on: {
                "on-blur": function(){
                  that.nowInputRow = params.row;
                  that.saveByInput();
                },
                input: (e) => {
                  params.row.eeeee = e;
                }
              }
            })
          ])
        }
      },
      {
        title: "新南村扣分值",
        key: "fffff",
        minWidth: 110,
        sortable: false,
        render: (h, params) => {
          var that = this;
          return h('div', [
            h('InputNumber', {
              props: {
                max: 10,
                min: -10,
                size: 'small',
                value: params.row.fffff
              },
              on: {
                "on-blur": function(){
                  that.nowInputRow = params.row;
                  that.saveByInput();
                },
                input: (e) => {
                  params.row.fffff = e;
                }
              }
            })
          ])
        }
      },
      {
        title: "新五星村扣分原因",
        key: "ggggg",
        minWidth: 200,
        sortable: false,
        render: (h, params) => {
          var that = this;
          return h('div', [
            h('Input', {
              props: {
                type: 'text',
                size: 'small',
                value: params.row.ggggg
              },
              on: {
                "on-blur": function(){
                  that.nowInputRow = params.row;
                  that.saveByInput();
                },
                input: (e) => {
                  params.row.ggggg = e;
                }
              }
            })
          ])
        }
      },
      {
        title: "新五星村扣分值",
        key: "hhhhh",
        minWidth: 110,
        sortable: false,
        render: (h, params) => {
          var that = this;
          return h('div', [
            h('InputNumber', {
              props: {
                max: 10,
                min: -10,
                size: 'small',
                value: params.row.hhhhh
              },
              on: {
                "on-blur": function(){
                  that.nowInputRow = params.row;
                  that.saveByInput();
                },
                input: (e) => {
                  params.row.hhhhh = e;
                }
              }
            })
          ])
        }
      },
      {
        title: "文围村扣分原因",
        key: "iiiii",
        minWidth: 200,
        sortable: false,
        render: (h, params) => {
          var that = this;
          return h('div', [
            h('Input', {
              props: {
                type: 'text',
                size: 'small',
                value: params.row.iiiii
              },
              on: {
                "on-blur": function(){
                  that.nowInputRow = params.row;
                  that.saveByInput();
                },
                input: (e) => {
                  params.row.iiiii = e;
                }
              }
            })
          ])
        }
      },
      {
        title: "文围村扣分值",
        key: "jjjjj",
        minWidth: 110,
        sortable: false,
        render: (h, params) => {
          var that = this;
          return h('div', [
            h('InputNumber', {
              props: {
                max: 10,
                min: -10,
                size: 'small',
                value: params.row.jjjjj
              },
              on: {
                "on-blur": function(){
                  that.nowInputRow = params.row;
                  that.saveByInput();
                },
                input: (e) => {
                  params.row.jjjjj = e;
                }
              }
            })
          ])
        }
      },
      {
        title: "青农社区扣分原因",
        key: "kkkkk",
        minWidth: 200,
        sortable: false,
        render: (h, params) => {
          var that = this;
          return h('div', [
            h('Input', {
              props: {
                type: 'text',
                size: 'small',
                value: params.row.kkkkk
              },
              on: {
                "on-blur": function(){
                  that.nowInputRow = params.row;
                  that.saveByInput();
                },
                input: (e) => {
                  params.row.kkkkk = e;
                }
              }
            })
          ])
        }
      },
      {
        title: "青农社区扣分值",
        key: "lllll",
        minWidth: 110,
        sortable: false,
        render: (h, params) => {
          var that = this;
          return h('div', [
            h('InputNumber', {
              props: {
                max: 10,
                min: -10,
                size: 'small',
                value: params.row.lllll
              },
              on: {
                "on-blur": function(){
                  that.nowInputRow = params.row;
                  that.saveByInput();
                },
                input: (e) => {
                  params.row.lllll = e;
                }
              }
            })
          ])
        }
      }
    ],
      data: [], // 表单数据
      pageNumber: 1, // 当前页数
      pageSize: 10, // 页面大小
      total: 0,// 表单数据总数
      nowTimeList: [],
      lineList: [],
      nowInputRow: {}
    };
  },
  methods: {
    init() {
      this.getAllAssessmentLineFx();
      // this.getNowTimesFx();
      this.getDataList();
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
    getDataList() {
      this.loading = true;
        getTwoWindowsList({lineId:this.searchForm.lineId,timeId:this.searchForm.timeId }).then(res => {
          this.loading = false;
          if (res.success) {
            this.data = res.result;
            this.total = res.result.length;
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