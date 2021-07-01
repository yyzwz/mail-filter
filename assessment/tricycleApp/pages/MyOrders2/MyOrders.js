var util = require('../../utils/util.js');
const app = getApp();
Page({
  data:{
    orderList:[],
    lookBigImageFlag: false,
    pageSize: 0,
    name: '',
  },
  onLoad: function (options) {
    wx.showLoading({});
    var that = this;
    this.getData();
    wx.hideLoading();
  },
  lookBigImageFx() {
    var that = this;
    this.setData({
      lookBigImageFlag: !that.data.lookBigImageFlag
    })
  },
  preview1(event) {
    let currentUrl = "https://changjienongye.cn/docs/static/" + event.currentTarget.dataset.src;
    var tempList = [];
    tempList.push(currentUrl);
    wx.previewImage({
      current: currentUrl,
      urls: tempList
    })
  },
  preview2(event) {
    let currentUrl = "https://changjienongye.cn/docs/static2/" + event.currentTarget.dataset.src;
    var tempList = [];
    tempList.push(currentUrl);
    wx.previewImage({
      current: currentUrl,
      urls: tempList
    })
  },
  deleteCar(e) {
    console.log(e);
  },
  getData :function(){
    var that = this;
    wx.request({
      url: app.data.appUrl + '/car/getAll?name=' + this.data.name + '&pageNumber=' + this.data.pageSize,
      method: "GET",
      header: {
        'content-type': 'application/json'
      },
      success: function (res) {
        for(var i = 0 ; i < res.data.result.length ; i ++) {
          if(res.data.result[i].violation == null || res.data.result[i].violation == undefined || res.data.result[i].violation == "null") {
            res.data.result[i].violation = "无处罚记录";
          }
        }
        that.setData({
          orderList: res.data.result
        });
      }
    }) 
  },
  changeName(e) {
    this.setData({
      name: e.detail.value,
      pageSize: 0
    })
    this.getData();
  },
  getMoreUsers() {
    this.setData({
      pageSize: this.data.pageSize + 1
    })
    wx.showLoading({
      title: '请稍后',
    })
    var that = this;
    wx.request({
      url: app.data.appUrl + '/car/getAll?name=' + this.data.name + '&pageNumber=' + this.data.pageSize,
      method: "GET",
      header: {
        'content-type': 'application/json'
      },
      success: function (res) {
        var newArray = [];
        for(var i = 0 ; i < res.data.result.length ; i ++) {
          if(res.data.result[i].violation == null || res.data.result[i].violation == undefined || res.data.result[i].violation == "null") {
            res.data.result[i].violation = "无处罚记录";
          }
          that.data.orderList.push(res.data.result[i]);
        }
        that.setData({
          orderList: that.data.orderList
        })
        wx.hideLoading({})
      }
    }) 
  },
  deletePUL:function(res){
    var deleteId = res.currentTarget.dataset.id;
    wx.showModal({
      title: '确认取消预约？',
      confirmText:'删除',
      confirmColor: "#f00",
      cancelText:'取消',
      cancelColor:'#0f0',
      success: function (res) {
        if(res.cancel){
        }else if(res.confirm){
          wx.request({
            url: app.data.appUrl + '/pul/deleteOrder?id=' + deleteId,
            method: "GET",
            header: {
              'content-type': 'application/json'
            },
            success: function (res) {
              wx.navigateBack({
                delta: 1,
              })
            }
          }) 
        }
      }
    })
  }
})