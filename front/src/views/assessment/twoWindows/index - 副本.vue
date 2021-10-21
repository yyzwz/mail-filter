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
            <span v-if="drop">
              <Form-item label="A" prop="A">
                <Input type="text" v-model="searchForm.A" placeholder="请输入A" clearable style="width: 200px"/>
              </Form-item>
              <Form-item label="B" prop="B">
                <Input type="text" v-model="searchForm.B" placeholder="请输入B" clearable style="width: 200px"/>
              </Form-item>
              <Form-item label="C" prop="C">
                <Input type="text" v-model="searchForm.C" placeholder="请输入C" clearable style="width: 200px"/>
              </Form-item>
              <Form-item label="D" prop="D">
                <Input type="text" v-model="searchForm.D" placeholder="请输入D" clearable style="width: 200px"/>
              </Form-item>
              <Form-item label="E" prop="E">
                <Input type="text" v-model="searchForm.E" placeholder="请输入E" clearable style="width: 200px"/>
              </Form-item>
              <Form-item label="F" prop="F">
                <Input type="text" v-model="searchForm.F" placeholder="请输入F" clearable style="width: 200px"/>
              </Form-item>
              <Form-item label="G" prop="G">
                <Input type="text" v-model="searchForm.G" placeholder="请输入G" clearable style="width: 200px"/>
              </Form-item>
              <Form-item label="H" prop="H">
                <Input type="text" v-model="searchForm.H" placeholder="请输入H" clearable style="width: 200px"/>
              </Form-item>
              <Form-item label="I" prop="I">
                <Input type="text" v-model="searchForm.I" placeholder="请输入I" clearable style="width: 200px"/>
              </Form-item>
              <Form-item label="J" prop="J">
                <Input type="text" v-model="searchForm.J" placeholder="请输入J" clearable style="width: 200px"/>
              </Form-item>
              <Form-item label="K" prop="K">
                <Input type="text" v-model="searchForm.K" placeholder="请输入K" clearable style="width: 200px"/>
              </Form-item>
            </span>
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
        <Table
          :loading="loading"
          border
          :columns="columns"
          :data="data"
          ref="table"
          sortable="custom"
          :span-method="handleSpan"
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
        title: "A",
        key: "a",
        minWidth: 120,
        sortable: false,
        align: "center",
        fixed: 'left'
      },
      {
        title: "B",
        key: "b",
        minWidth: 240,
        sortable: false,
        align: "center",
        render: (h, params) => {
          console.log(params);
          var that = this;
          if(params.index != 0) {
            return h('div', [
              h('Input', {
                props: {
                  type: 'text',
                  size: 'small',
                  value: params.row.b
                },
                on: {
                  "on-blur": function(){
                    that.nowInputRow = params.row;
                    that.saveByInput();
                  },
                  input: (e) => {
                    params.row.b = e;
                  }
                }
              })
            ])
          } else {
            return h('div',[
              h('span', {
                style: {
                    color: '#ff0000'
                }
              }, params.row.b),
            ]);
          }
        }
      },
      {
        title: "C",
        key: "c",
        minWidth: 120,
        sortable: false,
        align: "center",
        render: (h, params) => {
          var that = this;
          if(params.index != 0) {
            return h('div', [
              h('Input', {
                props: {
                  type: 'text',
                  size: 'small',
                  value: params.row.c,
                },
                on: {
                  "on-blur": function(){
                    that.nowInputRow = params.row;
                    that.saveByInput();
                  },
                  input: (e) => {
                    params.row.c = e;
                  }
                }
              })
            ])
          } else {
            return h('div',[
              h('span', {
                style: {
                    color: '#ff0000'
                }
              }, params.row.c),
            ]);
          }
        }
      },
      {
        title: "D",
        key: "d",
        minWidth: 240,
        sortable: false,
        align: "center",
        render: (h, params) => {
          var that = this;
          if(params.index != 0) {
            return h('div', [
              h('Input', {
                props: {
                  type: 'text',
                  size: 'small',
                  value: params.row.d,
                },
                on: {
                  "on-blur": function(){
                    that.nowInputRow = params.row;
                    that.saveByInput();
                  },
                  input: (e) => {
                    params.row.d = e;
                  }
                }
              })
            ])
          } else {
            return h('div',[
              h('span', {
                style: {
                    color: '#ff0000'
                }
              }, params.row.d),
            ]);
          }
        }
      },
      {
        title: "E",
        key: "e",
        minWidth: 120,
        sortable: false,
        align: "center",
        render: (h, params) => {
          var that = this;
          if(params.index != 0) {
            return h('div', [
              h('Input', {
                props: {
                  type: 'text',
                  size: 'small',
                  value: params.row.e,
                },
                on: {
                  "on-blur": function(){
                    that.nowInputRow = params.row;
                    that.saveByInput();
                  },
                  input: (e) => {
                    params.row.e = e;
                  }
                }
              })
            ])
          } else {
            return h('div',[
              h('span', {
                style: {
                    color: '#ff0000'
                }
              }, params.row.e),
            ]);
          }
        }
      },
      {
        title: "F",
        key: "f",
        minWidth: 240,
        sortable: false,
        align: "center",
        render: (h, params) => {
          var that = this;
          if(params.index != 0) {
            return h('div', [
              h('Input', {
                props: {
                  type: 'text',
                  size: 'small',
                  value: params.row.f,
                },
                on: {
                  "on-blur": function(){
                    that.nowInputRow = params.row;
                    that.saveByInput();
                  },
                  input: (e) => {
                    params.row.f = e;
                  }
                }
              })
            ])
          } else {
            return h('div',[
              h('span', {
                style: {
                    color: '#ff0000'
                }
              }, params.row.f),
            ]);
          }
        }
      },
      {
        title: "G",
        key: "g",
        minWidth: 120,
        sortable: false,
        align: "center",
        render: (h, params) => {
          var that = this;
          if(params.index != 0) {
            return h('div', [
              h('Input', {
                props: {
                  type: 'text',
                  size: 'small',
                  value: params.row.g,
                },
                on: {
                  "on-blur": function(){
                    that.nowInputRow = params.row;
                    that.saveByInput();
                  },
                  input: (e) => {
                    params.row.g = e;
                  }
                }
              })
            ])
          } else {
            return h('div',[
              h('span', {
                style: {
                    color: '#ff0000'
                }
              }, params.row.g),
            ]);
          }
        }
      },
      {
        title: "H",
        key: "h",
        minWidth: 240,
        sortable: false,
        align: "center",
        render: (h, params) => {
          var that = this;
          if(params.index != 0) {
            return h('div', [
              h('Input', {
                props: {
                  type: 'text',
                  size: 'small',
                  value: params.row.h,
                },
                on: {
                  "on-blur": function(){
                    that.nowInputRow = params.row;
                    that.saveByInput();
                  },
                  input: (e) => {
                    params.row.h = e;
                  }
                }
              })
            ])
          } else {
            return h('div',[
              h('span', {
                style: {
                    color: '#ff0000'
                }
              }, params.row.h),
            ]);
          }
        }
      },
      {
        title: "I",
        key: "i",
        minWidth: 120,
        sortable: false,
        align: "center",
        render: (h, params) => {
          var that = this;
          if(params.index != 0) {
            return h('div', [
              h('Input', {
                props: {
                  type: 'text',
                  size: 'small',
                  value: params.row.i,
                },
                on: {
                  "on-blur": function(){
                    that.nowInputRow = params.row;
                    that.saveByInput();
                  },
                  input: (e) => {
                    params.row.i = e;
                  }
                }
              })
            ])
          } else {
            return h('div',[
              h('span', {
                style: {
                    color: '#ff0000'
                }
              }, params.row.i),
            ]);
          }
        }
      },
      {
        title: "J",
        key: "j",
        minWidth: 240,
        sortable: false,
        align: "center",
        render: (h, params) => {
          var that = this;
          if(params.index != 0) {
            return h('div', [
              h('Input', {
                props: {
                  type: 'text',
                  size: 'small',
                  value: params.row.j,
                },
                on: {
                  "on-blur": function(){
                    that.nowInputRow = params.row;
                    that.saveByInput();
                  },
                  input: (e) => {
                    params.row.j = e;
                  }
                }
              })
            ])
          } else {
            return h('div',[
              h('span', {
                style: {
                    color: '#ff0000'
                }
              }, params.row.j),
            ]);
          }
        }
      },
      {
        title: "K",
        key: "k",
        minWidth: 120,
        sortable: false,
        align: "center",
        render: (h, params) => {
          var that = this;
          if(params.index != 0) {
            return h('div', [
              h('Input', {
                props: {
                  type: 'text',
                  size: 'small',
                  value: params.row.k,
                },
                on: {
                  "on-blur": function(){
                    that.nowInputRow = params.row;
                    that.saveByInput();
                  },
                  input: (e) => {
                    params.row.k = e;
                  }
                }
              })
            ])
          } else {
            return h('div',[
              h('span', {
                style: {
                    color: '#ff0000'
                }
              }, params.row.k),
            ]);
          }
        }
      },
      {
        title: "L",
        key: "l",
        minWidth: 240,
        sortable: false,
        align: "center",
        render: (h, params) => {
          var that = this;
          if(params.index != 0) {
            return h('div', [
              h('Input', {
                props: {
                  type: 'text',
                  size: 'small',
                  value: params.row.l,
                },
                on: {
                  "on-blur": function(){
                    that.nowInputRow = params.row;
                    that.saveByInput();
                  },
                  input: (e) => {
                    params.row.l = e;
                  }
                }
              })
            ])
          } else {
            return h('div',[
              h('span', {
                style: {
                    color: '#ff0000'
                }
              }, params.row.l),
            ]);
          }
        }
      },
      {
        title: "M",
        key: "m",
        minWidth: 120,
        sortable: false,
        align: "center",
        render: (h, params) => {
          var that = this;
          if(params.index != 0) {
            return h('div', [
              h('Input', {
                props: {
                  type: 'text',
                  size: 'small',
                  value: params.row.m,
                },
                on: {
                  "on-blur": function(){
                    that.nowInputRow = params.row;
                    that.saveByInput();
                  },
                  input: (e) => {
                    params.row.m = m;
                  }
                }
              })
            ])
          } else {
            return h('div',[
              h('span', {
                style: {
                    color: '#ff0000'
                }
              }, params.row.m),
            ]);
          }
        }
      },
      {
        title: "N",
        key: "n",
        minWidth: 240,
        sortable: false,
        align: "center",
        render: (h, params) => {
          var that = this;
          if(params.index != 0) {
            return h('div', [
              h('Input', {
                props: {
                  type: 'text',
                  size: 'small',
                  value: params.row.n,
                },
                on: {
                  "on-blur": function(){
                    that.nowInputRow = params.row;
                    that.saveByInput();
                  },
                  input: (e) => {
                    params.row.n = e;
                  }
                }
              })
            ])
          } else {
            return h('div',[
              h('span', {
                style: {
                    color: '#ff0000'
                }
              }, params.row.n),
            ]);
          }
        }
      },
      {
        title: "O",
        key: "o",
        minWidth: 120,
        sortable: false,
        align: "center",
        render: (h, params) => {
          var that = this;
          if(params.index != 0) {
            return h('div', [
              h('Input', {
                props: {
                  type: 'text',
                  size: 'small',
                  value: params.row.o,
                },
                on: {
                  "on-blur": function(){
                    that.nowInputRow = params.row;
                    that.saveByInput();
                  },
                  input: (e) => {
                    params.row.o = e;
                  }
                }
              })
            ])
          } else {
            return h('div',[
              h('span', {
                style: {
                    color: '#ff0000'
                }
              }, params.row.o),
            ]);
          }
        }
      },
      {
        title: "P",
        key: "p",
        minWidth: 240,
        sortable: false,
        align: "center",
        render: (h, params) => {
          var that = this;
          if(params.index != 0) {
            return h('div', [
              h('Input', {
                props: {
                  type: 'text',
                  size: 'small',
                  value: params.row.p,
                },
                on: {
                  "on-blur": function(){
                    that.nowInputRow = params.row;
                    that.saveByInput();
                  },
                  input: (e) => {
                    params.row.p = e;
                  }
                }
              })
            ])
          } else {
            return h('div',[
              h('span', {
                style: {
                    color: '#ff0000'
                }
              }, params.row.p),
            ]);
          }
        }
      },
      {
        title: "Q",
        key: "q",
        minWidth: 120,
        sortable: false,
        align: "center",
        render: (h, params) => {
          var that = this;
          if(params.index != 0) {
            return h('div', [
              h('Input', {
                props: {
                  type: 'text',
                  size: 'small',
                  value: params.row.q,
                },
                on: {
                  "on-blur": function(){
                    that.nowInputRow = params.row;
                    that.saveByInput();
                  },
                  input: (e) => {
                    params.row.q = e;
                  }
                }
              })
            ])
          } else {
            return h('div',[
              h('span', {
                style: {
                    color: '#ff0000'
                }
              }, params.row.q),
            ]);
          }
        }
      },
      {
        title: "R",
        key: "r",
        minWidth: 240,
        sortable: false,
        align: "center",
        render: (h, params) => {
          var that = this;
          if(params.index != 0) {
            return h('div', [
              h('Input', {
                props: {
                  type: 'text',
                  size: 'small',
                  value: params.row.r,
                },
                on: {
                  "on-blur": function(){
                    that.nowInputRow = params.row;
                    that.saveByInput();
                  },
                  input: (e) => {
                    params.row.r = e;
                  }
                }
              })
            ])
          } else {
            return h('div',[
              h('span', {
                style: {
                    color: '#ff0000'
                }
              }, params.row.r),
            ]);
          }
        }
      },
      {
        title: "S",
        key: "s",
        minWidth: 120,
        sortable: false,
        align: "center",
        render: (h, params) => {
          var that = this;
          if(params.index != 0) {
            return h('div', [
              h('Input', {
                props: {
                  type: 'text',
                  size: 'small',
                  value: params.row.s,
                },
                on: {
                  "on-blur": function(){
                    that.nowInputRow = params.row;
                    that.saveByInput();
                  },
                  input: (e) => {
                    params.row.s = e;
                  }
                }
              })
            ])
          } else {
            return h('div',[
              h('span', {
                style: {
                    color: '#ff0000'
                }
              }, params.row.s),
            ]);
          }
        }
      },
      {
        title: "T",
        key: "t",
        minWidth: 240,
        sortable: false,
        align: "center",
        render: (h, params) => {
          var that = this;
          if(params.index != 0) {
            return h('div', [
              h('Input', {
                props: {
                  type: 'text',
                  size: 'small',
                  value: params.row.t,
                },
                on: {
                  "on-blur": function(){
                    that.nowInputRow = params.row;
                    that.saveByInput();
                  },
                  input: (e) => {
                    params.row.t = e;
                  }
                }
              })
            ])
          } else {
            return h('div',[
              h('span', {
                style: {
                    color: '#ff0000'
                }
              }, params.row.t),
            ]);
          }
        }
      },
      {
        title: "U",
        key: "u",
        minWidth: 120,
        sortable: false,
        align: "center",
        render: (h, params) => {
          var that = this;
          if(params.index != 0) {
            return h('div', [
              h('Input', {
                props: {
                  type: 'text',
                  size: 'small',
                  value: params.row.u,
                },
                on: {
                  "on-blur": function(){
                    that.nowInputRow = params.row;
                    that.saveByInput();
                  },
                  input: (e) => {
                    params.row.u = e;
                  }
                }
              })
            ])
          } else {
            return h('div',[
              h('span', {
                style: {
                    color: '#ff0000'
                }
              }, params.row.u),
            ]);
          }
        }
      },
      {
        title: "V",
        key: "v",
        minWidth: 240,
        sortable: false,
        align: "center",
        render: (h, params) => {
          var that = this;
          if(params.index != 0) {
            return h('div', [
              h('Input', {
                props: {
                  type: 'text',
                  size: 'small',
                  value: params.row.v,
                },
                on: {
                  "on-blur": function(){
                    that.nowInputRow = params.row;
                    that.saveByInput();
                  },
                  input: (e) => {
                    params.row.v = e;
                  }
                }
              })
            ])
          } else {
            return h('div',[
              h('span', {
                style: {
                    color: '#ff0000'
                }
              }, params.row.v),
            ]);
          }
        }
      },
      {
        title: "W",
        key: "w",
        minWidth: 120,
        sortable: false,
        align: "center",
        render: (h, params) => {
          var that = this;
          if(params.index != 0) {
            return h('div', [
              h('Input', {
                props: {
                  type: 'text',
                  size: 'small',
                  value: params.row.w,
                },
                on: {
                  "on-blur": function(){
                    that.nowInputRow = params.row;
                    that.saveByInput();
                  },
                  input: (e) => {
                    params.row.w = e;
                  }
                }
              })
            ])
          } else {
            return h('div',[
              h('span', {
                style: {
                    color: '#ff0000'
                }
              }, params.row.w),
            ]);
          }
        }
      },
      {
        title: "X",
        key: "x",
        minWidth: 240,
        sortable: false,
        align: "center",
        render: (h, params) => {
          var that = this;
          if(params.index != 0) {
            return h('div', [
              h('Input', {
                props: {
                  type: 'text',
                  size: 'small',
                  value: params.row.x,
                },
                on: {
                  "on-blur": function(){
                    that.nowInputRow = params.row;
                    that.saveByInput();
                  },
                  input: (e) => {
                    params.row.x = e;
                  }
                }
              })
            ])
          } else {
            return h('div',[
              h('span', {
                style: {
                    color: '#ff0000'
                }
              }, params.row.x),
            ]);
          }
        }
      },
      {
        title: "Y",
        key: "y",
        minWidth: 120,
        sortable: false,
        align: "center",
        render: (h, params) => {
          var that = this;
          if(params.index != 0) {
            return h('div', [
              h('Input', {
                props: {
                  type: 'text',
                  size: 'small',
                  value: params.row.y,
                },
                on: {
                  "on-blur": function(){
                    that.nowInputRow = params.row;
                    that.saveByInput();
                  },
                  input: (e) => {
                    params.row.y = e;
                  }
                }
              })
            ])
          } else {
            return h('div',[
              h('span', {
                style: {
                    color: '#ff0000'
                }
              }, params.row.y),
            ]);
          }
        }
      },
      {
        title: "Z",
        key: "z",
        minWidth: 240,
        sortable: false,
        align: "center",
        render: (h, params) => {
          var that = this;
          if(params.index != 0) {
            return h('div', [
              h('Input', {
                props: {
                  type: 'text',
                  size: 'small',
                  value: params.row.z,
                },
                on: {
                  "on-blur": function(){
                    that.nowInputRow = params.row;
                    that.saveByInput();
                  },
                  input: (e) => {
                    params.row.z = e;
                  }
                }
              })
            ])
          } else {
            return h('div',[
              h('span', {
                style: {
                    color: '#ff0000'
                }
              }, params.row.z),
            ]);
          }
        }
      },
      {
        title: "AA",
        key: "aa",
        minWidth: 120,
        sortable: false,
        align: "center",
        render: (h, params) => {
          var that = this;
          if(params.index != 0) {
            return h('div', [
              h('Input', {
                props: {
                  type: 'text',
                  size: 'small',
                  value: params.row.aa,
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
          } else {
            return h('div',[
              h('span', {
                style: {
                    color: '#ff0000'
                }
              }, params.row.aa),
            ]);
          }
        }
      },
      {
        title: "AB",
        key: "ab",
        minWidth: 240,
        sortable: false,
        align: "center",
        render: (h, params) => {
          var that = this;
          if(params.index != 0) {
            return h('div', [
              h('Input', {
                props: {
                  type: 'text',
                  size: 'small',
                  value: params.row.ab,
                },
                on: {
                  "on-blur": function(){
                    that.nowInputRow = params.row;
                    that.saveByInput();
                  },
                  input: (e) => {
                    params.row.ab = e;
                  }
                }
              })
            ])
          } else {
            return h('div',[
              h('span', {
                style: {
                    color: '#ff0000'
                }
              }, params.row.ab),
            ]);
          }
        }
      },
      {
        title: "AC",
        key: "ac",
        minWidth: 120,
        sortable: false,
        align: "center",
        render: (h, params) => {
          var that = this;
          if(params.index != 0) {
            return h('div', [
              h('Input', {
                props: {
                  type: 'text',
                  size: 'small',
                  value: params.row.ac,
                },
                on: {
                  "on-blur": function(){
                    that.nowInputRow = params.row;
                    that.saveByInput();
                  },
                  input: (e) => {
                    params.row.ac = e;
                  }
                }
              })
            ])
          } else {
            return h('div',[
              h('span', {
                style: {
                    color: '#ff0000'
                }
              }, params.row.ac),
            ]);
          }
        }
      },
      {
        title: "AD",
        key: "ad",
        minWidth: 240,
        sortable: false,
        align: "center",
        render: (h, params) => {
          var that = this;
          if(params.index != 0) {
            return h('div', [
              h('Input', {
                props: {
                  type: 'text',
                  size: 'small',
                  value: params.row.ad,
                },
                on: {
                  "on-blur": function(){
                    that.nowInputRow = params.row;
                    that.saveByInput();
                  },
                  input: (e) => {
                    params.row.ad = e;
                  }
                }
              })
            ])
          } else {
            return h('div',[
              h('span', {
                style: {
                    color: '#ff0000'
                }
              }, params.row.ad),
            ]);
          }
        }
      },
      {
        title: "AE",
        key: "ae",
        minWidth: 120,
        sortable: false,
        align: "center",
        render: (h, params) => {
          var that = this;
          if(params.index != 0) {
            return h('div', [
              h('Input', {
                props: {
                  type: 'text',
                  size: 'small',
                  value: params.row.ae,
                },
                on: {
                  "on-blur": function(){
                    that.nowInputRow = params.row;
                    that.saveByInput();
                  },
                  input: (e) => {
                    params.row.ae = e;
                  }
                }
              })
            ])
          } else {
            return h('div',[
              h('span', {
                style: {
                    color: '#ff0000'
                }
              }, params.row.ae),
            ]);
          }
        }
      },
      {
        title: "AF",
        key: "af",
        minWidth: 240,
        sortable: false,
        align: "center",
        render: (h, params) => {
          var that = this;
          if(params.index != 0) {
            return h('div', [
              h('Input', {
                props: {
                  type: 'text',
                  size: 'small',
                  value: params.row.af,
                },
                on: {
                  "on-blur": function(){
                    that.nowInputRow = params.row;
                    that.saveByInput();
                  },
                  input: (e) => {
                    params.row.af = e;
                  }
                }
              })
            ])
          } else {
            return h('div',[
              h('span', {
                style: {
                    color: '#ff0000'
                }
              }, params.row.af),
            ]);
          }
        }
      },
      {
        title: "AG",
        key: "ag",
        minWidth: 120,
        sortable: false,
        align: "center",
        render: (h, params) => {
          var that = this;
          if(params.index != 0) {
            return h('div', [
              h('Input', {
                props: {
                  type: 'text',
                  size: 'small',
                  value: params.row.ag,
                },
                on: {
                  "on-blur": function(){
                    that.nowInputRow = params.row;
                    that.saveByInput();
                  },
                  input: (e) => {
                    params.row.ag = e;
                  }
                }
              })
            ])
          } else {
            return h('div',[
              h('span', {
                style: {
                    color: '#ff0000'
                }
              }, params.row.ag),
            ]);
          }
        }
      },
      {
        title: "AH",
        key: "ah",
        minWidth: 240,
        sortable: false,
        align: "center",
        render: (h, params) => {
          var that = this;
          if(params.index != 0) {
            return h('div', [
              h('Input', {
                props: {
                  type: 'text',
                  size: 'small',
                  value: params.row.ah,
                },
                on: {
                  "on-blur": function(){
                    that.nowInputRow = params.row;
                    that.saveByInput();
                  },
                  input: (e) => {
                    params.row.ah = e;
                  }
                }
              })
            ])
          } else {
            return h('div',[
              h('span', {
                style: {
                    color: '#ff0000'
                }
              }, params.row.ah),
            ]);
          }
        }
      },
      {
        title: "AI",
        key: "ai",
        minWidth: 120,
        sortable: false,
        align: "center",
        render: (h, params) => {
          var that = this;
          if(params.index != 0) {
            return h('div', [
              h('Input', {
                props: {
                  type: 'text',
                  size: 'small',
                  value: params.row.ai,
                },
                on: {
                  "on-blur": function(){
                    that.nowInputRow = params.row;
                    that.saveByInput();
                  },
                  input: (e) => {
                    params.row.ai = e;
                  }
                }
              })
            ])
          } else {
            return h('div',[
              h('span', {
                style: {
                    color: '#ff0000'
                }
              }, params.row.ai),
            ]);
          }
        }
      },
      {
        title: "AJ",
        key: "aj",
        minWidth: 240,
        sortable: false,
        align: "center",
        render: (h, params) => {
          var that = this;
          if(params.index != 0) {
            return h('div', [
              h('Input', {
                props: {
                  type: 'text',
                  size: 'small',
                  value: params.row.aj,
                },
                on: {
                  "on-blur": function(){
                    that.nowInputRow = params.row;
                    that.saveByInput();
                  },
                  input: (e) => {
                    params.row.aj = e;
                  }
                }
              })
            ])
          } else {
            return h('div',[
              h('span', {
                style: {
                    color: '#ff0000'
                }
              }, params.row.aj),
            ]);
          }
        }
      },
      {
        title: "AK",
        key: "ak",
        minWidth: 120,
        sortable: false,
        align: "center",
        render: (h, params) => {
          var that = this;
          if(params.index != 0) {
            return h('div', [
              h('Input', {
                props: {
                  type: 'text',
                  size: 'small',
                  value: params.row.ak,
                },
                on: {
                  "on-blur": function(){
                    that.nowInputRow = params.row;
                    that.saveByInput();
                  },
                  input: (e) => {
                    params.row.ak = e;
                  }
                }
              })
            ])
          } else {
            return h('div',[
              h('span', {
                style: {
                    color: '#ff0000'
                }
              }, params.row.ak),
            ]);
          }
        }
      },
      {
        title: "AL",
        key: "al",
        minWidth: 240,
        sortable: false,
        align: "center",
        render: (h, params) => {
          var that = this;
          if(params.index != 0) {
            return h('div', [
              h('Input', {
                props: {
                  type: 'text',
                  size: 'small',
                  value: params.row.al,
                },
                on: {
                  "on-blur": function(){
                    that.nowInputRow = params.row;
                    that.saveByInput();
                  },
                  input: (e) => {
                    params.row.al = e;
                  }
                }
              })
            ])
          } else {
            return h('div',[
              h('span', {
                style: {
                    color: '#ff0000'
                }
              }, params.row.al),
            ]);
          }
        }
      },
      {
        title: "AM",
        key: "am",
        minWidth: 120,
        sortable: false,
        align: "center",
        render: (h, params) => {
          var that = this;
          if(params.index != 0) {
            return h('div', [
              h('Input', {
                props: {
                  type: 'text',
                  size: 'small',
                  value: params.row.am,
                },
                on: {
                  "on-blur": function(){
                    that.nowInputRow = params.row;
                    that.saveByInput();
                  },
                  input: (e) => {
                    params.row.am = e;
                  }
                }
              })
            ])
          } else {
            return h('div',[
              h('span', {
                style: {
                    color: '#ff0000'
                }
              }, params.row.am),
            ]);
          }
        }
      },
      {
        title: "AN",
        key: "an",
        minWidth: 240,
        sortable: false,
        align: "center",
        render: (h, params) => {
          var that = this;
          if(params.index != 0) {
            return h('div', [
              h('Input', {
                props: {
                  type: 'text',
                  size: 'small',
                  value: params.row.an,
                },
                on: {
                  "on-blur": function(){
                    that.nowInputRow = params.row;
                    that.saveByInput();
                  },
                  input: (e) => {
                    params.row.an = e;
                  }
                }
              })
            ])
          } else {
            return h('div',[
              h('span', {
                style: {
                    color: '#ff0000'
                }
              }, params.row.an),
            ]);
          }
        }
      },
      {
        title: "AO",
        key: "ao",
        minWidth: 120,
        sortable: false,
        align: "center",
        render: (h, params) => {
          var that = this;
          if(params.index != 0) {
            return h('div', [
              h('Input', {
                props: {
                  type: 'text',
                  size: 'small',
                  value: params.row.ao,
                },
                on: {
                  "on-blur": function(){
                    that.nowInputRow = params.row;
                    that.saveByInput();
                  },
                  input: (e) => {
                    params.row.ao = e;
                  }
                }
              })
            ])
          } else {
            return h('div',[
              h('span', {
                style: {
                    color: '#ff0000'
                }
              }, params.row.ao),
            ]);
          }
        }
      },
      {
        title: "AP",
        key: "ap",
        minWidth: 240,
        sortable: false,
        align: "center",
        render: (h, params) => {
          var that = this;
          if(params.index != 0) {
            return h('div', [
              h('Input', {
                props: {
                  type: 'text',
                  size: 'small',
                  value: params.row.ap,
                },
                on: {
                  "on-blur": function(){
                    that.nowInputRow = params.row;
                    that.saveByInput();
                  },
                  input: (e) => {
                    params.row.ap = e;
                  }
                }
              })
            ])
          } else {
            return h('div',[
              h('span', {
                style: {
                    color: '#ff0000'
                }
              }, params.row.ap),
            ]);
          }
        }
      },
      {
        title: "AQ",
        key: "aq",
        minWidth: 120,
        sortable: false,
        align: "center",
        render: (h, params) => {
          var that = this;
          if(params.index != 0) {
            return h('div', [
              h('Input', {
                props: {
                  type: 'text',
                  size: 'small',
                  value: params.row.aq,
                },
                on: {
                  "on-blur": function(){
                    that.nowInputRow = params.row;
                    that.saveByInput();
                  },
                  input: (e) => {
                    params.row.aq = e;
                  }
                }
              })
            ])
          } else {
            return h('div',[
              h('span', {
                style: {
                    color: '#ff0000'
                }
              }, params.row.aq),
            ]);
          }
        }
      },
      {
        title: "AR",
        key: "ar",
        minWidth: 240,
        sortable: false,
        align: "center",
        render: (h, params) => {
          var that = this;
          if(params.index != 0) {
            return h('div', [
              h('Input', {
                props: {
                  type: 'text',
                  size: 'small',
                  value: params.row.ar,
                },
                on: {
                  "on-blur": function(){
                    that.nowInputRow = params.row;
                    that.saveByInput();
                  },
                  input: (e) => {
                    params.row.ar = e;
                  }
                }
              })
            ])
          } else {
            return h('div',[
              h('span', {
                style: {
                    color: '#ff0000'
                }
              }, params.row.ar),
            ]);
          }
        }
      },
      {
        title: "AS",
        key: "ass",
        minWidth: 120,
        sortable: false,
        align: "center",
        render: (h, params) => {
          var that = this;
          if(params.index != 0) {
            return h('div', [
              h('Input', {
                props: {
                  type: 'text',
                  size: 'small',
                  value: params.row.ass,
                },
                on: {
                  "on-blur": function(){
                    that.nowInputRow = params.row;
                    that.saveByInput();
                  },
                  input: (e) => {
                    params.row.ass = e;
                  }
                }
              })
            ])
          } else {
            return h('div',[
              h('span', {
                style: {
                    color: '#ff0000'
                }
              }, params.row.ass),
            ]);
          }
        }
      },
      {
        title: "AT",
        key: "at",
        minWidth: 240,
        sortable: false,
        align: "center",
        render: (h, params) => {
          var that = this;
          if(params.index != 0) {
            return h('div', [
              h('Input', {
                props: {
                  type: 'text',
                  size: 'small',
                  value: params.row.at,
                },
                on: {
                  "on-blur": function(){
                    that.nowInputRow = params.row;
                    that.saveByInput();
                  },
                  input: (e) => {
                    params.row.at = e;
                  }
                }
              })
            ])
          } else {
            return h('div',[
              h('span', {
                style: {
                    color: '#ff0000'
                }
              }, params.row.at),
            ]);
          }
        }
      },
      {
        title: "AU",
        key: "au",
        minWidth: 120,
        sortable: false,
        align: "center",
        render: (h, params) => {
          var that = this;
          if(params.index != 0) {
            return h('div', [
              h('Input', {
                props: {
                  type: 'text',
                  size: 'small',
                  value: params.row.au,
                },
                on: {
                  "on-blur": function(){
                    that.nowInputRow = params.row;
                    that.saveByInput();
                  },
                  input: (e) => {
                    params.row.au = e;
                  }
                }
              })
            ])
          } else {
            return h('div',[
              h('span', {
                style: {
                    color: '#ff0000'
                }
              }, params.row.au),
            ]);
          }
        }
      },
      {
        title: "AV",
        key: "av",
        minWidth: 240,
        sortable: false,
        align: "center",
        render: (h, params) => {
          var that = this;
          if(params.index != 0) {
            return h('div', [
              h('Input', {
                props: {
                  type: 'text',
                  size: 'small',
                  value: params.row.av,
                },
                on: {
                  "on-blur": function(){
                    that.nowInputRow = params.row;
                    that.saveByInput();
                  },
                  input: (e) => {
                    params.row.av = e;
                  }
                }
              })
            ])
          } else {
            return h('div',[
              h('span', {
                style: {
                    color: '#ff0000'
                }
              }, params.row.av),
            ]);
          }
        }
      },
      {
        title: "AW",
        key: "aw",
        minWidth: 120,
        sortable: false,
        align: "center",
        render: (h, params) => {
          var that = this;
          if(params.index != 0) {
            return h('div', [
              h('Input', {
                props: {
                  type: 'text',
                  size: 'small',
                  value: params.row.aw,
                },
                on: {
                  "on-blur": function(){
                    that.nowInputRow = params.row;
                    that.saveByInput();
                  },
                  input: (e) => {
                    params.row.aw = e;
                  }
                }
              })
            ])
          } else {
            return h('div',[
              h('span', {
                style: {
                    color: '#ff0000'
                }
              }, params.row.aw),
            ]);
          }
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
    // getNowTimesFx() {
    //   var that = this;
    //   getNowTimes().then(res => {
    //     that.nowTimeList = res.result;
    //     that.searchForm.timeId = res.result[0].id;
    //     that.searchForm.timeName = res.result[0].timeName;
    //   })
    // },
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
          console.log(res);
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