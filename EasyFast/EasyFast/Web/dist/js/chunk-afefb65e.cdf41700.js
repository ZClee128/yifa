(window["webpackJsonp"]=window["webpackJsonp"]||[]).push([["chunk-afefb65e"],{"063f":function(e,t,i){"use strict";var n=i("03de"),s=i("856f"),r=i("55b1"),a=i("e465");function l(e){return Array.isArray(e)?e:[e]}function o(e,t){return new Promise((function(i){if("file"!==t){var n=new FileReader;n.onload=function(e){i(e.target.result)},"dataUrl"===t?n.readAsDataURL(e):"text"===t&&n.readAsText(e)}else i()}))}function u(e,t){return l(e).some((function(e){return e.size>t}))}var c=/\.(jpeg|jpg|gif|png|svg|webp|jfif|bmp|dpg)/i;function h(e){return c.test(e)}function f(e){return!!e.isImage||(e.file&&e.file.type?0===e.file.type.indexOf("image"):e.url?h(e.url):!!e.content&&0===e.content.indexOf("data:image"))}var d=i("cc7f"),g=i("2496"),v=i("a91f"),p=i("f55e"),m=i("f17b"),b=Object(s["a"])("uploader"),y=b[0],w=b[1];t["a"]=y({inheritAttrs:!1,mixins:[d["a"]],model:{prop:"fileList"},props:{disabled:Boolean,lazyLoad:Boolean,uploadText:String,afterRead:Function,beforeRead:Function,beforeDelete:Function,previewSize:[Number,String],previewOptions:Object,name:{type:[Number,String],default:""},accept:{type:String,default:"image/*"},fileList:{type:Array,default:function(){return[]}},maxSize:{type:[Number,String],default:Number.MAX_VALUE},maxCount:{type:[Number,String],default:Number.MAX_VALUE},deletable:{type:Boolean,default:!0},showUpload:{type:Boolean,default:!0},previewImage:{type:Boolean,default:!0},previewFullImage:{type:Boolean,default:!0},imageFit:{type:String,default:"cover"},resultType:{type:String,default:"dataUrl"},uploadIcon:{type:String,default:"photograph"}},computed:{previewSizeWithUnit:function(){return Object(r["a"])(this.previewSize)},value:function(){return this.fileList}},methods:{getDetail:function(e){return void 0===e&&(e=this.fileList.length),{name:this.name,index:e}},onChange:function(e){var t=this,i=e.target.files;if(!this.disabled&&i.length){if(i=1===i.length?i[0]:[].slice.call(i),this.beforeRead){var n=this.beforeRead(i,this.getDetail());if(!n)return void this.resetInput();if(Object(a["f"])(n))return void n.then((function(e){e?t.readFile(e):t.readFile(i)})).catch(this.resetInput)}this.readFile(i)}},readFile:function(e){var t=this,i=u(e,this.maxSize);if(Array.isArray(e)){var n=this.maxCount-this.fileList.length;e.length>n&&(e=e.slice(0,n)),Promise.all(e.map((function(e){return o(e,t.resultType)}))).then((function(n){var s=e.map((function(e,t){var i={file:e,status:"",message:""};return n[t]&&(i.content=n[t]),i}));t.onAfterRead(s,i)}))}else o(e,this.resultType).then((function(n){var s={file:e,status:"",message:""};n&&(s.content=n),t.onAfterRead(s,i)}))},onAfterRead:function(e,t){var i=this;this.resetInput();var n=e;if(t){var s=e;Array.isArray(e)?(s=[],n=[],e.forEach((function(e){e.file&&(e.file.size>i.maxSize?s.push(e):n.push(e))}))):n=null,this.$emit("oversize",s,this.getDetail())}var r=Array.isArray(n)?Boolean(n.length):Boolean(n);r&&(this.$emit("input",[].concat(this.fileList,l(n))),this.afterRead&&this.afterRead(n,this.getDetail()))},onDelete:function(e,t){var i=this;if(this.beforeDelete){var n=this.beforeDelete(e,this.getDetail(t));if(!n)return;if(Object(a["f"])(n))return void n.then((function(){i.deleteFile(e,t)})).catch(a["h"])}this.deleteFile(e,t)},deleteFile:function(e,t){var i=this.fileList.slice(0);i.splice(t,1),this.$emit("input",i),this.$emit("delete",e,this.getDetail(t))},resetInput:function(){this.$refs.input&&(this.$refs.input.value="")},onPreviewImage:function(e){var t=this;if(this.previewFullImage){var i=this.fileList.filter((function(e){return f(e)})),s=i.map((function(e){return e.content||e.url}));this.imagePreview=Object(m["a"])(Object(n["a"])({images:s,startPosition:i.indexOf(e),closeOnPopstate:!0,onClose:function(){t.$emit("close-preview")}},this.previewOptions))}},closeImagePreview:function(){this.imagePreview&&this.imagePreview.close()},chooseFile:function(){this.disabled||this.$refs.input&&this.$refs.input.click()},genPreviewMask:function(e){var t=this.$createElement,i=e.status,n=e.message;if("uploading"===i||"failed"===i){var s="failed"===i?t(g["a"],{attrs:{name:"close"},class:w("mask-icon")}):t(p["a"],{class:w("loading")}),r=Object(a["c"])(n)&&""!==n;return t("div",{class:w("mask")},[s,r&&t("div",{class:w("mask-message")},[n])])}},genPreviewItem:function(e,t){var i=this,n=this.$createElement,s="uploading"!==e.status&&this.deletable,r=s&&n("div",{class:w("preview-delete"),on:{click:function(n){n.stopPropagation(),i.onDelete(e,t)}}},[n(g["a"],{attrs:{name:"cross"},class:w("preview-delete-icon")})]),a=this.slots("preview-cover",e),l=a&&n("div",{class:w("preview-cover")},[a]),o=f(e)?n(v["a"],{attrs:{fit:this.imageFit,src:e.content||e.url,width:this.previewSize,height:this.previewSize,lazyLoad:this.lazyLoad},class:w("preview-image"),on:{click:function(){i.onPreviewImage(e)}}},[l]):n("div",{class:w("file"),style:{width:this.previewSizeWithUnit,height:this.previewSizeWithUnit}},[n(g["a"],{class:w("file-icon"),attrs:{name:"description"}}),n("div",{class:[w("file-name"),"van-ellipsis"]},[e.file?e.file.name:e.url]),l]);return n("div",{class:w("preview"),on:{click:function(){i.$emit("click-preview",e,i.getDetail(t))}}},[o,this.genPreviewMask(e),r])},genPreviewList:function(){if(this.previewImage)return this.fileList.map(this.genPreviewItem)},genUpload:function(){var e=this.$createElement;if(!(this.fileList.length>=this.maxCount)&&this.showUpload){var t,i=this.slots(),s=e("input",{attrs:Object(n["a"])({},this.$attrs,{type:"file",accept:this.accept,disabled:this.disabled}),ref:"input",class:w("input"),on:{change:this.onChange}});if(i)return e("div",{class:w("input-wrapper")},[i,s]);if(this.previewSize){var r=this.previewSizeWithUnit;t={width:r,height:r}}return e("div",{class:w("upload"),style:t},[e(g["a"],{attrs:{name:this.uploadIcon},class:w("upload-icon")}),this.uploadText&&e("span",{class:w("upload-text")},[this.uploadText]),s])}}},render:function(){var e=arguments[0];return e("div",{class:w()},[e("div",{class:w("wrapper",{disabled:this.disabled})},[this.genPreviewList(),this.genUpload()])])}})},"21a5":function(e,t,i){"use strict";i("e1d5"),i("fbbd"),i("de0a"),i("1b19"),i("5162"),i("401d"),i("e837"),i("d7b9"),i("93c9"),i("a78f"),i("c4c7")},4959:function(e,t,i){"use strict";var n=i("23c4"),s=i.n(n),r=i("03de"),a=i("5f1c"),l=i("b875"),o=i("2cc9"),u=i("856f"),c=i("e465"),h=i("55b1"),f=i("2496"),d=i("ca00"),g=i("3766"),v=Object(u["a"])("field"),p=v[0],m=v[1];t["a"]=p({inheritAttrs:!1,provide:function(){return{vanField:this}},inject:{vanForm:{default:null}},props:Object(r["a"])({},g["a"],{name:String,rules:Array,disabled:Boolean,readonly:Boolean,autosize:[Boolean,Object],leftIcon:String,rightIcon:String,clearable:Boolean,formatter:Function,maxlength:[Number,String],labelWidth:[Number,String],labelClass:null,labelAlign:String,inputAlign:String,placeholder:String,errorMessage:String,errorMessageAlign:String,showWordLimit:Boolean,value:{type:[String,Number],default:""},type:{type:String,default:"text"},error:{type:Boolean,default:null},colon:{type:Boolean,default:null},clearTrigger:{type:String,default:"focus"},formatTrigger:{type:String,default:"onChange"}}),data:function(){return{focused:!1,validateFailed:!1,validateMessage:""}},watch:{value:function(){this.updateValue(this.value),this.resetValidation(),this.validateWithTrigger("onChange"),this.$nextTick(this.adjustSize)}},mounted:function(){this.updateValue(this.value,this.formatTrigger),this.$nextTick(this.adjustSize),this.vanForm&&this.vanForm.addField(this)},beforeDestroy:function(){this.vanForm&&this.vanForm.removeField(this)},computed:{showClear:function(){if(this.clearable&&!this.readonly){var e=Object(c["c"])(this.value)&&""!==this.value,t="always"===this.clearTrigger||"focus"===this.clearTrigger&&this.focused;return e&&t}},showError:function(){return null!==this.error?this.error:!!(this.vanForm&&this.vanForm.showError&&this.validateFailed)||void 0},listeners:function(){return Object(r["a"])({},this.$listeners,{blur:this.onBlur,focus:this.onFocus,input:this.onInput,click:this.onClickInput,keypress:this.onKeypress})},labelStyle:function(){var e=this.getProp("labelWidth");if(e)return{width:Object(h["a"])(e)}},formValue:function(){return this.children&&(this.$scopedSlots.input||this.$slots.input)?this.children.value:this.value}},methods:{focus:function(){this.$refs.input&&this.$refs.input.focus()},blur:function(){this.$refs.input&&this.$refs.input.blur()},runValidator:function(e,t){return new Promise((function(i){var n=t.validator(e,t);if(Object(c["f"])(n))return n.then(i);i(n)}))},isEmptyValue:function(e){return Array.isArray(e)?!e.length:!e},runSyncRule:function(e,t){return(!t.required||!this.isEmptyValue(e))&&!(t.pattern&&!t.pattern.test(e))},getRuleMessage:function(e,t){var i=t.message;return Object(c["d"])(i)?i(e,t):i},runRules:function(e){var t=this;return e.reduce((function(e,i){return e.then((function(){if(!t.validateFailed){var e=t.formValue;return i.formatter&&(e=i.formatter(e,i)),t.runSyncRule(e,i)?i.validator?t.runValidator(e,i).then((function(n){!1===n&&(t.validateFailed=!0,t.validateMessage=t.getRuleMessage(e,i))})):void 0:(t.validateFailed=!0,void(t.validateMessage=t.getRuleMessage(e,i)))}}))}),Promise.resolve())},validate:function(e){var t=this;return void 0===e&&(e=this.rules),new Promise((function(i){e||i(),t.runRules(e).then((function(){t.validateFailed?i({name:t.name,message:t.validateMessage}):i()}))}))},validateWithTrigger:function(e){if(this.vanForm&&this.rules){var t=this.vanForm.validateTrigger===e,i=this.rules.filter((function(i){return i.trigger?i.trigger===e:t}));this.validate(i)}},resetValidation:function(){this.validateMessage&&(this.validateFailed=!1,this.validateMessage="")},updateValue:function(e,t){void 0===t&&(t="onChange"),e=Object(c["c"])(e)?String(e):"";var i=this.maxlength;if(Object(c["c"])(i)&&e.length>i&&(e=e.slice(0,i)),"number"===this.type||"digit"===this.type){var n="number"===this.type;e=Object(l["a"])(e,n)}this.formatter&&t===this.formatTrigger&&(e=this.formatter(e));var s=this.$refs.input;s&&e!==s.value&&(s.value=e),e!==this.value&&this.$emit("input",e),this.currentValue=e},onInput:function(e){e.target.composing||this.updateValue(e.target.value)},onFocus:function(e){this.focused=!0,this.$emit("focus",e),this.readonly&&this.blur()},onBlur:function(e){this.focused=!1,this.updateValue(this.value,"onBlur"),this.$emit("blur",e),this.validateWithTrigger("onBlur"),Object(a["a"])()},onClick:function(e){this.$emit("click",e)},onClickInput:function(e){this.$emit("click-input",e)},onClickLeftIcon:function(e){this.$emit("click-left-icon",e)},onClickRightIcon:function(e){this.$emit("click-right-icon",e)},onClear:function(e){Object(o["c"])(e),this.$emit("input",""),this.$emit("clear",e)},onKeypress:function(e){var t=13;if(e.keyCode===t){var i=this.getProp("submitOnEnter");i||"textarea"===this.type||Object(o["c"])(e),"search"===this.type&&this.blur()}this.$emit("keypress",e)},adjustSize:function(){var e=this.$refs.input;if("textarea"===this.type&&this.autosize&&e){e.style.height="auto";var t=e.scrollHeight;if(Object(c["e"])(this.autosize)){var i=this.autosize,n=i.maxHeight,s=i.minHeight;n&&(t=Math.min(t,n)),s&&(t=Math.max(t,s))}t&&(e.style.height=t+"px")}},genInput:function(){var e=this.$createElement,t=this.type,i=this.slots("input"),n=this.getProp("inputAlign");if(i)return e("div",{class:m("control",[n,"custom"]),on:{click:this.onClickInput}},[i]);var a={ref:"input",class:m("control",n),domProps:{value:this.value},attrs:Object(r["a"])({},this.$attrs,{name:this.name,disabled:this.disabled,readonly:this.readonly,placeholder:this.placeholder}),on:this.listeners,directives:[{name:"model",value:this.value}]};if("textarea"===t)return e("textarea",s()([{},a]));var l,o=t;return"number"===t&&(o="text",l="decimal"),"digit"===t&&(o="tel",l="numeric"),e("input",s()([{attrs:{type:o,inputmode:l}},a]))},genLeftIcon:function(){var e=this.$createElement,t=this.slots("left-icon")||this.leftIcon;if(t)return e("div",{class:m("left-icon"),on:{click:this.onClickLeftIcon}},[this.slots("left-icon")||e(f["a"],{attrs:{name:this.leftIcon,classPrefix:this.iconPrefix}})])},genRightIcon:function(){var e=this.$createElement,t=this.slots,i=t("right-icon")||this.rightIcon;if(i)return e("div",{class:m("right-icon"),on:{click:this.onClickRightIcon}},[t("right-icon")||e(f["a"],{attrs:{name:this.rightIcon,classPrefix:this.iconPrefix}})])},genWordLimit:function(){var e=this.$createElement;if(this.showWordLimit&&this.maxlength){var t=(this.value||"").length;return e("div",{class:m("word-limit")},[e("span",{class:m("word-num")},[t]),"/",this.maxlength])}},genMessage:function(){var e=this.$createElement;if(!this.vanForm||!1!==this.vanForm.showErrorMessage){var t=this.errorMessage||this.validateMessage;if(t){var i=this.getProp("errorMessageAlign");return e("div",{class:m("error-message",i)},[t])}}},getProp:function(e){return Object(c["c"])(this[e])?this[e]:this.vanForm&&Object(c["c"])(this.vanForm[e])?this.vanForm[e]:void 0},genLabel:function(){var e=this.$createElement,t=this.getProp("colon")?":":"";return this.slots("label")?[this.slots("label"),t]:this.label?e("span",[this.label+t]):void 0}},render:function(){var e,t=arguments[0],i=this.slots,n=this.getProp("labelAlign"),s={icon:this.genLeftIcon},r=this.genLabel();r&&(s.title=function(){return r});var a=this.slots("extra");return a&&(s.extra=function(){return a}),t(d["a"],{attrs:{icon:this.leftIcon,size:this.size,center:this.center,border:this.border,isLink:this.isLink,required:this.required,clickable:this.clickable,titleStyle:this.labelStyle,valueClass:m("value"),titleClass:[m("label",n),this.labelClass],arrowDirection:this.arrowDirection},scopedSlots:s,class:m((e={error:this.showError,disabled:this.disabled},e["label-"+n]=n,e["min-height"]="textarea"===this.type&&!this.autosize,e)),on:{click:this.onClick}},[t("div",{class:m("body")},[this.genInput(),this.showClear&&t(f["a"],{attrs:{name:"clear"},class:m("clear"),on:{touchstart:this.onClear}}),this.genRightIcon(),i("button")&&t("div",{class:m("button")},[i("button")])]),this.genWordLimit(),this.genMessage()])}})},"5f1c":function(e,t,i){"use strict";i.d(t,"a",(function(){return l}));var n=i("e465");function s(){return!n["g"]&&/ios|iphone|ipad|ipod/.test(navigator.userAgent.toLowerCase())}var r=i("1412"),a=s();function l(){a&&Object(r["g"])(Object(r["b"])())}},be72:function(e,t,i){},c4c7:function(e,t,i){},f820:function(e,t,i){"use strict";i("e1d5"),i("de0a"),i("1b19"),i("c2c3"),i("be72")}}]);