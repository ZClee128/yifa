(window["webpackJsonp"]=window["webpackJsonp"]||[]).push([["chunk-2ab20472"],{"03de":function(t,e,n){"use strict";function i(){return i=Object.assign||function(t){for(var e=1;e<arguments.length;e++){var n=arguments[e];for(var i in n)Object.prototype.hasOwnProperty.call(n,i)&&(t[i]=n[i])}return t},i.apply(this,arguments)}n.d(e,"a",(function(){return i}))},1412:function(t,e,n){"use strict";function i(t){return t===window}n.d(e,"d",(function(){return o})),n.d(e,"c",(function(){return a})),n.d(e,"h",(function(){return s})),n.d(e,"b",(function(){return u})),n.d(e,"g",(function(){return c})),n.d(e,"a",(function(){return f})),n.d(e,"e",(function(){return l})),n.d(e,"f",(function(){return d}));var r=/scroll|auto/i;function o(t,e){void 0===e&&(e=window);var n=t;while(n&&"HTML"!==n.tagName&&1===n.nodeType&&n!==e){var i=window.getComputedStyle(n),o=i.overflowY;if(r.test(o)){if("BODY"!==n.tagName)return n;var a=window.getComputedStyle(n.parentNode),s=a.overflowY;if(r.test(s))return n}n=n.parentNode}return e}function a(t){var e="scrollTop"in t?t.scrollTop:t.pageYOffset;return Math.max(e,0)}function s(t,e){"scrollTop"in t?t.scrollTop=e:t.scrollTo(t.scrollX,e)}function u(){return window.pageYOffset||document.documentElement.scrollTop||document.body.scrollTop||0}function c(t){s(window,t),s(document.body,t)}function f(t,e){if(i(t))return 0;var n=e?a(e):u();return t.getBoundingClientRect().top+n}function l(t){return i(t)?t.innerHeight:t.getBoundingClientRect().height}function d(t){return i(t)?0:t.getBoundingClientRect().top}},2290:function(t,e,n){"use strict";function i(t){return/^\d+(\.\d+)?$/.test(t)}function r(t){return Number.isNaN?Number.isNaN(t):t!==t}n.d(e,"b",(function(){return i})),n.d(e,"a",(function(){return r}))},"23c4":function(t,e,n){"use strict";function i(){return i=Object.assign||function(t){for(var e,n=1;n<arguments.length;n++)for(var i in e=arguments[n],e)Object.prototype.hasOwnProperty.call(e,i)&&(t[i]=e[i]);return t},i.apply(this,arguments)}var r=["attrs","props","domProps"],o=["class","style","directives"],a=["on","nativeOn"],s=function(t){return t.reduce((function(t,e){for(var n in e)if(t[n])if(-1!==r.indexOf(n))t[n]=i({},t[n],e[n]);else if(-1!==o.indexOf(n)){var s=t[n]instanceof Array?t[n]:[t[n]],c=e[n]instanceof Array?e[n]:[e[n]];t[n]=s.concat(c)}else if(-1!==a.indexOf(n))for(var f in e[n])if(t[n][f]){var l=t[n][f]instanceof Array?t[n][f]:[t[n][f]],d=e[n][f]instanceof Array?e[n][f]:[e[n][f]];t[n][f]=l.concat(d)}else t[n][f]=e[n][f];else if("hook"==n)for(var h in e[n])t[n][h]=t[n][h]?u(t[n][h],e[n][h]):e[n][h];else t[n]=e[n];else t[n]=e[n];return t}),{})},u=function(t,e){return function(){t&&t.apply(this,arguments),e&&e.apply(this,arguments)}};t.exports=s},"2cc9":function(t,e,n){"use strict";n.d(e,"b",(function(){return a})),n.d(e,"a",(function(){return s})),n.d(e,"c",(function(){return c}));var i=n("e465"),r=!1;if(!i["g"])try{var o={};Object.defineProperty(o,"passive",{get:function(){r=!0}}),window.addEventListener("test-passive",null,o)}catch(f){}function a(t,e,n,o){void 0===o&&(o=!1),i["g"]||t.addEventListener(e,n,!!r&&{capture:!1,passive:o})}function s(t,e,n){i["g"]||t.removeEventListener(e,n)}function u(t){t.stopPropagation()}function c(t,e){("boolean"!==typeof t.cancelable||t.cancelable)&&t.preventDefault(),e&&u(t)}},"3e0b":function(t,e,n){"use strict";n.d(e,"a",(function(){return a}));var i=n("e02c"),r=n.n(i),o=function(){return Math.random().toString(36).substring(2)},a={name:"ContentLoader",functional:!0,props:{width:{type:[Number,String],default:400},height:{type:[Number,String],default:130},speed:{type:Number,default:2},preserveAspectRatio:{type:String,default:"xMidYMid meet"},baseUrl:{type:String,default:""},primaryColor:{type:String,default:"#f9f9f9"},secondaryColor:{type:String,default:"#ecebeb"},primaryOpacity:{type:Number,default:1},secondaryOpacity:{type:Number,default:1},uniqueKey:{type:String},animate:{type:Boolean,default:!0}},render:function(t,e){var n=e.props,i=e.data,a=e.children,s=n.uniqueKey?n.uniqueKey+"-idClip":o(),u=n.uniqueKey?n.uniqueKey+"-idGradient":o();return t("svg",r()([i,{attrs:{viewBox:"0 0 "+n.width+" "+n.height,version:"1.1",preserveAspectRatio:n.preserveAspectRatio}}]),[t("rect",{style:{fill:"url("+n.baseUrl+"#"+u+")"},attrs:{"clip-path":"url("+n.baseUrl+"#"+s+")",x:"0",y:"0",width:n.width,height:n.height}}),t("defs",[t("clipPath",{attrs:{id:s}},[a||t("rect",{attrs:{x:"0",y:"0",rx:"5",ry:"5",width:n.width,height:n.height}})]),t("linearGradient",{attrs:{id:u}},[t("stop",{attrs:{offset:"0%","stop-color":n.primaryColor,"stop-opacity":n.primaryOpacity}},[n.animate?t("animate",{attrs:{attributeName:"offset",values:"-2; 1",dur:n.speed+"s",repeatCount:"indefinite"}}):null]),t("stop",{attrs:{offset:"50%","stop-color":n.secondaryColor,"stop-opacity":n.secondaryOpacity}},[n.animate?t("animate",{attrs:{attributeName:"offset",values:"-1.5; 1.5",dur:n.speed+"s",repeatCount:"indefinite"}}):null]),t("stop",{attrs:{offset:"100%","stop-color":n.primaryColor,"stop-opacity":n.primaryOpacity}},[n.animate?t("animate",{attrs:{attributeName:"offset",values:"-1; 2",dur:n.speed+"s",repeatCount:"indefinite"}}):null])])])])}}},"55ae":function(t,e,n){"use strict";var i=n("856f"),r=n("2cc9"),o=n("1412"),a=n("84e4"),s=n("f55e"),u=Object(i["a"])("pull-refresh"),c=u[0],f=u[1],l=u[2],d=50,h=["pulling","loosing","success"];e["a"]=c({mixins:[a["a"]],props:{disabled:Boolean,successText:String,pullingText:String,loosingText:String,loadingText:String,value:{type:Boolean,required:!0},successDuration:{type:[Number,String],default:500},animationDuration:{type:[Number,String],default:300},headHeight:{type:[Number,String],default:d}},data:function(){return{status:"normal",distance:0,duration:0}},computed:{touchable:function(){return"loading"!==this.status&&"success"!==this.status&&!this.disabled},headStyle:function(){if(this.headHeight!==d)return{height:this.headHeight+"px"}}},watch:{value:function(t){this.duration=this.animationDuration,t?this.setStatus(+this.headHeight,!0):this.slots("success")||this.successText?this.showSuccessTip():this.setStatus(0,!1)}},mounted:function(){this.bindTouchEvent(this.$refs.track),this.scrollEl=Object(o["d"])(this.$el)},methods:{checkPullStart:function(t){this.ceiling=0===Object(o["c"])(this.scrollEl),this.ceiling&&(this.duration=0,this.touchStart(t))},onTouchStart:function(t){this.touchable&&this.checkPullStart(t)},onTouchMove:function(t){this.touchable&&(this.ceiling||this.checkPullStart(t),this.touchMove(t),this.ceiling&&this.deltaY>=0&&"vertical"===this.direction&&(Object(r["c"])(t),this.setStatus(this.ease(this.deltaY))))},onTouchEnd:function(){var t=this;this.touchable&&this.ceiling&&this.deltaY&&(this.duration=this.animationDuration,"loosing"===this.status?(this.setStatus(+this.headHeight,!0),this.$emit("input",!0),this.$nextTick((function(){t.$emit("refresh")}))):this.setStatus(0))},ease:function(t){var e=+this.headHeight;return t>e&&(t=t<2*e?e+(t-e)/2:1.5*e+(t-2*e)/4),Math.round(t)},setStatus:function(t,e){var n;n=e?"loading":0===t?"normal":t<this.headHeight?"pulling":"loosing",this.distance=t,n!==this.status&&(this.status=n)},genStatus:function(){var t=this.$createElement,e=this.status,n=this.distance,i=this.slots(e,{distance:n});if(i)return i;var r=[],o=this[e+"Text"]||l(e);return-1!==h.indexOf(e)&&r.push(t("div",{class:f("text")},[o])),"loading"===e&&r.push(t(s["a"],{attrs:{size:"16"}},[o])),r},showSuccessTip:function(){var t=this;this.status="success",setTimeout((function(){t.setStatus(0)}),this.successDuration)}},render:function(){var t=arguments[0],e={transitionDuration:this.duration+"ms",transform:this.distance?"translate3d(0,"+this.distance+"px, 0)":""};return t("div",{class:f()},[t("div",{ref:"track",class:f("track"),style:e},[t("div",{class:f("head"),style:this.headStyle},[this.genStatus()]),this.slots()])])}})},"55b1":function(t,e,n){"use strict";n.d(e,"a",(function(){return a})),n.d(e,"b",(function(){return f}));var i,r=n("e465"),o=n("2290");function a(t){if(Object(r["c"])(t))return t=String(t),Object(o["b"])(t)?t+"px":t}function s(){if(!i){var t=document.documentElement,e=t.style.fontSize||window.getComputedStyle(t).fontSize;i=parseFloat(e)}return i}function u(t){return t=t.replace(/rem/g,""),+t*s()}function c(t){return t=t.replace(/vw/g,""),+t*window.innerWidth/100}function f(t){if("number"===typeof t)return t;if(r["b"]){if(-1!==t.indexOf("rem"))return u(t);if(-1!==t.indexOf("vw"))return c(t)}return parseFloat(t)}},"76ae":function(t,e,n){"use strict";n.d(e,"b",(function(){return s})),n.d(e,"a",(function(){return u})),n.d(e,"c",(function(){return c}));var i=n("03de"),r=n("0261"),o=["ref","style","class","attrs","nativeOn","directives","staticClass","staticStyle"],a={nativeOn:"on"};function s(t,e){var n=o.reduce((function(e,n){return t.data[n]&&(e[a[n]||n]=t.data[n]),e}),{});return e&&(n.on=n.on||{},Object(i["a"])(n.on,t.data.on)),n}function u(t,e){for(var n=arguments.length,i=new Array(n>2?n-2:0),r=2;r<n;r++)i[r-2]=arguments[r];var o=t.listeners[e];o&&(Array.isArray(o)?o.forEach((function(t){t.apply(void 0,i)})):o.apply(void 0,i))}function c(t,e){var n=new r["default"]({el:document.createElement("div"),props:t.props,render:function(n){return n(t,Object(i["a"])({props:this.$props},e))}});return document.body.appendChild(n.$el),n}},"78c7":function(t,e,n){},"84e4":function(t,e,n){"use strict";n.d(e,"a",(function(){return a}));var i=n("2cc9"),r=10;function o(t,e){return t>e&&t>r?"horizontal":e>t&&e>r?"vertical":""}var a={data:function(){return{direction:""}},methods:{touchStart:function(t){this.resetTouchStatus(),this.startX=t.touches[0].clientX,this.startY=t.touches[0].clientY},touchMove:function(t){var e=t.touches[0];this.deltaX=e.clientX-this.startX,this.deltaY=e.clientY-this.startY,this.offsetX=Math.abs(this.deltaX),this.offsetY=Math.abs(this.deltaY),this.direction=this.direction||o(this.offsetX,this.offsetY)},resetTouchStatus:function(){this.direction="",this.deltaX=0,this.deltaY=0,this.offsetX=0,this.offsetY=0},bindTouchEvent:function(t){var e=this.onTouchStart,n=this.onTouchMove,r=this.onTouchEnd;Object(i["b"])(t,"touchstart",e),Object(i["b"])(t,"touchmove",n),r&&(Object(i["b"])(t,"touchend",r),Object(i["b"])(t,"touchcancel",r))}}}},"856f":function(t,e,n){"use strict";function i(t,e){return e?"string"===typeof e?" "+t+"--"+e:Array.isArray(e)?e.reduce((function(e,n){return e+i(t,n)}),""):Object.keys(e).reduce((function(n,r){return n+(e[r]?i(t,r):"")}),""):""}function r(t){return function(e,n){return e&&"string"!==typeof e&&(n=e,e=""),e=e?t+"__"+e:t,""+e+i(e,n)}}n.d(e,"a",(function(){return O}));var o=n("e465"),a=n("98ae"),s={methods:{slots:function(t,e){void 0===t&&(t="default");var n=this.$slots,i=this.$scopedSlots,r=i[t];return r?r(e):n[t]}}};function u(t){var e=this.name;t.component(e,this),t.component(Object(a["a"])("-"+e),this)}function c(t){var e=t.scopedSlots||t.data.scopedSlots||{},n=t.slots();return Object.keys(n).forEach((function(t){e[t]||(e[t]=function(){return n[t]})})),e}function f(t){return{functional:!0,props:t.props,model:t.model,render:function(e,n){return t(e,n.props,c(n),n)}}}function l(t){return function(e){return Object(o["d"])(e)&&(e=f(e)),e.functional||(e.mixins=e.mixins||[],e.mixins.push(s)),e.name=t,e.install=u,e}}var d=n("0261"),h=Object.prototype.hasOwnProperty;function p(t,e,n){var i=e[n];Object(o["c"])(i)&&(h.call(t,n)&&Object(o["e"])(i)?t[n]=v(Object(t[n]),e[n]):t[n]=i)}function v(t,e){return Object.keys(e).forEach((function(n){p(t,e,n)})),t}var y={name:"姓名",tel:"电话",save:"保存",confirm:"确认",cancel:"取消",delete:"删除",complete:"完成",loading:"加载中...",telEmpty:"请填写电话",nameEmpty:"请填写姓名",nameInvalid:"请输入正确的姓名",confirmDelete:"确定要删除吗",telInvalid:"请输入正确的手机号",vanCalendar:{end:"结束",start:"开始",title:"日期选择",confirm:"确定",startEnd:"开始/结束",weekdays:["日","一","二","三","四","五","六"],monthTitle:function(t,e){return t+"年"+e+"月"},rangePrompt:function(t){return"选择天数不能超过 "+t+" 天"}},vanContactCard:{addText:"添加联系人"},vanContactList:{addText:"新建联系人"},vanPagination:{prev:"上一页",next:"下一页"},vanPullRefresh:{pulling:"下拉即可刷新...",loosing:"释放即可刷新..."},vanSubmitBar:{label:"合计："},vanCoupon:{unlimited:"无使用门槛",discount:function(t){return t+"折"},condition:function(t){return"满"+t+"元可用"}},vanCouponCell:{title:"优惠券",tips:"暂无可用",count:function(t){return t+"张可用"}},vanCouponList:{empty:"暂无优惠券",exchange:"兑换",close:"不使用优惠券",enable:"可用",disabled:"不可用",placeholder:"请输入优惠码"},vanAddressEdit:{area:"地区",postal:"邮政编码",areaEmpty:"请选择地区",addressEmpty:"请填写详细地址",postalEmpty:"邮政编码格式不正确",defaultAddress:"设为默认收货地址",telPlaceholder:"收货人手机号",namePlaceholder:"收货人姓名",areaPlaceholder:"选择省 / 市 / 区"},vanAddressEditDetail:{label:"详细地址",placeholder:"街道门牌、楼层房间号等信息"},vanAddressList:{add:"新增地址"}},g=d["default"].prototype,m=d["default"].util.defineReactive;m(g,"$vantLang","zh-CN"),m(g,"$vantMessages",{"zh-CN":y});var b={messages:function(){return g.$vantMessages[g.$vantLang]},use:function(t,e){var n;g.$vantLang=t,this.add((n={},n[t]=e,n))},add:function(t){void 0===t&&(t={}),v(g.$vantMessages,t)}};function S(t){var e=Object(a["a"])(t)+".";return function(t){for(var n=b.messages(),i=Object(o["a"])(n,e+t)||Object(o["a"])(n,t),r=arguments.length,a=new Array(r>1?r-1:0),s=1;s<r;s++)a[s-1]=arguments[s];return Object(o["d"])(i)?i.apply(void 0,a):i}}function O(t){return t="van-"+t,[l(t),r(t),S(t)]}},"98ae":function(t,e,n){"use strict";n.d(e,"a",(function(){return r})),n.d(e,"b",(function(){return o}));var i=/-(\w)/g;function r(t){return t.replace(i,(function(t,e){return e.toUpperCase()}))}function o(t,e){void 0===e&&(e=2);var n=t+"";while(n.length<e)n="0"+n;return n}},c2e1:function(t,e,n){"use strict";n("e1d5"),n("e837"),n("78c7")},e02c:function(t,e){var n=/^(attrs|props|on|nativeOn|class|style|hook)$/;function i(t,e){return function(){t&&t.apply(this,arguments),e&&e.apply(this,arguments)}}t.exports=function(t){return t.reduce((function(t,e){var r,o,a,s,u;for(a in e)if(r=t[a],o=e[a],r&&n.test(a))if("class"===a&&("string"===typeof r&&(u=r,t[a]=r={},r[u]=!0),"string"===typeof o&&(u=o,e[a]=o={},o[u]=!0)),"on"===a||"nativeOn"===a||"hook"===a)for(s in o)r[s]=i(r[s],o[s]);else if(Array.isArray(r))t[a]=r.concat(o);else if(Array.isArray(o))t[a]=[r].concat(o);else for(s in o)r[s]=o[s];else t[a]=e[a];return t}),{})}},e465:function(t,e,n){"use strict";n.d(e,"b",(function(){return r})),n.d(e,"g",(function(){return o})),n.d(e,"h",(function(){return a})),n.d(e,"c",(function(){return s})),n.d(e,"d",(function(){return u})),n.d(e,"e",(function(){return c})),n.d(e,"f",(function(){return f})),n.d(e,"a",(function(){return l}));var i=n("0261"),r="undefined"!==typeof window,o=i["default"].prototype.$isServer;function a(){}function s(t){return void 0!==t&&null!==t}function u(t){return"function"===typeof t}function c(t){return null!==t&&"object"===typeof t}function f(t){return c(t)&&u(t.then)&&u(t.catch)}function l(t,e){var n=e.split("."),i=t;return n.forEach((function(t){i=s(i[t])?i[t]:""})),i}},e837:function(t,e,n){},f55e:function(t,e,n){"use strict";var i=n("23c4"),r=n.n(i),o=n("856f"),a=n("55b1"),s=n("76ae"),u=Object(o["a"])("loading"),c=u[0],f=u[1];function l(t,e){if("spinner"===e.type){for(var n=[],i=0;i<12;i++)n.push(t("i"));return n}return t("svg",{class:f("circular"),attrs:{viewBox:"25 25 50 50"}},[t("circle",{attrs:{cx:"50",cy:"50",r:"20",fill:"none"}})])}function d(t,e,n){if(n.default){var i=e.textSize&&{fontSize:Object(a["a"])(e.textSize)};return t("span",{class:f("text"),style:i},[n.default()])}}function h(t,e,n,i){var o=e.color,u=e.size,c=e.type,h={color:o};if(u){var p=Object(a["a"])(u);h.width=p,h.height=p}return t("div",r()([{class:f([c,{vertical:e.vertical}])},Object(s["b"])(i,!0)]),[t("span",{class:f("spinner",c),style:h},[l(t,e)]),d(t,e,n)])}h.props={color:String,size:[Number,String],vertical:Boolean,textSize:[Number,String],type:{type:String,default:"circular"}},e["a"]=c(h)}}]);