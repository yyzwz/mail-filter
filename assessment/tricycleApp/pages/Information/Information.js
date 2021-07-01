const app = getApp();
var WXBizDataCrypt = require('../../utils/RdWXBizDataCrypt.js');
var AppId = 'wx3cc5ca75674a486b'
var AppSecret = '08544ce777869bfd261d85279e722963'
Page({
  data: {
    openId: '',
    shopName: '',
    shopDuty:'',
    remark: '',
    mobile: '',
    idCard: '',
    id: '',
    yyzz: '',
    date: '',
    address: '',
    sh: 0,
    images1: [] ,//存放图片的数组
    images2: [] ,//存放图片的数组
  },
  onLoad: function (options) {
    this.setData({
      openId: app.data.openId,
      shopName: app.data.shopName,
      shopDuty: app.data.shopDuty,
      remark: app.data.remark,
      mobile: app.data.mobile,
      idCard: app.data.idCard,
      id: app.data.id,
      yyzz: app.data.yyzz,
      date: app.data.date,
      address: app.data.address,
      sh: app.data.sh
    })
  },
  getPhoneNumber(e) {
    wx.showLoading({});
    var that = this;
    console.log(e.detail.errMsg)
    console.log(e.detail.iv)
    console.log(e.detail.encryptedData)
    var pc = new WXBizDataCrypt(AppId, app.data.sessionkey)
    var data = pc.decryptData(e.detail.encryptedData, e.detail.iv)
    console.log('手机号码: ', data.phoneNumber)
    app.data.mobile = data.phoneNumber;
    this.saveInfoFx();
  },
  saveInfoFx: function () {
    var that = this;
    var mobile_reg = /^((13[0-9])|(14[5|7])|(15([0-3]|[5-9]))|(18[0,5-9]))\\d{8}$/;
    var idcard_reg = /^[1-9]\d{5}(18|19|([23]\d))\d{2}((0[1-9])|(10|11|12))(([0-2][1-9])|10|20|30|31)\d{3}[0-9Xx]$/;
    if(that.data.shopName.length < 1) {
      wx.showToast({
        title: '店名为空',
      })
      return ;
    }
    if(that.data.shopDuty.length < 1) {
      wx.showToast({
        title: '负责人为空',
      })
      return ;
    }
    if(idcard_reg.test(that.data.idCard) == false) {
      wx.showToast({
        title: '身份证错误',
      })
      return ;
    }
    if(that.data.yyzz.length < 1) {
      wx.showToast({
        title: '营业执照为空',
      })
      return ;
    }
    if(that.data.address.length < 1) {
      wx.showToast({
        title: '店铺地址为空',
      })
      return ;
    }
    if(that.data.images1.length < 1) {
      wx.showToast({
        title: '请上传营业执照',
      })
      return ;
    }
    if(that.data.images2.length < 1) {
      wx.showToast({
        title: '请上传店铺照片',
      })
      return ;
    }
    var that = this;
    wx.showLoading({});
    wx.request({
      url: app.data.appUrl + '/seller/appUpdate',
      method: 'POST',
      data: {
        id: that.data.id,
        shopName: that.data.shopName,
        shopDuty: that.data.shopDuty,
        idCard: that.data.idCard,
        yyzz: that.data.yyzz,
        address: that.data.address,
        mobile: app.data.mobile
      },
      header: {
        "Content-Type": "application/x-www-form-urlencoded" // 默认值
      },
      success(res) {
        if(res.data.success) {
          app.data.shopName = that.data.shopName;
          app.data.id = that.data.id;
          app.data.shopDuty = that.data.shopDuty;
          app.data.idCard = that.data.idCard;
          app.data.yyzz = that.data.yyzz;
          app.data.address = that.data.address;
          wx.uploadFile({
            url: app.data.appUrl + '/fileUpload/uploadSellerFile?g=api&m=banana&a=upload_info',
            filePath: that.data.images1[0],
            method: 'POST',
            name: 'file',
            header: { "Content-Type": "application/x-www-form-urlencoded" },
            formData: {
              id: app.data.id,
              type: '1'
            },
            success: function (res) {
              wx.uploadFile({
                url: app.data.appUrl + '/fileUpload/uploadSellerFile?g=api&m=banana&a=upload_info',
                filePath: that.data.images2[0],
                method: 'POST',
                name: 'file',
                header: { "Content-Type": "application/x-www-form-urlencoded" },
                formData: {
                  id: app.data.id,
                  type: '2'
                },
                success: function (res) {
                  wx.navigateBack({
                    delta: 2,
                    success: function() {
                      wx.navigateTo({
                        url: '../main/main',
                        success: function() {
                          wx.showToast({
                            title: '更新成功',
                          })
                        }
                      })
                    }
                  })
                  console.log(res);
                },
                fail: function (res) {
                  console.log(res);
                },
              })
            },
            fail: function (res) {
              console.log(res);
            },
          })
        }else {
          // wx.showToast({
          //   title: '系统正在维护,请稍后再试',
          // })
        }
      },
      complete:function(){
        wx.hideLoading();
      }  
    })
  },
  shopName: function (e) {
    this.setData({
      shopName: e.detail.value
    })
  },
  shopDuty: function (e) {
    this.setData({
      shopDuty: e.detail.value
    })
  },
  // mobile: function (e) {
  //   this.setData({
  //     mobile: e.detail.value
  //   })
  // },
  idCard: function (e) {
    this.setData({
      idCard: e.detail.value
    })
  },
  yyzz: function (e) {
    this.setData({
      yyzz: e.detail.value
    })
  },
  address: function (e) {
    this.setData({
      address: e.detail.value
    })
  },
  // 选择照片
  chooseImage1: function (e) {
    var that = this;
    wx.chooseImage({
      sizeType: ['compressed'], //可选择原图或压缩后的图片
      sourceType: ['album', 'camera'], //可选择性开放访问相册、相机
      success: res => {
        if (this.data.images1.length <= 0) {
          if(res.tempFiles[0].size > 5242870) {
            wx.showToast({
              title: '发票图片最大5MB,请重新上传',
              icon: 'none',
              duration: 2000,
              mask: true
            })
          }else {
            const images = that.data.images1.concat(res.tempFilePaths)
            that.setData({
              images1: images
            })
          }
        } else {
          wx.showToast({
            title: '最多只能选择一张照片',
            icon: 'none',
            duration: 2000,
            mask: true
          })
        }
      }
    })
  },
  // 移除图片
  removeImage1(e) {
    const idx = e.target.dataset.idx;
    this.data.images1.splice(idx, 1);
    var del_image = this.data.images1;
    this.setData({
      images1: del_image
    })
  },
  // 预览图片
  handleImagePreview1(e) {
    const idx = e.target.dataset.idx
    const images = this.data.images1
    wx.previewImage({
      current: images[idx], //当前预览的图片
      urls: images, //所有要预览的图片
    })
  },
  chooseImage2: function (e) {
    var that = this;
    wx.chooseImage({
      sizeType: ['compressed'], //可选择原图或压缩后的图片
      sourceType: ['album', 'camera'], //可选择性开放访问相册、相机
      success: res => {
        if (this.data.images2.length <= 0) {
          if(res.tempFiles[0].size > 5242870) {
            wx.showToast({
              title: '发票图片最大5MB,请重新上传',
              icon: 'none',
              duration: 2000,
              mask: true
            })
          }else {
            const images = that.data.images2.concat(res.tempFilePaths)
            that.setData({
              images2: images
            })
          }
        } else {
          wx.showToast({
            title: '最多只能选择一张照片',
            icon: 'none',
            duration: 2000,
            mask: true
          })
        }
      }
    })
  },
  // 移除图片
  removeImage2(e) {
    const idx = e.target.dataset.idx;
    this.data.images2.splice(idx, 1);
    var del_image = this.data.images2;
    this.setData({
      images2: del_image
    })
  },
  // 预览图片
  handleImagePreview2(e) {
    const idx = e.target.dataset.idx
    const images = this.data.images2
    wx.previewImage({
      current: images[idx], //当前预览的图片
      urls: images, //所有要预览的图片
    })
  },
})