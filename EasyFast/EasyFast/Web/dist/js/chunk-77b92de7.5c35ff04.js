(window["webpackJsonp"]=window["webpackJsonp"]||[]).push([["chunk-77b92de7"],{"0b7a":function(e,t,i){"use strict";var a=function(){var e=this,t=e.$createElement,i=e._self._c||t;return i("div",{staticClass:"nav-bar-wrap",class:{"not-fill":!e.fill}},[i("div",{staticClass:"nav-bar",style:{background:e.bg,color:e.color,paddingTop:e.$store.state.navHeight+"px"}},[i("div",{staticClass:"border",class:[e.border?"show":""],style:{background:e.bg}},[i("div",{staticClass:"nav-bar-left",on:{click:e.back}},[i("van-icon",{attrs:{name:"arrow-left",size:"22px"}})],1),i("div",{staticClass:"nav-bar-title"},[e._v(e._s(e.title))]),i("div",{staticClass:"nav-bar-left"})])])])},s=[],o=(i("053b"),i("73d1")),n=(i("ead7"),i("2496")),r={props:{title:{type:String},border:{type:Boolean,default:!0},bg:{type:String,default:"#fff"},color:{type:String,default:""},fixed:{type:Boolean,default:!0},fill:{type:Boolean,default:!0}},components:Object(o["a"])({},n["a"].name,n["a"]),data:function(){return{navHeight:{}}},mounted:function(){this.getNavHeight()},methods:{back:function(){this.$emit("left-click")},getNavHeight:function(){var e=this;this.$bridge.callhandler("NavHeight",null,(function(t){console.log(t,"参数回调"),e.navHeight=t.data}))}}},l=r,d=(i("5110"),i("9ca4")),c=Object(d["a"])(l,a,s,!1,null,null,null);t["a"]=c.exports},1630:function(e,t,i){"use strict";i("e1d5"),i("1aa9")},"1aa9":function(e,t,i){var a=i("6195");"string"===typeof a&&(a=[[e.i,a,""]]),a.locals&&(e.exports=a.locals);var s=i("85cb").default;s("38b20bb1",a,!0,{sourceMap:!1,shadowMode:!1})},"316c":function(e,t,i){"use strict";i.r(t);var a,s=function(){var e=this,t=e.$createElement,a=e._self._c||t;return a("div",{staticClass:"logistics brace-fixed"},[a("nav-bar",{attrs:{title:"填写退货物流"},on:{"left-click":e.backPage}}),a("div",{staticClass:"delivery-address border-top-sm bg-white"},[a("div",{staticClass:"icon"},[a("img",{directives:[{name:"lazy",rawName:"v-lazy",value:e.adIcon,expression:"adIcon"}],attrs:{alt:""}})]),e._m(0)]),a("div",{staticClass:"goods-list bg-white  border-top-sm "},e._l(2,(function(t){return a("div",{key:t,staticClass:"goods-item padding-lr"},[a("div",[a("van-checkbox",{attrs:{"icon-size":"20","checked-color":"#F14745"},model:{value:e.checked,callback:function(t){e.checked=t},expression:"checked"}})],1),a("div",{staticClass:"photo  "},[a("img",{directives:[{name:"lazy",rawName:"v-lazy",value:i("31a4"),expression:"require('@/assets/testImg@2x.png')"}],attrs:{alt:""}})]),a("div",{staticClass:"info"},[a("div",{staticClass:"name"},[e._v(" 商品名称复古宫廷风台灯具灯罩，可 以换行，商品名称复古宫廷风台灯具 ")]),a("div",{staticClass:"number"},[a("div",{staticClass:"left"},[e._v("蓝色l")]),a("div",{staticClass:"right"},[a("span",{staticClass:"font-24"},[e._v("×200")]),a("van-stepper",{attrs:{"checked-color":"#F14745"},model:{value:e.value,callback:function(t){e.value=t},expression:"value"}})],1)])])])})),0),a("div",{staticClass:"form bg-white"},[a("van-field",{attrs:{label:"物流单号","label-width":"1.7rem",placeholder:"请填写物流单号"},model:{value:e.value,callback:function(t){e.value=t},expression:"value"}}),a("van-cell",{attrs:{title:"物流公司","is-link":"","arrow-direction":"down",value:"请选择"}}),a("van-field",{attrs:{label:"联系电话","label-width":"1.7rem",placeholder:"请填写联系电话",border:!1},model:{value:e.value,callback:function(t){e.value=t},expression:"value"}}),a("div",{staticClass:"padding-lr bg-white textarea-wrap"},[a("van-field",{attrs:{rows:"5",autosize:"",type:"textarea",maxlength:"200","show-word-limit":"",placeholder:"退款说明（选填）"},model:{value:e.message,callback:function(t){e.message=t},expression:"message"}})],1),a("div",{staticClass:"uploader-wrap padding-lr"},[a("div",{staticClass:"u-title text-gray"},[e._v("上传凭证(最多3张）")]),a("van-uploader",{attrs:{"before-read":e.beforeRead,"max-count":"3"},model:{value:e.fileList,callback:function(t){e.fileList=t},expression:"fileList"}})],1)],1),a("van-goods-action",{attrs:{"safe-area-inset-bottom":""}},[a("van-button",{staticClass:"submit-btn",attrs:{type:"danger",block:""}},[e._v("提交")])],1)],1)},o=[function(){var e=this,t=e.$createElement,i=e._self._c||t;return i("div",{staticClass:"user"},[i("div",{staticClass:"name"},[i("div",[e._v("李啦啦")]),i("div",[e._v("18737528967")])]),i("div",{staticClass:"address"},[e._v("广东省 深圳市 南山区 桃源街道 桃花小苑B708")])])}],n=(i("053b"),i("73d1")),r=(i("ef80"),i("ae53")),l=(i("1630"),i("cc15")),d=(i("21a5"),i("063f")),c=(i("4fbc"),i("ca00")),h=(i("f820"),i("4959")),b=i("0b7a"),f={data:function(){return{adIcon:i("bb61"),fileList:[],value:""}},components:(a={navBar:b["a"]},Object(n["a"])(a,h["a"].name,h["a"]),Object(n["a"])(a,c["a"].name,c["a"]),Object(n["a"])(a,d["a"].name,d["a"]),Object(n["a"])(a,l["a"].name,l["a"]),Object(n["a"])(a,r["a"].name,r["a"]),a),methods:{backPage:function(){this.$router.go(-1)},beforeRead:function(){return!0}}},g=f,m=(i("42c8"),i("9ca4")),p=Object(m["a"])(g,s,o,!1,null,null,null);t["default"]=p.exports},"31a4":function(e,t,i){e.exports=i.p+"img/testImg@2x.dfe0540d.png"},"42c8":function(e,t,i){"use strict";var a=i("6d37"),s=i.n(a);s.a},"4ba0":function(e,t,i){var a=i("a1a8");t=a(!1),t.push([e.i,'.logistics{background:#fcf9fc}.logistics .delivery-address{display:-webkit-box;display:-webkit-flex;display:-ms-flexbox;display:flex;-webkit-box-pack:center;-webkit-justify-content:center;-ms-flex-pack:center;justify-content:center;-webkit-box-align:center;-webkit-align-items:center;-ms-flex-align:center;align-items:center;position:relative;overflow:hidden;padding:.52rem 0 .56rem}.logistics .delivery-address:before{position:absolute;right:0;bottom:0;left:-11%;height:.10667rem;width:120%;background:-webkit-repeating-linear-gradient(135deg,#f84a73,#f84a73 25%,transparent 0,transparent 50%,#3389ff 0,#3389ff 75%,transparent 0,transparent);background:repeating-linear-gradient(-45deg,#f84a73,#f84a73 25%,transparent 0,transparent 50%,#3389ff 0,#3389ff 75%,transparent 0,transparent);-webkit-transform:skewX(-45deg);-ms-transform:skewX(-45deg);transform:skewX(-45deg);background-size:1.33333rem;content:""}.logistics .delivery-address .icon{width:1.37333rem;display:-webkit-box;display:-webkit-flex;display:-ms-flexbox;display:flex;-webkit-box-pack:center;-webkit-justify-content:center;-ms-flex-pack:center;justify-content:center;-webkit-box-align:center;-webkit-align-items:center;-ms-flex-align:center;align-items:center}.logistics .delivery-address .icon img{width:.69333rem;height:.69333rem}.logistics .delivery-address .user{-webkit-box-flex:1;-webkit-flex:1;-ms-flex:1;flex:1}.logistics .delivery-address .user .name{display:-webkit-box;display:-webkit-flex;display:-ms-flexbox;display:flex;margin-bottom:.30667rem;font-size:16PX}[data-dpr="2"] .logistics .delivery-address .user .name{font-size:32PX}[data-dpr="3"] .logistics .delivery-address .user .name{font-size:64PX}.logistics .delivery-address .user .name>div{line-height:1}.logistics .delivery-address .user .name>div:first-child{margin-right:.69333rem}.logistics .delivery-address .user .address{font-size:13PX}[data-dpr="2"] .logistics .delivery-address .user .address{font-size:26PX}[data-dpr="3"] .logistics .delivery-address .user .address{font-size:52PX}.logistics .delivery-address .right-icon{padding:0 .56rem 0 .46667rem}.logistics .delivery-address .right-icon img{height:.4rem;width:.4rem}.logistics .goods-list{padding-top:.53333rem;padding-bottom:.13333rem}.logistics .goods-list .goods-item{padding-bottom:.4rem}.logistics .goods-list .goods-item,.logistics .goods-list .goods-item .photo{display:-webkit-box;display:-webkit-flex;display:-ms-flexbox;display:flex;-webkit-box-pack:center;-webkit-justify-content:center;-ms-flex-pack:center;justify-content:center;-webkit-box-align:center;-webkit-align-items:center;-ms-flex-align:center;align-items:center}.logistics .goods-list .goods-item .photo{background:#f1f5f7;min-width:2.13333rem;max-width:2.13333rem;height:2.13333rem}.logistics .goods-list .goods-item .photo img{width:100%;border-radius:.13333rem}.logistics .goods-list .goods-item .info{display:-webkit-box;display:-webkit-flex;display:-ms-flexbox;display:flex;-webkit-box-pack:center;-webkit-justify-content:center;-ms-flex-pack:center;justify-content:center;-webkit-box-align:center;-webkit-align-items:center;-ms-flex-align:center;align-items:center;-webkit-box-orient:vertical;-webkit-box-direction:normal;-webkit-flex-flow:column;-ms-flex-flow:column;flex-flow:column;-webkit-box-flex:1;-webkit-flex:1;-ms-flex:1;flex:1;padding-left:.34667rem}.logistics .goods-list .goods-item .info .name{text-overflow:ellipsis;display:-webkit-box;-webkit-line-clamp:2;-webkit-box-orient:vertical;overflow:hidden;margin-bottom:.24rem}.logistics .goods-list .goods-item .info .number{display:-webkit-box;display:-webkit-flex;display:-ms-flexbox;display:flex;-webkit-box-pack:justify;-webkit-justify-content:space-between;-ms-flex-pack:justify;justify-content:space-between;-webkit-box-align:center;-webkit-align-items:center;-ms-flex-align:center;align-items:center;width:100%;color:#aeaeae}.logistics .goods-list .goods-item .info .number .left{font-size:12PX}[data-dpr="2"] .logistics .goods-list .goods-item .info .number .left{font-size:24PX}[data-dpr="3"] .logistics .goods-list .goods-item .info .number .left{font-size:48PX}.logistics .goods-list .goods-item .info .number .right{font-size:13PX}[data-dpr="2"] .logistics .goods-list .goods-item .info .number .right{font-size:26PX}[data-dpr="3"] .logistics .goods-list .goods-item .info .number .right{font-size:52PX}.logistics .textarea-wrap .van-cell{background:#fafafa;border-radius:.26667rem}.logistics .uploader-wrap{padding-bottom:.53333rem}.logistics .uploader-wrap .u-title{padding:.53333rem 0 .41333rem;font-size:13PX}[data-dpr="2"] .logistics .uploader-wrap .u-title{font-size:26PX}[data-dpr="3"] .logistics .uploader-wrap .u-title{font-size:52PX}.logistics .submit-btn{height:1.33333rem;font-size:16PX}[data-dpr="2"] .logistics .submit-btn{font-size:32PX}[data-dpr="3"] .logistics .submit-btn{font-size:64PX}',""]),e.exports=t},5110:function(e,t,i){"use strict";var a=i("92c7"),s=i.n(a);s.a},6195:function(e,t,i){var a=i("a1a8");t=a(!1),t.push([e.i,".van-goods-action{position:fixed;right:0;bottom:0;left:0;display:-webkit-box;display:-webkit-flex;display:-ms-flexbox;display:flex;-webkit-box-align:center;-webkit-align-items:center;-ms-flex-align:center;align-items:center;box-sizing:content-box;height:1.33333rem;padding-bottom:constant(safe-area-inset-bottom);padding-bottom:env(safe-area-inset-bottom);background-color:#fff}.van-goods-action--unfit{padding-bottom:0}",""]),e.exports=t},"6d37":function(e,t,i){var a=i("4ba0");"string"===typeof a&&(a=[[e.i,a,""]]),a.locals&&(e.exports=a.locals);var s=i("85cb").default;s("2be43618",a,!0,{sourceMap:!1,shadowMode:!1})},"7cce":function(e,t,i){var a=i("a1a8");t=a(!1),t.push([e.i,'.nav-bar-wrap{position:relative;height:1.17333rem}.nav-bar-wrap.not-fill{position:inherit;height:0}.nav-bar-wrap .nav-bar{position:fixed;top:0;left:0;height:1.17333rem;width:100%;z-index:99;display:-webkit-box;display:-webkit-flex;display:-ms-flexbox;display:flex;-webkit-box-pack:justify;-webkit-justify-content:space-between;-ms-flex-pack:justify;justify-content:space-between;-webkit-box-align:center;-webkit-align-items:center;-ms-flex-align:center;align-items:center}.nav-bar-wrap .nav-bar .show{position:relative;height:1.17333rem}.nav-bar-wrap .nav-bar .show:after{content:"";pointer-events:none;box-sizing:border-box;position:absolute;width:200%;height:200%;left:0;top:0;border-bottom:1PX solid #e5e5e5;-webkit-transform-origin:0 0;-webkit-transform:scale(.5);-ms-transform:scale(.5);transform:scale(.5);-ms-transform-origin:0 0;transform-origin:0 0;z-index:10}@media only screen and (-webkit-min-device-pixel-ratio:2){.nav-bar-wrap .nav-bar .show:after{-webkit-transform:scale(.5);-ms-transform:scale(.5);transform:scale(.5)}}@media only screen and (-webkit-min-device-pixel-ratio:3){.nav-bar-wrap .nav-bar .show:after{-webkit-transform:scale(.5);-ms-transform:scale(.5);transform:scale(.5)}}.nav-bar-wrap .nav-bar .border{display:-webkit-box;display:-webkit-flex;display:-ms-flexbox;display:flex;-webkit-box-pack:justify;-webkit-justify-content:space-between;-ms-flex-pack:justify;justify-content:space-between;-webkit-box-align:center;-webkit-align-items:center;-ms-flex-align:center;align-items:center;width:100%}.nav-bar-wrap .nav-bar .border .nav-bar-left{padding:0 .4rem;width:2rem;box-sizing:border-box}.nav-bar-wrap .nav-bar .border .nav-bar-left img{height:.56rem}.nav-bar-wrap .nav-bar .border .nav-bar-title{font-size:17PX}[data-dpr="2"] .nav-bar-wrap .nav-bar .border .nav-bar-title{font-size:34PX}[data-dpr="3"] .nav-bar-wrap .nav-bar .border .nav-bar-title{font-size:68PX}',""]),e.exports=t},"92c7":function(e,t,i){var a=i("7cce");"string"===typeof a&&(a=[[e.i,a,""]]),a.locals&&(e.exports=a.locals);var s=i("85cb").default;s("994d2012",a,!0,{sourceMap:!1,shadowMode:!1})},bb61:function(e,t){e.exports="data:image/png;base64,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"},cc15:function(e,t,i){"use strict";var a=i("856f"),s=i("ac44"),o=Object(a["a"])("goods-action"),n=o[0],r=o[1];t["a"]=n({mixins:[Object(s["b"])("vanGoodsAction")],props:{safeAreaInsetBottom:{type:Boolean,default:!0}},render:function(){var e=arguments[0];return e("div",{class:r({unfit:!this.safeAreaInsetBottom})},[this.slots()])}})},ead7:function(e,t,i){"use strict";i("e1d5"),i("de0a"),i("1b19")}}]);