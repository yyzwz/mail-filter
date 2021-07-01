const app = getApp()
Page({
  data: {
    shopName: '1',
    navbar: [
      '实验室预约', 
      '实验室简介', 
      '我的预约', 
      '我的信息'
      ],
    navurl: ['../../pages/AddHouse/AddHouse', '../../pages/SetTenantHouse/SetTenantHouse', '../../pages/MyHouses/MyHouses', '../../pages/MyTenantsByHouse/MyTenantsByHouse'],
    navable: ['', 'disabled', '', ''],
    // 头像
    image: "../../statis/img/userlogo.jpg",
    inf: '',
    // 确认唯一身份的信息
    loginID: '',  //zwz
    nameMsg: '', //郑为中
  },
  onShow :function(){
    this.setData({
      shopName: app.data.shopName
    })
    if(app.data.sh == 0) {
      wx.request({
        url: app.data.appUrl + '/seller/getShStatus?openId=' + app.data.openId,
        method: 'GET',
        header: {
          'content-type': 'application/json'
        },
        success: function (res) {
          if(res.data.result == '1') {
            app.setData({
              sh: 1
            })
          }
        }
      });
    }
  },
  onLoad: function (options) {
    if(app.data.shopName != null) {
      this.setData({
        shopName: app.data.shopName
      })
    }
  },
  navbarTap: function (e) {
    wx.navigateTo({
      url: e.currentTarget.dataset.href
    })
  },
  // 获取基础授权信息 如昵称 头像
  btn_sub: function (res) {
    var that = this;
    console.log(res.detail);
    var userinfos = res.detail.userInfo;
    that.data.inf = res.detail.userInfo;
    if (userinfos != undefined) {
      this.setData({
        image: userinfos.avatarUrl
      })
    } 
    else {
      this.setData({
        image: "../../statis/img/userlogo.jpg"
      })
    }
  },
  // 点击登入按钮
  login: function(){
    if (app.data.loginTel == ''){
      wx.navigateTo({
        url: '../msg/msg'
      }) 
    }
    else{
      wx.navigateTo({
        url: '../login/login'
      })
    }
  },
  // 跳转到第一个分页面
  intent03: function () {
    if (app.data.shopName == "") {
      this.login();
    }
    else {
      wx.navigateTo({
        url: '../../pages/Information/Information'
      })
    }
  },
// 跳转到第二个分页面
  intent01: function () {
    if (app.data.sh == "0") {
      wx.showToast({
        title: '实名审核未通过',
      })
    }
    else {
      wx.navigateTo({
        url: '../../pages/addCar/addCar'
      })
    }
  },
  // 跳转到第三个分页面
  intent02: function () {
    if (app.data.sh == "0") {
      wx.showToast({
        title: '实名审核未通过',
      })
    }
    else {
      wx.navigateTo({
        url: '../../pages/MyOrders/MyOrders'
      })
    }
  },
  // 跳转到第四个分页面
  intent04: function () { 
    wx.navigateTo({
      url: '../../pages/msg/msg'
    })
  },
})