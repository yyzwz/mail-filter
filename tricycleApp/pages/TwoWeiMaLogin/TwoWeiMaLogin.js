const app = getApp();
var WXBizDataCrypt = require('../../utils/RdWXBizDataCrypt.js');
var AppId = 'wx3cc5ca75674a486b'
var AppSecret = '08544ce777869bfd261d85279e722963'
Page({

  data: {
    carData: {
      sellDate: '', // 出售日期
      jia: '', // 车架号
      gu: '', // 车骨号
      pinPai: '', // 车品牌
      xingHao: '', // 车型号
      type: '', // 车类型
      piaoPhoto: '', // 发票照片
      paiHao: '', // 防盗车牌号
      baoXian: '', // 上保险时间
      remark: '', // 备注
      fileId: '', // 文件编号
      sellerName: '', // 卖家
      name: '', // 买家
      mobile: '', // 手机号
      ownerIdcard: '', // 身份证号
      addressHu: '', // 户籍地址
      addressZhu: '', // 住址
      re1: '', // 户籍地址
      re2: '', // 户籍地址
      jiaNumber: '', // 驾照号码
    },
    ewmId: '',
    sessionkey: '',
    openid: '',
    canLookFlag: true,
  },
 
  onLoad: function (q) {
    app.data.ewmFlag = 1;
    var that = this;
    console.log("q == ");
    console.log(q);
    // 传递的参数需要转码
    that.setData({
      ewmId:decodeURIComponent(q.q)
    })
    console.log(that.data.ewmId);
    var num;
    num = that.data.ewmId.split('=');
    this.setData({
      ewmId: num[1],
    })
    this.getLogin();
  },
  getData: function () {
    var that = this;
    console.log("this.data.openid = " + this.data.openid);
    wx.request({
      url: app.data.appUrl + '/car/getByOpenId?id=' + this.data.ewmId + "&openId=" + this.data.openid,
      method: "GET",
      header: {
        'content-type': 'application/json'
      },
      success: function (res) {
        console.log(res);
        if(res.data.result == null) {
          that.setData({
            canLookFlag: false
          });
        } else {
          that.setData({
            canLookFlag: true,
            carData: res.data.result
          });
        }
      }
    })
  },
  lookBigImage(event) {
    let currentUrl = "https://changjienongye.cn/docs/static/" + event.currentTarget.dataset.src;
    var list = [];
    list.push(currentUrl);
    wx.previewImage({
      current: currentUrl,
      urls: list
    })
  },
  lookBigImage2(event) {
    let currentUrl = "https://changjienongye.cn/docs/static2/" + event.currentTarget.dataset.src;
    var list = [];
    list.push(currentUrl);
    wx.previewImage({
      current: currentUrl,
      urls: list
    })
  },
  getPhoneNumber(e) {
    var that = this;
    var pc = new WXBizDataCrypt(AppId, this.data.sessionkey)
    wx.getUserInfo({
      success: function (res) {
        var data = pc.decryptData(e.detail.encryptedData, e.detail.iv)
        console.log('手机号码: ', data.phoneNumber);
        app.data.loginTel = data.phoneNumber;
        that.upload_info();
      }
    })
  },
  getLogin: function () {
    var that = this;
    wx.login({
      success: function (res) {
        that.setData({
          code: res.code,
        })
        wx.request({
          url: 'https://changjienongye.cn/docs/getOpenId_zc.jsp?code=' + that.data.code,
          method: 'POST',
          header: {
            'content-type': 'application/json'
          },
          success: function (res) {
            that.setData({
              sessionkey: res.data.session_key,
              openid: res.data.openid,
            })
            app.data.openid = res.data.openid;
            app.data.sessionkey = res.data.sessionkey;
            that.getData();
          }
        })
      }
    })
  },
  upload_info: function () {
    var that = this;
      wx.request({
        url: app.data.appUrl + '/puser/checkMoblie',
        data: {
          mobile: app.data.loginTel
        },
        method: 'GET',
        header: {
          'content-type': 'application/json'
        },
        success: function (res) {
          app.data.loginId = res.data.id;
          wx.navigateTo({
            url: '../yuYue/yuYue',
          })
        }
      })
  },
})