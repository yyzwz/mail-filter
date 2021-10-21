<style lang="less">
</style>

<template>
  <div>
    <Card>
      <img src="https://changjienongye.cn/forestry/static/img/houseImages/house_115.jpg" />
    </Card>
  </div>
</template>

<script>
export default {
  name: "show",
  data() {
    return {
      loading: false,
      go: "",
      url: "",
      html: "",
      height: "525px"
    };
  },
  computed: {
    currNav() {
      return this.$store.state.app.currNav;
    }
  },
  methods: {
    initUrl() {
      let url;
      if (this.currNav == "doc") {
        url = "https://www.kancloud.cn/exrick/xboot/content";
      } else if (this.currNav == "xboot-show") {
        url = "http://xb.exrick.cn";
      } else if (this.currNav == "xpay") {
        url = "http://xpay.exrick.cn";
      } else if (this.currNav == "xmall") {
        url = "http://xmall.exrick.cn";
      }
      if (url) {
        this.url = url;
        this.go = url;
      }
    },
    handleGo() {
      let url = this.url;
      this.go = this.url;
    },
    handleOpen() {
      window.open(this.url);
    }
  },
  watch: {
    currNav(v, oldV) {
      this.initUrl();
    }
  },
  mounted() {
    // 计算高度
    let height = document.documentElement.clientHeight;
    this.height = Number(height - 217) + "px";
    this.initUrl();
  }
};
</script>
