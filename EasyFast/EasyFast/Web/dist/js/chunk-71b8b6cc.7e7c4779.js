(window["webpackJsonp"]=window["webpackJsonp"]||[]).push([["chunk-71b8b6cc"],{"051f":function(t,i,e){"use strict";var a=e("856f"),n=e("55b1"),s=e("2cc9"),o=e("84e4"),r=e("cc7f"),c=e("2496"),l=Object(a["a"])("rate"),d=l[0],u=l[1];function b(t,i,e){return t>=i?"full":t+.5>=i&&e?"half":"void"}i["a"]=d({mixins:[o["a"],r["a"]],props:{size:[Number,String],color:String,gutter:[Number,String],readonly:Boolean,disabled:Boolean,allowHalf:Boolean,voidColor:String,iconPrefix:String,disabledColor:String,value:{type:Number,default:0},icon:{type:String,default:"star"},voidIcon:{type:String,default:"star-o"},count:{type:[Number,String],default:5},touchable:{type:Boolean,default:!0}},computed:{list:function(){for(var t=[],i=1;i<=this.count;i++)t.push(b(this.value,i,this.allowHalf));return t},sizeWithUnit:function(){return Object(n["a"])(this.size)},gutterWithUnit:function(){return Object(n["a"])(this.gutter)}},mounted:function(){this.bindTouchEvent(this.$el)},methods:{select:function(t){this.disabled||this.readonly||t===this.value||(this.$emit("input",t),this.$emit("change",t))},onTouchStart:function(t){var i=this;if(!this.readonly&&!this.disabled&&this.touchable){this.touchStart(t);var e=this.$refs.items.map((function(t){return t.getBoundingClientRect()})),a=[];e.forEach((function(t,e){i.allowHalf?a.push({score:e+.5,left:t.left},{score:e+1,left:t.left+t.width/2}):a.push({score:e+1,left:t.left})})),this.ranges=a}},onTouchMove:function(t){if(!this.readonly&&!this.disabled&&this.touchable&&(this.touchMove(t),"horizontal"===this.direction)){Object(s["c"])(t);var i=t.touches[0].clientX;this.select(this.getScoreByPosition(i))}},getScoreByPosition:function(t){for(var i=this.ranges.length-1;i>0;i--)if(t>this.ranges[i].left)return this.ranges[i].score;return this.allowHalf?.5:1},genStar:function(t,i){var e,a=this,n=this.$createElement,s=this.icon,o=this.color,r=this.count,l=this.voidIcon,d=this.disabled,b=this.voidColor,f=this.disabledColor,v=i+1,g="full"===t,h="void"===t;return this.gutterWithUnit&&v!==+r&&(e={paddingRight:this.gutterWithUnit}),n("div",{ref:"items",refInFor:!0,key:i,attrs:{role:"radio",tabindex:"0","aria-setsize":r,"aria-posinset":v,"aria-checked":String(!h)},style:e,class:u("item")},[n(c["a"],{attrs:{size:this.sizeWithUnit,name:g?s:l,color:d?f:g?o:b,classPrefix:this.iconPrefix,"data-score":v},class:u("icon",{disabled:d,full:g}),on:{click:function(){a.select(v)}}}),this.allowHalf&&n(c["a"],{attrs:{size:this.sizeWithUnit,name:h?l:s,color:d?f:h?b:o,classPrefix:this.iconPrefix,"data-score":v-.5},class:u("icon",["half",{disabled:d,full:!h}]),on:{click:function(){a.select(v-.5)}}})])}},render:function(){var t=this,i=arguments[0];return i("div",{class:u({readonly:this.readonly,disabled:this.disabled}),attrs:{tabindex:"0",role:"radiogroup"}},[this.list.map((function(i,e){return t.genStar(i,e)}))])}})},"0b7a":function(t,i,e){"use strict";var a=function(){var t=this,i=t.$createElement,e=t._self._c||i;return e("div",{staticClass:"nav-bar-wrap",class:{"not-fill":!t.fill}},[e("div",{staticClass:"nav-bar",style:{background:t.bg,color:t.color,paddingTop:t.$store.state.navHeight+"px"}},[e("div",{staticClass:"border",class:[t.border?"show":""],style:{background:t.bg}},[e("div",{staticClass:"nav-bar-left",on:{click:t.back}},[e("van-icon",{attrs:{name:"arrow-left",size:"22px"}})],1),e("div",{staticClass:"nav-bar-title"},[t._v(t._s(t.title))]),e("div",{staticClass:"nav-bar-left"})])])])},n=[],s=(e("053b"),e("73d1")),o=(e("ead7"),e("2496")),r={props:{title:{type:String},border:{type:Boolean,default:!0},bg:{type:String,default:"#fff"},color:{type:String,default:""},fixed:{type:Boolean,default:!0},fill:{type:Boolean,default:!0}},components:Object(s["a"])({},o["a"].name,o["a"]),data:function(){return{navHeight:{}}},mounted:function(){this.getNavHeight()},methods:{back:function(){this.$emit("left-click")},getNavHeight:function(){var t=this;this.$bridge.callhandler("NavHeight",null,(function(i){console.log(i,"参数回调"),t.navHeight=i.data}))}}},c=r,l=(e("5110"),e("9ca4")),d=Object(l["a"])(c,a,n,!1,null,null,null);i["a"]=d.exports},"124d":function(t,i,e){},1630:function(t,i,e){"use strict";e("e1d5"),e("1aa9")},"19fd":function(t,i){t.exports="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAADAAAAAwCAMAAABg3Am1AAAAaVBMVEVHcEw4xzg4yTg4yTg4yjg4yTg4yjhAz0A4yTg4yTg4yTgzzDM4yDg5xjk4yTg2yTY7zDs6xTo5yDk5yTk5yTk3yDc3yDc4yTg4yTg4yTg5xjlAv0A3yDc6xTou0S44yzg4yTg4yTg4yTh5cnmSAAAAInRSTlMATvH2af1bEPD6+QWDJP5CHh9wWXVdQX/p7RIIShYLSet7NjNK5gAAAJtJREFUSMftlssOgyAQRUcULD77tO/a3v//yC5q01RBmYTl3B3JOSEz3AVEkVLXPL4CKg5fFkBRMoQcAHIRRBBBBBEiCMfn6hMFAGo4nF4+/g53motHeCi3cL76rmhTF592/iFu1sG3c2MnE8P284saGzZZWq3RPP7f0LuQZz78eBNWjOwrmNAqDUYWXr4tkyfaN5rFE23Wsb45b16XKkoO2oXwAAAAAElFTkSuQmCC"},"1aa9":function(t,i,e){},"31a4":function(t,i,e){t.exports=e.p+"img/testImg@2x.dfe0540d.png"},"3dfd":function(t,i){t.exports="data:image/png;base64,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"},5110:function(t,i,e){"use strict";var a=e("124d"),n=e.n(a);n.a},6926:function(t,i,e){"use strict";e("e1d5"),e("de0a"),e("1b19"),e("edfe")},7113:function(t,i,e){"use strict";var a=e("fecb"),n=e.n(a);n.a},8750:function(t,i){t.exports="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAADAAAAAwCAMAAABg3Am1AAAAaVBMVEVHcEzySEXxR0XwRkXwRkTxR0XxRkbvQEDxR0XxR0XxR0XxRkTxR0f/MzPxR0XwRkbxR0TxR0XxSEXySEbvSkLuRETxR0fwRkT/QEDxRkbzRkbxR0XvR0fxRkToRkbxR0XxR0XxSEXxR0UfDhRyAAAAInRSTlMATvH2af1bEPD6+YMkBf5CcF1ZdR8eEnsISRbtQX8L6etKbVRVLAAAAJhJREFUSMft1rkOgzAQRVGwMcSsWci+3///yBQhipTYmJEo/Tqkc0UBxSTJTOu3Mr9pTSbxSwBBkYGoGDzk0/zq4zGTitzwLdYyDzYN+dSCpPj1YI9j/vnnQXd+32kc0xefvymcOx88wcntaXe+V1wfi/cUgBoe7vvwxygACsHfGoMYxCAGMQiuKaFsJKdABZXs2Kjruc6cF1D1KkpN0+8tAAAAAElFTkSuQmCC"},ae53:function(t,i,e){"use strict";var a=e("03de"),n=e("23c4"),s=e.n(n),o=e("856f"),r=e("76ae"),c=e("a6bc"),l=e("8343"),d=e("2496"),u=e("f55e"),b=Object(o["a"])("button"),f=b[0],v=b[1];function g(t,i,e,a){var n,o=i.tag,b=i.icon,f=i.type,g=i.color,h=i.plain,A=i.disabled,p=i.loading,W=i.hairline,y=i.loadingText,m={};function X(t){p||A||(Object(r["a"])(a,"click",t),Object(l["a"])(a))}function x(t){Object(r["a"])(a,"touchstart",t)}g&&(m.color=h?g:c["d"],h||(m.background=g),-1!==g.indexOf("gradient")?m.border=0:m.borderColor=g);var B=[v([f,i.size,{plain:h,loading:p,disabled:A,hairline:W,block:i.block,round:i.round,square:i.square}]),(n={},n[c["b"]]=W,n)];function T(){var a,n=[];return p?n.push(t(u["a"],{class:v("loading"),attrs:{size:i.loadingSize,type:i.loadingType,color:"currentColor"}})):b&&n.push(t(d["a"],{attrs:{name:b,classPrefix:i.iconPrefix},class:v("icon")})),a=p?y:e.default?e.default():i.text,a&&n.push(t("span",{class:v("text")},[a])),n}return t(o,s()([{style:m,class:B,attrs:{type:i.nativeType,disabled:A},on:{click:X,touchstart:x}},Object(r["b"])(a)]),[t("div",{class:v("content")},[T()])])}g.props=Object(a["a"])({},l["c"],{text:String,icon:String,color:String,block:Boolean,plain:Boolean,round:Boolean,square:Boolean,loading:Boolean,hairline:Boolean,disabled:Boolean,iconPrefix:String,nativeType:String,loadingText:String,loadingType:String,tag:{type:String,default:"button"},type:{type:String,default:"default"},size:{type:String,default:"normal"},loadingSize:{type:String,default:"20px"}}),i["a"]=f(g)},b328:function(t,i,e){},c661:function(t,i,e){"use strict";e.r(i);var a,n=function(){var t=this,i=t.$createElement,a=t._self._c||i;return a("div",{staticClass:"brace-fixed"},[a("nav-bar",{attrs:{title:"商店介绍"},on:{"left-click":t.onClickLeft}}),t.loading?a("Skeleton",{style:{paddingTop:t.$store.state.navHeight+"px"}}):t._e(),t.loading?t._e():a("div",{style:{paddingTop:t.$store.state.navHeight+"px"}},[a("div",{staticClass:"header bg-white"},[a("div",{staticClass:"shop-intro"},[a("div",{staticClass:"logo"},[a("img",{directives:[{name:"lazy",rawName:"v-lazy",value:e("31a4"),expression:"require('@/assets/testImg@2x.png')"}],attrs:{alt:""}})]),t._m(0)]),a("div",{staticClass:"address"},[a("img",{directives:[{name:"lazy",rawName:"v-lazy",value:t.addressIcon,expression:"addressIcon"}],attrs:{alt:""}}),a("div",[t._v("深圳市南山区大新时代大厦")])])]),a("div",{staticClass:"content margin-top"},[a("van-tabs",{attrs:{"line-width":"50","title-active-color":"#F14745",scrollspy:"",border:!1},model:{value:t.active,callback:function(i){t.active=i},expression:"active"}},[a("van-tab",{attrs:{title:"基础信息"}},[a("div",{staticClass:"margin-top-sm bg-white tab1"},[a("div",{staticClass:"title-1"},[t._v("企业身份认证")]),a("ul",{staticClass:"padding-lr info"},[a("li",[a("div",[t._v("公司名称:")]),a("div",[t._v(" 易发（深圳）互联网贸易有限公司 ")])]),a("li",[a("div",[t._v("经营地址：")]),a("div",[t._v("广东省深圳市南山区大新时代广场A座 成立日期")])]),a("li",[a("div",[t._v("成立日期：")]),a("div",[t._v("2020年7月22日")])]),a("li",[a("div",[t._v("经营范围：")]),a("div",[t._v(" 广告，金融，医疗，互联网销售；文化，艺术活动策划；互联网贸易批发啊；文具用品批发，互联网软件研发；广告设计，制作，代理，发布； ")])])]),a("div",{staticClass:"rate "},[a("div",[t._v("供应商等级:")]),a("van-rate",{attrs:{size:20,color:"#F44746",gutter:"11","void-icon":"star","void-color":"#D6D6D8"},model:{value:t.value,callback:function(i){t.value=i},expression:"value"}})],1),a("div",{staticClass:"rate-two"},[a("div",[t._v("供应商等级:")]),a("ul",[a("li",[a("div",[t._v("发货速度")]),a("div",[t._v(" 13% "),a("img",{directives:[{name:"lazy",rawName:"v-lazy",value:t.upIcon,expression:"upIcon"}],attrs:{alt:""}})])]),a("li",[a("div",[t._v("响应速度")]),a("div",[t._v(" 13% "),a("img",{directives:[{name:"lazy",rawName:"v-lazy",value:t.upIcon,expression:"upIcon"}],attrs:{alt:""}})])]),a("li",[a("div",[t._v("发货速度")]),a("div",[t._v(" 13% "),a("img",{directives:[{name:"lazy",rawName:"v-lazy",value:t.upIcon,expression:"upIcon"}],attrs:{alt:""}})])]),a("li",[a("div",[t._v("响应速度")]),a("div",[t._v(" 13% "),a("img",{directives:[{name:"lazy",rawName:"v-lazy",value:t.upIcon,expression:"upIcon"}],attrs:{alt:""}})])])])])])]),a("van-tab",{attrs:{title:"工厂介绍"}},[a("div",{staticClass:"tab2 border-top-sm bg-white"},[a("div",{staticClass:"title-2"},[t._v("工厂介绍")]),a("ul",{staticClass:"padding-lr padding-bottom-lg"},[a("li",[a("div",[t._v("厂房面积：")]),a("div",[t._v("30000平方米")])]),a("li",[a("div",[t._v("研发人数：")]),a("div",[t._v("500人")])]),a("li",[a("div",[t._v("加工方式：")]),a("div",[t._v("自主研发，来料加工")])]),a("li",[a("div",[t._v("加工工艺：")]),a("div",[t._v(" 无机非金属材料加工 ")])]),a("li",[a("div",[t._v("月产量：")]),a("div",[t._v(" 20000件 ")])]),a("li",[a("div",[t._v("年营业额：")]),a("div",[t._v(" 人民币31万元/年 ~ 50万元/每年 ")])])])])])],1)],1),a("van-goods-action",{attrs:{"safe-area-inset-bottom":""}},[a("div",{staticClass:"footer-button"},[a("van-button",{attrs:{type:"default"},on:{click:t.goIM}},[t._v("联系商家")]),a("a",{attrs:{href:"tel://22"}},[t._v("电话联系")])],1)])],1)],1)},s=[function(){var t=this,i=t.$createElement,e=t._self._c||i;return e("div",{staticClass:"intro"},[e("div",{staticClass:"name"},[t._v("张飞旗舰店")]),e("div",{staticClass:"tag"},[e("div",[t._v("7天无理由退货")]),e("div",[t._v("原厂货源")])])])}],o=(e("053b"),e("e18c"),e("73d1")),r=(e("ef80"),e("ae53")),c=(e("1630"),e("cc15")),l=(e("6926"),e("051f")),d=(e("158f"),e("f047")),u=(e("f0ab"),e("4f4a")),b=e("0b7a"),f={components:(a={},Object(o["a"])(a,u["a"].name,u["a"]),Object(o["a"])(a,d["a"].name,d["a"]),Object(o["a"])(a,l["a"].name,l["a"]),Object(o["a"])(a,c["a"].name,c["a"]),Object(o["a"])(a,r["a"].name,r["a"]),Object(o["a"])(a,"navBar",b["a"]),Object(o["a"])(a,"Skeleton",(function(){return e.e("chunk-3066dc3c").then(e.bind(null,"395c"))})),a),data:function(){return{upIcon:e("8750"),bottomIcon:e("19fd"),addressIcon:e("3dfd"),active:0,loading:!1,transitionName:"",value:3}},created:function(){var t=this;setTimeout((function(){t.loading=!1}),800)},methods:{goIM:function(){this.$parent.goIM()},onClickLeft:function(){this.$router.go(-1)}}},v=f,g=(e("7113"),e("9ca4")),h=Object(g["a"])(v,n,s,!1,null,null,null);i["default"]=h.exports},cc15:function(t,i,e){"use strict";var a=e("856f"),n=e("ac44"),s=Object(a["a"])("goods-action"),o=s[0],r=s[1];i["a"]=o({mixins:[Object(n["b"])("vanGoodsAction")],props:{safeAreaInsetBottom:{type:Boolean,default:!0}},render:function(){var t=arguments[0];return t("div",{class:r({unfit:!this.safeAreaInsetBottom})},[this.slots()])}})},cc7f:function(t,i,e){"use strict";e.d(i,"a",(function(){return a}));var a={inject:{vanField:{default:null}},watch:{value:function(){var t=this.vanField;t&&(t.resetValidation(),t.validateWithTrigger("onChange"))}},created:function(){var t=this.vanField;t&&!t.children&&(t.children=this)}}},ead7:function(t,i,e){"use strict";e("e1d5"),e("de0a"),e("1b19")},edfe:function(t,i,e){},ef80:function(t,i,e){"use strict";e("e1d5"),e("de0a"),e("1b19"),e("e837"),e("b328")},fecb:function(t,i,e){}}]);