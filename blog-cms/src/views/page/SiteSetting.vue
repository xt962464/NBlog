<template>
    <div>
        <div style="text-align: right;margin-bottom: 15px">
            <el-button type="primary" icon="el-icon-check" @click="submit">保存</el-button>
        </div>
        <el-row :gutter="20">
            <el-col :span="12">
                <el-card>
                    <div slot="header">
                        <span>基础设置</span>
                    </div>
                    <el-form label-position="right" label-width="100px">
                        <el-form-item :label="item.nameZh" v-for="item in typeMap.type1" :key="item.id">
                            <div v-if="item.nameEn=='footerImgUrl'">
                                <file-upload className="text-left" :showFileList="true" :style="uploadStyle" :limit="1"
                                    :fileUrls="item.value" @change="footerImgUrlUploadSuccess" class="upload-class">
                                </file-upload>
                            </div>
                            <div v-else-if="item.nameEn=='reward'">
                                <file-upload className="text-left" :showFileList="true" :style="uploadStyle" :limit="1"
                                    :fileUrls="item.value" @change="rewardUrlUploadSuccess" class="upload-class">
                                </file-upload>
                            </div>
                            <el-input v-else v-model="item.value" size="mini"></el-input>
                        </el-form-item>
                    </el-form>
                </el-card>
            </el-col>
            <el-col :span="12">
                <el-card>
                    <div slot="header">
                        <span>资料卡</span>
                    </div>
                    <el-form label-position="right" label-width="100px">
                        <el-form-item :label="item.nameZh" v-for="item in typeMap.type2" :key="item.id">
                            <div v-if="item.nameEn=='favorite'">
                                <el-col :span="20">
                                    <el-input v-model="item.value" size="mini"></el-input>
                                </el-col>
                                <el-col :span="4">
                                    <el-button type="danger" size="mini" icon="el-icon-delete"
                                        @click="deleteFavorite(item)">删除</el-button>
                                </el-col>
                            </div>
                            <div v-else-if="item.nameEn=='avatar'">
                                <file-upload className="text-left" :showFileList="true" :style="uploadStyle" :limit="1"
                                    :fileUrls="item.value" @change="avatarUploadSuccess" class="upload-class">
                                </file-upload>
                            </div>
                            <div v-else>
                                <el-input v-model="item.value" size="mini"></el-input>
                            </div>
                        </el-form-item>
                        <el-button type="primary" size="mini" icon="el-icon-plus" @click="addFavorite">添加自定义</el-button>
                    </el-form>
                </el-card>
            </el-col>
        </el-row>

        <el-row style="margin-top: 20px">
            <el-card>
                <div slot="header">
                    <span>页脚徽标</span>
                </div>
                <el-form :inline="true" v-for="badge in typeMap.type3" :key="badge.id">
                    <el-form-item label="title">
                        <el-input v-model="badge.value.title" size="mini"></el-input>
                    </el-form-item>
                    <el-form-item label="url">
                        <el-input v-model="badge.value.url" size="mini"></el-input>
                    </el-form-item>
                    <el-form-item label="subject">
                        <el-input v-model="badge.value.subject" size="mini"></el-input>
                    </el-form-item>
                    <el-form-item label="value">
                        <el-input v-model="badge.value.value" size="mini"></el-input>
                    </el-form-item>
                    <el-form-item label="color">
                        <el-input v-model="badge.value.color" size="mini"></el-input>
                    </el-form-item>
                    <el-form-item>
                        <el-button type="danger" size="mini" icon="el-icon-delete" @click="deleteBadge(badge)">删除
                        </el-button>
                    </el-form-item>
                </el-form>
                <el-button type="primary" size="mini" icon="el-icon-plus" @click="addBadge">添加 badge</el-button>
            </el-card>
        </el-row>

        <el-row style="margin-top: 20px">
            <el-card>
                <div slot="header" class="site-index-pic-header">
                    <div>首页封面轮播图</div>
                    <div class="site-index-pic-btn">
                        <!-- 数量: -->
                        <!-- <el-input-number v-model="siteIndexPicCount" @change="siteIndexPicCountChange" :min="1" /> -->
                        <el-upload class="upload-demo" ref="siteBanner" :action="uploadAction" :headers="httpHeaders"
                            :limit="1" :on-success="siteIndexPicUploadSuccess">
                            <el-button size="small" type="primary">点击上传</el-button>
                        </el-upload>
                    </div>
                </div>
                <div v-for="item in typeMap.type4" :key="item.id">
                    <el-carousel v-if="item.nameEn=='siteIndexBannerPic'" height="500px" :interval="5000"
                        arrow="always">
                        <el-carousel-item v-for="(pic,i) in siteIndexPicList" :key="i" class="site-index-banner-item">
                            <div class="site-banner-item">
                                <i class="el-icon-circle-close" @click="delSiteBanner(i)"></i>
                                <img :src="pic" />
                            </div>
                        </el-carousel-item>
                    </el-carousel>
                </div>
            </el-card>
        </el-row>

        <div style="text-align: right;margin-top: 30px">
            <el-button type="primary" icon="el-icon-check" @click="submit">保存</el-button>
        </div>
    </div>
</template>

<script>
import Breadcrumb from "@/components/Breadcrumb";
import fileUpload from "@/components/upload/file-upload";
import { getSiteSettingData, update } from "@/api/siteSetting";
import _ from "lodash";

export default {
    name: "SiteSetting",
    components: { Breadcrumb, fileUpload },
    data() {
        return {
            siteIndex: 0,
            siteIndexPicCount: 0,
            siteIndexPicList: [],
            uploadStyle: {
                "text-align": "center",
            },
            deleteIds: [],
            typeMap: {},
            httpHeaders: {},
            uploadAction: "",
        };
    },
    created() {
        this.getData();
    },
    mounted() {
        this.httpHeaders = {
            Authorization: window.localStorage.getItem("token"),
        };
        this.uploadAction = process.env.VUE_APP_BASE_API + "file/qiniu/upload";
    },
    methods: {
        /**
         * 头像上传成功
         */
        avatarUploadSuccess(urls) {
            console.log(urls);
            for (let index = 0; index < this.typeMap.type2.length; index++) {
                if (this.typeMap.type2[index].nameEn == "avatar") {
                    this.typeMap.type2[index].value = urls;
                    return;
                }
            }
        },
        /**
         * 页脚图片上传成功
         */
        footerImgUrlUploadSuccess(urls) {
            for (let index = 0; index < this.typeMap.type1.length; index++) {
                if (this.typeMap.type1[index].nameEn == "footerImgUrl") {
                    this.typeMap.type1[index].value = urls;
                }
            }
        },
        /**
         * 页脚图片上传成功
         */
        rewardUrlUploadSuccess(urls) {
            for (let index = 0; index < this.typeMap.type1.length; index++) {
                if (this.typeMap.type1[index].nameEn == "reward") {
                    this.typeMap.type1[index].value = urls;
                }
            }
        },
        siteIndexPicUploadSuccess(res, file, fileList) {
            var _this = this;
            // console.log(res, file, fileList);
            this.typeMap.type4.forEach((item) => {
                if (item.nameEn == "siteIndexBannerPic") {
                    _this.siteIndexPicList.push(res["data"]);
                    item.value = _this.siteIndexPicList.join(",");
                }
            });
            console.log(this.typeMap);
            this.clearFiles();
        },
        clearFiles() {
            this.$refs["siteBanner"].clearFiles();
        },
        // 删除首页轮播图
        delSiteBanner(i) {
            var _this = this;
            this.$confirm("确定删除图片吗?", "温馨提示", {
                confirmButtonText: "确定",
                cancelButtonText: "取消",
                type: "warning",
            })
                .then(() => {
                    this.siteIndexPicList.splice(i, 1);
                    console.log("list",this.siteIndexPicList);
                    try {
                        this.typeMap.type4.forEach((item) => {
                            if (item.nameEn == "siteIndexBannerPic") {
                                item.value = _this.siteIndexPicList.join(",");
                                throw new Error("End Loop");
                            }
                        });
                    } catch (e) {
                        console.log("end");
                    }
                    console.log(this.typeMap.type4);
                })
                .catch(() => {
                    // this.$message({
                    //     type: 'info',
                    //     message: '已取消删除'
                    // });
                });
        },
        /**
         * 首页图片数量变化
         */
        siteIndexPicCountChange(currentValue, oldValue) {
            if (currentValue < oldValue) {
                //添加一张图
                this.$confirm("确定删除最后一张图片吗?", "温馨提示", {
                    confirmButtonText: "确定",
                    cancelButtonText: "取消",
                    type: "warning",
                })
                    .then(() => {
                        this.siteIndexPicList.pop();
                        this.$message({
                            type: "success",
                            message: "删除成功!",
                        });
                    })
                    .catch(() => {
                        // this.$message({
                        //     type: 'info',
                        //     message: '已取消删除'
                        // });
                    });
            } else {
                this.siteIndexPicList.push("");
            }
        },
        getData() {
            getSiteSettingData().then((res) => {
                this.typeMap = res.data;
                // console.log("typeMap", this.typeMap);
                res.data.type3.forEach((item) => {
                    item.value = JSON.parse(item.value);
                });
                res.data.type4.forEach((item) => {
                    if (item.nameEn == "siteIndexBannerPic") {
                        if (item.value) {
                            this.siteIndexPicList = item.value.split(",");
                        }
                    }
                });
                // console.log("typeMap", this.typeMap);
            });
        },
        addFavorite() {
            this.typeMap.type2.push({
                key: Date.now(),
                nameEn: "favorite",
                nameZh: "自定义",
                type: 2,
                value: '{"title":"","content":""}',
            });
        },
        addBadge() {
            this.typeMap.type3.push({
                key: Date.now(),
                nameEn: "badge",
                nameZh: "徽标",
                type: 3,
                value: {
                    color: "",
                    subject: "",
                    title: "",
                    url: "",
                    value: "",
                },
            });
        },
        deleteFavorite(favorite) {
            let arr = this.typeMap.type2;
            if (favorite.id) {
                this.deleteIds.push(favorite.id);
                arr.forEach((item, index) => {
                    if (item.id === favorite.id) {
                        arr.splice(index, 1);
                        return;
                    }
                });
            } else {
                arr.forEach((item, index) => {
                    if (item.key === favorite.key) {
                        arr.splice(index, 1);
                        return;
                    }
                });
            }
        },
        deleteBadge(badge) {
            let arr = this.typeMap.type3;
            if (badge.id) {
                this.deleteIds.push(badge.id);
                arr.forEach((item, index) => {
                    if (item.id === badge.id) {
                        arr.splice(index, 1);
                        return;
                    }
                });
            } else {
                arr.forEach((item, index) => {
                    if (item.key === badge.key) {
                        arr.splice(index, 1);
                        return;
                    }
                });
            }
        },
        submit() {
            const result = _.cloneDeep(this.typeMap);
            result.type3.forEach((item) => {
                item.value = JSON.stringify(item.value);
            });
            let updateArr = [];
            updateArr.push(...result.type1);
            updateArr.push(...result.type2);
            updateArr.push(...result.type3);
            updateArr.push(...result.type4);
            update(updateArr, this.deleteIds).then((res) => {
                this.deleteIds = [];
                this.getData();
                this.msgSuccess(res.msg);
            });
        },
    },
};
</script>

<style scoped lang="scss">
.site-index-pic-header {
    display: flex;
}
.site-index-pic-btn {
    margin-left: auto;
}
.site-index-banner-item {
    text-align: center;
    .site-banner-item {
        height: 100%;
        i {
            position: absolute;
            top: 0;
            right: 0;
            font-size: 25px;
            color: red;
            cursor: pointer;
        }
        img {
            height: 100%;
        }
    }
}
</style>