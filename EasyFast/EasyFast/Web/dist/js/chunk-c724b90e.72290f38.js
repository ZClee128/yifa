(window["webpackJsonp"]=window["webpackJsonp"]||[]).push([["chunk-c724b90e"],{"06c6":function(t,e,i){"use strict";i("e1d5"),i("e837"),i("36b0")},"0b7a":function(t,e,i){"use strict";var n=function(){var t=this,e=t.$createElement,i=t._self._c||e;return i("div",{staticClass:"nav-bar-wrap",class:{"not-fill":!t.fill},style:{paddingTop:t.$store.state.navHeight+"px"}},[i("div",{staticClass:"nav-bar",style:{background:t.bg,color:t.color,paddingTop:t.$store.state.navHeight+"px"}},[i("div",{staticClass:"border",class:[t.border?"show":""],style:{background:t.bg}},[i("div",{staticClass:"nav-bar-left",on:{click:t.back}},[i("van-icon",{attrs:{name:"arrow-left",size:"22px"}})],1),i("div",{staticClass:"nav-bar-title"},[t._v(t._s(t.title))]),i("div",{staticClass:"nav-bar-left"})])])])},a=[],s=(i("053b"),i("73d1")),r=(i("ead7"),i("2496")),o={props:{title:{type:String},border:{type:Boolean,default:!0},bg:{type:String,default:"#fff"},color:{type:String,default:""},fixed:{type:Boolean,default:!0},fill:{type:Boolean,default:!0}},components:Object(s["a"])({},r["a"].name,r["a"]),data:function(){return{navHeight:{}}},mounted:function(){this.getNavHeight()},methods:{back:function(){this.$emit("left-click")},getNavHeight:function(){var t=this;this.$bridge.callhandler("NavHeight",null,(function(e){console.log(e,"参数回调"),t.navHeight=e.data}))},goIM:function(){}}},c=o,l=(i("5110"),i("9ca4")),u=Object(l["a"])(c,n,a,!1,null,null,null);e["a"]=u.exports},"124d":function(t,e,i){},"31a4":function(t,e,i){t.exports=i.p+"img/testImg@2x.dfe0540d.png"},"36b0":function(t,e,i){},3766:function(t,e,i){"use strict";i.d(e,"a",(function(){return n}));var n={icon:String,size:String,center:Boolean,isLink:Boolean,required:Boolean,clickable:Boolean,iconPrefix:String,titleStyle:null,titleClass:null,valueClass:null,labelClass:null,title:[Number,String],value:[Number,String],label:[Number,String],arrowDirection:String,border:{type:Boolean,default:!0}}},"37a2":function(t,e,i){"use strict";var n=i("e2ac"),a=i.n(n);a.a},"3eab":function(t,e,i){"use strict";var n=function(){var t=this,e=t.$createElement,i=t._self._c||e;return i("div",{staticClass:"cu-progress"},[i("div",{staticClass:"percentage",style:[{width:t.loading?t.percentage:""}]}),i("div",{staticClass:"surplus"},[t._v(t._s(t.text))])])},a=[],s={data:function(){return{loading:!1}},mounted:function(){var t=this;setTimeout((function(){t.loading=!0}),500)},props:["percentage","text"]},r=s,o=(i("585b"),i("9ca4")),c=Object(o["a"])(r,n,a,!1,null,null,null);e["a"]=c.exports},"40be":function(t,e,i){"use strict";var n=i("856f"),a=i("b401"),s=i("98ae"),r=1e3,o=60*r,c=60*o,l=24*c;function u(t){var e=Math.floor(t/l),i=Math.floor(t%l/c),n=Math.floor(t%c/o),a=Math.floor(t%o/r),s=Math.floor(t%r);return{days:e,hours:i,minutes:n,seconds:a,milliseconds:s}}function d(t,e){var i=e.days,n=e.hours,a=e.minutes,r=e.seconds,o=e.milliseconds;if(-1===t.indexOf("DD")?n+=24*i:t=t.replace("DD",Object(s["b"])(i)),-1===t.indexOf("HH")?a+=60*n:t=t.replace("HH",Object(s["b"])(n)),-1===t.indexOf("mm")?r+=60*a:t=t.replace("mm",Object(s["b"])(a)),-1===t.indexOf("ss")?o+=1e3*r:t=t.replace("ss",Object(s["b"])(r)),-1!==t.indexOf("S")){var c=Object(s["b"])(o,3);t=-1!==t.indexOf("SSS")?t.replace("SSS",c):-1!==t.indexOf("SS")?t.replace("SS",c.slice(0,2)):t.replace("S",c.charAt(0))}return t}function h(t,e){return Math.floor(t/1e3)===Math.floor(e/1e3)}var f=Object(n["a"])("count-down"),g=f[0],b=f[1];e["a"]=g({props:{millisecond:Boolean,time:{type:[Number,String],default:0},format:{type:String,default:"HH:mm:ss"},autoStart:{type:Boolean,default:!0}},data:function(){return{remain:0}},computed:{timeData:function(){return u(this.remain)},formattedTime:function(){return d(this.format,this.timeData)}},watch:{time:{immediate:!0,handler:"reset"}},activated:function(){this.keepAlivePaused&&(this.counting=!0,this.keepAlivePaused=!1,this.tick())},deactivated:function(){this.counting&&(this.pause(),this.keepAlivePaused=!0)},beforeDestroy:function(){this.pause()},methods:{start:function(){this.counting||(this.counting=!0,this.endTime=Date.now()+this.remain,this.tick())},pause:function(){this.counting=!1,Object(a["a"])(this.rafId)},reset:function(){this.pause(),this.remain=+this.time,this.autoStart&&this.start()},tick:function(){this.millisecond?this.microTick():this.macroTick()},microTick:function(){var t=this;this.rafId=Object(a["c"])((function(){t.counting&&(t.setRemain(t.getRemain()),t.remain>0&&t.microTick())}))},macroTick:function(){var t=this;this.rafId=Object(a["c"])((function(){if(t.counting){var e=t.getRemain();h(e,t.remain)&&0!==e||t.setRemain(e),t.remain>0&&t.macroTick()}}))},getRemain:function(){return Math.max(this.endTime-Date.now(),0)},setRemain:function(t){this.remain=t,this.$emit("change",this.timeData),0===t&&(this.pause(),this.$emit("finish"))}},render:function(){var t=arguments[0];return t("div",{class:b()},[this.slots("default",this.timeData)||this.formattedTime])}})},"4fbc":function(t,e,i){"use strict";i("e1d5"),i("de0a"),i("1b19"),i("c2c3")},5110:function(t,e,i){"use strict";var n=i("124d"),a=i.n(n);a.a},"55ae":function(t,e,i){"use strict";var n=i("856f"),a=i("2cc9"),s=i("1412"),r=i("84e4"),o=i("f55e"),c=Object(n["a"])("pull-refresh"),l=c[0],u=c[1],d=c[2],h=50,f=["pulling","loosing","success"];e["a"]=l({mixins:[r["a"]],props:{disabled:Boolean,successText:String,pullingText:String,loosingText:String,loadingText:String,value:{type:Boolean,required:!0},successDuration:{type:[Number,String],default:500},animationDuration:{type:[Number,String],default:300},headHeight:{type:[Number,String],default:h}},data:function(){return{status:"normal",distance:0,duration:0}},computed:{touchable:function(){return"loading"!==this.status&&"success"!==this.status&&!this.disabled},headStyle:function(){if(this.headHeight!==h)return{height:this.headHeight+"px"}}},watch:{value:function(t){this.duration=this.animationDuration,t?this.setStatus(+this.headHeight,!0):this.slots("success")||this.successText?this.showSuccessTip():this.setStatus(0,!1)}},mounted:function(){this.bindTouchEvent(this.$refs.track),this.scrollEl=Object(s["d"])(this.$el)},methods:{checkPullStart:function(t){this.ceiling=0===Object(s["c"])(this.scrollEl),this.ceiling&&(this.duration=0,this.touchStart(t))},onTouchStart:function(t){this.touchable&&this.checkPullStart(t)},onTouchMove:function(t){this.touchable&&(this.ceiling||this.checkPullStart(t),this.touchMove(t),this.ceiling&&this.deltaY>=0&&"vertical"===this.direction&&(Object(a["c"])(t),this.setStatus(this.ease(this.deltaY))))},onTouchEnd:function(){var t=this;this.touchable&&this.ceiling&&this.deltaY&&(this.duration=this.animationDuration,"loosing"===this.status?(this.setStatus(+this.headHeight,!0),this.$emit("input",!0),this.$nextTick((function(){t.$emit("refresh")}))):this.setStatus(0))},ease:function(t){var e=+this.headHeight;return t>e&&(t=t<2*e?e+(t-e)/2:1.5*e+(t-2*e)/4),Math.round(t)},setStatus:function(t,e){var i;i=e?"loading":0===t?"normal":t<this.headHeight?"pulling":"loosing",this.distance=t,i!==this.status&&(this.status=i)},genStatus:function(){var t=this.$createElement,e=this.status,i=this.distance,n=this.slots(e,{distance:i});if(n)return n;var a=[],s=this[e+"Text"]||d(e);return-1!==f.indexOf(e)&&a.push(t("div",{class:u("text")},[s])),"loading"===e&&a.push(t(o["a"],{attrs:{size:"16"}},[s])),a},showSuccessTip:function(){var t=this;this.status="success",setTimeout((function(){t.setStatus(0)}),this.successDuration)}},render:function(){var t=arguments[0],e={transitionDuration:this.duration+"ms",transform:this.distance?"translate3d(0,"+this.distance+"px, 0)":""};return t("div",{class:u()},[t("div",{ref:"track",class:u("track"),style:e},[t("div",{class:u("head"),style:this.headStyle},[this.genStatus()]),this.slots()])])}})},"585b":function(t,e,i){"use strict";var n=i("9b27"),a=i.n(n);a.a},"78c7":function(t,e,i){},"8bcb":function(t,e,i){},9667:function(t,e,i){"use strict";var n=i("856f"),a=i("4ee6"),s=i("1412"),r=i("2643"),o=i("f55e"),c=Object(n["a"])("list"),l=c[0],u=c[1],d=c[2];e["a"]=l({mixins:[Object(r["a"])((function(t){this.scroller||(this.scroller=Object(s["d"])(this.$el)),t(this.scroller,"scroll",this.check)}))],model:{prop:"loading"},props:{error:Boolean,loading:Boolean,finished:Boolean,errorText:String,loadingText:String,finishedText:String,immediateCheck:{type:Boolean,default:!0},offset:{type:[Number,String],default:300},direction:{type:String,default:"down"}},data:function(){return{innerLoading:this.loading}},updated:function(){this.innerLoading=this.loading},mounted:function(){this.immediateCheck&&this.check()},watch:{loading:"check",finished:"check"},methods:{check:function(){var t=this;this.$nextTick((function(){if(!(t.innerLoading||t.finished||t.error)){var e,i=t.$el,n=t.scroller,s=t.offset,r=t.direction;e=n.getBoundingClientRect?n.getBoundingClientRect():{top:0,bottom:n.innerHeight};var o=e.bottom-e.top;if(!o||Object(a["a"])(i))return!1;var c=!1,l=t.$refs.placeholder.getBoundingClientRect();c="up"===r?e.top-l.top<=s:l.bottom-e.bottom<=s,c&&(t.innerLoading=!0,t.$emit("input",!0),t.$emit("load"))}}))},clickErrorText:function(){this.$emit("update:error",!1),this.check()},genLoading:function(){var t=this.$createElement;if(this.innerLoading&&!this.finished)return t("div",{class:u("loading"),key:"loading"},[this.slots("loading")||t(o["a"],{attrs:{size:"16"}},[this.loadingText||d("loading")])])},genFinishedText:function(){var t=this.$createElement;if(this.finished){var e=this.slots("finished")||this.finishedText;if(e)return t("div",{class:u("finished-text")},[e])}},genErrorText:function(){var t=this.$createElement;if(this.error){var e=this.slots("error")||this.errorText;if(e)return t("div",{on:{click:this.clickErrorText},class:u("error-text")},[e])}}},render:function(){var t=arguments[0],e=t("div",{ref:"placeholder",class:u("placeholder")});return t("div",{class:u(),attrs:{role:"feed","aria-busy":this.innerLoading}},["down"===this.direction?this.slots():e,this.genLoading(),this.genFinishedText(),this.genErrorText(),"up"===this.direction?this.slots():e])}})},"9b27":function(t,e,i){},ae53:function(t,e,i){"use strict";var n=i("03de"),a=i("23c4"),s=i.n(a),r=i("856f"),o=i("76ae"),c=i("a6bc"),l=i("8343"),u=i("2496"),d=i("f55e"),h=Object(r["a"])("button"),f=h[0],g=h[1];function b(t,e,i,n){var a,r=e.tag,h=e.icon,f=e.type,b=e.color,v=e.plain,p=e.disabled,m=e.loading,x=e.hairline,S=e.loadingText,k={};function y(t){m||p||(Object(o["a"])(n,"click",t),Object(l["a"])(n))}function T(t){Object(o["a"])(n,"touchstart",t)}b&&(k.color=v?b:c["d"],v||(k.background=b),-1!==b.indexOf("gradient")?k.border=0:k.borderColor=b);var O=[g([f,e.size,{plain:v,loading:m,disabled:p,hairline:x,block:e.block,round:e.round,square:e.square}]),(a={},a[c["b"]]=x,a)];function j(){var n,a=[];return m?a.push(t(d["a"],{class:g("loading"),attrs:{size:e.loadingSize,type:e.loadingType,color:"currentColor"}})):h&&a.push(t(u["a"],{attrs:{name:h,classPrefix:e.iconPrefix},class:g("icon")})),n=m?S:i.default?i.default():e.text,n&&a.push(t("span",{class:g("text")},[n])),a}return t(r,s()([{style:k,class:O,attrs:{type:e.nativeType,disabled:p},on:{click:y,touchstart:T}},Object(o["b"])(n)]),[t("div",{class:g("content")},[j()])])}b.props=Object(n["a"])({},l["c"],{text:String,icon:String,color:String,block:Boolean,plain:Boolean,round:Boolean,square:Boolean,loading:Boolean,hairline:Boolean,disabled:Boolean,iconPrefix:String,nativeType:String,loadingText:String,loadingType:String,tag:{type:String,default:"button"},type:{type:String,default:"default"},size:{type:String,default:"normal"},loadingSize:{type:String,default:"20px"}}),e["a"]=f(b)},b31a:function(t,e,i){"use strict";i.r(e);var n,a=function(){var t=this,e=t.$createElement,n=t._self._c||e;return n("div",{ref:"navRef",staticClass:"group-cur brace-fixed bg-white"},[n("nav-bar",{attrs:{title:"我的团购"},on:{"left-click":t.onClickLeft}}),n("van-pull-refresh",{on:{refresh:t.onRefresh},model:{value:t.refreshing,callback:function(e){t.refreshing=e},expression:"refreshing"}},[n("van-list",{attrs:{finished:t.finished,"finished-text":"没有更多了"},on:{load:t.onLoad},model:{value:t.loading,callback:function(e){t.loading=e},expression:"loading"}},[n("van-tabs",{attrs:{sticky:"",swipeable:"","swipe-threshold":"5",border:!1,"line-width":"0.53rem",animated:"","offset-top":t.tabTop},model:{value:t.activeTab,callback:function(e){t.activeTab=e},expression:"activeTab"}},t._l(t.tabsList,(function(e){return n("van-tab",{key:e.index,attrs:{title:e.title}},[n("div",{staticClass:"order-li border-top-sm"},[n("van-cell",{attrs:{border:!1},scopedSlots:t._u([{key:"title",fn:function(){return[n("span",{staticClass:"text-26"},[t._v("订单号：YFMY202007091459003")])]},proxy:!0},{key:"right-icon",fn:function(){return[n("span",{staticClass:"text-26 text-red"},[t._v("拼单中")])]},proxy:!0}],null,!0)}),n("div",{staticClass:"goods-item"},[n("div",{staticClass:"goods-photo"},[n("img",{directives:[{name:"lazy",rawName:"v-lazy",value:i("31a4"),expression:"require('@/assets/testImg@2x.png')"}],attrs:{alt:""}})]),n("div",{staticClass:"info"},[n("div",[t._v("商品名称复古宫廷风台灯具灯罩，可 以换行，最多两行")]),n("div",{staticClass:"spec"},[t._v("属性:蓝色（不包含灯泡） 中码")]),n("div",{staticClass:"number"},[n("span",[t._v("￥799")]),n("span",[t._v("×300")])])])]),n("div",{staticClass:"total padding-lr"},[n("span",[t._v("共600件")]),n("div",[n("span",[t._v("合计")]),t._v(" ¥479,400 ")])]),n("div",{staticClass:"current-group-info"},[n("div",{staticClass:"g-row"},[n("div",{staticClass:"left"},[t._v("当前拼单人数：")]),n("div",{staticClass:"right"},[n("img",{attrs:{src:"https://img.yzcdn.cn/vant/cat.jpeg",alt:""}}),n("img",{attrs:{src:"https://img.yzcdn.cn/vant/cat.jpeg",alt:""}}),n("img",{attrs:{src:"https://img.yzcdn.cn/vant/cat.jpeg",alt:""}}),t._v(" 859人 ")])]),n("div",{staticClass:"g-row"},[n("div",{staticClass:"left"},[t._v("拼单进度：")]),n("div",{staticClass:"right progress"},[n("cu-progress",{attrs:{percentage:"90%",text:"剩余80%"}})],1)]),n("div",{staticClass:"g-row"},[n("div",{staticClass:"left"},[t._v("当前订单倒计时：")]),n("div",{staticClass:"right btn"},[n("van-count-down",{attrs:{time:t.time}}),n("van-button",{attrs:{type:"default"}},[t._v("立即支付")])],1)])])],1)])})),1)],1)],1)],1)},s=[],r=(i("053b"),i("73d1")),o=(i("debd"),i("40be")),c=(i("c2e1"),i("55ae")),l=(i("4fbc"),i("ca00")),u=(i("158f"),i("f047")),d=(i("f0ab"),i("4f4a")),h=(i("ef80"),i("ae53")),f=(i("06c6"),i("9667")),g=i("3eab"),b=i("0b7a"),v={data:function(){return{loading:!1,refreshing:!1,finished:!1,activeTab:0,tabsList:[{title:"全部",index:0},{title:"待拼团",index:1},{title:"等待中",index:2},{title:"已完成",index:3},{title:"已失效",index:4}],time:108e6,tabTop:"44px"}},mounted:function(){var t=this.$route.query;t.index&&(console.log(t.index),this.activeTab=t.index),this.tabTop=document.getElementsByClassName("nav-bar-wrap")[0].offsetHeight-1+"px"},components:(n={},Object(r["a"])(n,f["a"].name,f["a"]),Object(r["a"])(n,h["a"].name,h["a"]),Object(r["a"])(n,d["a"].name,d["a"]),Object(r["a"])(n,u["a"].name,u["a"]),Object(r["a"])(n,l["a"].name,l["a"]),Object(r["a"])(n,c["a"].name,c["a"]),Object(r["a"])(n,o["a"].name,o["a"]),Object(r["a"])(n,"cuProgress",g["a"]),Object(r["a"])(n,"navBar",b["a"]),n),methods:{onLoad:function(){this.finished=!1},onClickLeft:function(){this.$parent.goback()},onRefresh:function(){this.finished=!1,this.refreshing=!1}}},p=v,m=(i("37a2"),i("9ca4")),x=Object(m["a"])(p,a,s,!1,null,null,null);e["default"]=x.exports},b328:function(t,e,i){},c2c3:function(t,e,i){},c2e1:function(t,e,i){"use strict";i("e1d5"),i("e837"),i("78c7")},ca00:function(t,e,i){"use strict";var n=i("03de"),a=i("23c4"),s=i.n(a),r=i("856f"),o=i("e465"),c=i("76ae"),l=i("8343"),u=i("3766"),d=i("2496"),h=Object(r["a"])("cell"),f=h[0],g=h[1];function b(t,e,i,n){var a=e.icon,r=e.size,u=e.title,h=e.label,f=e.value,b=e.isLink,v=i.title||Object(o["c"])(u);function p(){var n=i.label||Object(o["c"])(h);if(n)return t("div",{class:[g("label"),e.labelClass]},[i.label?i.label():h])}function m(){if(v)return t("div",{class:[g("title"),e.titleClass],style:e.titleStyle},[i.title?i.title():t("span",[u]),p()])}function x(){var n=i.default||Object(o["c"])(f);if(n)return t("div",{class:[g("value",{alone:!v}),e.valueClass]},[i.default?i.default():t("span",[f])])}function S(){return i.icon?i.icon():a?t(d["a"],{class:g("left-icon"),attrs:{name:a,classPrefix:e.iconPrefix}}):void 0}function k(){var n=i["right-icon"];if(n)return n();if(b){var a=e.arrowDirection;return t(d["a"],{class:g("right-icon"),attrs:{name:a?"arrow-"+a:"arrow"}})}}function y(t){Object(c["a"])(n,"click",t),Object(l["a"])(n)}var T=b||e.clickable,O={clickable:T,center:e.center,required:e.required,borderless:!e.border};return r&&(O[r]=r),t("div",s()([{class:g(O),attrs:{role:T?"button":null,tabindex:T?0:null},on:{click:y}},Object(c["b"])(n)]),[S(),m(),x(),k(),null==i.extra?void 0:i.extra()])}b.props=Object(n["a"])({},u["a"],l["c"]),e["a"]=f(b)},debd:function(t,e,i){"use strict";i("e1d5"),i("8bcb")},e2ac:function(t,e,i){},ead7:function(t,e,i){"use strict";i("e1d5"),i("de0a"),i("1b19")},ef80:function(t,e,i){"use strict";i("e1d5"),i("de0a"),i("1b19"),i("e837"),i("b328")}}]);