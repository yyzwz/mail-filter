const CompressionPlugin = require('compression-webpack-plugin');

module.exports = {
    // devServer: {
    //     host: '0.0.0.0',
    //     port: 9999,
    //     proxy: {
    //         '/xboot': {
    //             target: 'http://118.126.82.167:8888',  // 请求本地 需要xboot后端项目
    //             ws: true
    //         },
    //         '/foo': {
    //             target: '<other_url>'
    //         }
    //     }
    // },
    devServer: {
        https:true,
        pfxPassphrase: 'YPCQMM_changjie1314', // when develop with https need to provide server certificate to browser.
        // 证书在本项目下的相对路径
        pfx: './changjienongye.cn.pfx', // https://github.com/gitpod-io/gitpod/issues/26
        // win10 host文件中 对本机IP映射的域名，例如本机IP 192.168.0.22， host文件对该IP的映射域名为 xxx.com
        public: 'changjienongye.cn',
        //host: '47.111.160.108',
        host: '0.0.0.0',
        // host: '127.0.0.1',
        port: 8080,
        proxy: {
            '/xboot': {
                target: 'http://127.0.0.1:8888',  // 请求本地 需要xboot后端项目
                ws: true
            },
            '/foo': {
                target: '<other_url>'
            }
        },
        disableHostCheck: true
    },
    // 打包时不生成.map文件 避免看到源码
    productionSourceMap: false,
    // 部署优化
    configureWebpack: {
        // 使用CDN
        externals: {
            vue: 'Vue',
            'vue-i18n': 'VueI18n',
            axios: 'axios',
            'vue-router': 'VueRouter',
            vuex: 'Vuex',
            'view-design': 'iview',
            echarts: 'echarts',
            apexcharts: 'ApexCharts',
            'vue-apexcharts': 'VueApexCharts',
            xlsx: 'XLSX',
            dplayer: 'DPlayer',
            'print-js': 'printJS',
            html2canvas: 'html2canvas',
            'vue-json-pretty': 'VueJsonPretty',
            'vue-lazyload': 'VueLazyload',
            gitalk: 'Gitalk',
            'js-cookie': 'Cookies',
            wangEditor: 'wangEditor',
            quill: 'Quill',
            'sockjs-client': 'SockJS',
            vuedraggable: 'vuedraggable',
            viewerjs: 'Viewer'
        },
        // GZIP压缩
        plugins: [
            new CompressionPlugin({
                test: /\.js$|\.html$|\.css/, // 匹配文件
                threshold: 10240 // 对超过10k文件压缩
            })
        ]
    }
}