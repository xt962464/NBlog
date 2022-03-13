<template>
  <div :style="styles">
    <!-- 上传文件组件 -->
    <el-upload
        :class="[hideUploadBtnVisable?'hide-upload-btn':'', className]"
        ref="upload"
        :action="getActionUrl"
        :list-type="(uploadType=='1'||uploadType==1)?'text':'picture-card'"
        :multiple="multiple"
        :limit="limit"
        :headers="myHeaders"
        :file-list="fileList"
        :on-exceed="handleExceed"
        :on-preview="handleUploadPreview"
        :on-remove="handleRemove"
        :on-success="handleUploadSuccess"
        :on-error="handleUploadErr"
        :show-file-list="showFileList"
        :before-upload="handleBeforeUpload"
    >
    <i class="el-icon-plus"></i>
        <!-- <span v-if="fileUrlList.length < limit">
            <span v-if="(uploadType=='1'||uploadType==1)">
                <el-button  type="primary">点击上传</el-button> 
            </span>
            <span v-else>
                <i class="el-icon-plus avatar-uploader-icon"></i>
            </span>
        </span>
        <div v-else v-for="(item,i) in fileUrlList" :key="i">
            <img  :src="item"  style="width:100%;height:100%;">
            <div></div>
        </div> -->
        <div slot="tip" class="el-upload__tip" style="color:#838fa1;">{{tip}}</div>
    </el-upload>
    <el-dialog v-if="(uploadType!='1'||uploadType!=1)" :visible.sync="dialogVisible" size="tiny" append-to-body>
      <img width="100%" :src="dialogImageUrl" alt>
    </el-dialog>
  </div>
</template>
<script>
export default {
  data() {
    return {
      hideUploadBtnVisable:false,
      // 查看大图
      dialogVisible: false,
      // 查看大图
      dialogImageUrl: "",
      // 组件渲染图片的数组字段，有特殊格式要求
      fileList: [],
      fileUrlList: [],
      myHeaders:{}
    };
  },
  props: ["tip", "action", "limit", "multiple", "fileUrls","uploadType","styles","showFileList","index",'className'],
  mounted() {
    this.init();
    this.myHeaders= {
      'Authorization': window.localStorage.getItem('token')
    }
  },
  watch: {
    fileUrls: function(val, oldVal) {
      //   console.log("new: %s, old: %s", val, oldVal);
      this.init();
    }
  },
  computed: {
    // 计算属性的 getter
    getActionUrl: function() {
        var api=""
        if(this.action){
            api=process.env.VUE_APP_BASE_API+ this.action;
        }else{
            api=process.env.VUE_APP_BASE_API+"upload/file"
        }
      return api;
    }
  },
  methods: {
    // 初始化
    init() {
      //   console.log(this.fileUrls);
      if (this.fileUrls.trim().length>0) {
        this.fileUrlList = this.fileUrls.split(",");
        // console.log('组件-init',this.fileUrls);
        // console.log('组件-init',this.fileUrlList);
        let fileArray = [];
        this.fileUrlList.forEach(function(item, index) {
          var url = item;
          var name = index;
          var file = {
            name: name,
            url: url
          };
          fileArray.push(file);
        });
        this.setFileList(fileArray);
        this.hideUploadBtn();
      }
    },
    handleBeforeUpload(file) {
        console.log('上传前',file);
    },
    // 上传文件成功后执行
    handleUploadSuccess(res, file, fileList) {
      if (res && res.code == 200) {
        fileList[fileList.length - 1]["url"] =  res.data;
        // fileList[fileList.length - 1]["url"] = process.env.VUE_APP_BASE_API + "/upload/" + file.response.file;
        this.setFileList(fileList);
        console.log("成功",this.fileUrlList);
        if((this.index+"").trim().length>0){
            this.$emit("change", {"url":this.fileUrlList.join(","),"index":this.index});
        }else{
            this.$emit("change", this.fileUrlList.join(","));
        }
        this.hideUploadBtn();
      } else {
        this.$message.error(res.msg);
      }
    },
    hideUploadBtn(){
        if(this.fileUrlList.length >= this.limit){
            this.hideUploadBtnVisable = true;
        }else{
            this.hideUploadBtnVisable = false;
        }
    },
    // 图片上传失败
    handleUploadErr(err, file, fileList) {
      this.$message.error("文件上传失败");
      this.hideUploadBtn();
    },
    // 移除图片
    handleRemove(file, fileList) {
      this.setFileList(fileList);
      this.$emit("change", this.fileUrlList.join(","));
      this.hideUploadBtn();
    },
    // 查看大图
    handleUploadPreview(file) {
      this.dialogImageUrl = file.url;
      this.dialogVisible = true;
    },
    // 限制图片数量
    handleExceed(files, fileList) {
        console.log("限制图片数量");
      this.$message.warning(`最多上传${this.limit}张图片`);
    },
    // 重新对fileList进行赋值
    setFileList(fileList) {
      var fileArray = [];
      var fileUrlArray = [];
      // 有些图片不是公开的，所以需要携带token信息做权限校验
    //   var token = getToken();
      fileList.forEach(function(item, index) {
        var url = item.url.split("?")[0];
        var name = item.name;
        var file = {
          name: name,
          url: url 
        };
        fileArray.push(file);
        fileUrlArray.push(url);
      });
      this.fileList = fileArray;
      this.fileUrlList = fileUrlArray;
    }
  }
};
</script>
<style lang="scss">
    .text-left{
        text-align: left;
    }
    .hide-upload-btn .el-upload--picture-card{
        display: none;
    }
    /*去除upload组件过渡效果*/
    .el-upload-list__item {
    transition: none !important;
    }
</style>