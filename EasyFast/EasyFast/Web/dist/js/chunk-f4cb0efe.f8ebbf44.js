(window["webpackJsonp"]=window["webpackJsonp"]||[]).push([["chunk-f4cb0efe"],{a9af:function(e,t,i){"use strict";var n=i("e40e"),r=i.n(n);r.a},e015:function(e,t,i){"use strict";i.r(t);var n=function(){var e=this,t=e.$createElement,i=e._self._c||t;return i("div",[i("my-swiper")],1)},r=[],s=function(){var e=this,t=e.$createElement,i=e._self._c||t;return i("div",[i("swiper",{ref:"mySwiper",staticClass:"content-scroll",attrs:{options:e.swiperOptions},on:{touchMove:e.onTouchMove}})],1)},o=[],l={data:function(){return{tabsList:[{title:"全部",index:0,list:[]},{title:"待受理",index:1,list:[]},{title:"待退货",index:2,list:[]},{title:"已完成",index:3,list:[]},{title:"已拒绝",index:4,list:[]}],tabTop:"40px",swiperOptions:{scrollbar:{el:".swiper-scrollbar"}}}},computed:{swiper:function(){return this.$refs.mySwiper.$swiper}}},c=l,p=i("9ca4"),u=Object(p["a"])(c,s,o,!1,null,null,null),a=u.exports,w={data:function(){return{swiperOptions:{scrollbar:{el:".swiper-scrollbar"}}}},components:{mySwiper:a},computed:{swiper:function(){return this.$refs.mySwiper.$swiper}},mounted:function(){console.log("Current Swiper instance object",this.swiper),this.swiper.slideTo(3,1e3,!1)}},f=w,d=(i("a9af"),Object(p["a"])(f,n,r,!1,null,null,null));t["default"]=d.exports},e40e:function(e,t,i){}}]);