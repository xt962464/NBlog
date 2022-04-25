<template>
    <div v-infinite-scroll="loadMore" class="file-list-mange diy-scrollbar">
        <!-- <el-row>
			<el-select v-model="activeRepos" placeholder="请选择仓库" :filterable="true" @change="changeRepos" style="min-width: 300px">
				<el-option v-for="item in reposList" :key="item.id" :label="item.name" :value="item.name"></el-option>
			</el-select>
		</el-row> -->
        <el-row v-viewer>
            <div class="image-container" v-for="(file,index) in fileList" :key="index">
                <el-image :src="file.url" fit="scale-down"></el-image>
                <div class="image-content">
                    <div class="info">
                        <span>{{ file.key }}</span>
                    </div>
                    <div class="icons">
                        <el-tooltip class="item" effect="dark" content="复制CDN链接" placement="bottom">
                            <i class="icon el-icon-link" @click="copy(1,file)"></i>
                        </el-tooltip>
                        <el-tooltip class="item" effect="dark" content="复制MD格式" placement="bottom">
                            <SvgIcon icon-class="markdown" class-name="icon" @click="copy(2,file)"></SvgIcon>
                        </el-tooltip>
                        <i class="icon el-icon-delete" @click="delFile(file,index)"></i>
                    </div>
                </div>
            </div>
        </el-row>
        <div v-loading="loading" element-loading-text="拼命加载中" element-loading-spinner="el-icon-loading" style="height:80px;width:100%;"></div>

        <!-- <el-drawer title="上传文件" :visible.sync="isDrawerShow" direction="rtl" size="40%" :wrapperClosable="false" :close-on-press-escape="false">
			<el-row>
				<el-radio v-model="nameType" label="1">使用源文件名</el-radio>
				<el-radio v-model="nameType" label="2">使用UUID文件名</el-radio>
				<el-button size="small" type="primary" icon="el-icon-upload" v-throttle="[submitUpload,`click`,3000]">确定上传</el-button>
			</el-row>
			<el-row>
				当前目录：{{ realPath }}
			</el-row>
			<el-row>
				<el-switch v-model="isCustomPath" active-text="自定义目录"></el-switch>
				<el-input placeholder="例：oldFolder/newFolder/" v-model="customPath" :disabled="!isCustomPath" size="medium" style="margin-top: 10px"></el-input>
			</el-row>
			<el-upload ref="uploadRef" action="" :http-request="upload" drag multiple :file-list="uploadList" list-type="picture" :auto-upload="false">
				<i class="el-icon-upload"></i>
				<div class="el-upload__text">将文件拖到此处，或<em>点击上传</em></div>
			</el-upload>
		</el-drawer> -->
    </div>
</template>

<script>
import SvgIcon from "@/components/SvgIcon";
import { isImgExt } from "@/util/validate";
import { copy } from "@/util/copy";
export default {
    name: "Manage",
    components: { SvgIcon },
    data() {
        return {
            loading: false,
            fileList: [],
            isCDN: true,
            isDrawerShow: false,
            pageForm: {
                index: 1,
                limit: 50,
            },
        };
    },
    computed: {},
    created() {
        this.loading = true;
        this.getFileList();
    },
    methods: {
        loadMore() {
            if (!this.loading) {
                this.pageForm.index++;
                console.log("加载");
                this.getFileList();
            }
        },
        getFileList() {
            this.loading = true;
            this.$http
                .get("/file/qiniu/list", { params: this.pageForm })
                .then((resp) => {
                    if (resp.data && resp.data.length > 0) {
                        this.fileList = this.fileList.concat(resp.data);
                    }
                    this.loading = false;
                });
        },
        copy(type, file) {
            // type 1 cdn link  2 Markdown
            let imgUrl = file.url;
            let copyCont = imgUrl;
            if (type == 2) {
                copyCont = `![${file.key}](${imgUrl})`;
            }
            copy(copyCont);
            this.msgSuccess("复制成功");
        },
        delFile(file, index) {
            this.$confirm("此操作将永久删除该文件, 是否删除?", "提示", {
                confirmButtonText: "确定",
                cancelButtonText: "取消",
                type: "warning",
            })
                .then(() => {
                    this.$http
                        .post("file/qiniu/del", { url: file.key })
                        .then((resp) => {
                            this.fileList.splice(index, 1);
                            this.msgSuccess("删除成功");
                        });
                })
                .catch(() => {
                    this.$message({
                        type: "info",
                        message: "已取消删除",
                    });
                });
        },
        submitUpload() {
            //https://github.com/ElemeFE/element/issues/12080
            this.uploadList = this.$refs.uploadRef.uploadFiles;
            if (this.uploadList.length) {
                //触发 el-upload 中 http-request 绑定的函数
                this.$refs.uploadRef.submit();
            } else {
                this.msgError("请先选择文件");
            }
        },
        upload(data) {
            let reader = new FileReader();
            reader.readAsDataURL(data.file);
            reader.onload = () => {
                let base64 = reader.result.split(",")[1];
                let fileName = data.file.name;
                if (this.nameType === "2") {
                    fileName =
                        randomUUID() +
                        fileName.substr(fileName.lastIndexOf("."));
                }
                //批量上传需要间隔时间，否则可能commit版本号冲突，返回409错误码，Status: 409 Conflict
                taskQueue(() => this.push2Github(data, fileName, base64), 1000);
            };
        },
        push2Github(data, fileName, base64) {
            let requestData = {
                message: "Add files via PictureHosting",
                content: base64,
            };

            let path = this.activePath.join("/");
            if (this.isCustomPath) {
                if (this.customPath === "/") {
                    path = "";
                } else {
                    path = this.customPath;
                    if (path.charAt(0) !== "/") {
                        path = "/" + path;
                    }
                    if (path.charAt(path.length - 1) === "/") {
                        path = path.substring(0, path.length - 1);
                    }
                }
            }

            upload(
                this.userInfo.login,
                this.activeRepos,
                path,
                fileName,
                requestData
            ).then(() => {
                this.msgSuccess("上传成功");
                data.onSuccess();
            });
        },
    },
};
</script>

<style scoped>
.file-list-mange {
    overflow: auto;
    height: calc(100vh - 100px);
}
</style>

<style>
.el-drawer__body {
    margin: 0 20px;
    overflow: auto;
}

.el-drawer__body .el-upload {
    margin-top: 20px;
}

.el-drawer__body .el-upload,
.el-drawer__body .el-upload-dragger {
    width: 100%;
}
</style>

<style scoped>
.el-row + .el-row,
.el-row + .el-alert,
.el-alert + .el-row {
    margin-top: 20px;
}

.el-alert + .el-alert {
    margin-top: 10px;
}

.el-select + .el-cascader,
.el-cascader + .el-button,
.el-button + .el-switch {
    margin-left: 10px;
}

.el-switch + .el-button {
    margin-left: 30px;
}

.image-container {
    position: relative;
    width: 200px;
    height: 200px;
    overflow: hidden;
    display: inline-block;
    margin: 0 2px;
}

.el-image {
    width: 100%;
    height: 100%;
    z-index: 1;
}

.image-content {
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
}

.image-content .info {
    background: linear-gradient(0deg, transparent, rgba(0, 0, 0, 0.6));
    position: absolute;
    left: 0;
    right: 0;
    top: 0;
    padding: 6px;
    font-size: 12px;
    color: #fff;
    opacity: 0;
    transition: opacity 0.5s;
    z-index: 2;
}

.image-content .info span {
    word-wrap: break-word;
}

.image-container:hover .image-content .info {
    opacity: 1;
    transition-duration: 0.25s;
}

.icons {
    position: absolute;
    right: 8px;
    bottom: 8px;
    z-index: 2;
}

.icon {
    text-decoration: none;
    font-size: 22px;
    margin-left: 20px;
    transform: translateY(80px);
    cursor: pointer;
}

.image-container:hover .icon {
    transform: translateY(0px);
}

.icon:nth-child(1) {
    transition: transform 0.25s 0.05s, color 0.3s;
}

.icon:nth-child(2) {
    transition: transform 0.25s 0.1s, color 0.3s;
}

.icon:nth-child(3) {
    transition: transform 0.25s 0.15s, color 0.3s;
}

.icon:nth-child(1):hover {
    color: #409eff;
}

.icon:nth-child(2):hover {
    color: #409eff;
}

.icon:nth-child(3):hover {
    color: #f56c6c;
}

.image-content::before {
    content: "";
    position: absolute;
    left: 0;
    bottom: 0;
    background: rgba(255, 255, 255, 0.7);
    width: 100%;
    height: 0;
    clip-path: polygon(0 100%, 100% 0, 100% 100%);
    transition: 0.3s;
    z-index: 2;
}

.image-container:hover .image-content::before {
    height: 80px;
}
</style>