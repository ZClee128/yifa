(window["webpackJsonp"]=window["webpackJsonp"]||[]).push([["chunk-3306fd42"],{"06c6":function(t,e,i){"use strict";i("e1d5"),i("e837"),i("36b0")},"0bad":function(t,e,i){"use strict";i.r(e);var r,a=function(){var t=this,e=t.$createElement,r=t._self._c||e;return r("div",{staticClass:"shop bg-white"},[t.load?r("Skeleton"):t._e(),r("div",{staticClass:"navigator-header",on:{click:t.backPage}},[r("img",{directives:[{name:"lazy",rawName:"v-lazy",value:t.rightIcon,expression:"rightIcon"}],attrs:{alt:""}})]),r("transition",{attrs:{name:"fade"}},[t.load?t._e():r("div",[r("div",{staticClass:"header"},[r("div",{staticClass:"shop-logo"},[r("div",{staticClass:"logo"},[r("img",{directives:[{name:"lazy",rawName:"v-lazy",value:i("31a4"),expression:"require('@/assets/testImg@2x.png')"}],attrs:{alt:""}})]),r("div",{staticClass:"name"},[r("div",{staticClass:"top",on:{click:t.goDetali}},[t._v(" 张飞的店 粉丝5万 ")]),r("div",{staticClass:"bottom"},[r("div",[r("img",{directives:[{name:"lazy",rawName:"v-lazy",value:t.gzIcon,expression:"gzIcon"}],attrs:{alt:""}}),t._v(" 关注 ")]),r("div",{on:{click:t.goIM}},[r("img",{directives:[{name:"lazy",rawName:"v-lazy",value:t.kfIcon,expression:"kfIcon"}],attrs:{alt:""}}),t._v(" 客服 ")])])])]),r("div",{staticClass:"area"},[r("div",{staticClass:"text-30"},[t._v("源头工厂")]),r("ul",[r("li",[r("div",[t._v("福建福州")]),r("div",[t._v("工厂地址")])]),r("li",[r("div",[t._v("100-150人")]),r("div",[t._v("员工人数")])]),r("li",[r("div",[t._v("来样加工")]),r("div",[t._v("加工方式")])])])])]),r("div",{staticClass:"bg-white content"},[r("van-tabs",{attrs:{animated:"",duration:"0.2",sticky:"",color:"#FE851E","line-width":"0.5rem",border:!1,"title-active-color":"#4D4D4D","title-inactive-color":"#4D4D4D",swipeable:""},on:{click:t.changTab,scroll:t.scrollTab},model:{value:t.activeTab,callback:function(e){t.activeTab=e},expression:"activeTab"}},t._l(t.tabList,(function(e,i){return r("van-tab",{key:i,attrs:{"title-style":{paddingTop:t.isFixed?t.$store.state.navHeight+"px":0}},scopedSlots:t._u([{key:"title",fn:function(){return[r("div",[t._v(t._s(e.title))])]},proxy:!0}],null,!0)},[r("div",[r("van-list",{attrs:{finished:t.finished,"finished-text":"没有更多了"},on:{load:t.onLoad},model:{value:t.loading,callback:function(e){t.loading=e},expression:"loading"}},[r("div",{staticClass:"goods-list",style:{paddingTop:t.isFixed?t.$store.state.navHeight+"px":0}},t._l(t.list[i].list,(function(t,e){return r("cu-list",{key:e})})),1)])],1)])})),1)],1)])])],1)},n=[],s=(i("053b"),i("e18c"),i("af40")),o=(i("06c6"),i("9667")),c=(i("158f"),i("f047")),l=(i("f0ab"),i("4f4a")),d=function(){var t=this,e=t.$createElement,i=t._self._c||e;return i("content-loader",{attrs:{width:750,height:1600,speed:2,primaryColor:"#f3f3f3",secondaryColor:"#ecebeb"}},[i("rect",{attrs:{x:"0",y:"8",rx:"3",ry:"3",width:"750",height:"380"}}),i("rect",{attrs:{x:"30",y:"307",rx:"20",ry:"20",width:"690",height:"150"}}),i("rect",{attrs:{x:"80",y:"485",rx:"0",ry:"0",width:"110",height:"30"}}),i("rect",{attrs:{x:"319",y:"485",rx:"0",ry:"0",width:"110",height:"30"}}),i("rect",{attrs:{x:"558",y:"485",rx:"0",ry:"0",width:"110",height:"30"}}),i("rect",{attrs:{x:"30",y:"574",rx:"10",ry:"10",width:"330",height:"330"}}),i("rect",{attrs:{x:"390",y:"574",rx:"10",ry:"10",width:"330",height:"330"}}),i("rect",{attrs:{x:"50",y:"930",rx:"10",ry:"10",width:"277",height:"30"}}),i("rect",{attrs:{x:"50",y:"990",rx:"10",ry:"10",width:"70",height:"30"}}),i("rect",{attrs:{x:"154",y:"990",rx:"10",ry:"10",width:"147",height:"30"}}),i("rect",{attrs:{x:"407",y:"930",rx:"10",ry:"10",width:"277",height:"30"}}),i("rect",{attrs:{x:"408",y:"990",rx:"10",ry:"10",width:"70",height:"30"}}),i("rect",{attrs:{x:"511",y:"990",rx:"10",ry:"10",width:"147",height:"30"}}),i("rect",{attrs:{x:"30",y:1078,rx:"10",ry:"10",width:"330",height:"330"}}),i("rect",{attrs:{x:"390",y:1078,rx:"10",ry:"10",width:"330",height:"330"}}),i("rect",{attrs:{x:"50",y:1434,rx:"10",ry:"10",width:"277",height:"30"}}),i("rect",{attrs:{x:"50",y:1494,rx:"10",ry:"10",width:"70",height:"30"}}),i("rect",{attrs:{x:"154",y:1494,rx:"10",ry:"10",width:"147",height:"30"}}),i("rect",{attrs:{x:"407",y:1434,rx:"10",ry:"10",width:"277",height:"30"}}),i("rect",{attrs:{x:"408",y:1494,rx:"10",ry:"10",width:"70",height:"30"}}),i("rect",{attrs:{x:"511",y:1494,rx:"10",ry:"10",width:"147",height:"30"}})])},h=[],u=i("3e0b"),g={components:{ContentLoader:u["a"]}},f=g,p=i("9ca4"),A=Object(p["a"])(f,d,h,!1,null,null,"3ed68d7d"),m=A.exports,x={data:function(){return{rightIcon:i("0d5e"),kfIcon:i("c7c4"),gzIcon:i("6834"),isFixed:!1,tabList:[{title:"商家推荐",naem:"a"},{title:"全部商品",naem:"b"},{title:"新品上市",naem:"c"}],activeTab:0,load:!1,loading:!1,finished:!1,list:[{list:[]},{list:[]},{list:[]}]}},components:(r={},Object(s["a"])(r,l["a"].name,l["a"]),Object(s["a"])(r,c["a"].name,c["a"]),Object(s["a"])(r,o["a"].name,o["a"]),Object(s["a"])(r,"cuList",(function(){return i.e("chunk-79d003c7").then(i.bind(null,"ca5a"))})),Object(s["a"])(r,"Skeleton",m),r),created:function(){var t=this;setTimeout((function(){t.load=!1}),800),this.onLoad()},watch:{$route:function(t,e){console.log(0==t.meta.index,"Home"==e.name,1231312),0!=t.meta.index||"Home"!=e.name?t.meta.index>e.meta.index?this.transition="slide-left":this.transition="slide-right":this.transition=""}},methods:{changTab:function(){},scrollTab:function(t){this.isFixed=t.isFixed},backPage:function(){this.$route.query.app?this.$parent.goback():this.$backRouer(-1)},onLoad:function(){var t=this;setTimeout((function(){t.refreshing&&(t.list=[],t.refreshing=!1),console.log(t.activeTab);for(var e=0;e<t.tabList.length;e++){for(var i=0;i<5;i++)t.list[t.activeTab].list.push(t.list.length+1);t.loading=!1,t.list[e].list.length>=40&&(t.finished=!0)}}),0)},goDetali:function(){console.log(1123),this.$router.push("/shopDetail")},goIM:function(){this.$parent.goIM()}}},y=x,v=(i("7e44"),Object(p["a"])(y,a,n,!1,null,null,null));e["default"]=v.exports},"0d5e":function(t,e){t.exports="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAADAAAAAwCAMAAABg3Am1AAAAgVBMVEVHcEz///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////8KTOKkAAAAKnRSTlMAA7E36sgKFdsk9ZZO/nhp/AGHpFv53+eqP685xAZT2uFIQlfl4ElSkUxbb6oRAAAArUlEQVRIx+XWRxKDMBQEUZFzTs459v0P6IUvwNjGG7TvQvC+VBjz1Tr2+5MUHCB2lOACuJEQnDMgDIQiB9hshSIBaKrxgWUD1MIjfA+gEIogBMpUKCIXkWPdqRztZxyer3KsZsjhxCpH+i8O21I5kvFB1YhBLW6pEF86LbXPqsJFLtAtteHLWnG88/EAizkCCGfzDbCbDEA+Mo+JAZ4igLmqV1ev/jrch+FmfrxeA60gPoe5BqYAAAAASUVORK5CYII="},"31a4":function(t,e,i){t.exports=i.p+"img/testImg@2x.dfe0540d.png"},"36b0":function(t,e,i){},"3e0b":function(t,e,i){"use strict";i.d(e,"a",(function(){return s}));var r=i("e02c"),a=i.n(r),n=function(){return Math.random().toString(36).substring(2)},s={name:"ContentLoader",functional:!0,props:{width:{type:[Number,String],default:400},height:{type:[Number,String],default:130},speed:{type:Number,default:2},preserveAspectRatio:{type:String,default:"xMidYMid meet"},baseUrl:{type:String,default:""},primaryColor:{type:String,default:"#f9f9f9"},secondaryColor:{type:String,default:"#ecebeb"},primaryOpacity:{type:Number,default:1},secondaryOpacity:{type:Number,default:1},uniqueKey:{type:String},animate:{type:Boolean,default:!0}},render:function(t,e){var i=e.props,r=e.data,s=e.children,o=i.uniqueKey?i.uniqueKey+"-idClip":n(),c=i.uniqueKey?i.uniqueKey+"-idGradient":n();return t("svg",a()([r,{attrs:{viewBox:"0 0 "+i.width+" "+i.height,version:"1.1",preserveAspectRatio:i.preserveAspectRatio}}]),[t("rect",{style:{fill:"url("+i.baseUrl+"#"+c+")"},attrs:{"clip-path":"url("+i.baseUrl+"#"+o+")",x:"0",y:"0",width:i.width,height:i.height}}),t("defs",[t("clipPath",{attrs:{id:o}},[s||t("rect",{attrs:{x:"0",y:"0",rx:"5",ry:"5",width:i.width,height:i.height}})]),t("linearGradient",{attrs:{id:c}},[t("stop",{attrs:{offset:"0%","stop-color":i.primaryColor,"stop-opacity":i.primaryOpacity}},[i.animate?t("animate",{attrs:{attributeName:"offset",values:"-2; 1",dur:i.speed+"s",repeatCount:"indefinite"}}):null]),t("stop",{attrs:{offset:"50%","stop-color":i.secondaryColor,"stop-opacity":i.secondaryOpacity}},[i.animate?t("animate",{attrs:{attributeName:"offset",values:"-1.5; 1.5",dur:i.speed+"s",repeatCount:"indefinite"}}):null]),t("stop",{attrs:{offset:"100%","stop-color":i.primaryColor,"stop-opacity":i.primaryOpacity}},[i.animate?t("animate",{attrs:{attributeName:"offset",values:"-1; 2",dur:i.speed+"s",repeatCount:"indefinite"}}):null])])])])}}},6834:function(t,e){t.exports="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAEgAAABIBAMAAACnw650AAAAD1BMVEVHcEz///////////////8T4DEaAAAABHRSTlMALTNXgmISTgAAADtJREFUSMdjYBgFAwxEXBxHFY0qGlVEmSImJQQwcXFG4ikgFLG44AIOA6aIKIePRvCoolFFNFM0CmgMAFEqPrFi7C2DAAAAAElFTkSuQmCC"},"7e44":function(t,e,i){"use strict";var r=i("b15a"),a=i.n(r);a.a},9667:function(t,e,i){"use strict";var r=i("856f"),a=i("4ee6"),n=i("1412"),s=i("2643"),o=i("f55e"),c=Object(r["a"])("list"),l=c[0],d=c[1],h=c[2];e["a"]=l({mixins:[Object(s["a"])((function(t){this.scroller||(this.scroller=Object(n["d"])(this.$el)),t(this.scroller,"scroll",this.check)}))],model:{prop:"loading"},props:{error:Boolean,loading:Boolean,finished:Boolean,errorText:String,loadingText:String,finishedText:String,immediateCheck:{type:Boolean,default:!0},offset:{type:[Number,String],default:300},direction:{type:String,default:"down"}},data:function(){return{innerLoading:this.loading}},updated:function(){this.innerLoading=this.loading},mounted:function(){this.immediateCheck&&this.check()},watch:{loading:"check",finished:"check"},methods:{check:function(){var t=this;this.$nextTick((function(){if(!(t.innerLoading||t.finished||t.error)){var e,i=t.$el,r=t.scroller,n=t.offset,s=t.direction;e=r.getBoundingClientRect?r.getBoundingClientRect():{top:0,bottom:r.innerHeight};var o=e.bottom-e.top;if(!o||Object(a["a"])(i))return!1;var c=!1,l=t.$refs.placeholder.getBoundingClientRect();c="up"===s?e.top-l.top<=n:l.bottom-e.bottom<=n,c&&(t.innerLoading=!0,t.$emit("input",!0),t.$emit("load"))}}))},clickErrorText:function(){this.$emit("update:error",!1),this.check()},genLoading:function(){var t=this.$createElement;if(this.innerLoading&&!this.finished)return t("div",{class:d("loading"),key:"loading"},[this.slots("loading")||t(o["a"],{attrs:{size:"16"}},[this.loadingText||h("loading")])])},genFinishedText:function(){var t=this.$createElement;if(this.finished){var e=this.slots("finished")||this.finishedText;if(e)return t("div",{class:d("finished-text")},[e])}},genErrorText:function(){var t=this.$createElement;if(this.error){var e=this.slots("error")||this.errorText;if(e)return t("div",{on:{click:this.clickErrorText},class:d("error-text")},[e])}}},render:function(){var t=arguments[0],e=t("div",{ref:"placeholder",class:d("placeholder")});return t("div",{class:d(),attrs:{role:"feed","aria-busy":this.innerLoading}},["down"===this.direction?this.slots():e,this.genLoading(),this.genFinishedText(),this.genErrorText(),"up"===this.direction?this.slots():e])}})},b15a:function(t,e,i){},c7c4:function(t,e){t.exports="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAEgAAABICAMAAABiM0N1AAAB7FBMVEVHcEz///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////+wOur2AAAAo3RSTlMAjsBmAvSs4AGk2fL85QQwjesMKmVecfsQHGPfSPrkOKgPucSzAzNs79rCPuhgQ8edLgdX9UnFLB4rmU4WWpXn0YJGG4M6LVlAHQn5X72K7sMLiZSQtL+8aReBeT9qRAiE95JL/RKgdMnYo0L444AGm1C+DdBc3G831s9VtTZWJ9eiMsZY1fa2ZzXS6e1o8fApzGshKHPO/qmyCkHKmIhNdt07rK3wVQAAA5FJREFUGBnVweOCK2kUBdAddsVW27Z5+9q2bWNs27b2i875KlXppDuq+jWzFv5XtIjLccI/7CE9w/4TDldEgw3P9ntjXCfm3f8M1gz5plnWtG8I9WueZRWzzajPxGGWCIRCAZY4PIHa4o4gTa2+vns56HL3+nytNAUdcdTQO0BD09kE1kmcbaJhoBdVNe5j3slRDWVooyeZt68RlWkHmTfWhoraxph3UEMFPePUHUq6UYU7eYi68R6UpY1T15VDDbku6sY1lHOUumgYNYWj1B1FGY3UpVGXNHWN2KD3PpUU6pSicr8X68QHqKRRtzSVgThKRak4YIGDShQl5oIUXWFYEO6iCM6h2CBF/zwsme+nGESRZipJWJSk0ow1gxS33bDIfZtiEAVDVHbAsh1UhmC6S+GEDU6KuzDEPRQXYcNFCk8ceSmKJg02aE0UKeR5KbbDlu0UXui0GMUCbFmgiGlQJihCsClEMQHFReGDTT4KFxQHRR9s6qOIQummGIVNoxTdUPwUe2DTHgo/lGEKFCw5G5zXsObGVb//6g2sueZscC6hgGIYiodkAKYUlRWY9m6m2LwXphUqKZgCJD1QKEIwuFepPNBgcFHngkF7QGXVDUOIAgpFKwzbmHcGhkXqFmE4w7xtMDRQQJkm+SUMR4JUWi7BcJm6yzBcaqESPAJDjALKpxQwtVPxwZTIUGQSMPmotMOUIdkP5Q5FDobsKZKdHSiYCpCBKRR0dJI8lYVhmcIPpZviVxREnkRQrGNmpgPFIk8iKGijOAAlSnEBNiUpfoeSpPDBpkWKb6DMUbTCpjsUbVC0GMVXsGWewhOGzkuxBbakKV5D3i6KvzXY8QPFR8j7xUPRDBs+psgsw/A2hRM2/ETxM0yvU/kHliV+pJhBwVOKr92wqpvifQ0FW6m4YNGfVN5DkU6KL76FJdkQxSduFPmuhWIsDCu8VM6jxB9UjsGCv6jcRKnJV6jcQt1evU7RmsU6b3qonEadlloorp/HBruou4W6vNFC5XuU8ZC6Y49Qk3aOuscoaxN17+ZQyxR13h6UpW2iLnBaQ3UjVNofoZKHzJvdjapGKD7sQWUrV5jXudWNykYojqOanS/T8MK5BVQyQnEcVU1uydDU9PhC27KGjT6ncKCGnQdYLLjasMEVihdR0+4x1iGBOrx08wPW4EV9ss+397OK37KoW/idxk1P3/qMG2WeS0/iv+5fxNSIU/5zXUoAAAAASUVORK5CYII="},e02c:function(t,e){var i=/^(attrs|props|on|nativeOn|class|style|hook)$/;function r(t,e){return function(){t&&t.apply(this,arguments),e&&e.apply(this,arguments)}}t.exports=function(t){return t.reduce((function(t,e){var a,n,s,o,c;for(s in e)if(a=t[s],n=e[s],a&&i.test(s))if("class"===s&&("string"===typeof a&&(c=a,t[s]=a={},a[c]=!0),"string"===typeof n&&(c=n,e[s]=n={},n[c]=!0)),"on"===s||"nativeOn"===s||"hook"===s)for(o in n)a[o]=r(a[o],n[o]);else if(Array.isArray(a))t[s]=a.concat(n);else if(Array.isArray(n))t[s]=[a].concat(n);else for(o in n)a[o]=n[o];else t[s]=e[s];return t}),{})}}}]);